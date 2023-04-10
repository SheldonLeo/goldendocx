# frozen_string_literal: true

$LOAD_PATH.push "#{Dir.pwd}/lib"
require 'goldendocx'
Goldendocx.configure { |config| config.xml_serializer = :ox }
docx = Goldendocx::Docx.new("#{Dir.pwd}/demo/templates/blankDocument.docx")

# Register styles because default document without any style
docx.add_style(File.read("#{Dir.pwd}/demo/templates/styles/reportTable"))
# Set default textAlignment at template instead of modify manually
# docx.document.styles.styles.find { |s| s.type == 'paragraph' && s.default? }.tap do |style|
#   style.node.public_send('w:pPr').tap do |pr|
#     pr << Ox::Element.new('w:textAlignment').tap { |a| a['w:val'] = :center }
#   end
# end

table = docx.create_table(style: 'reportTable')

# Headers
table.add_header('名称', width: (Goldendocx::Tables::DEFAULT_TABLE_DXA_WIDTH / 2))
table.add_header('数量', width: 1500)
table.add_header('单价')
table.add_header('总价', width: (Goldendocx::Tables::DEFAULT_TABLE_DXA_WIDTH / 6))

# Rows
image_base64 = File.read("#{Dir.pwd}/demo/templates/image_base64")
image = docx.create_embed_image(image_base64, width: 720000, height: 720000, align: :left)

rows = [
  [Goldendocx::Tables::ImageCell.new(image:, content: '选项A'), 3, '¥3.00', '¥9.00'],
  [Goldendocx::Tables::ImageCell.new(image:, content: '选项B'), 4, '¥6.50', '¥18.00'],
  [Goldendocx::Tables::ImageCell.new(image:, content: '选项C'), 10, '¥6.00', '¥60.00']
]
rows.each do |r|
  row = table.add_row(r)
  row.height = 1500
end

filename = 'embedImageTableDocument.docx'
system "rm -f ~/Desktop/#{filename}" # -f so that we don't have an error if the file doesn't exist
docx.write_to File.expand_path("~/Desktop/#{filename}")
exec "open ~/Desktop/#{filename}"
