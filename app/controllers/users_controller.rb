class UsersController < ApplicationController

  def search
  end
  
  def search_results
    # current_user以外を検索する
    @users = User.where.not(id: current_user.id).search(params[:keyword])
  end
 
end