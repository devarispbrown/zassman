class UsersController < ApplicationController
  def show
    @user = User.find(params[:id])
    @assets = @user.assets.page(params[:page]).per_page(20)
  end
end