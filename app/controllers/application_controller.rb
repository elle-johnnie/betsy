class ApplicationController < ActionController::Base
  before_action :find_user
  before_action :list_categories, :list_merchants
  # before_action :require_login, except: [:create, :root]

  helper_method :current_order

  def list_categories
    @categories = Category.all
  end

  def list_merchants
    @users = User.all
  end


  def current_order
    if !session[:order_id].nil?
      Order.find(session[:order_id])
    else
      Order.new
    end
  end

  def render_404
    raise ActionController::RoutingError.new('Not Found')
  end

  private
    def find_user
      if session[:user_id]
        @login_user ||= User.find(session[:user_id]) if session[:user_id]
      end
    end


    def require_login
      if session[:user_id].nil?
        flash[:status] = :failure
        flash[:result_text] = "You must be logged in to view this section"
        redirect_to root_path
      end
    end

end
