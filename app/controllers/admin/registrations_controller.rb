class Admin::RegistrationsController < Admin::AdminController

  before_filter :check_authorization, :get_registration

  def index
    @registrations = Registration.all
  end

  def edit
  end

  def update
    if @registration.update_attributes(registration_params)
      redirect_to admin_registration_url(@registration), :notice => "Successfully updated registration for #{@registration.chapter}"
    else
      render :edit
    end
  end

  def show
  end

  def delete
  end

  def destroy
    @registration.destroy
    redirect_to admin_registrations_url, :notice => "Successfully deleted registration for #{@registration.chapter}."
  end

  def confirm
  end

  def approve
    # Create a new chapter.
    chapter = Chapter.create :name => @registration.chapter,
                             :email => @registration.email,
                             :contact => @registration.contact,
                             :address => @registration.address,
                             :city => @registration.city,
                             :state => @registration.state,
                             :zip => @registration.zip

    account = Account.create_and_setup :email => @registration.email,
                                       :type => 'ChapterAccount',
                                       :chapter_id => chapter.id

    if account.valid?
      @registration.destroy
      redirect_to admin_account_path(account), :notice => "Successfully approved and deleted registration, created chapter, and created account for #{@registration.chapter}."
    else
      redirect_to admin_registrations_url, :flash => { :error => "Unable to approve registration for #{@registration.chapter}"}
    end
  end

  private

  def check_authorization
    redirect_to post_login_url(current_account), :flash => { :error => 'You cannot view registrations.' } unless can?(:manage, Registration)
  end


  def get_registration
    @registration = Registration.find(params[:id]) if params[:id]
  end

  def registration_params
    params.require(:registration).permit(:chapter, :email, :contact, :address, :city, :state, :zip)
  end

end
