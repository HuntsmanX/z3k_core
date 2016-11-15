class V1::UsersController < ApplicationController

  before_action :authenticate_user

  def index
    users = User.all.page(params[:page])
    render json: users, meta: pagination_dict(users)
  end

end