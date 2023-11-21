module UserService
  class RegisterUser < ApplicationService
    def initialize(params:)
      super
      @params = params
    end

    def call
      return unless register_user_params.permitted? || store_params.permitted?

      ActiveRecord::Base.transaction do
        user = User.create_with(register_user_params)
                   .find_or_create_by(email: register_user_params[:email])
        user.stores.create!(store_params)
        @result = user
      end
    end

    private

    def register_user_params
      @params.require(:user).permit(:email,
                                    :password,
                                    :password_confirmation,
                                    :name)
    end

    def store_params
      @params.require(:store).permit(:name)
    end
  end
end
