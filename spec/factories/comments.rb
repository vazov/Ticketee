FactoryGirl.define do
  factory :comment do
    text "MyText"
    ticket_id 1
    user_id 1
  end
end
