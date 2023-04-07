# frozen_string_literal: true

describe Goldendocx::ContentTypes::Override do
  let(:override) { described_class.new(part_name: 'part', content_type: 'type') }

  it 'compares with other instance' do
    same = described_class.new(part_name: 'part', content_type: 'type')
    expect(same).to eq(override)

    different = described_class.new(part_name: 'part1', content_type: 'type')
    expect(different).not_to eq(override)

    expect([same, different]).to be_any(override)
  end
end
