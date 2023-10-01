class Users::AccountsController < ApplicationController
  
  def show
  end

  def edit 
  end

  def update
    if @user.update
      flash[:success] = "プロフィールを更新しました!"
      redirect_to @user
    else
      render :edit
    end
  end
  
end