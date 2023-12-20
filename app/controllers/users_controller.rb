class UsersController < ApplicationController

  def search_result
    # current_user以外を検索する
    @users = User.where.not(id: current_user.id).search(params[:keyword])
  end
 
end