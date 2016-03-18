class CriteriaController < ApplicationController
  before_action :set_matrix, only: [:new, :create, :edit, :update]
  before_action :set_criterium, only: [:edit, :update]

  def new
    @criterium = @matrix.criteria.new
  end

  def edit
  end

  def create
    @criterium = @matrix.criteria.new(criterium_params)

    if @criterium.save
      redirect_to @matrix,
                  notice: "#{@criterium.name} was successfully created."
    else
      render :new
    end
  end

  def update
    if @criterium.update(criterium_params)
      redirect_to @matrix,
                  notice: "#{@criterium.name} was successfully updated."
    else
      render :edit
    end
  end

  private

  def set_matrix
    @matrix = Matrix.find(params[:matrix_id])
  end

  def set_criterium
    @criterium = Criterium.find(params[:id])
  end

  def criterium_params
    params.require(:criterium).permit(:name)
  end
end
