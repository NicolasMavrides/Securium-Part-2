# ApplicationHelper
module ApplicationHelper
  def link_dynamic(name = nil, options = nil, remote_target = nil, html_options = nil, &block)
    html_options, remote_target, options, name = remote_target, options, name, block if block_given?

    html_options ||= {}
    html_options[:data] ||= {}
    html_options[:data][:remote_target] = remote_target
    html_options[:remote] = true
    html_options[:class] ||= ''
    html_options[:class] += ' link-dynamic'

    if block_given?
      link_to(options, html_options, &block)
    else
      link_to(name, options, html_options, &block)
    end
  end

  def html_only(string)
    sanitize string, tags: %w[strong em a code pre h1 h2 h3 p blockquote ul ol li br],
                     attributes: %w[href class]
  end
end
