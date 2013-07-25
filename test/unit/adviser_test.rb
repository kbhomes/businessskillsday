require 'test_helper'

class AdviserTest < ActiveSupport::TestCase

  test 'adviser must have a name' do
    a = build :adviser, :name => nil
    assert !a.save, 'Saved the adviser without a name'
  end

  test 'adviser must belong to a chapter' do
    a = build :adviser, :chapter => nil
    assert !a.save, 'Saved the adviser without a chapter'
  end

end
