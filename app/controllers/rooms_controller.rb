class RoomsController < ApplicationController

  before_action :check_update, only: [:update,:edit]
  
  before_action :authenticate_user!, only: [:show]
  
  def new
    @user = current_user
    @room = Room.new
  end

  def create
    @room = current_user.rooms.new(params.require(:room).permit(:image, :name_of_hotel, :introduction, :price, :address))
    if @room.save
      flash[:success] = "施設が作成されました"
      redirect_to @room
    else
      render new_room_path
      #flash[:alert] = "施設作成に失敗。施設画像以外は、記入必須項目です。"
    end
  end

  def show
    @user = current_user
    @room = Room.find(params[:id])
    #reservation(予約)を新規作成
    @reservation = Reservation.new
  end

  def edit
    @user = current_user
    @room = Room.find(params[:id])
  end

  def update
    @room = Room.find(params[:id])
    if @room.update (params.require(:room).permit(:image, :name_of_hotel, :introduction, :price, :created_at, :address))
      flash[:notice] = "「#{@room.name_of_hotel}」の情報を更新しました"
    redirect_to @room
    else
      render :edit
    end
  end

  def destroy
    @room = Room.find(params[:id])
    @room.destroy
    flash[:notice] = "施設を削除しました"
    redirect_to :own_rooms
  end

  def own
    @rooms=current_user.rooms.all
  end

  def search
    @rooms = Room.all
    if params[:address].present?
      @rooms = @rooms.where('address LIKE ?', "%#{params[:address]}%")
    end
    if params[:keyword].present?
        @rooms = @rooms.where('address LIKE ?', "%#{params[:address]}%")
        @rooms = @rooms.where('name_of_hotel LIKE ? or introduction LIKE ?', "%#{params[:keyword]}%","%#{params[:keyword]}%")
    end
  end

  private

  def check_update
    if Room.find(params[:id]).user_id != current_user.id
      redirect_to root_path
    end
  end

end