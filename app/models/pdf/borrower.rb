class Pdf::Borrower < Prawn::Document
  def initialize
    super
    header
    borrower_table
  end

  def header
    text "Ngày #{Time.now}", align: :center, size: 18
  end

  def borrower_table
    data = []
    data << ['Họ tên']
  end
end
