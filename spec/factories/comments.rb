require 'faker'

FactoryGirl.define do
  factory :comment do |f|
    f.name "aj"
    f.text "this is it"
    f.vote 11
    f.blog { FactoryGirl.create(:blog) }
  end

  factory :comment_error, class: Comment do |f|
    f.name  "bob"
    f.email "john123@vt.edu"
  end
end
