class Recipe < ApplicationRecord
  attr_accessor :ingredients_attributes
  belongs_to :user
  has_many :ingredients, dependent: :destroy
  has_one :menu
  accepts_nested_attributes_for :ingredients, allow_destroy: true

  validates :name, presence: true
  validates :unit_id, :numericality => { :greater_than_or_equal_to => 0, :less_than_or_equal_to => 6 }

  scope :recent, -> { order(cooked: :asc) }

  def fetch(url)
    fetch_data = FetchRecipe.new(url)
    fetch_data.cookpad
    self.name = fetch_data.title
    self.url = fetch_data.url
    self.cooking_recipe = fetch_data.recipe
    # self.ingredients_attributes =  fetch_data.names.length.times.map do |i| 
    #                                     self.ingredients.new( name: fetch_data.names[i], amount: fetch_data.quantitys[i] )
    #                                   end
    self.ingredients_attributes = fetch_data.ingredients
  end
end
