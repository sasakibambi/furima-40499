class ApplicationController < ActionController::Base
  before_action :basic_auth
  before_action :configure_permitted_parameters, if: :devise_controller?

  private

  def configure_permitted_parameters
    devise_parameter_sanitizer.permit(:sign_up,
                                      keys: [:nickname, :family_name, :first_name, :family_name_kana, :first_name_kana,
                                             :date_of_birth])
  end

  def basic_auth
    authenticate_or_request_with_http_basic do |username, password|
      username == ENV['BASIC_AUTH_USER'] && password == ENV['BASIC_AUTH_PASSWORD'] # 環境変数を読み込む記述に変更
    end
  end
end

# devise使用時はここのコントローラーが呼び出される
#  devise_parameter_sanitizer新規登録をデバイス経由で使いたい時
# configure_permitted_parametersデバイス経由でパラメーターが送信される
