module StudentEventsAssociationExtension
  def owner
    proxy_association.owner
  end

  def events
    owner.events
  end

  def errors
    owner.errors
  end

  def grade
    owner.grade
  end

  def check_duplicate(event)
    !events.where{id == event.id}.exists?
  end

  def check_maximum_events_limit(event)
    unless events.count < 3
      message = 'Student cannot participate in more than 3 events'
      errors.add(:events, message)
      raise message
    end
    true
  rescue
    false
  end

  def check_grade_and_event(event)
    if event.nine_ten && (11..12).include?(grade)
      message = 'Student cannot participate in a grade 9/10 event'
      errors.add(:events, message)
      raise message
    end
    true
  rescue
    false
  end

  def check_written_events(event)
    if event.is_a? WrittenEvent
      unless events.select { |ev| ev.is_a? WrittenEvent }.count < 3
        message = 'Student cannot participate in more than 3 written events'
        errors.add(:events, message)
        raise message
      end
    end
    true
  rescue
    false
  end

  def check_performance_events(event)
    if event.is_a? PerformanceEvent
      unless events.select { |ev| ev.is_a? PerformanceEvent }.count < 1
        message = 'Student cannot participate in more than 1 performance event'
        errors.add(:events, message)
        raise message
      end
    end
    true
  rescue
    false
  end

  def handle_add_team_event(event)
    if event.is_a? TeamPerformanceEvent
      # Find the team for the chapter for this event.
      team = owner.chapter.teams.where{event_id == event.id}.first
      owner.team = team
      owner.save
    end
  end

  def handle_remove_team_event(event)
    if event.is_a? TeamPerformanceEvent
      owner.team = nil
      owner.save
    end
  end

  def <<(*records)
    (records.map do |r|
      return false unless check_duplicate(r)
      return false unless check_grade_and_event(r)
      return false unless check_maximum_events_limit(r)
      return false unless check_performance_events(r)
      return false unless check_written_events(r)

      proxy_association.concat(r)
      handle_add_team_event r

      true
    end).all?
  end

  def delete(*records)
    records.each do |r|
      proxy_association.delete r
      handle_remove_team_event r
    end
  end
end