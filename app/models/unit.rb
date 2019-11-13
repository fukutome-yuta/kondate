class Unit
  include ActiveModel::Model

  attr_reader :name

  def initialize
    @name = { 1 => 'g', 2 => 'mg', 3 => 'ml', 4 => '大さじ', 5 => '小さじ', 6 => 'ケ', 7 => '少々' }
  end
end