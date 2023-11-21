namespace :import_data do
  task locations: :environment do
    p 'starting'
    result = []
    path = Rails.root.join('lib/tasks/locations.json').to_s
    file = File.read(path)
    locations = JSON.parse file
    locations.each do |provice|
      pv = Location.new(name: provice['name'], address_type: 0)
      provice['districts'].each do |district|
        dt = pv.districts.build(name: district['name'], address_type: 1)
        district['wards'].each do |ward|
          dt.wards.build(name: ward['name'], address_type: 2)
        end
      end
      result << pv
    end
    Location.import(result, recursive: true)
    p 'done'
  end
end
