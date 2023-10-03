# frozen_string_literal: true

module ApplicationHelper
  include Pagy::Frontend

  def flash_messages
    flash_data = {
      messages: [],
    }

    flash.each do |type, messages|
      flash_data[:messages] << {
        type:,
        body: messages.is_a?(Array) ? messages.join("<br />") : messages,
      }
    end

    flash_data[:messages]
  end
end
