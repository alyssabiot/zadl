class Booking < ApplicationRecord
  belongs_to :user
  belongs_to :event
  validates :user, uniqueness: { scope: :event }
  validates :reimbursed, inclusion: {in: ["pending","reimbursed","reimbursement refused"]}
  monetize :amount_cents
end
