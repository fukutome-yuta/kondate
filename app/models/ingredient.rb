class Ingredient < ApplicationRecord
  before_validation :set_empty_name_amount
  belongs_to :recipe

  private

  def set_empty_name_amount
    self.name ||= ''
    self.amount ||= ''
  end
end
