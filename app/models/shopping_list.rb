class ShoppingList < ApplicationRecord
  belongs_to :user

  scope :recent, -> { order(bought: :asc) }

  def list_create(user, recipe_ids)
    lists = Ingredient.select("ingredients.name, sum(ingredients.quantity) as sum_quantity, ingredients.conversion_unit").where("recipe_id IN (?)" ,recipe_ids).group(:name, :conversion_unit)

    result = {}

    ShoppingList.transaction do
      lists.each do |l|
        unit = l.conversion_unit == 'conv_piece' ? 'ケ' : 'g'
        list = user.shopping_lists.new(ingredient: l.name, quantity: l.sum_quantity, unit: unit)
        list.save!
      end
    end
      result[:path] = '/shopping_lists/show'
      result[:message] = "買い物リストを作成しました。"
      @lists = user.shopping_lists.all
    rescue => e
      result[:path] = '/menus/index'
      result[:message] = "買い物リストを作成に失敗しました。"
      raise ActiveRecord::Rollback
    ensure
      return result
  end
end
