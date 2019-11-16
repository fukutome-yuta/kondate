class ShoppingList < ApplicationRecord
  belongs_to :user

  scope :recent, -> { select('shopping_lists.ingredient, sum(shopping_lists.quantity) as sum_quantity, shopping_lists.unit').group(:ingredient, :unit) }

  def list_create(user, recipe_ids)
    lists = Ingredient.select("ingredients.name, ingredients.quantity, ingredients.unit_id").where("recipe_id IN (?)" ,recipe_ids)
    lists.each do |l|
      unit = l.unit_id == 'piece' ? 'ケ' : 'g'
      list = user.shopping_lists.new(ingredient: l.name, quantity: l.quantity, unit: unit)
      list.save!
    end
    return user.shopping_lists.recent
  end
end
