class MenusController < ApplicationController
  def index
    @menus = current_user.menus.recent

    unless @menus.present?
      redirect_to new_menu_url, notice: "献立表を作成してください。"
    else
      unless current_user.list_completed?
        redirect_to menus_edit_path
      end
    end
    @recipe_ids = @menus.pluck(:recipe_id)
  end

  def select
    @recipes = current_user.recipes.recent
    @menu = current_user.menus.find(params[:id])
  end

  def new
  end

  def edit
    current_user.update!(list_completed: false)
    @menus = current_user.menus.recent
    @menus.each do |m|
      @completed = m.recipe_id.present?
      break unless @completed
    end
  end

  def create
    result = ExtendMenu.new.list_create(current_user, params[:start_date], params[:end_date])
    redirect_to result[:path], notice: result[:message]
  end

  def update
    message = ExtendMenu.new.list_update(current_user, params[:before_id], params[:after_id])
    redirect_to menus_url, notice: message
  end

  def complete
    current_user.update!(list_completed: true)
    redirect_to menus_url, notice: "献立の作成が完了しました。"
  end

  def destroy
    @menus = current_user.menus.all
    @menus.each { |menu| menu.destroy }
    current_user.update!(list_completed: false)
    redirect_to new_menu_url, notice: "献立表を削除しました。"
  end

  private

  def menu_params
    params.require(:menu).permit(:user_id, :recipe_id, :schedule, :name, :url, :cooked)
  end
end
