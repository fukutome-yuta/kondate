class MenusController < ApplicationController
  def index
    @menus = current_user.menus.recent

    unless @menus.present?
      redirect_to new_menu_url, notice: "献立表を作成してください。"
    else
      redirect_to menus_edit_path unless current_user.list_readied
    end
    @recipe_ids = @menus.pluck(:recipe_id)
  end

  def select
    @recipes = current_user.recipes.recent
    @menu = current_user.menus.find(params[:id])
    redirect_to menus_edit_path unless @menu.present?
  end

  def new
  end

  def edit
    current_user.update!(list_readied: false) if current_user.list_readied
    @menus = current_user.menus.recent
    @menus.each do |m|
      @readied = m.recipe_id.present?
      break unless @readied
    end
  end

  def create
    result = ExtendMenu.new.list_create(current_user, params[:start_date], params[:end_date])
    redirect_to result[:path], notice: result[:message]
  end

  def update
    message = ExtendMenu.new.list_update(current_user, params[:before_id], params[:after_id])
    redirect_to menus_path, notice: message
  end

  def ready
    if params([:readied]) == true
      current_user.update!(list_readied: true)
      redirect_to menus_url, notice: "献立表を作成しました。"
    end
    redirect_to menus_path
  end

  def complete
    if current_user.list_readied
      result = ExtendMenu.new.list_complete(current_user)
      redirect_to result[:path], notice: result[:message]
    end
  end

  def change_cooked
    menu = current_user.menus.find(params[:menu_id])
    menu.cooked = !menu.cooked
    menu.save
    head :no_content
  end

  def destroy
    menus = current_user.menus.all
    menus.each { |menu| menu.destroy }
    lists = current_user.shopping_lists.all
    lists.each { |list| list.destroy } if lists.present?
    current_user.update!(list_readied: false)
    redirect_to new_menu_url, notice: "献立表を削除しました。"
  end

  private

  def menu_params
    params.require(:menu).permit(:user_id, :recipe_id, :schedule, :name, :url, :cooked)
  end
end
