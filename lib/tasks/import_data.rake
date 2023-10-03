# frozen_string_literal: true

require "csv"

namespace :import_data do
  desc "import data phone book from csv"
  task borrowers: :environment do
    path = Rails.root.join("lib/tasks/csv/data.csv").to_s
    raw_data = CSV.read(path)
    raw_data.shift
    clients = []
    Time.zone = "Hanoi"
    raw_data.each do |f|
      data = {
        name: f[1],
        note: f[2],
        district_id: f[4],
        ward_id: f[5],
        amount: f[3],
        created_at: Time.zone.parse(f[6]).utc,
      }
      clients << data
    end
    p "start"
    Borrower.create!(clients)
    p "done"
  end

  desc "import location from csv"
  task locations: :environment do
    path = Rails.root.join("lib/tasks/csv/locations.csv").to_s
    raw_data = CSV.read(path)
    raw_data.shift
    locations = []

    raw_data.each do |f|
      locations << {
        name: f[1],
        address_type: f[2] == "1" ? :district : :ward,
        parent_id: f[3],
      }
    end
    p("start")
    Location.create(locations)
    p("done")
  rescue StandardError => e
    p(e.methods)
  end
end
