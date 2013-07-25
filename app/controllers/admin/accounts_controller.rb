module Admin
  class AccountsController < AdminController

    before_filter :get_account

    def index
      @admin_accounts = Account.scoped.page(params[:page])
    end

    def show
    end

    def new
      @admin_account = Account.new
    end

    def edit
    end

    def create
      password = SecureRandom.hex(10)
      account_params = admin_account_params
      account_params[:password] = account_params[:password_confirmation] = password

      # Make sure the type parameter is valid.
      raise 'Account type is not valid' unless Account.types.include?(account_params[:type])

      @admin_account = (account_params[:type].constantize).new(account_params)

      if @admin_account.save
        AccountMailer.new_account(@admin_account, password).deliver
        redirect_to admin_account_url(@admin_account), notice: 'Account was successfully created.'
      else
        render action: "new"
      end
    end

    def update
      account_params = admin_account_params
      success = true

      current_password = account_params.delete(:current_password)
      if account_params[:password].present? || account_params[:password_confirmation].present?
        success = @admin_account.authenticate(current_password)
        @admin_account.errors.add(:current_password, 'is incorrect') unless success
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