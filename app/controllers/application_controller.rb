class ApplicationController < ActionController::Base
  protect_from_forgery

  config_vars_auth
end
