# URL หลักของแอป ใช้สร้าง redirect_uri ให้ Keycloak
# ลำดับ: APP_URL → https://APP_HOST → https://RAILWAY_PUBLIC_DOMAIN → http://localhost:3000
module AppUrl
  module_function

  def base
    return ENV["APP_URL"].chomp("/") if ENV["APP_URL"].present?

    host = ENV["APP_HOST"].presence || ENV["RAILWAY_PUBLIC_DOMAIN"].presence
    host ? "https://#{host}" : "http://localhost:3000"
  end
end
