# frozen_string_literal: true

$LOAD_PATH.push "#{Dir.pwd}/lib"
require 'goldendocx'

docx = Goldendocx::Docx.new

docx.create_text('Hello World!')
docx.create_text('Hello World!', align: :center, color: 'FF8533', bold: true)

filename = 'plainTextDocument.docx'
system "rm -f ~/Desktop/#{filename}" # -f so that we don't have an error if the file doesn't exist
docx.write_to File.expand_path("~/Desktop/#{filename}")
exec "open ~/Desktop/#{filename}"
