class CrudController < ApplicationController
  before_action :authenticate_user!, except: [:index, :show]

  private

  def authenticate_matrix_owner
    unless matrix_owner?
      flash[:notice] = 'You are not authorized to edit this matrix.'
      redirect_to @matrix
    end
  end
end
