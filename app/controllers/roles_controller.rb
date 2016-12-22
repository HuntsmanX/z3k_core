class RolesController < ApplicationController

  def index
    roles = Role.all.page(params[:page])
    render json: roles, meta: pagination_dict(roles)
  end

  def create
    role = Role.new(name: role_params[:name])
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

  def find
    results = Role.ransack(name_i_cont: params[:q]).result
    render json: results
  end

  private

  def role_params
    params.require(:role).merge(permissions_attributes: params[:permissions_attributes])
          .permit(:id, :name, permissions_attributes: [:id, :allowed, conditions: []])
  end

end