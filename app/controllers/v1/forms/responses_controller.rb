class V1::Forms::ResponsesController < ApplicationController

  def index
    render json: ::Forms::Response.all, each_serializer: Forms::ResponseSerializer
  end

  def create
    testee = ::Forms::FindOrInitTestee.new(response_params[:testee]).testee

    if testee.save
      response = ::Forms::ResponseDup.new(testee, response_params[:test_id]).response
      redirect_to start_path(response.id) and return
    else
      redirect_to responses_path, alert: testee.errors.full_messages.join(', ') and return
    end
  end

  def start
    respond_with ::Forms::Response.find_by_id(params[:response_id])
  end

  private

  def response_params
    params.require(:response).permit(:test_id, testee: [:source_type, :user_id, :first_name, :last_name, :email, :phone, :city_id])
  end

end
