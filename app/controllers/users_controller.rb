class UsersController < ApplicationController
  def show
    @user = User.find(params[:id])
    @matrices = @user.matrices.order(created_at: :desc)
  end
end
