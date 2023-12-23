class ItemsController < ApplicationController

  def index
    group = Group.find(params[:group_id])
    @items = group.items
  end

  def new
    @item_category = ItemCategory.new
  end

  def create
    @item_category = ItemCategory.new(item_params)
    if @item_category.valid?
      @item_category.save
      flash[:items_create] = "在庫リストを作成しました！"
      redirect_to group_items_path(params[:group_id])
    else
      render :new, status: :unprocessable_entity
    end
  end

  def edit
    # @item_category = ItemCategory.find(params[:id])
    @item = Item.find(params[:id])
  end

  def upadate
  end

  private

  def item_params
    params.require(:item_category).permit(:name, :memo, :image).merge(group_id: params[:group_id])
  end

end
