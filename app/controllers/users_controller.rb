class UsersController < ApplicationController

  def search_result
    @users = User.where.not(id: current_user.id).search(params[:keyword])
  end
 
end