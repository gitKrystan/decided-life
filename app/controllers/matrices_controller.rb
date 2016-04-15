class MatricesController < CrudController
  helper_method :options_sort_method, :options_sort_direction,
                :options_sort_criterium
  before_action :set_matrix, only: [:show, :edit, :update, :destroy, :copy]
  before_action :set_criteria, only: [:show, :edit, :update]
  before_action :set_options, only: [:show, :edit, :update]
  before_action :authenticate_matrix_owner, only: [:edit, :update, :destroy]

  def index
    @my_matrices = Matrix.where(owner: current_user).order(created_at: :desc)
    @krystan_matrices = Matrix.where(owner_id: 1).order(created_at: :desc)
    @other_matrices = Matrix.where.not(owner: current_user).order(created_at: :desc)
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
      flash[:notice] = "#{@matrix.name} was successfully updated."
      redirect_to edit_matrix_path(@matrix)
    else
      render :edit
    end
  end

  def destroy
    @matrix.destroy
    redirect_to matrices_path,
                notice: "#{@matrix.name} was successfully deleted."
  end

  def copy
    new_matrix = @matrix.amoeba_dup
    new_matrix.owner = current_user
    if new_matrix.save
      flash[:notice] = "#{new_matrix.name} was successfully created."
      redirect_to edit_matrix_path(new_matrix)
    else
      flash[:alert] = "Sorry, #{@matrix.name} could not be copied."
      @matrix = new_matrix
      render :show
    end
  end

  private

  def matrix_params
    score_attributes = [:id, :amount, :criterium_id, :option_id, :bin_id]
    option_attributes = [:id, :name, scores_attributes: score_attributes]
    params.require(:matrix).permit(:name, options_attributes: option_attributes)
  end

  def set_matrix
    @matrix = Matrix.find(params[:id])
  end

  def set_criteria
    @criteria = @matrix.criteria.sort_by(&:weight).reverse
    # TODO: order by user selection
  end

  def set_options
    @options = @matrix.options_by(options_sort_method,
                                  options_sort_direction,
                                  options_sort_criterium)
  end

  def options_sort_method
    if action_name == 'show'
      params[:sort_options_by] || 'total_score'
    else
      params[:sort_options_by] || 'name'
    end
  end

  def options_sort_direction
    if action_name == 'show'
      params[:options_direction] || 'desc'
    else
      params[:options_direction] || 'asc'
    end
  end

  def options_sort_criterium
    params[:sort_by_criterium] || nil
  end

  def criteria_count
    @matrix.criteria.count
  end
  helper_method :criteria_count
end
