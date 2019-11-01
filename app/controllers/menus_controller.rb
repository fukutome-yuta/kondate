class MenusController < ApplicationController
  def index
    @menus = current_user.menus.recent

    render :new unless @menus.presenet?
  end

  def show
  end

  def new
  end

  def edit
  end
end
