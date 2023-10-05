class Users::ProfilesController < ApplicationController
  
  def show
  end

  def edit
  end

  def update
    @user = current_user
    @user.attributes
    if @user.update(profile_params)
      flash[:success] = "プロフィールを更新しました!"
      redirect_to users_profile_path
    else
      render :edit
    end
  end

  private

  def profile_params
    params.require(:user).permit(:image, :name, :profile)
  end

end