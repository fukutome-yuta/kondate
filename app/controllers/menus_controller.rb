class MenusController < ApplicationController
  def index
    @menus = current_user.menus.recent

    unless @menus.present?
      redirect_to new_menu_url, notice: "献立表を作成してください。"
    else
      unless current_user.list_completed?
        render :edit
      end
    end    
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

    Menu.transaction do
      (start_date..end_date).each do |date|
        menu = current_user.menus.new(schedule: date)
        menu.save!
      end
    end
      redirect_to menus_edit_url, notice: "献立表を作成しました。"
    rescue => e
      raise ActiveRecord::Rollback
      redirect_to new_menu_url, notice: "献立表の作成に失敗しました。"
  end

  def update
    before = current_user.menus.find(params[:before_id])
    after = current_user.recipes.find(params[:after_id])
    before.update!(name: after.name, url: after.url)
    redirect_to menus_url, notice: "献立表に「#{after.name}」を追加しました。"
  end

  private

  def menu_params
    params.require(:menu).permit(:user_id, :recipe_id, :schedule, :name, :url, :cooked)
  end
end
