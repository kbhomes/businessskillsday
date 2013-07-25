module Admin
  class ChaptersController < AdminController
    def index
      @admin_chapters = Chapter.ordered.page(params[:page])
    end

    def new
      @admin_chapter = Chapter.new
    end

    def delete
      @admin_chapter = Chapter.find(params[:id])
    end

    def destroy
      @admin_chapter = Chapter.find(params[:id])
      @admin_chapter.destroy

      redirect_to admin_chapters_url
    end

    private

    def admin_chapter_params
      params.require(:admin_chapter).permit(:name, :address, :city, :state, :zip, :contact, :email, :invoice_sent)
    end
  end
end