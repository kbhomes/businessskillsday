module Admin
  class AdvisersController < AdminController
    # GET /admin/advisers
    def index
      @admin_advisers = Adviser.ordered.page(params[:page])
    end

    # GET /admin/advisers/1
    def show
      @admin_adviser = Adviser.find(params[:id])
    end

    # GET /admin/advisers/new
    def new
      @admin_adviser = Adviser.new
    end

    # DELETE /admin/advisers/1
    def destroy
      @admin_adviser = Adviser.find(params[:id])
      @admin_adviser.destroy

      redirect_to admin_advisers_url
    end

    private

    def admin_adviser_params
      params.require(:admin_adviser).permit()
    end
  end
end