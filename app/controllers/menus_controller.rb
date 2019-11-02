class MenusController < ApplicationController
  def index
    @menus = current_user.menus.recent

    render :new unless @menus.present?
  end

  def select
    @recipes = current_user.recipes.recent
    @menu = current_user.menus.find(params[:id])
  end

  def new
  end

  def edit
    @menus = current_user.menus.all
  end

  def create
    start_date = Date.parse(params[:start_date])
    end_date = Date.parse(params[:end_date])

    (start_date..end_date).each do |date|
      menu = current_user.menus.new(schedule: date)
menu.save!
      # unless menu.save
      #   redirect_to new_menu_url, notice: "献立表の作成に失敗しました。" and return
      # end 
    end
    redirect_to menus_edit_url, notice: "献立表を作成しました。" and return
  end

  private

  def menu_params
    params.require(:menu).permit(:user_id, :recipe_id, :schedule, :name, :url, :cooked)
  end
end
