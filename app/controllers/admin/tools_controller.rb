module Admin
  class ToolsController < AdminController
    def index

    end

    def nametags
      students = Student.all.includes(:events, :chapter)

      respond_to do |format|
        format.html
        format.pdf do
          nametags = NametagsReport.new(students)
          send_data nametags.render,
                    :filename => 'nametags.pdf',
                    :type => 'application/pdf',
                    :disposition => 'inline'
        end
      end
    end
  end
end