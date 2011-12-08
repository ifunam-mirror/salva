class Academic::ApplicationController < ActionController::Base
  protect_from_forgery
  skip_before_filter :authenticate_user!
  before_filter :authenticate_academic!
  alias :current_user :current_academic

  layout :layout_by_resource

  def layout_by_resource
    if devise_controller?
      "devise"
    else
      "academic"
    end
  end
end
