class UsersController < ApplicationController
  before_action :set_user, only: [:show, :edit, :update, :destroy]

  # GET /users/1
  def show
    @user = User.find_by(id: params[:id])
    render_404 unless @user
  end

  # GET /users/new
  def new
    @user = User.new
  end

  # POST /users
  def create
    @user = User.new(user_params)

    if @user.save # save returns true if the database insert succeeds
      flash[:success] = 'user Created!'

      redirect_to root_path # go to the index so we can see the book in the list
    else # save failed :(
      flash.now[:danger] = 'user not created!'

      render :new, status: :bad_request# show the new book form view again
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_user
      @user = User.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def user_params
      params.require(:user).permit(:uid, :username, :email, :id)
    end

  # GET /users/1/edit
  def edit
  end


end
