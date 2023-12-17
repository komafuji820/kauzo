class UsersController < ApplicationController
  def search
    @users = User.search(params[:keyword])
    @group = Group.new
  end
end
