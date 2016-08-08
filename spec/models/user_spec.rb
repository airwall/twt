require 'rails_helper'

RSpec.describe User, type: :model do
  it { should have_many(:tweets).dependent(:destroy) }
  it { should have_many(:active_relationships).class_name('Relationship').with_foreign_key("follower_id").dependent(:destroy) }
  it { should have_many(:following).through(:active_relationships).source(:followed) }

  describe ".follow" do
    let!(:follower) { create(:user) }
    let!(:followed) { create(:user) }
    it "Create active_relationship" do
      expect{ follower.follow(followed) }.to change{ follower.reload.active_relationships.count }.by(1)
    end
  end

  describe ".follow" do
    let!(:follower) { create(:user) }
    let!(:followed) { create(:user) }
    it "Destroy active_relationship" do
      follower.follow(followed)
      expect{ follower.unfollow(followed) }.to change{ follower.reload.active_relationships.count }.by(-1)
    end
  end
end
