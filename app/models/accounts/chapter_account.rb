class ChapterAccount < Account

  # Validation
  validates :chapter, :presence => true

  def display_name
    chapter.name
  end
end