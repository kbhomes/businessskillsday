FactoryGirl.define do

  factory :account do
    sequence(:email) { |n| "account#{n}@example.com" }
    password 'password'
    password_confirmation { password }
    type 'ChapterAccount'
  end

  factory :chapter_account, :parent => :account, :class => 'ChapterAccount' do
    sequence(:email) { |n| "chapter#{n}@example.com" }
    association :chapter
    type 'ChapterAccount'
  end

  factory :staff_account, :parent => :account, :class => 'StaffAccount' do
    sequence(:email) { |n| "staff#{n}@example.com"}
    type 'StaffAccount'
  end

  factory :admin_account, :parent => :account, :class => 'AdminAccount' do
    sequence(:email) { |n| "admin#{n}@example.com" }
    type 'AdminAccount'
  end

end