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
      session["members_list"] = {users: @users.attributes} # @usersをハッシュ型にしてsessionに格納
      session["members_list"][:users]["ids"] = params[:group][:user_ids] # メンバーリストに追加したユーザーのIDをsessionに格納
      user_ids = session["members_list"][:users]["ids"]

    # session情報が存在する場合
    else
      session["members_list"]["users"]["ids"] << params[:group][:user_ids] # 新しくメンバーリストに追加したユーザーのIDを既存のsessionに追加
      user_ids = session["members_list"]["users"]["ids"]
    end
    @members = User.find(user_ids) # session情報からユーザーを検索
  end

  def new
    # sessionに格納された情報をもとに、ユーザーを検索
    user_ids = session["members_list"]["users"]["ids"]
    @members = User.find(user_ids)
    # 空のインスタンスを生成
    @group = Group.new
  end

  def create
    @group = Group.new(group_params)
    if @group.save
      flash[:group_create] = "#{@group.name}を作成しました！"
      session["members_list"] = nil # session情報を削除
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

  def add_members_to_list_params # メンバーリストに追加する時のストロングパラメータ
    params.require(:group).permit(user_ids:[])
  end

  def group_params # グループ作成時のストロングパラメータ
    params.require(:group).permit(:name, user_ids:[])
  end

  def find_group
    @group = Group.find(params[:id])
  end

  def find_group_users
    @users = @group.users
  end

end