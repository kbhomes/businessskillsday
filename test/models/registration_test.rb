require 'test_helper'

class RegistrationTest < ActiveSupport::TestCase

  test 'registration must have a chapter name' do
    registration = build :registration, :chapter => nil
    assert !registration.save, 'Did save registration without a chapter name'
  end

  test 'registration must have a email' do
    registration = build :registration, :email => nil
    assert !registration.save, 'Did save registration without an email'
  end

  test 'registration must have a contact' do
    registration = build :registration, :contact => nil
    assert !registration.save, 'Did save registration without a contact'
  end

  test 'registration must have an address' do
    registration = build :registration, :address => nil
    assert !registration.save, 'Did save registration without an address'
  end

  test 'registration must have a city' do
    registration = build :registration, :city => nil
    assert !registration.save, 'Did save registration without a city'
  end

  test 'registration must have a state' do
    registration = build :registration, :state => nil
    assert !registration.save, 'Did save registration without a state'
  end

  test 'registration must have a zip' do
    registration = build :registration, :zip => nil
    assert !registration.save, 'Did save registration without a zip'
  end

  test 'registration cannot have a chapter name that already exists' do
    create :registration, :chapter => 'Chapter A'
    create :chapter, :name => 'Chapter B'

    registration = build :registration

    # Chapter name must be unique across registrations.
    registration.chapter = 'Chapter A'
    assert !registration.save, 'Saved registration that has a non-unique registration chapter name'

    # Chapter name must be unique across existing chapters.
    registration.chapter = 'Chapter B'
    assert !registration.save, 'Saved registration that has the same name as an existing chapter'
  end

  test 'registration cannot have a email that already exists' do
    create :registration, :email => 'chapterA@example.com'
    create :chapter_account, :email => 'chapterB@example.com'

    registration = build :registration

    # Email must be unique across email.
    registration.email = 'chapterA@example.com'
    assert !registration.save, 'Saved registration that has a non-unique registration email'

    # Email must be unique across existing chapter accounts.
    registration.email = 'chapterB@example.com'
    assert !registration.save, 'Saved registration that has the same email as an existing chapter account'
  end

end
