# frozen_string_literal: true

require 'ox'
require 'fileutils'
require 'active_support/core_ext/string/inflections'

class XmlToClass
  def parse(node)
    @node = node
    @namespace, @tag = parse_tag(@node.name)
    @class_name = "#{@tag}Property".classify
    parse_attributes
    parse_children
    self
  end

  def write_rb(dir)
    dir_to_write = "#{Dir.pwd}/lib/#{dir}"
    FileUtils.mkdir_p(dir_to_write)

    File.open("#{dir_to_write}/#{@tag}.rb", 'w') do |f|
      f.puts '# frozen_string_literal: true'
      f.puts ''
      f.puts "class Goldendocx::#{@class_name}"
      f.puts '  include Goldendocx::Element'
      f.puts ''
      f.puts "  namespace :#{@namespace}" if @namespace
      f.puts "  tag :#{@tag}"
      f.puts ''
      @attributes.each do |name, opt|
        options = opt.map { |k, v| "#{k}: :#{v}" }.join(',')
        f.puts "  attribute :#{name.underscore}, #{options}"
      end
      f.puts ''
      @children.group_by(&:to_s).each do |name, values|
        method = values.size > 1 ? :embeds_many : :embeds_one
        _, class_name = parse_tag(name)
        f.puts "  #{method} :#{class_name.underscore}, class_name: 'Goldendocx::#{class_name.classify}Property'"
      end
      f.puts 'end'
    end

    @subclasses.each { |c| c.write_rb("#{dir}/#{@tag}") }
  end

  def write_spec(dir)
    dir_to_write = "#{Dir.pwd}/spec/#{dir}"
    FileUtils.mkdir_p(dir_to_write)

    File.open("#{dir_to_write}/#{@tag}_spec.rb", 'w') do |f|
      f.puts '# frozen_string_literal: true'
      f.puts ''
      f.puts "describe Goldendocx::#{@class_name} do"
      f.puts '  let(:property) { described_class.new }'
      f.puts ''
      f.puts "  specify 'builds default #{@tag} property xml' do "
      f.puts "    expect(property.to_xml).to eq('<#{@namespace}:#{@tag}/>')"
      f.puts '  end'
      f.puts ''
      f.puts "  specify 'builds customized #{@tag} property xml' do"
      f.puts '    property.attribute = :value '
      f.puts "    expect(property.to_xml).to eq('<#{@namespace}:#{@tag}/>') "
      f.puts '  end '
      f.puts 'end'
    end

    @subclasses.each { |c| c.write_spec("#{dir}/#{@tag}") }
  end

  def parse_tag(string)
    string = string.to_s
    string.include?(':') ? string.split(':') : [nil, string]
  end

  def parse_attributes
    @attributes ||= {}
    @node.attributes.each_key do |name|
      ns, tg = parse_tag(name)
      @attributes[tg] = { alias_name: tg, namespace: ns }.compact
    end
  end

  def parse_children
    @children = []
    @subclasses = []
    @node.nodes.each do |node|
      @children << node.name.to_s
      @subclasses << XmlToClass.new.parse(node)
    end
  end
end
