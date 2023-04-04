# frozen_string_literal: true

describe Goldendocx::HasAttributes do
  it 'defines attributes for class' do
    element_class = Class.new do
      include Goldendocx::Element

      attribute :name
      attribute :color, namespace: :w
      attribute :style, alias_name: :s, default: 'STYLE'
    end

    expect(element_class.attributes.size).to eq(3)
    expect(element_class.attributes['name']).to eq({})
    expect(element_class.attributes['color']).to eq(namespace: :w)
    expect(element_class.attributes['style']).to eq(alias_name: :s, default: 'STYLE')

    element = element_class.new
    expect(element.attributes).to eq('s' => 'STYLE')
  end

  it 'defines setter and getter for instances' do
    element_class = Class.new do
      include Goldendocx::Element

      attribute :name
      attribute :gender, readonly: true
    end

    element = element_class.new
    expect(element).to be_respond_to(:name)
    expect(element).to be_respond_to(:name=)

    expect(element).to be_respond_to(:gender)
    expect(element).not_to be_respond_to(:gender=)
  end

  it 'assigns attributes' do
    element_class = Class.new do
      include Goldendocx::Element

      attribute :name
      attribute :gender
    end

    element = element_class.new
    element.assign_attributes(name: 'Harry', gender: :boy)
    expect(element.attributes).to eq('gender' => :boy, 'name' => 'Harry')
  end
end
