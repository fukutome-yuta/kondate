class Ingredient < ApplicationRecord
  belongs_to :recipe, inverse_of: :ingredients, optional: true
  before_validation :set_empty_name_amount
  before_validation :unit_conversion, on: [ :create, :update ]
  validates :unit_id, :numericality => { :greater_than_or_equal_to => 0, :less_than_or_equal_to => 5 }
  
  enum unit_id: { piece: 0, g: 1, ml: 2, table_spoon: 3, tea_spoon: 4, nip: 5 }

  private

  def set_empty_name_amount
    self.name ||= ''
    self.amount ||= ''
  end

  def unit_conversion
    case self.unit_id
    when 'table_spoon'
      self.quantity *= 15
    when 'tea_spoon'
      self.quantity *= 5
    when 'nip'
      self.quantity = 1
    end
  end
end
