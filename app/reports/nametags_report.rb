class NametagsReport
  require 'prawn/measurement_extensions'

  def initialize(students)
    @students = students
    @pdf = Prawn::Document.new(
        :left_margin => (0.7).in,
        :right_margin => (0.7).in,
        :top_margin => (0.56).in,
        :bottom_margin => (0.5).in,
    )
    @pdf.font_size 10
    @pdf.stroke_color '888888'
    @pdf.line_width 0.5

    @students = @students.order{chapter.name}.references(:chapter)

    width = (3.38).in
    height = (2.33).in
    margin = (0.1).in

    horizontal_gap = (0.34).in
    vertical_gap = (0.21).in

    @students.each_with_index do |student, i|
      left = (i % 2 == 0) ? 0 : (width + horizontal_gap)
      top = @pdf.cursor

      name = "#{student.name}\n"
      number = "#{student.to_unique_number.to_s}\n"
      events = student.events.map { |event| "#{event.number.to_s.rjust(3, '0')} - #{event.to_s}" }.join("\n")

      @pdf.bounding_box([left, top], :width => width, :height => height) do
        # @pdf.stroke_bounds
        @pdf.bounding_box([margin, height - margin], :width => width - 2*margin, :height => height - 2*margin) do
          @pdf.formatted_text(
              [
                  { :text => name, :styles => [:bold] },
                  { :text => number },
                  { :text => "\n" },
                  { :text => events },
              ],
              :align => :center,
              :valign => :center
          )

          @pdf.text 'ASU Business Skills Day 25', :align => :center, :valign => :bottom, :color => 'CCCCCC', :size => 8
        end
      end

      # If we've finished the first student in the row,
      # then move back up so we can finish the second student
      # Else, move down by the gap.
      if (i % 2 == 0)
        @pdf.move_up height
      else
        @pdf.move_down vertical_gap
      end


      # Start a new page if we've just finished the 8th student for this page.
      @pdf.start_new_page if (i % 8 == 7)
    end
  end

  def render
    @pdf.render
  end
end