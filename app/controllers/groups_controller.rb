class GroupsController < ApplicationController
  before_action :authenticate_user!
  before_action :find_group, :find_group_users, only:[:show, :edit]

  def index
  end

  def new
    # sessionに格納された情報をもとに、ユーザーを指定
    user_ids = session["add_member_data"]["users"]["id"]
    @members = User.find(user_ids)
    # 空のインスタンス変数生成
    @group = Group.new
  end

  def add_member
    # メンバーに追加したいユーザーのIDからインスタンス変数を生成
    @users = Group.new(add_member_params)
    
    # session情報がない場合
    if session["add_member_data"] == nil
      session["add_member_data"] = {users: @users.attributes} # @usersをハッシュ型にしてsessionに格納
      session["add_member_data"][:users]["id"] = params[:group][:user_ids] # メンバーに追加したユーザーのIDをsessionに格納
      user_ids = session["add_member_data"][:users]["id"] # session情報をuser_idsに代入

    # session情報が存在する場合
    else
      session["add_member_data"]["users"]["id"] << params[:group][:user_ids] # 既存のsessionに新しく追加したユーザーのIDを追加
      user_ids = session["add_member_data"]["users"]["id"] # session情報をuser_idsに代入
    end
    @members = User.find(user_ids) # user_idsに格納したsession情報からユーザーを指定
  end

  def create
    @group = Group.new(group_params)
    if @group.save
      flash[:group_create] = "#{@group.name}を作成しました！"
      session["add_member_data"] = nil # session情報を削除
      redirect_to root_path
    else
      flash.now[:group_name_error] = "グループ名を入力してください。"
      user_ids = session["add_member_data"]["users"]["id"]
      @members = User.find(user_ids) # session情報をもとにユーザーを指定。検索結果をrender先へ持ち越す
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

  def group_params # グループ作成時のストロングパラメータ
    params.require(:group).permit(:name, user_ids:[])
  end

  def add_member_params # メンバー追加時のストロングパラメータ
    params.require(:group).permit(user_ids:[])
  end

  def find_group
    @group = Group.find(params[:id])
  end

  def find_group_users
    @users = @group.users
  end

end