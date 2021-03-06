class ApplicationController < ActionController::Base
  protect_from_forgery with: :exception
  before_action :authenticate_user!
  before_action :set_locale
  after_action :store_location

  before_action :configure_permitted_parameters, if: :devise_controller?

  def set_locale
    I18n.locale = params[:locale] || I18n.default_locale
  end

  def default_url_options
    { host: ENV['HOST'] || 'localhost:3000', locale: I18n.locale == I18n.default_locale ? nil : I18n.locale }
  end

  def configure_permitted_parameters
    # For additional fields in app/views/devise/registrations/new.html.erb
    devise_parameter_sanitizer.permit(:sign_up, keys: [:first_name, :last_name])

    # For additional in app/views/devise/registrations/edit.html.erb
    devise_parameter_sanitizer.permit(:account_update, keys: [:username])
  end


  def store_location
    if request.original_url !~ /users\/(sign_in|sign_up)/ # safelist
      session[:back_url] = request.original_url
    end
  end

  def after_sign_in_path_for(resource)
    stored_location_for(resource) || session.delete(:back_url) || request.env['omniauth.origin'] || root_path
  end

  include Pundit

    # Pundit: white-list approach.
    after_action :verify_authorized, except: :index, unless: :skip_pundit?
    after_action :verify_policy_scoped, only: :index, unless: :skip_pundit?

    # Uncomment when you *really understand* Pundit!
    rescue_from Pundit::NotAuthorizedError, with: :user_not_authorized
    def user_not_authorized
      flash[:alert] = "You are not authorized to perform this action."
      redirect_to(root_path)
    end

    private

    def skip_pundit?
      devise_controller? || params[:controller] =~ /(^(rails_)?admin)|(^pages$)/
    end
end
