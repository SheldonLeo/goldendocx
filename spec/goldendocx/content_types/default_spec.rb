# frozen_string_literal: true

describe Goldendocx::ContentTypes::Default do
  let(:default) { described_class.new('ext', 'type') }

  it 'compares with other instance' do
    same = described_class.new('ext', 'type')
    expect(same).to eq(default)

    different = described_class.new('ext1', 'type1')
    expect(different).not_to eq(default)

    expect([same, different]).to be_any(default)
    expect([default, default].uniq.size).to eq(1)
  end
end
