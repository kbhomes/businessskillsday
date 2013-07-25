module Admin
  class TeamsController < AdminController
    # GET /admin/teams
    def index
      @admin_teams = Team.ordered.page(params[:page])
    end

    # GET /admin/teams/new
    def new
      @admin_team = Team.new
    end

    # DELETE /admin/teams/1
    def destroy
      @admin_team = Team.find(params[:id])
      @admin_team.destroy

      redirect_to admin_teams_url
    end

    private

    # Use this method to whitelist the permissible parameters. Example:
    # params.require(:person).permit(:name, :age)
    # Also, you can specialize this method with per-user checking of permissible attributes.
    def admin_team_params
      params.require(:admin_team).permit()
    end
  end
end