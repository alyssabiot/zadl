class Event < ApplicationRecord
  geocoded_by :location
  mount_uploader :photo, PhotoUploader
  belongs_to :user
  has_many :bookings, dependent: :nullify
  has_many :messages, dependent: :nullify
  validates :name, presence: true, allow_blank: false
  validates :description, presence: true, allow_blank: false
  validates :starts_at, presence: true, allow_blank: false
  validates :starts_at, date: { after: Proc.new { Date.current }, message: 'Doit être dans le futur' }, on: :create
  validates :ends_at, presence: true, allow_blank: false, date: { after: :starts_at, message: 'Doit être après la date de début'  }
  validates :location, presence: true, allow_blank: false
  validates :max_participants, allow_blank: true, :numericality => { :greater_than_or_equal_to => 0 }
  validates :price, :numericality => { :greater_than_or_equal_to => 0 }
  after_validation :geocode, if: :location_changed?
  monetize :price_cents

  def validated_bookings_number
    bookings.where(cancelled: false, on_waiting_list: false).count
  end
end
