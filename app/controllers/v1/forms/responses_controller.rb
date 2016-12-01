class V1::Forms::ResponsesController < ApplicationController

  def index
    responses = ::Forms::Response.with_nested.includes(:user).all.page(params[:page])
    render json: responses, with_nested: false, meta: pagination_dict(responses)
  end

  def show
    response = ::Forms::Response.with_nested.references(:fields).find params[:id]
    render json: response, include: [sections: [questions: [fields: :options]]]
  end

  def create
    testee = ::Forms::FindOrInitTestee.new(response_params[:user_id]).testee
    if testee.save
      response = ::Forms::DuplicateTestForResponse.new(testee, response_params[:test_id]).response
      render json: response
    else
      render json: testee, status: 422, adapter: :json_api, serializer: ActiveModel::Serializer::ErrorSerializer and return
    end
  end

  private

  def response_params
    params.require(:response).permit(:test_id, :user_id)
  end

end
