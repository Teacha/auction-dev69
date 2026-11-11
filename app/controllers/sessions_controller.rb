# หน้า sign in (มีแค่ปุ่มไป Keycloak) และ sign out
# sign out = ล้าง session ในระบบเรา แล้วส่งต่อไป Keycloak logout เพื่อปิด SSO session ด้วย
class SessionsController < ApplicationController
  skip_before_action :authenticate_user!

  def new
    redirect_to root_path if user_signed_in?
  end

  def destroy
    sign_out(:user)
    redirect_to keycloak_logout_url, allow_other_host: true
  end

  private

  def keycloak_logout_url
    issuer = ENV["KEYCLOAK_ISSUER"]
    return root_path if issuer.blank?

    query = {
      client_id: ENV["KEYCLOAK_CLIENT_ID"],
      post_logout_redirect_uri: root_url
    }.to_query
    "#{issuer.chomp('/')}/protocol/openid-connect/logout?#{query}"
  end
end
