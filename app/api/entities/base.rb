# frozen_string_literal: true

module Entities
  class Base < Grape::Entity
    root 'data', 'data'

    format_with(:iso_timestamp) { |dt| dt&.iso8601 }
  end
end
