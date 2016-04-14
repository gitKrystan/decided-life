class MatrixStepsController < MatricesChildrenController
  include Wicked::Wizard
  steps :criteria, :options

  def show
    case step
    when :criteria
      @matrix.criteria.build
      @criteria = @matrix.criteria
      @criteria_count = @criteria.length
    when :options
      @matrix.options.build
      @options = @matrix.options
    end
    render_wizard
  end

  def update
    case step
    when :criteria
      update_association_and_set_notice(:criteria)
    when :options
      update_association_and_set_notice(:options)
    end
    render_wizard @matrix
  end

  private

  def matrix_params
    bin_attributes = [:id, :score, :description]
    criterium_attributes = [:id, :name, :importance, :_destroy,
                            bins_attributes: bin_attributes]
    option_attributes = [:id, :name, :_destroy]
    params.require(:matrix).permit(:name,
                                   criteria_attributes: criterium_attributes,
                                   options_attributes: option_attributes)
  end

  def finish_wizard_path
    edit_matrix_path @matrix
  end

  def update_association_and_set_notice(association_symbol)
    association = association_symbol.to_s
    association_count_before = @matrix.send(association).count
    if @matrix.update(matrix_params)
      set_notice(association, association_count_before)
    end
  end

  def set_notice(association, association_count_before)
    if @matrix.send(association).count > association_count_before
      flash[:notice] = "Your #{association} have been updated."
    else
      flash[:notice] = "No #{association} have been added. " \
               "Dont worry, you can add #{association} later."
    end
  end
end
