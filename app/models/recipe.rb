class Recipe < ApplicationRecord
  attr_accessor :ingredients_attributes
  belongs_to :user
  belongs_to :menu, optional: true
  has_many :ingredients, dependent: :destroy, inverse_of: :recipe
  accepts_nested_attributes_for :ingredients, allow_destroy: true

  validates :name, presence: true

  scope :recent, -> { order(cooked: :asc).order(cooked_at: :asc) }

  def completed(user)
    query = <<-SQL
      SELECT SUM(CASE WHEN recipes.cooked = true THEN 0 ELSE 1 END) AS completed
      FROM recipes
      WHERE user_id = #{user.id}
    SQL

    result = ActiveRecord::Base.connection.select_all(query)
    return result.to_hash[0]["completed"] == 0 ? true : false
  end
  
  def fetch(url)
    fetch_data = FetchRecipe.new(url)
    fetch_data.cookpad
    self.name = fetch_data.title
    self.url = fetch_data.url
    self.cooking_recipe = fetch_data.recipe
    self.ingredients_attributes = fetch_data.names.length.times.map { |i| self.ingredients.new( name: fetch_data.names[i], amount: fetch_data.quantitys[i] ) }
  end
end
