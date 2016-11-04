class V1::UsersController < ApplicationController

  before_action :authenticate_user

  def index
    @users = User.all
    render json: @users, each_serializer: ::UserSerializer
  end

end