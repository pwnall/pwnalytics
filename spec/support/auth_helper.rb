module AuthHelper
  def configvars_auth
    request.env['HTTP_AUTHORIZATION'] =
        ActionController::HttpAuthentication::Basic.encode_credentials('config',
                                                                       'vars')
  end
end
