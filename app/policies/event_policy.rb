class EventPolicy < ApplicationPolicy
  class Scope < Scope
    def resolve
      scope.all
    end
  end

  def ics_export?
    true
  end

  def show?
    true
  end

  def create?
    true
  end

  def update?
    record.user == user  # Only event creator can update it
  end

  def destroy?
    record.user == user  # Only event creator can destroy it
  end
end
