class V1::Forms::TestsController < ApplicationController
  before_action :authenticate_v1_user!

  def index
    authorize ::Forms::Test
    tests = ::Forms::Test.with_nested.order(created_at: :desc).search(params[:q]).result.page(params[:page]).per(params[:per])
    render json: tests, with_nested: false, meta: pagination_dict(tests)
  end

  def find
    authorize ::Forms::Test
    tests = ::Forms::Test.search({ name_cont: params[:q] }).result
    render json: tests.as_json(methods: :alerts)
  end

  def show
    test = ::Forms::Test.with_nested.find params[:id]
    authorize test
    render json: test, include: [sections: [questions: [fields: :options]]]
  end

  def create
    authorize ::Forms::Test
    test = ::Forms::Test.new test_params
    if test.save
      render json: test
    else
      render json: test.errors.messages, status: 422
    end
  end

  def destroy
    test = ::Forms::Test.find params[:id]
    authorize test
    test.destroy
    render json: {}
  end

  private

  def test_params
    params.require(:test).permit(:name)
  end

end
