class Menu < ApplicationRecord
  before_validation :set_empty_url
  belongs_to :user
  belongs_to :recipe, optional: true
  scope :recent, -> { order(schedule: :asc) }

  private

  def set_empty_url
    self.url ||= ''
  end
end
