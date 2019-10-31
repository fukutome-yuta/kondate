class Recipe < ApplicationRecord
  validates :name, presence: true
  #has_many :incredients
  belongs_to :user

  scope :recent, -> { order(cooked: :asc) }
end
