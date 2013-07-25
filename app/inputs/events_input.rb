class EventsInput < SimpleForm::Inputs::CollectionCheckBoxesInput
  include ActionView::Helpers::TextHelper
  include EventsHelper

  def input
    label_method, value_method = detect_collection_methods
    student = object
    chapter = student.chapter

    @builder.collection_check_boxes(
      attribute_name, collection, value_method, label_method,
      input_options, input_html_options
    ) do |b|
        event = b.object
        text = event_with_icon(event)
        available = true

        if event.is_a?(IndividualPerformanceEvent)
          count = event.students_for_chapter(chapter).count
          available = student.events.include?(event) || chapter.can_register_for_event?(event, count)
          count_class = if available then 'muted' else 'text-error' end
          text = "#{text} - <span class=\"#{count_class}\">#{pluralize(count, 'student')}</span>".html_safe
        end

        b.check_box(:disabled => !available) + b.label(:disabled => !available) { text}
    end

  end
end