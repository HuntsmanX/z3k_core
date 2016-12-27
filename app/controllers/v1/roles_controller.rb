class V1::RolesController < ApplicationController
  before_action :authenticate_v1_user!

  def index
    authorize Role
    roles = Role.all.page(params[:page])
    render json: roles, meta: pagination_dict(roles)
  end

  def create
    authorize Role
    role = Role.new role_params
    if role.save
      render json: role
    else
      render json: role.errors.messages, status: 422
    end
  end

  def show
    role = Role.find(params[:id])
    authorize role
    render json: role
  end

  def update
    role = Role.find(params[:id])
    authorize role
    if role.update_attributes(role_params)
      render json: role
    else
      render json: role.errors.messages, status: 422
    end
  end

  def find
    authorize Role
    render json: Role.ransack(name_cont: params[:q]).result.as_json
  end

  private

  def role_params
    params.permit(
      :name,
      permissions_attributes: [
        :id,
        :allowed,
        conditions: PermissionsSchema.instance.condition_attr_names
      ]
    )
  end

end
