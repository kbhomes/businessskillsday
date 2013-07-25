class AdvisersController < ChapterAuthenticationController

  before_filter :get_adviser
  authorize_resource

  def index
    @advisers = @chapter.advisers.page(params[:page])
  end

  def show
  end

  def new
    @adviser = @chapter.advisers.build
  end

  def edit
  end

  def create
    @adviser = @chapter.advisers.build(adviser_params)

    if @adviser.save
      redirect_to chapter_adviser_url(@chapter, @adviser), notice: 'Adviser was successfully created.'
    else
      render action: "new"
    end
  end

  def update
    if @adviser.update_attributes(adviser_params)
      redirect_to chapter_adviser_url(@chapter, @adviser), notice: 'Adviser was successfully updated.'
    else
      render action: "edit"
    end
  end

  def destroy
    @adviser.destroy
    redirect_to chapter_advisers_url(@chapter), notice: "Successfully deleted adviser #{@adviser.name}"
  end

  private

    def get_adviser
      @adviser = @chapter.advisers.find(params[:id]) if params[:id]
    end

    def adviser_params
      params.require(:adviser).permit(:name)
    end
end
