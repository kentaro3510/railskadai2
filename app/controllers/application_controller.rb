class ApplicationController < ActionController::Base
  protect_from_forgery with: :exception

  # ログイン済ユーザーのみにアクセスを許可する
  # application_controller.rbに設定することで、
  # どのページでもログインしていないとログインページに飛ばされるようになります
  #before_action :authenticate_user!

  # deviseコントローラーにストロングパラメータを追加する 
  before_action :configure_permitted_parameters, if: :devise_controller?

  protected
  # deviseをインストールすることで使えるストロングパラメータに該当する機能
  # 入力フォームからアカウント名情報をDBに保存するために追加
  def configure_permitted_parameters
    # サインアップ時にnameのストロングパラメータを追加
    devise_parameter_sanitizer.permit(:sign_up, keys: [:name, :email, :image])
    # アカウント編集の時にnameとprofileのストロングパラメータを追加
    devise_parameter_sanitizer.permit(:account_update, keys: [:name, :profile, :image])
  end

  #ログイン後のリダイレクト先をホーム画面に指定
  def after_sign_in_path_for(resource)
    root_path
  end

end
