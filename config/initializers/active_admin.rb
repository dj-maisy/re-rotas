class SessionAuthAdapter < ActiveAdmin::AuthorizationAdapter
  def authorized?(_, _ = nil)
    Rotas::Authorisation.is_admin?(user)
  end
end

ActiveAdmin.setup do |config|
  config.site_title = "Rotas"

  config.authentication_method = :maybe_redirect_if_not_signed_in
  config.authorization_adapter = SessionAuthAdapter
  config.current_user_method = :current_user
  config.logout_link_path = :session_path

  config.comments = false
  config.batch_actions = true

  config.localize_format = :long
end
