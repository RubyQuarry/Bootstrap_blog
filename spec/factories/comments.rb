require 'faker'



FactoryGirl.define do
  factory :comment do |f|
    f.name "aj"
    f.text "this is it"
  end
end