class AddConversionUnitToIngredient < ActiveRecord::Migration[5.2]
  def change
    add_column :ingredients, :conversion_unit, :integer
  end
end
