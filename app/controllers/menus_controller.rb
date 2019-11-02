class MenusController < ApplicationController
  def index
    @menus = current_user.menus.recent

    render :new unless @menus.present?
  end

  def show
  end

  def new
  end

  def edit
  end

  def create
    @start_date = params[:start_date]
    @end_date = params[:end_date]
    render :show
  end
end
