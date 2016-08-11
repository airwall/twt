FactoryGirl.define do
  sequence :body do |n|
    "Lorem Ipsum #{n}"
  end

  factory :tweet do
    body
  end

  factory :invalid_tweet, class: "Tweet" do
    body nil
  end
end
