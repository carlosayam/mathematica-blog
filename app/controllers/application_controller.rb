class ApplicationController < ActionController::Base

  protect_from_forgery

  expose(:all_years) { Post.years() }

end
