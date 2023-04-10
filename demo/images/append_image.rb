# frozen_string_literal: true

$LOAD_PATH.push "#{Dir.pwd}/lib"
require 'goldendocx'
require 'open-uri'

docx = Goldendocx::Docx.new("#{Dir.pwd}/demo/templates/blankDocument.docx")

image = File.open("#{Dir.pwd}/demo/templates/bg.png")
docx.create_image(image)

image_base64 = File.read("#{Dir.pwd}/demo/templates/image_base64")
docx.create_image(image_base64)

image_url = 'https://www.google.com/images/branding/googlelogo/2x/googlelogo_color_272x92dp.png'
docx.create_image(URI.parse(image_url).open)

filename = 'simpleImageDocument.docx'
system "rm -f ~/Desktop/#{filename}" # -f so that we don't have an error if the file doesn't exist
docx.write_to File.expand_path("~/Desktop/#{filename}")
exec "open ~/Desktop/#{filename}"
