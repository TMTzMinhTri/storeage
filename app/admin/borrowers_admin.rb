Trestle.resource(:borrowers) do
  menu do
    item :borrowers, icon: 'fa fa-users', label: 'Người mượn'
  end

  collection do
    model.for_listing
  end

  # Customize the table columns shown on the index view.
  #
  table do
    column :id
    column :name, link: true
    column :amount
    # column :district, link: false
    # column :ward, link: false
    column :note
    column :created_at, align: :center
    actions
  end

  # Customize the form fields shown on the new/edit views.
  #
  form dialog: true do |_borrower|
    text_field :name
    row do
      col { number_field :amount }
      col { text_field :note }
    end

    # row do
    # col { select :district_id, Location.district }
    # col { select :ward_id, Location.wa }
    # end
  end

  params do |params|
    params.require(:borrower).permit(:name, :amount, :note, :district_id)
  end
end
