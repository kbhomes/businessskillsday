class ChaptersController < ChapterAuthenticationController

  authorize_resource

  def show
    respond_to do |format|
      format.html # show.html.erb
      format.json { render json: @chapter }
    end
  end

  def edit
  end

  def update
    respond_to do |format|
      if @chapter.update_attributes(chapter_params)
        format.html { redirect_to @chapter, notice: 'Chapter was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render action: "edit" }
        format.json { render json: @chapter.errors, status: :unprocessable_entity }
      end
    end
  end

  def results
    @student_results = StudentResult.joins{participant.outer.chapter.outer}.joins{event}.where{chapters.id == my{@chapter.id}}.order{events.number}
    @team_results =       TeamResult.joins{participant.outer.chapter.outer}.joins{event}.where{chapters.id == my{@chapter.id}}.order{events.number}
  end

  private

    def chapter_params
      params.require(:chapter).permit(:name, :address, :city, :state, :zip, :contact, :email, :invoice_sent)
    end
end
