# frozen_string_literal: true

describe Goldendocx::ContentTypes::Override do
  let(:override) { described_class.new('part', 'type') }

  it 'compares with other instance' do
    same = described_class.new('part', 'type')
    expect(same).to eq(override)

    different = described_class.new('part1', 'type')
    expect(different).not_to eq(override)

    expect([same, different]).to be_any(override)
  end
end
