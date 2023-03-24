# frozen_string_literal: true

$LOAD_PATH.push "#{Dir.pwd}/lib"
require 'goldendocx'

docx = Goldendocx::Docx.new("#{Dir.pwd}/demo/templates/blankDocument.docx")

docx.add_style(File.read("#{Dir.pwd}/demo/templates/styles/reportTitle"))
docx.add_style(File.read("#{Dir.pwd}/demo/templates/styles/reportSubTitle"))

docx.create_text('表单最近表现(2023.01.29-2023.02.28)', style: 'SubTitle')

chart = docx.create_chart(:line)
chart.name = '表单最近表现'

categories = %w[
  2023-01-29 2023-01-30 2023-01-31 2023-02-01 2023-02-02 2023-02-03 2023-02-04 2023-02-05
  2023-02-06 2023-02-07 2023-02-08 2023-02-09 2023-02-10 2023-02-11 2023-02-12 2023-02-13
  2023-02-14 2023-02-15 2023-02-16 2023-02-17 2023-02-18 2023-02-19 2023-02-20 2023-02-21
  2023-02-22 2023-02-23 2023-02-24 2023-02-25 2023-02-26 2023-02-27 2023-02-28
]

view_values = [
  0, 0, 0, 2, 0, 48, 158, 94, 126, 142, 9, 7, 1, 1, 0, 1, 0, 0, 1, 0, 0, 0, 1, 0, 0, 0, 0, 1, 2, 3, 2
]
chart.add_series('浏览', categories, view_values)

fill_values = [
  0, 0, 0, 23, 0, 0, 0, 0, 0, 0, 20, 0, 20, 0, 0, 60, 0, 0, 2, 0, 0, 0, 0, 0, 0, 0, 0, 45, 30, 0, 0
]
chart.add_series('填写', categories, fill_values)

query_values = [
  2, 1, 12, 0, 0, 0, 0, 45, 0, 0, 20, 0, 0, 24, 0, 0, 0, 0, 23, 0, 0, 10, 0, 0, 0, 0, 0, 0, 0, 0, 0
]
chart.add_series('查询', categories, query_values)

filename = 'simpleLineChartDocument.docx'
system "rm -f ~/Desktop/#{filename}" # -f so that we don't have an error if the file doesn't exist
docx.write_to File.expand_path("~/Desktop/#{filename}")
exec "open ~/Desktop/#{filename}"
