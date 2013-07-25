module Admin
  class StudentsController < AdminController
    # GET /admin/students
    def index
      @admin_students = Student.ordered.page(params[:page])
    end

    # GET /admin/students/new
    def new
      @admin_student = Student.new
    end

    # DELETE /admin/students/1
    def destroy
      @admin_student = Student.find(params[:id])
      @admin_student.destroy

      redirect_to admin_students_url
    end

    private

    def admin_student_params
      params.require(:admin_student).permit()
    end
  end
end