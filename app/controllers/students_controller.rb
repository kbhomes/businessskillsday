class StudentsController < ChapterAuthenticationController

  before_filter :get_student
  authorize_resource

  def index
    @students = @chapter.students.page(params[:page])
  end

  def show
  end

  def new
    @student = @chapter.students.build

    respond_to do |format|
      format.html # new.html.erb
      format.json { render json: @student }
    end
  end

  def edit
  end

  def create
    begin
      @student = @chapter.students.build()
      success = @student.update_attributes(student_params)
    rescue
      success = false
    end

    respond_to do |format|
      if success && @student.save
        format.html { redirect_to chapter_student_url(@chapter, @student), notice: 'Student was successfully created.' }
      else
        format.html { render action: "new" }
      end
    end
  end

  def update
    begin
      success = @student.update_attributes(student_params)
    rescue
      success = false
    end

    respond_to do |format|
      if success
        format.html { redirect_to chapter_student_url(@chapter, @student), notice: 'Student was successfully updated.' }
      else
        format.html { render action: "edit" }
      end
    end
  end

  def delete
  end

  def destroy
    @student.destroy
    redirect_to chapter_students_url(@chapter), notice: "Successfully deleted student #{@student.name}"
  end

  private

    def get_student
      @student = @chapter.students.find(params[:id]) if params[:id]
    end

    def student_params
      p = params.require(:student).permit(:name, :grade, :team_id, :event_ids => [])

      if p[:team_id].present? && Team.find(p[:team_id])
        p[:event_ids] << Team.find(p[:team_id]).event.id
      end

      p
    end
end
