class V1::UsersController < ApplicationController

  def index
    users = User.all.page(params[:page])
    render json: users, meta: pagination_dict(users)
  end

  def show
    user = User.find(params[:id])
    render json: user, include: [roles: :permissions]
  end

  def update
    user = User.find(params[:id])
    user.update_attributes(user_params)
    render json: user
  end

  def find
    users = User.search(params[:q])
    render json: users
  end

  private

  def user_params
    params.require(:user).merge(role_ids: params[:role_ids])
                         .permit(:id, role_ids: [])
  end

end