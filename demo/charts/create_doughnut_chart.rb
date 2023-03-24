# frozen_string_literal: true

$LOAD_PATH.push "#{Dir.pwd}/lib"
require 'goldendocx'

docx = Goldendocx::Docx.new("#{Dir.pwd}/demo/templates/blankDocument.docx")

docx.add_style(File.read("#{Dir.pwd}/demo/templates/styles/reportTitle"))
docx.add_style(File.read("#{Dir.pwd}/demo/templates/styles/reportSubTitle"))

docx.create_text('地域分布详情数据（Top 10）', style: 'SubTitle')

chart = docx.create_chart(:doughnut)
categories = %w[
  河南省 山东省 浙江省 四川省 安徽省 上海市 湖北省 山西省 河北省 贵州省 广东省 江西省
  北京市 陕西省 江苏省 广西壮族自治区 福建省 甘肃省 新疆维吾尔自治区 内蒙古自治区 黑龙江省
  宁夏回族自治区 吉林省 天津市 辽宁省 云南省 海外
]
values = [
  13, 12, 9, 9, 8, 7, 7, 6, 5, 4, 4, 3, 3, 3, 3, 2, 2, 2, 2, 2, 2, 1, 1, 1, 1, 1, 1
]

chart.add_series('地域分布详情数据', categories, values)

filename = 'simpleDoughnutChartDocument.docx'
system "rm -f ~/Desktop/#{filename}" # -f so that we don't have an error if the file doesn't exist
docx.write_to File.expand_path("~/Desktop/#{filename}")
exec "open ~/Desktop/#{filename}"
