# frozen_string_literal: true

describe Utils::ImageUtil do
  describe '.guess_image_type' do
    let(:png) { File.open('spec/fixtures/docx.png') }
    let(:jpg) { File.open('spec/fixtures/cute.jpg') }
    let(:gif) { File.open('spec/fixtures/loading.gif') }

    it 'guesses correctly on image type' do
      expect(described_class.guess_image_type(png)).to eq(:png)
      expect(described_class.guess_image_type(jpg)).to eq(:jpeg)
    end

    it 'raises error for unsupported image type' do
      expect { described_class.guess_image_type(gif) }.to raise_error(UnsupportedImageType)
    end

    context 'with different sources' do
      let!(:url) { 'https://www.google.com/images/branding/googlelogo/2x/googlelogo_color_272x92dp.png' }

      it 'accepts with a readable stream' do
        file_readable = File.open('spec/fixtures/cute.jpg')
        expect(described_class.guess_image_type(file_readable)).to eq(:jpeg)
      end

      it 'accepts with a base64 string' do
        base64 = File.read('spec/fixtures/png_base64')
        expect(described_class.guess_image_type(base64)).to eq(:png)
      end

      it 'accepts with a file path' do
        path = 'spec/fixtures/docx.png'
        expect(described_class.guess_image_type(path)).to eq(:png)
      end

      it 'accepts with a url readable stream', if: ENV.fetch('ALL_SPECS', nil).present? do
        url_readable = URI.parse(url).open
        expect(described_class.guess_image_type(url_readable)).to eq(:png)
      end

      it 'accepts with a url path', if: ENV.fetch('ALL_SPECS', nil).present? do
        expect(described_class.guess_image_type(url)).to eq(:png)
      end
    end
  end
end
