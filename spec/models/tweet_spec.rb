require "rails_helper"

RSpec.describe Tweet, type: :model do
  it { should validate_presence_of :user_id }
  it { should validate_presence_of :body }
  it { should belong_to :user }
end
