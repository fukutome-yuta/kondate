class ShoppingListsController < ApplicationController
  def show
    @lists = current_user.shopping_lists.all
  end

  def create
    @lists = ShoppingList.new.list_create(current_user, params[:recipe_ids])
    redirect_to shopping_lists_show_path, notice: '買い物リストを作成しました。'
  end

  def update
    render :show
  end

  def destroy
    @lists = current_user.shopping_lists.all
    @lists.each { |list| list.destroy }
    redirect_to menus_url, notice: '買い物リストを削除しました。'
  end
end
