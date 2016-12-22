class V1::Forms::ResponsesController < ApplicationController
  before_action :authenticate_v1_user!, except: [:show]
  respond_to :json

  def index
    authorize [:v1, :forms, :response]
    responses = ::Forms::Response.with_nested.includes(:user).search(params[:q]).result.page(params[:page])
    render json: responses, with_nested: false, meta: pagination_dict(responses)
  end

  def show
    response = ::Forms::Response.with_nested.find params[:id]
    authorize [:v1, response]
    render json: response, include: [sections: [questions: [fields: :options]]]
  end

  def create
    authorize [:v1, :forms, :response]
    form = ::Forms::CreateResponseForm.new
     if form.submit(response_params)
       render json: form.model
     else
       render json: form.errors.messages, status: 422
     end
  end

  private

  def response_params
    params.require(:response).permit(:test_id, :user_id)
  end

end
