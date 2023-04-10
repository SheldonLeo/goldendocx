# frozen_string_literal: true

# A parts holds media
module Goldendocx
  module Parts
    class Media
      TYPE = 'http://schemas.openxmlformats.org/officeDocument/2006/relationships/image'

      def initialize(name, data)
        @name = name
        @data = data
      end

      def target
        "media/#{@name}"
      end

      def input_stream
        Utils::ImageUtil.to_stream(@data)
      end

      def write_to(zos)
        zos.put_next_entry "word/#{target}"
        zos.write input_stream.read
      end
    end
  end
end
