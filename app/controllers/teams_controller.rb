class TeamsController < ChapterAuthenticationController

  before_filter :get_team
  authorize_resource

  def index
    @teams = @chapter.teams.page(params[:page])

    respond_to do |format|
      format.html # index.html.erb
    end
  end

  def show
  end

  def new
    @team = @chapter.teams.build
  end

  def edit
  end

  def create
    begin
      @team = @chapter.teams.build()
      @team.update_attributes(team_params)
      success = true
    rescue
      success = false
    end

    if success && @team.save
      redirect_to chapter_team_url(@chapter, @team), notice: 'Team was successfully created.'
    else
      render action: "new"
    end
  end

  def update
    begin
      success = @team.update_attributes(team_params)
    rescue
      success = false
    end

    if success
      redirect_to chapter_team_url(@chapter, @team), notice: 'Team was successfully updated.'
    else
      render action: "edit"
    end
  end

  def delete
  end

  def destroy
    @team.destroy
    redirect_to chapter_teams_url(@chapter), notice: "Successfully deleted team for #{@team}"
  end

  private

    def get_team
      @team = @chapter.teams.find(params[:id]) if params[:id]
    end

    def team_params
      params.require(:team).permit(:chapter_id, :event_id, :student_ids => [])
    end

end
