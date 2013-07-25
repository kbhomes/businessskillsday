module Admin
  class MainController < AdminController
    skip_authorize_resource

    def index
      @admin_chapters = Chapter.ordered
      @admin_students = Student.ordered
      @admin_advisers = Adviser.ordered
      @admin_teams = Team.ordered
      @admin_events = Event.scoped
      @admin_accounts = Account.scoped
    end
  end
end