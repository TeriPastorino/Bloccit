FactoryGirl.define do
  factory :user do
    name "Steve Pasto"
    email 'spasto@example.com'
    password 'helloworld'
    password_confirmation 'helloworld'
    confirmed_at Time.now

    # if needed
    # is_active true
  end
end