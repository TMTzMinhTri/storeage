module UserService
  class CreateUser < ApplicationService
    def initialize(params:)
      super
      @params = params
    end

    def call
      return unless create_user_params.permitted?

      ActiveRecord::Base.transaction do
        user = User.create!(create_user_params)
        store = user.store
        user.stores << store

        @result = user
      end
    end

    private

    def create_user_params
      @params.permit(:email,
                     :password,
                     :name,
                     store_attributes: [:name])
    end
  end
end
