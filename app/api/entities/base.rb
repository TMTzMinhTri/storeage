# frozen_string_literal: true

module Entities
  class Base < Grape::Entity
    include ActionView::Helpers::TextHelper
    root 'data', 'data'

    format_with(:iso_timestamp) { |dt| dt&.iso8601 }
    format_with(:truncate) do |string|
      truncate(string.gsub(/\s+/, ' '), length: 140, separator: ' ')
    end
  end
end
