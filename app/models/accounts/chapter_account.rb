class ChapterAccount < Account

  # Validation
  validates :chapter, :presence => true

  def display_name
    if chapter.present?
      chapter.name
    else
      email
    end
  end
end