class UsersController < ApplicationController

  def search
    @users = User.where.not(id: current_user.id).search(params[:keyword])
  end

  def add_member
    @users = Group.new(add_member_params)
    session["add_member_data"] = {users: @users.attributes}
    session["add_member_data"][:users]["id"] = params[:group][:user_ids]
    user_ids = session["add_member_data"][:users]["id"]
    @members = User.find(user_ids)
  end

  private
  def add_member_params
    params.require(:group).permit(user_ids:[])
  end
  
end
