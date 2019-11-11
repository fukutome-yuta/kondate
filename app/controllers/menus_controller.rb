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
    start_date = Date.parse(params[:start_date])
    end_date = Date.parse(params[:end_date])

    Menu.transaction do
      (start_date..end_date).each do |date|
        menu = current_user.menus.new(schedule: date)
        menu.save!
      end
    end
      redirect_to menus_edit_url, notice: "献立表にメニューを追加してください。"
    rescue => e
      raise ActiveRecord::Rollback
      redirect_to new_menu_url, notice: "献立表の作成に失敗しました。"
  end

  def update
    before = current_user.menus.find(params[:before_id])
    after = current_user.recipes.find(params[:after_id])
    message = before.name.present? ? "#{before.schedule}のメニューを変更しました。" : "献立表に「#{after.name}」を追加しました。"
    before.update!(recipe_id: after.id, name: after.name, url: after.url)
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
