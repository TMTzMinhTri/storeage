module UserService
  class InviteUser < ApplicationService
    def initialize(store_id:, user_params:, current_user:)
      super
      @store_id = store_id
      @params = user_params
      @current_user = current_user
    end

    def call
      return unless invite_user_params.permitted?

      raise ApplicationError, 'Store invalid' if store.nil?

      ActiveRecord::Base.transaction do
        user = User.create_with(invite_user_params)
                   .find_or_create_by(email: invite_user_params[:email])

        user_stores = user.user_stores.build(store_id: store.id, role: :staff)
        user_stores.save!
        @result = user
      end
    end

    private

    def invite_user_params
      @params.require(:user).permit(:email, :name)
    end

    def store
      @store ||= Store.joins(:user_stores)
                      .where(user_stores: {
                               user_id: @current_user.id,
                               store_id: @store_id
                             }).first
    end
  end
end
