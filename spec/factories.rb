FactoryGirl.define do
  factory :client, class: Paymill::Client do
    email       'john.rambo@qaiware.com'
    description 'John Rambo is a former member of an elite United States Army Special Forces unit'
  end
end
