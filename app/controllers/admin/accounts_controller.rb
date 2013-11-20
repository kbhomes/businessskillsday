module Admin
  class AccountsController < AdminController

    before_filter :check_authorization, :get_account

    def index
      @admin_accounts = Account.all.page(params[:page])
    end

    def show
    end

    def new
      @admin_account = Account.new
    end

    def edit
    end

    def create
      @admin_account = Account.create_and_setup(admin_account_params)

      if @admin_account.valid?
        redirect_to admin_account_url(@admin_account), notice: 'Account was successfully created.'
      else
        render action: "new"
      end
    end

    def update
      account_params = admin_account_params
      success = true

      # Admins don't need the user's current password to force a new one
      unless current_ability.can? :update, :passwords
        current_password = account_params.delete(:current_password)
        if account_params[:password].present? || account_params[:password_confirmation].present?
          success = @admin_account.authenticate(current_password)
          @admin_account.errors.add(:current_password, 'is incorrect') unless success
        end
      end

      if success && @admin_account.update_attributes(account_params)
        @current_ability = nil
        @current_user = nil

        redirect_to admin_account_url(@admin_account), notice: 'Account was successfully updated.'
      else
        render action: "edit"
      end
    end

    def delete
    end

    def destroy
      @admin_account.destroy
      redirect_to admin_accounts_url, notice: "Successfully deleted account #{@admin_account.display_name}"
    end

    private

    def check_authorization
      redirect_to post_login_url(current_account), :flash => { :error => 'You cannot view other accounts.' } unless can?(:manage, Account)
    end

    def get_account
      @admin_account = Account.find(params[:id]) if params[:id]
    end

    def admin_account_params
      p = params.require(:admin_account).permit(:email, :type, :chapter_id, :current_password, :password, :password_confirmation)

      # Only admins are able to set these.
      unless can? :manage, :all
        p.delete(:type)
        p.delete(:chapter_id)
      end

      p
    end
  end
end