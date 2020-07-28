# Application Controller
class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception
  before_action :update_headers_to_disable_caching
  before_action :ie_warning
  before_action :configure_permitted_parameters, if: :devise_controller?

  def configure_permitted_parameters
    attributes = [:username, :password, :password_confirmation, :remember_me, :email]
    devise_parameter_sanitizer.permit(:sign_up, keys: attributes)
    devise_parameter_sanitizer.permit(:account_update, keys: attributes)
  end

  ## The following are used by our Responder service classes so we can access
  ## the instance variable for the current resource easily via a standard method
  def resource_name
    controller_name.demodulize.singularize
  end

  def current_resource
    instance_variable_get(:"@#{resource_name}")
  end

  def current_resource=(val)
    instance_variable_set(:"@#{resource_name}", val)
  end

  # Catch NotFound exceptions and handle them neatly
  # when URLs are mistyped or mislinked
  rescue_from ActiveRecord::RecordNotFound do
    render template: 'errors/error_404', status: 404
  end
  rescue_from CanCan::AccessDenied do
    render template: 'errors/error_403', status: 403
  end

  # IE over HTTPS will not download if browser caching is off,
  # so allow browser caching when sending files
  def send_file(file, opts = {})
    # Still prevent proxy caching
    response.headers['Cache-Control'] = 'private, proxy-revalidate'
    response.headers['Pragma'] = 'cache'
    response.headers['Expires'] = '0'
    super(file, opts)
  end

  def high_contrast
    cookies[:high_contrast] = {
      value: 'high contrast theme on'
    }
    redirect_back(fallback_location: home_path)
  end

  def normal_theme
    cookies.delete(:high_contrast)
    redirect_back(fallback_location: home_path)
  end

  private

  def update_headers_to_disable_caching
    response.headers['Cache-Control'] =
      'no-cache, no-cache="set-cookie", no-store, private, proxy-revalidate'
    response.headers['Pragma'] = 'no-cache'
    response.headers['Expires'] = '-1'
  end

  def ie_warning
    return redirect_to(ie_warning_path) if request.user_agent.to_s =~ %r{/MSIE [6-7]/ && request.user_agent.to_s !~ /Trident\/7.0/}
  end

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

  def after_sign_in_path_for(resource)
    if resource.is_a?(Admin)
      categories_path
    else
      root_path
    end
  end

end
