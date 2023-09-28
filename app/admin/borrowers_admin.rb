require 'prawn'

Trestle.resource(:borrowers) do
  menu do
    item :borrowers, icon: 'fa fa-users', label: 'Người mượn'
  end

  search do |query|
    query ? collection.pg_search(query) : collection
  end

  collection do
    model.for_listing
  end

  delete_instance do |instance, _attrs|
    instance.update!(deleted_at: Time.current)
  end

  hook('resource.index.footer') do
    content_tag(:div, "Tổng: #{Borrower.sum(&:amount)}")
  end

  table do
    column :name, link: true, header: 'Họ tên', sort: false
    column :amount, header: 'Số tiền mượn', sort: false
    column :district, link: false, header: 'Quận', sort: false
    column :ward, link: false, header: 'Phường', sort: false
    column :note, header: 'Ghi Chú', sort: false
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

    row data: { controller: 'location' } do
      col do
        select :district_id, Location.district, { include_blank: '- Chọn quận -', label: 'Quận' },
               { data: { 'location-target' => 'district' } }
      end
      col do
        select :ward_id, Location.wards(borrower.district_id), { include_blank: '- Chọn phường -', label: 'Phường' },
               { data: { 'location-target' => 'ward' } }
      end
    end
  end

  params do |params|
    params.require(:borrower).permit(:name, :amount, :note, :district_id, :ward_id)
  end

  controller do
    def export_to_pdf
      send_data generate_pdf,
                filename: "#{Date.current}.pdf",
                type: 'application/pdf',
                disposition: 'inline'
    end

    private

    def generate_pdf
      file = Pdf::Borrower.new
      file.render
    end
  end

  routes do
    get :export_to_pdf, on: :collection
  end
end
