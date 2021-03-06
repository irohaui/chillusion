class UsersController < ApplicationController
  before_action :require_user_logged_in, only: [:index, :show, :edit, :followings, :followers, :favorite_works]
  
  def index
    @users = User.all.order("created_at DESC").page(params[:page])
  end
  
  def show
    @user = User.find(params[:id])
    # binding.pry
    @works = @user.works.order("created_at DESC").page(params[:page])
    counts(@user)
  end

  def new
    if logged_in?
      @user = current_user
      @work = current_user.works.build #form_for用
      @works = current_user.feed_works.order("created_at DESC").page(params[:page])
    else
      @user = User.new
    end
  end

  def create
    @user = User.new(user_params)
    if @user.save
      flash[:success]="ユーザーを登録しました"
      redirect_to @user
    else
      flash.now[:danger]="ユーザーの登録に失敗しました"
      render :new
    end
  end

  def edit
    @user = User.find(params[:id])
  end

  def update
    @user = User.find(params[:id])
    if @user.update(user_params)
      flash[:success]="更新しました"
      redirect_to @user
    else
      flash.now[:danger]="更新に失敗しました"
      render :edit
    end
  end
  
  def followings
    @user = User.find(params[:id])
    @followings = @user.followings.order("created_at DESC").page(params[:page])
    counts(@user)
    # @works = current_user.feed_works.order("created_at DESC").page(params[:page])
    # @work = @user.works.last
  end
  
  def followers
    @user = User.find(params[:id])
    @followers = @user.followers.order("created_at DESC").page(params[:page])
    counts(@user)
    # @works = current_user.feed_works.order("created_at DESC").page(params[:page])
    # @work = @user.works.last
  end
  
  def favorite_works
    @user = User.find(params[:id])
    @favorite_works = @user.favorite_works.order("created_at DESC").page(params[:page])
    counts(@user)
  end
  
  private

  def user_params
    params.require(:user).permit(:name, :email, :password, :password_confirmaion, :profile, :image, :image_cache, :remove_image)
  end
end
