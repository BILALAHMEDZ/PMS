# frozen_string_literal: true

class ClientsPolicy < ApplicationPolicy
  def edit?
    user.manager?
  end

  def index?
    user.manager?
  end

  def new?
    user.manager?
  end

  def create?
    user.manager?
  end

  def update?
    user.manager?
  end

  def destroy?
    user.manager?
  end

  def check_manager?
    user.manager?
  end
end
