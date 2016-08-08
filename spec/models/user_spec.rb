require "rails_helper"

RSpec.describe User, type: :model do
  it { should validate_presence_of :username }
  it { should validate_uniqueness_of :username }
  it { should have_many(:tweets).dependent(:destroy) }
  it { should have_many(:active_relationships).class_name("Relationship").with_foreign_key("follower_id").dependent(:destroy) }
  it { should have_many(:passive_relationships).class_name("Relationship").with_foreign_key("followed_id").dependent(:destroy) }
  it { should have_many(:following).through(:active_relationships).source(:followed) }
  it { should have_many(:followers).through(:passive_relationships).source(:follower) }

  describe ".follow" do
    let!(:follower) { create(:user) }
    let!(:followed) { create(:user) }
    it "Create active_relationship" do
      expect { follower.follow(followed) }.to change { follower.reload.active_relationships.count }.by(1)
    end

    it "Create passive_relationship" do
      expect { follower.follow(followed) }.to change { followed.reload.passive_relationships.count }.by(1)
    end
  end

  describe ".unfollow" do
    let!(:follower) { create(:user) }
    let!(:followed) { create(:user) }
    it "Destroy active_relationship" do
      follower.follow(followed)
      expect { follower.unfollow(followed) }.to change { follower.reload.active_relationships.count }.by(-1)
    end

    it "Destroy passive_relationship" do
      follower.follow(followed)
      expect { follower.unfollow(followed) }.to change { followed.reload.passive_relationships.count }.by(-1)
    end
  end
end
