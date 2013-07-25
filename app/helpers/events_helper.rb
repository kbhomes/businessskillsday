module EventsHelper
  def event_with_icon(event)
    return '' unless event.present?

    icon = case event
             when WrittenEvent
               'icon-pencil'
             when IndividualPerformanceEvent
               'icon-user'
             when TeamPerformanceEvent
               'icon-group'
           end
    "<i class=\"#{icon}\"></i> #{event.to_s}".html_safe
  end

  def events_with_icons(events, separator = '<br>')
    events.map { |ev| event_with_icon ev }.to_sentence(
        :words_connector => separator,
        :two_words_connector => separator,
        :last_word_connector => separator
    ).html_safe
  end

  def event_type(event)
    case event
      when WrittenEvent
        'Written'
      when IndividualPerformanceEvent
        'Individual Performance'
      when TeamPerformanceEvent
        'Team Performance'
      else
        'Event'
    end
  end

  def participants_type(event)
    case event
      when WrittenEvent
        'Students'
      when TeamPerformanceEvent
        'Teams'
      else
        'Participants'
    end
  end

  def participants_count(event)
    if event.is_a? TeamPerformanceEvent
      pluralize event.participants.count, 'team'
    else
      pluralize event.participants.count, 'student'
    end
  end
end