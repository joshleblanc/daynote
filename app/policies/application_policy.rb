# frozen_string_literal: true

class ApplicationPolicy
  attr_reader :user, :record

  def initialize(user, record)
    @user = user
    @record = record
  end

  def index?
    record.user == user || user.admin?
  end

  def show?
    record.user == user || user.admin?
  end

  def create?
    user.present?
  end

  def new?
    user.present?
  end

  def update?
    record.user == user || user.admin?
  end

  def edit?
    update?
  end

  def destroy?
    record.user == user || user.admin?
  end

  class Scope
    def initialize(user, scope)
      @user = user
      @scope = scope
    end

    def resolve
      raise NoMethodError, "You must define #resolve in #{self.class}"
    end

    private

    attr_reader :user, :scope
  end
end
