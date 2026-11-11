class ApplicationController < ActionController::Base
  # Only allow modern browsers supporting webp images, web push, badges, import maps, CSS nesting, and CSS :has.
  allow_browser versions: :modern

  # Changes to the importmap will invalidate the etag for HTML responses
  stale_when_importmap_changes

  # ทุกหน้าต้อง login ยกเว้น controller ที่ skip เอง
  before_action :authenticate_user!

  private

  def require_admin!
    return if current_user&.admin?

    render plain: "403 Forbidden — หน้านี้สำหรับ Admin เท่านั้น", status: :forbidden
  end
end
