class UserPolicy < ApplicationPolicy
  def index?
    user.admin?
  end

  def show?
    user.admin? || user == record
  end

  def edit?
    p user, record
    user.admin? || user == record
  end

  def destroy?
    user.admin?
  end

  def create?
    user.admin?
  end

  def update?
    user.admin? || user == record
  end
end
