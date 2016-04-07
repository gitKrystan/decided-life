module MatrixHelper
  def sort_options(sort_method, options = {})
    title = options[:title] || sort_method.titleize
    criterium_id = options[:criterium_id]
    method_is_current = sort_method == options_sort_method
    criterium_is_current = criterium_id.to_s == options_sort_criterium.to_s
    css_class = if method_is_current && criterium_is_current
                  "dec-#{options_sort_direction}"
                end
    direction = if method_is_current && (options_sort_direction == 'asc')
                  'desc'
                else
                  'asc'
                end
    link_to title, { sort_options_by: sort_method,
                     options_direction: direction,
                     sort_by_criterium: criterium_id },
            class: css_class
  end
end
