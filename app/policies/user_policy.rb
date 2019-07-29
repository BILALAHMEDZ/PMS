# frozen_string_literal: true

class UserPolicy < ApplicationPolicy
  def users_list?
    user.admin?
  end

  def user_edit
    user.admin?
  end

  def profile_edit
    user.admin? || user.user? || user.manager?
  end

  def profile_update
    user.admin? || user.user? || user.manager?
  end

  def user_update
    user.admin?
  end

  def destroy_user
    user.admin?
  end
end
