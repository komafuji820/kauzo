class GroupsController < ApplicationController
  before_action :authenticate_user!
  before_action :find_group, only:[:show, :edit]

  
  def index
    @groups = Group.all
  end

  def new
    @group = Group.new
  end

  def create
    @group = Group.new(group_params)
    if @group.save
      flash[:group_create] = "グループ#{@group.name}を作成しました。"
      redirect_to root_path
    else
      flash.now[:group_name_error] = "グループ名を入力してください。"
      render :new, status: :unprocessable_entity
    end
  end

  def show
  end

  def edit
  end

  def update
    group = Group.find(params[:id])
    group.update(group_params)
    redirect_to root_path
  end

  private

  def group_params
    params.require(:group).permit(:name)
  end

  def find_group
    @group = Group.find(params[:id])
  end

end