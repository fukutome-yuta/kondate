class Recipe < ApplicationRecord
  attr_accessor :ingredients_attributes
  validates :name, presence: true
  belongs_to :user
  has_many :ingredients, dependent: :destroy
  has_one :menu
  accepts_nested_attributes_for :ingredients

  scope :recent, -> { order(cooked: :asc) }

  def fetch(url)
    fetch_data = FetchRecipe.new(url)
    fetch_data.cookpad
    self.name = fetch_data.title
    self.url = fetch_data.url
    self.cooking_recipe = fetch_data.recipe
    @ingredients = fetch_data.ingredients
  end
end
