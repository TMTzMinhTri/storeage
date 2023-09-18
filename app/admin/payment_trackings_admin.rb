Trestle.resource(:payment_trackings) do
  menu do
    item :payment_trackings, icon: 'fa fa-star', label: 'Sổ ngày'
  end

  collection do
    model.includes(:borrower)
  end

  table do
    column :borrower_name do |payment_trackings|
      payment_trackings.borrower.name
    end
    column :amount
    column :note

    actions
  end

  form do |_payment_tracking|
    select :borrower_id, Borrower.for_listing
    row do
      col { number_field :amount }
      col { text_field :note }
    end
  end

  params do |params|
    params.require(:payment_tracking).permit(:amount, :note, :borrower_id)
  end
end
