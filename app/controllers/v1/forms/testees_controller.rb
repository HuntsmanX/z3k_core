class V1::Forms::TesteesController < ApplicationController
  before_action :authenticate_v1_user!
  respond_to :json

	def index
		users = User.all.page(params[:page])
		render json: users, meta: pagination_dict(users)
	end

	def find
		users = ::Forms::Testee.by_name(params[:q],'recruitment')['employees']
		render json: users
	end

end
