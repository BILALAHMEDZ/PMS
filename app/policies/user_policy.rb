# frozen_string_literal: true

class UserPolicy < ApplicationPolicy
  def edit?
    user.admin?
  end

  def index?
    user.admin?
  end

  def new?
    user.admin?
  end

  def create?
    user.admin?
  end

  def update?
    user.admin?
  end

  def destroy?
    user.admin?
  end

  def check_admin?
    user.admin?
  end
end
