class Recipe < ApplicationRecord
  validates :name, presence: true
  #has_many :incredients
  belongs_to :user
  has_one :menu

  scope :recent, -> { order(cooked: :asc) }
end
