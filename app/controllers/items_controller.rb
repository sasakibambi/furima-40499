class ItemsController < ApplicationController
  before_action :authenticate_user!, except: [:index, :show]
  # except: [:index, :show]以外のリクエストは、ログアウト中のユーザーがリクエストを送った場合は自動的にログインページを表示させる.（ログインしていなければ[:index, :show]しか作動しない）
  def index
    @items = Item.order('created_at DESC')
  end
  # indexは全ての投稿を表示させるので変数名は複数形の方がわかりやすい
  # レコードを順に並べ替える
  # インスタンス変数にするのはビューで使えるようにするため

  def new
    @item = Item.new
  end

  def show
    @item = Item.find(params[:id])
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

  def item_params
    params.require(:item).permit(:product_name, :product_description, :category_id, :product_condition_id,
                                 :shipping_fee_burden_id, :prefecture_id, :shipping_day_id, :selling_price, :image).merge(user_id: current_user.id)
  end
end
