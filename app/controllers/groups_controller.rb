class GroupsController < ApplicationController
  before_action :authenticate_user!
  before_action :find_group, :find_group_users, only:[:show, :edit]

  def index
  end

  def new
    user_ids = session["add_member_data"]["users"]["id"]
    @members = User.find(user_ids)
    @group = Group.new
  end

  def create
    @group = Group.new(group_params)
    if @group.save
      flash[:group_create] = "#{@group.name}グループを作成しました。"
      session["add_member_data"]["users"].clear
      redirect_to root_path
    else
      flash.now[:group_name_error] = "グループ名を入力してください。"
      user_ids = session["add_member_data"]["users"]["id"]
      @members = User.find(user_ids)
      render :new, status: :unprocessable_entity
    end
  end

  def show
  end

  def edit
  end

  def update
    # group = Group.find(params[:id])
    # group.update(group_params)
    # redirect_to root_path
    # flash[:group_update] = "#{group.name}グループ情報を更新しました"
  end

  def destroy
    group = Group.find(params[:id])
    group.destroy
    redirect_to root_path
    flash[:group_delete] = "#{group.name}グループを削除しました"
  end

  private

  def group_params
    params.require(:group).permit(:name, user_ids:[])
  end

  def find_group
    @group = Group.find(params[:id])
  end

  def find_group_users
    @users = @group.users
  end

end