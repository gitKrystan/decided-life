module MatrixHelper
  def sort_options(sort_method, title = nil)
    title ||= sort_method.titleize
    method_is_current = sort_method == options_sort_method
    css_class = method_is_current ? "dec-#{options_sort_direction}" : nil
    direction = if method_is_current && (options_sort_direction == 'asc')
                  'desc'
                else
                  'asc'
                end
    link_to title, { sort_options: sort_method, options_direction: direction },
            class: css_class
  end
end
