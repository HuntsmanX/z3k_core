class V1::Forms::ResponsesController < ApplicationController

  def index
    render json: ::Forms::Response.all, each_serializer: Forms::ResponseSerializer
  end

  def create
    if response_params[:user_id] && params[:user_type] != 'local'
      user_params = User.show(response_params[:user_id], params[:user_type])
      user_params = { name: user_params['full_name'], email: user_params['email'], phone: user_params['phone'] }
    else
      user_params = response_params[:user]
    end

    user = User.new user_params
    response = nil

    if user.save
      response = user.responses.new
      response.duplicate_test(response_params[:test_id])
    end

    redirect_to start_path(response)
  end

  def start
    respond_with ::Forms::Response.find_by_id(params[:response_id])
  end

  private

  def response_params
    params.require(:response).permit(:test_id, :user_id, user: [:name, :email, :phone])
  end

end
