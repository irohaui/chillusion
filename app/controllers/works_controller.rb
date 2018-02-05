class WorksController < ApplicationController
  before_action :require_user_logged_in
  before_action :correct_user, only: [:destroy]
  def create
    @work = current_user.works.build(work_params)
    if @work.save
      flash[:success]="投稿しました"
      redirect_to root_url
    else
      @works = current_user.works.order("created_at DESC").page(params[:page])
      flash.now[:danger]="投稿に失敗しました"
      render "users/new"
    end
  end

  def show
  end

  def destroy
    @work.destroy
    flash[:success]="投稿を削除しました"
    redirect_back(fallback_location: root_path)
  end
  
  private
  
  def work_params
    params.require(:work).permit(:title, :work_path, :caption, :image)
  end
  
  def correct_user
    @work = current_user.works.find_by(id: params[:id])
    unless @work
      redirect_to root_url
    end
  end
end
