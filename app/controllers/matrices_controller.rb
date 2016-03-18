class MatricesController < ApplicationController
  before_action :set_matrix, only: [:show]

  def index
  end

  def show
  end

  def new
    @matrix = Matrix.new
  end

  def create
    @matrix = Matrix.new(matrix_params)

    if @matrix.save
      redirect_to @matrix, notice: 'Matrix was successfully created.'
    else
      render :new
    end
  end

  private

  def set_matrix
    @matrix = Matrix.find(params[:id])
  end

  def matrix_params
    params.require(:matrix).permit(:name)
  end
end
