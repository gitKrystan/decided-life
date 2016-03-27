class MatrixStepsController < MatricesChildrenController
  include Wicked::Wizard
  steps :criteria, :options

  def show
    case step
    when :criteria
      1.times { @matrix.criteria.build }
      @criteria = @matrix.criteria
    when :options
      1.times { @matrix.options.build }
      @options = @matrix.options
    end
    render_wizard
  end

  def update
    case step
    when :criteria
      flash[:notice] = 'Your criteria have been updated.'
    when :options
      flash[:notice] = 'Your options have been updated.'
    end
    @matrix.update(matrix_params)
    render_wizard @matrix
  end

  private

  def matrix_params
    params.require(:matrix)
          .permit(:name,
                  criteria_attributes: [:id, :name, :weight, :_destroy],
                  options_attributes: [:id, :name, :_destroy])
  end

  def finish_wizard_path
    @matrix
  end
end
