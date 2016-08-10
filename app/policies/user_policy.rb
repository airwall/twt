class UserPolicy < ApplicationPolicy
  def timeline?
    user.present?
  end

  def follow?
    timeline?
  end

  def unfollow?
    follow?
  end

  def followers?
    timeline?
  end

  def following?
    timeline?
  end
end
