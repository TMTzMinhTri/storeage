Trestle.resource(:borrowers) do
  menu do
    item :borrowers, icon: 'fa fa-users', label: 'Người mượn'
  end

  collection do
    model.for_listing
  end

  table do
    column :name, link: true, header: 'Họ tên'
    column :amount, header: 'Số tiền mượn'
    column :district, link: false, header: 'Quận'
    column :ward, link: false, header: 'Phường'
    column :note, header: 'Ghi Chú'
    column :created_at, align: :center, header: 'Ngày tạo' do |a|
      a.created_at.localtime.to_fs(:short)
    end
    actions
  end

  form do |borrower|
    text_field :name, label: 'Họ tên'
    row do
      col { number_field :amount, label: 'Số tiền' }
      col { text_field :note, label: 'Ghi chú' }
    end

    row do
      col do
        select :district_id, Location.district, { include_blank: '- Chọn quận -', label: 'Quận' }
      end
      col do
        select :ward_id, Location.wards(borrower.district_id), { include_blank: '- Chọn phường -', label: 'Phường' }
      end
    end
  end

  params do |params|
    params.require(:borrower).permit(:name, :amount, :note, :district_id, :ward_id)
  end
end
