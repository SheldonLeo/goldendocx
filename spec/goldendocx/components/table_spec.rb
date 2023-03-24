# frozen_string_literal: true

describe Goldendocx::Components::Table do
  let(:headers) { %w[名称 数量 占比] }
  let(:rows) { [%w[A 10 10%], %w[B 66 66%], %w[C 24 24%]] }
  let(:table) { described_class.new }

  describe '#add_header' do
    it 'adds header to headers' do
      expect do
        table.add_header('Column 1')
      end.to change { table.header.cells.size }.by(1)
    end
  end

  describe '#add_row' do
    it 'adds row to rows' do
      expect do
        row = table.add_row(%w[Data1 Data2])
        expect(row.cells.size).to eq(2)
      end.to change { table.rows.size }.by(1)
    end

    it 'adds cells to rows' do
      cell = Goldendocx::Tables::Cell.new
      expect do
        row = table.add_row([cell])
        expect(row.cells.size).to eq(1)
      end.to change { table.rows.size }.by(1)
    end

    it 'parses hash to cells and add to rows' do
      expect do
        row = table.add_row([{ content: 'Data1', span: 3 }])
        expect(row.cells.size).to eq(1)
      end.to change { table.rows.size }.by(1)
    end
  end
end
