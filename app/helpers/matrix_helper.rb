module MatrixHelper
  def sort_options(sort_method, title = nil)
    title ||= sort_method.titleize
    link_to title, sort_options: sort_method
  end
end
