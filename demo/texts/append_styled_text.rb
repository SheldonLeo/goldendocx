# frozen_string_literal: true

$LOAD_PATH.push "#{Dir.pwd}/lib"
require 'goldendocx'
docx = Goldendocx::Docx.new.read_from("#{Dir.pwd}/demo/templates/blankDocument.docx")

# Register styles because default document without any style
docx.add_style(File.read("#{Dir.pwd}/demo/templates/styles/reportTitle"))
docx.add_style(File.read("#{Dir.pwd}/demo/templates/styles/reportSubTitle"))
docx.add_style(File.read("#{Dir.pwd}/demo/templates/styles/reportLabel"))

docx.create_text('Hello World!', style: 'Title', align: :center)
docx.create_text('Chapter One', style: 'SubTitle', align: :left)
docx.create_text('Hello to you too', style: 'Label', align: :left)
docx.create_text('I am an ORANGE', color: 'FF8533', align: :center, style: 'Title')
docx.create_text('I am a PINK', color: 'F16B79', bold: true, style: 'SubTitle')
docx.create_text('Yours Sincerely', align: :right)

filename = 'styledTextDocument.docx'
system "rm -f ~/Desktop/#{filename}" # -f so that we don't have an error if the file doesn't exist
docx.write_to File.expand_path("~/Desktop/#{filename}")
exec "open ~/Desktop/#{filename}"
