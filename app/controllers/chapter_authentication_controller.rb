class ChapterAuthenticationController < ApplicationController

  before_filter :get_chapter

  private

    def get_chapter
      id ||= params[:chapter_id] if params[:chapter_id]
      id ||= params[:id] if params[:id]

      @chapter = Chapter.find(id) if id
    end
end