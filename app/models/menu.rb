class Menu < ApplicationRecord
  belongs_to :user
  belongs_to :recipe, optional: true
  scope :recent, -> { order(schedule: :desc) }
end
