module MatrixHelper
  def sort_options(sort_method, title = nil)
    title ||= sort_method.titleize
    method_is_current_method = sort_method == options_sort_method
    direction_is_ascending = options_sort_direction == 'asc'
    direction = if method_is_current_method && direction_is_ascending
                  'desc'
                else
                  'asc'
                end
    link_to title, sort_options: sort_method, options_direction: direction
  end
end
