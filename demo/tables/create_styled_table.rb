# frozen_string_literal: true

$LOAD_PATH.push "#{Dir.pwd}/lib"
require 'goldendocx'

docx = Goldendocx::Docx.new("#{Dir.pwd}/demo/templates/blankDocument.docx")

# Register styles because default document without any style
docx.add_style(File.read("#{Dir.pwd}/demo/templates/styles/reportTable"))

table = docx.create_table(style: 'reportTable')

# Headers
table.add_header('名称', width: (Goldendocx::Tables::DEFAULT_TABLE_DXA_WIDTH / 2))
table.add_header('数量', width: 1500)
table.add_header('单价')
table.add_header('总价', width: (Goldendocx::Tables::DEFAULT_TABLE_DXA_WIDTH / 6))

# Rows
rows = [
  %w[可口可乐 3 ¥3.00 ¥9.00],
  %w[魔爪 4 ¥6.50 ¥18.00],
  %w[北冰洋 10 ¥6.00 ¥60.00]
]
rows.each do |r|
  row = table.add_row(r)
  row.height = 500
end

# RowMergeCell
table.add_row([{ span: 4, content: '总数据量： 210', align: :center }])

filename = 'styledTableDocument.docx'
system "rm -f ~/Desktop/#{filename}" # -f so that we don't have an error if the file doesn't exist
docx.write_to File.expand_path("~/Desktop/#{filename}")
exec "open ~/Desktop/#{filename}"
