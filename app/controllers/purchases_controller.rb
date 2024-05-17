class PurchasesController < ApplicationController
  before_action :authenticate_user!  # ユーザーが認証されていることを確認
  before_action :set_item, only: [:index, :create]

  def index
    @form = Form.new  # Formオブジェクトのインスタンスを作成して、インスタンス変数に代入する
  end

  def create
    gon.public_key = ENV["PAYJP_PUBLIC_KEY"]
    @form = Form.new(purchase_params)
    if @form.valid?
      pay_item
      @form.save
      redirect_to root_path
    else
      gon.public_key = ENV["PAYJP_PUBLIC_KEY"]
      render :index, status: :unprocessable_entity
    end
  end

  private

  def set_item
    @item = Item.find(params[:item_id])
  end

  def purchase_params
   
      params.require(:form).permit(:purchase_id, :post_code, :prefecture_id, :purchase_price, :city_name,
                                   :street_address, :building_name, :telephone_number)
            .merge(user_id: current_user.id, item_id: params[:item_id],token: params[:token])
  end

  def pay_item
    Payjp.api_key = ENV["PAYJP_SECRET_KEY"]
    Payjp::Charge.create(
      amount: order_params[:price],  # 商品の値段
      card: order_params[:token],    # カードトークン
      currency: 'jpy'                 # 通貨の種類（日本円）
    )
  end
end

