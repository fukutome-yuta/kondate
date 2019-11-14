class RecipesController < ApplicationController
  before_action :set_recipe, only: [:show, :edit, :update, :destroy]
  def index
    @recipes = current_user.recipes.recent
  end

  def show
  end

  def new
    @recipe = current_user.recipes.new
    @recipe.ingredients.build
  end

  def edit
  end

  def create
    @recipe = current_user.recipes.new(recipe_params)
    ingredient_params = params[:recipe][:ingredients_attributes].permit!.to_hash
    @recipe.ingredients_attributes = ingredient_params.map do |key, value|
        @recipe.ingredients.new( name: value['name'], amount: value['amount'], quantity: value['quantity'], unit_id: value['unit_id'].to_i )
      end
    
    if @recipe.save
       redirect_to @recipe, notice: "レシピ「#{@recipe.name}」を登録しました。"
    else
      render :new
    end
  end

  def fetch
    @recipe = current_user.recipes.new
    @recipe.fetch(params[:fetch_url])
    render :new
  end

  def update
    recipe = current_user.recipes.find(params[:id])
    recipe.update!(recipe_params)
    redirect_to recipe_url, notice: "レシピ「#{recipe.name}」を更新しました。"
  end

  def destroy
    @recipe.destroy
    redirect_to recipes_url, notice: "レシピ「#{@recipe.name}」を削除しました。"
  end

  private

  def recipe_params
    #params.require(:recipe).permit(:user_id, :cooked, :name, :url, :cooking_recipe, :cooked_at, ingredients_attributes: [ :recipe_id, :name, :amount, :quantity, :unit_id ])
    params.require(:recipe).permit(:user_id, :cooked, :name, :url, :cooking_recipe, :cooked_at)
  end

  def set_recipe
    @recipe = current_user.recipes.find(params[:id])
  end
end
