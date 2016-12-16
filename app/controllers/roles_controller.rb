class RolesController < ApplicationController

  def index
    roles = Role.all.page(params[:page])
    render json: roles, meta: pagination_dict(roles)
  end

  def create
    users = User.where(id: params[:user_ids])
    role = Role.new(name: role_params[:name])
    role.assign_attributes(users: users) if users.any?
    role.save
    render json: role
  end

  def show
    role = Role.find(params[:id])
    render json: role
  end

  def update
    role = Role.find(params[:id])

    if role.update_attributes(role_params)
      render json: role
    else
      render json: role.errors.messages, status: 422
    end
  end

  def remove_user
    role = Role.find(params[:role_id])
    role.remove_user(params[:user_id])
    render json: role
  end

  def add_user
    role = Role.find(params[:role_id])
    render json: role
  end

  def search
    results = User.by_email(params[:email])
    render json: results.to_json
  end

  private

  def role_params
    params.require(:role).permit!
  end

end