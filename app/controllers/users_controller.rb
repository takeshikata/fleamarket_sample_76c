class UsersController < ApplicationController
  before_action :set_parent, except: [:destroy]

  def show
  end

  def set_parent
    @parents = Category.all.order("id ASC").limit(10)
  end
end
