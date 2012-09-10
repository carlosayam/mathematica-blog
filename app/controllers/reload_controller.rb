require 'digest/md5'

class ReloadController < ApplicationController

  REALM = "MathematicaBlog"

  ADMIN_USER = "#{Rails.application.config.admin_user}"
  ADMIN_PASSWORD = "#{Rails.application.config.admin_password}"

  USERS = {ADMIN_USER => Digest::MD5.hexdigest([ADMIN_USER,REALM,ADMIN_PASSWORD].join(":"))}

  before_filter :authenticate

  def reload
    Post.reload_year(params[:year])
    redirect_to post_index_path
  end

  private
  def authenticate
    authenticate_or_request_with_http_digest(REALM) do |username|
      USERS[username]
    end
  end  
end
