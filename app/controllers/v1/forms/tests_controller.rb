class V1::Forms::TestsController < ApplicationController
  before_action :authenticate_v1_user!
  respond_to :json

  def index
    tests = ::Forms::Test.with_nested.order(created_at: :desc).search(params[:q]).result.page(params[:page]).per(params[:per])
    render json: tests, with_nested: false, meta: pagination_dict(tests)
  end

  def find_test
    tests = ::Forms::Test.search_by_name(params[:q])
    tests = ::Forms::Test.all unless tests.any?
    render json: tests.as_json(methods: :alerts)
  end

  def show
    test = ::Forms::Test.with_nested.find params[:id]
    render json: test, include: [sections: [questions: [fields: :options]]]
  end

  def create
    test = ::Forms::Test.new test_params
    if test.save
      render json: test
    else
      render json: test.errors.messages, status: 422
    end
  end

  def destroy
    test = ::Forms::Test.find params[:id]
    test.destroy
    render json: {}
  end

  private

  def test_params
    params.require(:test).permit(:name)
  end

end
