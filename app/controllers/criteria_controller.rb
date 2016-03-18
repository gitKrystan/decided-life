class CriteriaController < ApplicationController
  before_action :set_matrix, only: [:new, :create]

  def new
    @criterium = Criterium.new
  end

  def create
    @criterium = Criterium.new(criterium_params)

    if @criterium.save
      redirect_to @matrix,
                  notice: "#{@criterium.name} was successfully created."
    else
      render :new
    end
  end

  private

  def set_matrix
    @matrix = Matrix.find(params[:matrix_id])
  end

  def criterium_params
    params.require(:criterium).permit(:name)
  end
end
