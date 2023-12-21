class GroupsController < ApplicationController
  before_action :authenticate_user!
  before_action :find_group, :find_group_users, only:[:show, :edit]

  def index
  end

  def add_members_to_list
    # メンバーリストに追加したユーザーのインスタンス変数を生成
    @users = Group.new(add_members_to_list_params)
    
    # session情報がない場合
    if session["members_list"] == nil
      session["members_list"] = {users: @users.attributes}
      session["members_list"][:users]["ids"] = params[:group][:user_ids]
      user_ids = session["members_list"][:users]["ids"]

    # session情報が存在する場合
    else
      session["members_list"]["users"]["ids"] << params[:group][:user_ids]
      user_ids = session["members_list"]["users"]["ids"]
    end

    # session情報からユーザーを検索
    @members = User.find(user_ids)
  end

  def new
    # session情報からユーザーを検索
    user_ids = session["members_list"]["users"]["ids"]
    @members = User.find(user_ids)
    @group = Group.new
  end

  def create
    @group = Group.new(group_params)
    if @group.save
      flash[:group_create] = "#{@group.name}を作成しました！"
      # session情報を削除
      session["members_list"] = nil
      redirect_to root_path
    else
      flash.now[:group_name_error] = "グループ名を入力してください。"
      # session情報からユーザーを検索し、その結果をrender先へ持ち越す
      user_ids = session["members_list"]["users"]["ids"]
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
    flash[:group_delete] = "#{group.name}を削除しました"
  end

  private

  # メンバーリストに追加する時のストロングパラメータ
  def add_members_to_list_params
    params.require(:group).permit(user_ids:[])
  end

  # グループ作成時のストロングパラメータ
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