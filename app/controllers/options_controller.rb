class OptionsController < MatricesChildrenController
  before_action :set_option, only: [:edit, :update, :destroy]

  def new
    @option = @matrix.options.new
  end

  def edit
  end

  def create
    @option = @matrix.options.new(option_params)

    if @option.save
      redirect_to edit_matrix_path(@matrix),
                  notice: "#{@option.name} was successfully created."
    else
      render :new
    end
  end

  def update
    if @option.update(option_params)
      redirect_to edit_matrix_path(@matrix),
                  notice: "#{@option.name} was successfully updated."
    else
      render :edit
    end
  end

  def destroy
    @option.destroy
    redirect_to edit_matrix_path(@matrix),
                notice: "#{@option.name} was successfully deleted."
  end

  private

  def option_params
    params.require(:option).permit(:name)
  end

  def set_option
    @option = Option.find(params[:id])
  end
end
