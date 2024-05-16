# class PurchasesController < ApplicationController
#   def index
#     @form = Form.new
#   end
# end

class PurchasesController < ApplicationController
  before_action :authenticate_user!  # ユーザーが認証されていることを確認
  before_action :set_item, only: [:index, :create]

  def index
    @form = Form.new  # Formオブジェクトのインスタンスを作成して、インスタンス変数に代入する
  end

  def create
    @form = Form.new(purchase_params)
    if @form.valid?
      @form.save
      redirect_to root_path
    else
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
            .merge(user_id: current_user.id, item_id: params[:item_id])
    end
end
