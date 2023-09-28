class Pdf::Borrower < Prawn::Document
  def initialize
    super
    font Rails.root.join('app/assets/fonts/Roboto-Light.ttf')
    header
    borrower_table
  end

  def header
    text Date.current.to_fs(:iso8601), align: :center, size: 18
  end

  def borrower_table
    data = []
    data << ['', 'Họ tên', 'mượn', 'ghi chú']
    Borrower.find_each do |row|
      data << ['', row['name'], row['amount'], row['note']]
    end

    table(data, position: :center, cell_style: { overflow: :shrink_to_fit }) do
      row(0).width = 60
    end
  end
end
