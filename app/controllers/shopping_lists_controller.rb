class ShoppingListsController < ApplicationController
  def show
    @lists = current_user.shopping_lists.all
    redirect_to menus_path, notice: '買い物リストがありません。' unless @lists.present?
  end

  def create
    result = ShoppingList.new.list_create(current_user, params[:recipe_ids])
    redirect_to result[:path], notice: result[:message]
  end

  def update
    list = current_user.shopping_lists.find(params[:id])
    list.bought = !list.bought
    list.save
    head :no_content
  end

  def destroy
    @lists = current_user.shopping_lists.all
    @lists.each { |list| list.destroy }
    redirect_to menus_path, notice: '買い物リストを削除しました。'
  end
end
