# DynamicRenderer
module DynamicRenderer
  def render_dynamic(partial, selector, format = nil)
    unless partial.is_a? Array
      partial = [partial]
      selector = [selector]
    end

    @selector = selector
    @partial = partial

    if format
      format.js { render :js, partial: 'layouts/dynamic' }
    else
      render :js, partial: 'layouts/dynamic'
    end
  end
end
