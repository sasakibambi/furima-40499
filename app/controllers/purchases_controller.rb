# class PurchasesController < ApplicationController
#   def index
#     @purchase_form = PurchaseForm.new
#   end
# end

class PurchasesController < ApplicationController
  before_action :authenticate_user!  # ユーザーが認証されていることを確認
  before_action :set_item, only: [:index, :create]

  def index
    @purchase_form = PurchaseForm.new  # Formオブジェクトのインスタンスを作成して、インスタンス変数に代入する
  end

  def create
    @purchase_form = PurchaseForm.new(purchase_params)
    if @purchase_form.save
      redirect_to root_path, notice: '購入が完了しました。'
    else
      render :index
    end
  end

  private

  def set_item
    @item = Item.find(params[:item_id])
  end

  def purchase_params
    params.require(:purchase_form).permit(:item_id, :buyer_id, :shipping_address_id, :purchase_price, :shipping_address_attributes => [:postal_code, :prefecture_id, :city, :address, :building, :phone_number]).merge(user_id: current_user.id)

  end
end