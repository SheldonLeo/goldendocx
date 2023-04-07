# The Ruby API for Microsoft Word

[![Gem Version](https://badge.fury.io/rb/goldendocx.svg)](https://badge.fury.io/rb/goldendocx)
[![Coverage Status](https://coveralls.io/repos/github/SheldonLeo/goldendocx/badge.svg)](https://coveralls.io/github/SheldonLeo/goldendocx)

Ruby APIs for manipulating Microsoft Word based upon OOXML standards.

## Installation

Install the gem and add to the application's Gemfile by executing:

    $ bundle add goldendocx

If bundler is not being used to manage dependencies, install the gem by executing:

    $ gem install goldendocx

## Usage

```ruby
  require 'goldendocx'
```

### XML Serializers

Support both `ox` and `nokogiri` as XML serializer, and `ox` as default.

You can customize with configuration

```ruby
Goldendocx.configure do |config|
  config.xml_serializer = :nokogiri
end
```

### Compose MS Word

- Create new MS Word file or read exists file and write to another path
    ```ruby
      docx = Goldendocx::Docx.new
      docx = Goldendocx::Docx.new(docx_file_path)
      docx.read_from(docx_file_path)
  
      docx.write_to(new_file_path)
    ```
- Create texts to MS Word
    ```ruby
      docx.create_text("Hello World!")
    ```
    ```ruby
      docx.add_style(well_comsposed_style_path)
      docx.create_text("Hello World!", style: 'StyleName', align: :center)
    ```
- Create tables to MS Word
    ```ruby
      headers = %w[名称 数量 百分比]
      rows = [
        %w[A 10 10%],
        %w[B 66 66%],
        %w[C 24 24%]
      ]
      table = docx.create_table
      headers.each { |header| table.add_header(header) }
      rows.each { |row| table.add_row(row) }
    ```
- Create images to MS Word
    ```ruby
      docx.create_image(File.open(image_path))
      docx.create_image("data:image/png;base64,ImageBase64StringData")
      docx.create_image(Kernel.open('https://image.url'))
    ```  

- Create charts to MS Word
    ```ruby
      chart = docx.create_chart(:column)
      chart.name = '地域分布详情数据'
        
      categories = %w[河南省 山东省 浙江省 四川省 安徽省 上海市 湖北省 山西省 河北省 贵州省]
      values = [13, 12, 9, 9, 8, 7, 7, 6, 5, 3]
      chart.add_series('地域分布详情数据', categories, values)
    ```

More demos view at [Demos](demo/)

