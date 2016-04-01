class MatricesController < CrudController
  before_action :set_matrix, only: [:show, :edit, :update, :destroy]
  before_action :set_criteria, only: [:show, :edit, :update]
  before_action :set_options, only: [:show, :edit, :update]
  before_action :authenticate_matrix_owner, only: [:edit, :update, :destroy]

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
      respond_to do |format|
        format.html do
          flash[:notice] = "#{@matrix.name} was successfully updated."
          redirect_to edit_matrix_path(@matrix)
        end
        format.js do
          @option_id = matrix_params[:options_attributes]['0'][:id].to_i
          @criterium_id = matrix_params[:options_attributes]['0'][:scores_attributes]['0'][:criterium_id].to_i
          @amount = matrix_params[:options_attributes]['0'][:scores_attributes]['0'][:amount].to_i
        end
      end
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
    score_attributes = [:id, :amount, :criterium_id, :option_id]
    option_attributes = [:id, :name, scores_attributes: score_attributes]
    params.require(:matrix).permit(:name, options_attributes: option_attributes)
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

  def criteria_count
    @matrix.criteria.count
  end
  helper_method :criteria_count
end
