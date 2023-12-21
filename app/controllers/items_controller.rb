class ItemsController < ApplicationController

  def index
    group = Group.find(params[:group_id])
    @items = group.items
  end

  def new
    @item = Item.new
  end

  def create
    @items = Item.new(item_params)
    if @items.save
      flash[:items_create] = "在庫リストを作成しました！"
      redirect_to group_items_path(@items.group_id)
    # else
      # render :new, status: :unprocessable_entity
    end
  end

  private

  def item_params
    params.require(:item).permit(:memo, :priority_id).merge(group_id: params[:group_id])
  end
end
