require 'rails_helper'

RSpec.describe Relationship, type: :model do
  it { should validate_presence_of :follower_id }
  it { should validate_presence_of :followed_id }
  it { should belong_to :follower }
  it { should belong_to :followed }
end
