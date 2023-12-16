class UsersController < ApplicationController
  def search
    @users = User.search(params[:keyword])
  end
end
