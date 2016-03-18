class MatricesController < ApplicationController
  before_action :set_matrix, only: [:show, :edit, :update]

  def index
    @matrices = Matrix.order(created_at: :desc)
  end

  def show
  end

  def new
    @matrix = Matrix.new
  end

  def edit
  end

  def create
    @matrix = Matrix.new(matrix_params)

    if @matrix.save
      redirect_to @matrix, notice: "#{@matrix.name} was successfully created."
    else
      render :new
    end
  end

  def update
    if @matrix.update(matrix_params)
      redirect_to @matrix, notice: "#{@matrix.name} was successfully updated."
    else
      render :edit
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
