module Admin
  class MainController < AdminController
    skip_authorize_resource

    def index
      @admin_chapters = Chapter.ordered
      @admin_students = Student.ordered
      @admin_advisers = Adviser.ordered
      @admin_teams = Team.ordered
      @admin_events = Event.all
      @admin_results = Result.all
      @admin_accounts = Account.all
      @admin_registrations = Registration.all
    end
  end
end