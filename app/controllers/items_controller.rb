class ItemsController < ApplicationController

  def index
    group = Group.find(params[:group_id])
    @items = group.items.order("created_at DESC")
  end

  def new
    @item = Item.new
  end

  def create
    @item = Item.new(item_params)
    if @item.save
      flash[:items_create] = "在庫リストを作成しました！"
      redirect_to group_items_path(params[:group_id])
    else
      flash.now[:items_create_error] = "メモを入力するか、画像を添付してください!"
      render :new, status: :unprocessable_entity
    end
  end

  def edit
    @item = Item.find(params[:id])
  end

  def update
    @item = Item.find(params[:id])
    if @item.update(item_params)
      redirect_to group_items_path(params[:group_id])
    else
      render :edit, status: :unprocessable_entity
    end
  end

  private

  def item_params
    params.require(:item).permit(:memo, :image, :category_id).merge(group_id: params[:group_id])
  end

end
