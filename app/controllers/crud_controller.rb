class CrudController < ApplicationController
  before_action :authenticate_user!, except: [:index, :show]

  private

  def user_is_matrix_owner?
    (current_user == @matrix.owner) if user_signed_in?
  end
  helper_method :user_is_matrix_owner?

  def authenticate_matrix_owner
    unless user_is_matrix_owner?
      flash[:notice] = 'You are not authorized to edit this matrix.'
      redirect_to @matrix
    end
  end
end
