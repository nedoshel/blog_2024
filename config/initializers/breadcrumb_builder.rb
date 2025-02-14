class BreadcrumbBuilder < BreadcrumbsOnRails::Breadcrumbs::Builder
  def render
    @elements.collect do |element|
      render_element(element)
    end.join('')
  end

  def render_element(element)
    if element.path == nil
      content = compute_name(element)
    else
      content = @context.link_to_unless_current(compute_name(element), compute_path(element), element.options)
    end
    @context.content_tag(:li, content, class: 'breadcrumb-item')
  end
end
