class GroupsController < ApplicationController
  before_action :authenticate_user!
  
  def index
  end

  def new
    @group = Group.new
  end

  def create
    
  end

  private

  def group_params
  end

end
