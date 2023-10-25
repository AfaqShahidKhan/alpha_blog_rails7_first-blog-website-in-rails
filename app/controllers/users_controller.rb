class UsersController < ApplicationController

  before_action :set_user, only: [:edit, :update, :show, :destroy]
  before_action :require_user, only: [:edit, :update]
  before_action :require_same_user, only: [:edit, :update, :destroy]


  def new
    @user = User.new
  end
  def show
  @articles = @user.articles
  @articles = @user.articles.paginate(page: params[:page], per_page: 5)
  end
  def index
  @users = User.all
  @users = User.paginate(page: params[:page], per_page: 5)
  end

  def create
    @user = User.new(user_params)
    if @user.save
    flash[:notice]="Welcome #{@user.username} to Alpha blog, you are signed up"
    redirect_to articles_path
    else
      render 'new'
    end

  end

  def destroy
    @user.destroy
    session[:user_id] = nil if @user == current_user
    flash[:notice] = "Account and all associated articles successfully deleted"
    redirect_to articles_path
  end

  def edit

  end
  def update
    if @user.update(user_params)
      flash[:notice]="User successfully updated!"
      redirect_to @user
      else
        render 'edit'
    end

  end


  private
  def user_params
  params.require(:user).permit(:username, :email, :password)
  end

  def set_user
    @user = User.find(params[:id])
  end

  def require_same_user
    if current_user != @user && !current_user.admin?
      flash[:alert] = "You can only edit or delete your own account"
      redirect_to @user
    end
  end

end
