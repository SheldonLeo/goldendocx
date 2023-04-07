# frozen_string_literal: true

# A parts holds media
module Goldendocx
  module Parts
    class Media
      BASE64_PNG_PATTERN = %r{
        ^data:image/png;base64,
        (?<data>(?:[A-Za-z0-9+/]{4})*(?:[A-Za-z0-9+/]{2}==|[A-Za-z0-9+/]{3}=)?)$
      }x

      def initialize(name, data)
        @name = name
        @data = data
      end

      def target
        "media/#{@name}"
      end

      def type
        'http://schemas.openxmlformats.org/officeDocument/2006/relationships/image'
      end

      def input_stream
        return StringIO.new(BASE64_PNG_PATTERN.match(@data)['data'].unpack1('m'), 'rb') if base64_png_data?

        @data
      end

      def write_to(zos)
        zos.put_next_entry "word/#{target}"
        zos.write input_stream.read
      end

      private

      def base64_png_data?
        @data.is_a?(String) && @data.match?(BASE64_PNG_PATTERN)
      end
    end
  end
end
