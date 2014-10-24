require 'faker'


FactoryGirl.define do
  factory :blog do |f|
    f.author     { Faker::Name.first_name }
    f.title      { Faker::Name.last_name }
    f.content    { Faker::Name.last_name }
    f.keywords   "runner,YOLO"
    f.created_at Date.new(2014, 8, 3)
    f.published  true
  end

  factory :sept_blog, class: Blog do |f|
    f.author     "aj"
    f.title      "hello, world"
    f.content    "#Welcome "
    f.keywords   "runner"
    f.created_at Date.new(2014, 7, 4)
    f.published  true
  end

  factory :blog_error, class: Blog do |f|
    f.author  { "Blog error" }
    f.title   { "Fake title" }
  end
end