class CriteriaController < MatricesChildrenController
  before_action :set_criterium, only: [:edit, :update, :destroy]

  def new
    @criterium = @matrix.criteria.new
  end

  def edit
  end

  def create
    @criterium = @matrix.criteria.new(criterium_params)

    if @criterium.save
      redirect_to edit_matrix_path(@matrix),
                  notice: "#{@criterium.name} was successfully created."
    else
      render :new
    end
  end

  def update
    if @criterium.update(criterium_params)
      redirect_to edit_matrix_path(@matrix),
                  notice: "#{@criterium.name} was successfully updated."
    else
      render :edit
    end
  end

  def destroy
    @criterium.destroy
    redirect_to edit_matrix_path(@matrix),
                notice: "#{@criterium.name} was successfully deleted."
  end

  private

  def criterium_params
    params.require(:criterium).permit(:name, :weight)
  end

  def set_criterium
    @criterium = Criterium.find(params[:id])
  end
end
