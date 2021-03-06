class ApplicationController < ActionController::Base
  protect_from_forgery with: :exception

  before_action :find_user
  before_action :require_login, only: [:index, :show]


  def render_404
    return render :file => "#{Rails.root}/public/404.html", :status => 404, :layout => false
  end

  private

  def find_user
    if session[:user_id]
      @login_user = User.find_by(id: session[:user_id])
    end
  end

  def require_login
    if session[:user_id].nil?
      flash[:error] = "You must be logged in to view this section"
      redirect_to root_path
    end
  end
end
