# frozen_string_literal: true

class ClientsPolicy < ApplicationPolicy
  def index?
    user.manager?
  end

  def edit?
    index?
  end

  def new?
    index?
  end

  def create?
    index?
  end

  def update?
    index?
  end

  def destroy?
    index?
  end
end
