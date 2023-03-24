# frozen_string_literal: true

$LOAD_PATH.push "#{Dir.pwd}/lib"
require 'goldendocx'

docx = Goldendocx::Docx.new("#{Dir.pwd}/demo/templates/blankDocument.docx")

docx.create_text('Hello World!')

filename = 'plainTextDocument.docx'
system "rm -f ~/Desktop/#{filename}" # -f so that we don't have an error if the file doesn't exist
docx.write_to File.expand_path("~/Desktop/#{filename}")
exec "open ~/Desktop/#{filename}"
