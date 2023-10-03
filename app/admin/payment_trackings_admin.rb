# frozen_string_literal: true

Trestle.resource(:payment_trackings) do
  menu do
    item :payment_trackings, icon: "fa fa-star", label: "Sổ ngày"
  end

  collection do |params|
    date = params[:filter_by_date] || Date.current
    model.includes(:borrower).filter_by_date(date.to_date)
  end

  hook("resource.index.header") do
    render "trestle/filter/date"
  end

  table do
    column :borrower_id, header: "Họ tên" do |payment_trackings|
      payment_trackings.borrower.name
    end
    column :amount, header: "Số tiền"
    column :note, header: "Ghi chú"

    actions
  end

  form do |_payment_tracking|
    collection_select :borrower_id,
      Borrower.for_listing,
      :id,
      :name,
      { label: "Danh sách người mượn", include_blank: "- Chọn tên -" }
    row do
      col { number_field :amount, label: "Số tiền" }
      col { text_field :note, label: "Ghi chú" }
    end
  end

  params do |params|
    params.require(:payment_tracking).permit(:amount, :note, :borrower_id)
  end
end
