class Menu < ApplicationRecord
  belongs_to :user
  belongs_to :recipe
  scope :recent, -> { order(schedule: :desc) }
end
