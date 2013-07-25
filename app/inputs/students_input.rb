class StudentsInput < SimpleForm::Inputs::CollectionCheckBoxesInput
  include ActionView::Helpers::TextHelper
  include EventsHelper

  def input
    label_method, value_method = detect_collection_methods
    team = object
    chapter = team.chapter

    @builder.collection_check_boxes(
        attribute_name, collection, value_method, label_method,
        input_options, input_html_options
    ) do |b|
      student = b.object
      text = b.text
      available = true

      if student.events.any?
        text << "<small><span class=\"muted\"> - "
        text << events_with_icons(student.events, ' &bull; ')
        text << "</span></small>"

        available = false unless (student.can_register_for_team?(team) && student.can_register_for_event?(team.event))
      end

      b.check_box(:disabled => !available) + b.label { text.html_safe }
    end

  end
end