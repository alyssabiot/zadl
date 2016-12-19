class BookingPolicy < ApplicationPolicy
  class Scope < Scope
    def resolve
      scope.all
    end
  end

  def create?
    true
  end

  def update?
    record.user == user || record.event.user == user # Only booking creator can update it
  end

  def destroy?
    record.user == user  # Only booking creator can destroy it
  end

  def show?
    true
  end
end
