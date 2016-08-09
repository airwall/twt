FactoryGirl.define do
  sequence :body do |n|
    "Lorem Ipsum #{n}"
  end

  factory :tweet do
    body
  end
end
