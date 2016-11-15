class V1::Forms::ResponsesController < ApplicationController

  def index
    responses = ::Forms::Response.all.page(params[:page])
    render json: responses, with_nested: false, meta: pagination_dict(responses)
  end

  def create
    testee = ::Forms::FindOrInitTestee.new(response_params[:testee]).testee

    if testee.save
      response = ::Forms::ResponseDup.new(testee, response_params[:test_id]).response
      render json: response and return
    else
      render json: testee, status: 422, adapter: :json_api, serializer: ActiveModel::Serializer::ErrorSerializer and return
    end

  end

  private

  def response_params
    params.require(:response).permit(:test_id, testee: [:source_type, :user_id, :first_name, :last_name, :email, :phone, :city_id])
  end

end
