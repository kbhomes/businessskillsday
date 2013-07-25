module TeamStudentsAssociationExtension
  def owner
    proxy_association.owner
  end

  def students
    owner.students
  end

  def errors
    owner.errors
  end

  def grade
    owner.grade
  end

  def check_duplicate(student)
    !students.where{id == student.id}.exists?
  end

  def check_can_register_for_team(student)
    unless student.can_register_for_team?(owner)
      message = 'cannot register this student'
      errors.add(:students, message)
      raise message
    end
    true
  rescue
    false
  end

  def check_maximum_team_size(student)
    unless students.count < 4
      message = 'cannot have more than 4 students'
      errors.add(:students, message)
      raise message
    end
    true
  rescue
    false
  end

  def check_student_belongs_to_chapter(student)
    unless student.chapter == owner.chapter
      message = 'must belong to the same chapter as the team'
      errors.add(:students, message)
      raise message
    end
    true
  rescue
    false
  end

  def handle_remove_student(student)
    student.events.delete(owner.event)
    student.team = nil
    student.save
  end

  def <<(*records)
    (records.map do |r|
      return false unless check_duplicate(r)
      return false unless check_can_register_for_team(r)
      return false unless check_maximum_team_size(r)
      return false unless check_student_belongs_to_chapter(r)

      proxy_association.concat(r)

      true
    end).all?
  end

  def delete(*records)
    records.each do |r|
      proxy_association.delete r
      handle_remove_student r
    end
  end
end