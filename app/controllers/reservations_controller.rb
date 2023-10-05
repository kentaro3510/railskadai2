class ReservationsController < ApplicationController
  
  #予約済み一覧
  def index
    @reservations= current_user.reservations.all
  end

  def create #room/showからの、予約確定ボタンの先
    @reservation = current_user.reservations.new(reservation_params)
    if @reservation.save
      flash[:notice] = "予約を完了しました"
      redirect_to reservations_path
    else
      render confirm_reservations_path
      flash[:alert] = "予約に失敗しました"
    end
  end

  def edit
    @reservation = Reservation.find(params[:id])
  end


  def update
    @reservation = Reservation.find(params[:id])
    if @reservation.update(reservation_params)
      redirect_to reservations_path
    else
      render confirm_reservations_path
    end
  end

  def destroy
    @reservation = Reservation.find(params[:id])
    @reservation.destroy
    flash[:notice] = "予約を削除しました"
    redirect_to reservations_path
  end


  # 予約＆再予約 直前の内容確認
  def confirm
    
    # find_or_initialize_byはデータがあればとってくるなければ新しく初期化するというメソッド
    @reservation = current_user.reservations.find_or_initialize_by(id: params[:id])
    # editとnewで分岐させる(すでに作成されているreservationはroomが紐づいているので...)
    if @reservation.room.present?
      # 再予約の時はroomがすでに紐づいているので、@reservation.roomで呼び出す
      @room = @reservation.room
    else
      # 新規の時はまだ紐づく前なので、送られてきたroom_idからroomを特定する
      @room = Room.find(reservation_params[:room_id])
    end

    #@reservation.roomにそのif文で代入したroomを入れているということ
    @reservation.room = @room

    # edit newの共通の処理
    @reservation.checkin_date = reservation_params[:checkin_date]
    @reservation.checkout_date = reservation_params[:checkout_date]
    @reservation.number_of_people = reservation_params[:number_of_people].to_i
    # 宿泊日数の計算
    if reservation_params[:checkout_date].present? && reservation_params[:checkin_date].present?
      @reservation.length_of_stay = reservation_params[:checkout_date].to_date - reservation_params[:checkin_date].to_date
    end
    # 宿泊金額の合計計算
    @reservation.amount_of_price = @reservation.length_of_stay.to_i * @room.price.to_i * reservation_params[:number_of_people].to_i

    #「予約確定」押下前の確認画面でバリデーションメッセージを表示するため、以下を追加
    # reservationバリデ-ションが通らなかった時(unless)、中身のif文を実行 
    unless @reservation.valid?
      #id=DBが存在する＝予約編集
      if @reservation.id.present?
        render :edit
      #id=DBが存在しない＝新規予約
      else
        render 'rooms/show'
      end
    end
  end

  private

  def reservation_params
    params.require(:reservation).permit(:room_id, :user_id, :checkin_date, :checkout_date, :number_of_people, :length_of_stay, :amount_of_price)
  end
  
end