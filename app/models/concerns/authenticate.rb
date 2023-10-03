# frozen_string_literal: true

module Authenticate
  extend ActiveSupport::Concern
  module ClassMethods
    def authorize!(params)
      account = find_for_database_authentication(params.slice(*authentication_keys))
      raise ApplicationError, i18n_message(invalid) unless account

      return unless check_valid_for_authentication(account) do
                      account.valid_password?(params[:password])
                    end

      unless account.active_for_authentication?
        raise ApplicationError,
          i18n_message(account.inactive_message)
      end

      account
    end

    def check_valid_for_authentication(resource, &)
      result = resource.valid_for_authentication?(&)
      raise ApplicationError, i18n_message(resource.unauthenticated_message) unless result

      true
    end

    def find_for_database_authentication(warden_conditions)
      conditions = warden_conditions.dup

      if (username = conditions.delete(:username))
        where(conditions.to_h)
          .where([
            "lower(phone_number) = :value OR lower(email) = :value",
            { value: username.strip.downcase },
          ])
          .first

      elsif conditions.key?(:phone_number) || conditions.key?(:email)
        where(conditions.to_h).first
      end
    end

    def i18n_message(default = nil)
      message = default || :unauthenticated
      if message.is_a?(Symbol)
        options = {}
        options[:scope] = "devise.failure"
        auth_keys = scope_class.authentication_keys
        keys = (auth_keys.respond_to?(:keys) ? auth_keys.keys : auth_keys).map do |key|
          scope_class.human_attribute_name(key)
        end
        options[:authentication_keys] = keys.join(I18n.t(:"support.array.words_connector"))
        options = i18n_options(options)

        I18n.t(message.to_s, **options)
      else
        message.to_s
      end
    end

    def scope_class
      name.constantize
    end

    def i18n_options(options)
      options
    end
  end
end
