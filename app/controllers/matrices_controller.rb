class MatricesController < CrudController
  before_action :set_matrix, only: [:show, :edit, :update, :destroy]
  before_action :set_criteria, only: [:show, :edit, :update]
  before_action :set_options, only: [:show, :edit, :update]
  before_action :authenticate_matrix_owner, only: [:edit, :update, :destroy]

  def index
    @matrices = Matrix.order(created_at: :desc)
  end

  def show
    @options_count = @matrix.options.count
  end

  def new
    @matrix = Matrix.new
  end

  def edit
  end

  def create
    @matrix = current_user.matrices.new(matrix_params)

    if @matrix.save
      flash[:notice] = "#{@matrix.name} was successfully created."
      redirect_to matrix_steps_path(@matrix)
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

  def destroy
    @matrix.destroy
    redirect_to matrices_path,
                notice: "#{@matrix.name} was successfully deleted."
  end

  private

  def matrix_params
    params.require(:matrix).permit(:name)
  end

  def set_matrix
    @matrix = Matrix.find(params[:id])
  end

  def set_criteria
    @criteria = @matrix.criteria.order(:name) # TODO: order by user sequence
  end

  def set_options
    @options = @matrix.options.order(:name) # TODO: order by user sequence
  end
end
