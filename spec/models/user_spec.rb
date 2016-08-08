require 'rails_helper'

RSpec.describe User, type: :model do
  it { should have_many :tweets }
  it { should have_many :active_relationships }
end
