# frozen_string_literal: true

require 'open-uri'

class UnsupportedImageType < StandardError
  def initialize
    super('Unsupported image type, supported types are [ png, jpeg ]')
  end
end

module Utils
  module ImageUtil
    IMAGE_MIME_TYPES = {
      png: 'image/png',
      jpeg: 'image/jpeg'
    }.freeze

    BASE64_PNG_PATTERN = %r{
      ^data:image/png;base64,
      (?<data>(?:[A-Za-z0-9+/]{4})*(?:[A-Za-z0-9+/]{2}==|[A-Za-z0-9+/]{3}=)?)$
    }x

    class << self
      def guess_image_type(image_data)
        image_stream = to_stream(image_data)
        image_stream.rewind if image_stream.respond_to?(:rewind)
        head = image_stream.read(2)
        case head
        when 0xff.chr + 0xd8.chr then :jpeg # https://en.wikipedia.org/wiki/JPEG#Syntax_and_structure
        when "#{0x89.chr}P" then :png # https://en.wikipedia.org/wiki/PNG#File_format
        else raise UnsupportedImageType
        end
      ensure
        image_stream.rewind if image_stream.respond_to?(:rewind)
      end

      def to_stream(image_data)
        return image_data if image_data.respond_to?(:read)
        return StringIO.new(BASE64_PNG_PATTERN.match(image_data)['data'].unpack1('m'), 'rb') if base64_png?(image_data)

        uri = URI.parse(image_data)
        return uri.open if uri.is_a?(URI::HTTP)

        File.open(image_data) if File.file?(image_data)
      end

      def base64_png?(image_data)
        image_data.is_a?(String) && image_data.match?(BASE64_PNG_PATTERN)
      end
    end
  end
end
