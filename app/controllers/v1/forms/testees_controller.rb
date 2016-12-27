class V1::Forms::TesteesController < ApplicationController
  before_action :authenticate_v1_user!

	def find
    authorize ::Forms::Testee
		users = ::Forms::Testee.by_name(params[:q],'recruitment')['employees']
		render json: users
	end

end
