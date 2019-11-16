class Recipe < ApplicationRecord
  attr_accessor :ingredients_attributes
  belongs_to :user
  belongs_to :menu, optional: true
  has_many :ingredients, dependent: :destroy, inverse_of: :recipe
  accepts_nested_attributes_for :ingredients, allow_destroy: true

  validates :name, presence: true

  scope :recent, -> { order(cooked: :asc) }

  def fetch(url)
    fetch_data = FetchRecipe.new(url)
    fetch_data.cookpad
    self.name = fetch_data.title
    self.url = fetch_data.url
    self.cooking_recipe = fetch_data.recipe
    self.ingredients_attributes = fetch_data.names.length.times.map { |i| self.ingredients.new( name: fetch_data.names[i], amount: fetch_data.quantitys[i] ) }
  end
end
