module Admin
  # controller ทุกตัวใต้ namespace admin ต้องสืบทอดจากคลาสนี้
  class BaseController < ApplicationController
    before_action :require_admin!
  end
end
