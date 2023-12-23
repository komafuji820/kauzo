class ItemsController < ApplicationController
  before_action :find_item, only: [:edit, :update]

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
      redirect_to group_items_path(params[:group_id])
    else
      render :new, status: :unprocessable_entity
    end
  end

  def edit
  end

  def update
    if @item.update(item_params)
      redirect_to group_items_path(params[:group_id])
    else
      render :edit, status: :unprocessable_entity
    end
  end

  def destroy
    item = Item.find(params[:id])
    item.destroy
    redirect_to group_items_path(id: item.group.id)
  end

  private

  def item_params
    params.require(:item).permit(:memo, :image, :category_id).merge(group_id: params[:group_id])
  end

  def find_item
    @item = Item.find(params[:id])
  end

end
