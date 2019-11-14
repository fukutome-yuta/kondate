class Ingredient < ApplicationRecord
  before_validation :set_empty_name_amount
  before_validation :unit_conversion, on: [ :create, :update ]
  belongs_to :recipe

  enum unit_id: { piece: 0, g: 1, mg: 2, ml: 3, table_spoon: 4, tea_spoon: 5, nip: 6 }

  private

  def set_empty_name_amount
    self.name ||= ''
    self.amount ||= ''
  end

  def unit_conversion
    case self.unit_id
    when 1
      self.quantity *= 1000
    when 4
      self.quantity *= 15
    when 5
      self.quantity *= 5
    when 6
      self.quantity = 1
    end
  end
end
