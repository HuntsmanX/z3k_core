class V1::UsersController < ApplicationController
  before_action :authenticate_v1_user!

  def index
    authorize User
    users = User.staff.page(params[:page])
    render json: users, meta: pagination_dict(users)
  end

  def update
    user = User.find(params[:id])
    authorize user
    user.update_attributes(user_params)
    render json: user
  end

  private

  def user_params
    params.permit(role_ids: [])
  end

end
