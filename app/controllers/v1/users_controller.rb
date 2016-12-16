class V1::UsersController < ApplicationController

  def index
    users = User.all.page(params[:page])
    render json: users, meta: pagination_dict(users)
  end

  def find
    users = User.search(params[:q])
    render json: users
  end

end