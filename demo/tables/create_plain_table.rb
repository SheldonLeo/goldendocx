# frozen_string_literal: true

$LOAD_PATH.push "#{Dir.pwd}/lib"
require 'goldendocx'

docx = Goldendocx::Docx.new("#{Dir.pwd}/demo/templates/blankDocument.docx")

headers = %w[名称 数量 单价]
rows = [
  %w[可口可乐 3 ¥3.00],
  %w[魔爪 4 ¥6.50],
  %w[北冰洋 10 ¥6.00]
]

table = docx.create_table
headers.each { |header| table.add_header(header) }
rows.each { |row| table.add_row(row) }

filename = 'plainTableDocument.docx'
system "rm -f ~/Desktop/#{filename}" # -f so that we don't have an error if the file doesn't exist
docx.write_to File.expand_path("~/Desktop/#{filename}")
exec "open ~/Desktop/#{filename}"
