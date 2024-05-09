class ItemsController < ApplicationController
  def index
      @items = Item.order("created_at DESC")
  end

  def new
    @item = Item.new
    # @product_conditions = ['新品、未使用', '未使用に近い', /* 他の状態を追加 */]
  end

  def create
    @item = Item.new(item_params)
    if @item.save
      redirect_to root_path
    else
      render :new, status: :unprocessable_entity
    end
    # バリデーションに引っ掛からず保存できたら
    # topページに遷移する
    # 出品ページに戻っていく
  end
  private

  private

  def item_params
    params.require(:item).permit(:product_name, :product_description, :category_id, :product_condition_id, :shipping_fee_burden_id, :prefecture_id, :shipping_day_id, :selling_price, :image).merge(user_id: current_user.id)
  end
end