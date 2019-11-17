class ShoppingList < ApplicationRecord
  belongs_to :user

  scope :recent, -> { order(bought: :asc) }

  def list_create(user, recipe_ids)
    #lists = Ingredient.select("ingredients.name, ingredients.quantity, ingredients.unit_id").where("recipe_id IN (?)" ,recipe_ids)
    lists = Ingredient.select("ingredients.name, sum(ingredients.quantity) as sum_quantity, ingredients.conversion_unit").where("recipe_id IN (?)" ,recipe_ids).group(:name, :conversion_unit)
    lists.each do |l|
      unit = l.conversion_unit == 'conv_piece' ? 'ケ' : 'g'
      list = user.shopping_lists.new(ingredient: l.name, quantity: l.sum_quantity, unit: unit)
      list.save!
    end
    return user.shopping_lists.all
  end
end
