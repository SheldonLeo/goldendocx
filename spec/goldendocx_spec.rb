# frozen_string_literal: true

RSpec.describe Goldendocx do
  it 'has a version number' do
    expect(Goldendocx::VERSION).not_to be_nil
  end

  context 'with configuration' do
    before do
      described_class.instance_variable_set(:@config, nil)
    end

    it 'returns xml serializer configuration' do
      described_class.configure { |config| config.xml_serializer = :ox }
      expect(described_class.config.xml_serializer).to eq(:ox)

      described_class.configure { |config| config.xml_serializer = :nokogiri }
      expect(described_class.config.xml_serializer).to eq(:nokogiri)
    end
  end

  describe '.xml_serializer' do
    before do
      described_class.instance_variable_set(:@xml_serializer, nil)
    end

    it 'returns configured xml serializer nokogiri' do
      described_class.configure { |config| config.xml_serializer = :nokogiri }

      expect(described_class.xml_serializer).to eq(Goldendocx::XmlSerializers::Nokogiri)
    end

    it 'returns configured xml serializer ox' do
      described_class.configure { |config| config.xml_serializer = :ox }

      expect(described_class.xml_serializer).to eq(Goldendocx::XmlSerializers::Ox)
    end

    it 'raise error if unsupported serializer nokogiri' do
      described_class.configure { |config| config.xml_serializer = :fastxml }

      expect { described_class.xml_serializer }.to raise_error(StandardError, /Unsupported XML serializer/)
    end
  end
end
