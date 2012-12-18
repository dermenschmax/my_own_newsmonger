# Read about factories at https://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  factory :comment do
    text "factory default for comment"
    user_name "factory_default for comment"
  end
end
