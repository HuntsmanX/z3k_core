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

  def update
    test = ::Forms::Test.find params[:id]
    authorize test
    if test.update_attributes(test_params)
      render json: test
    else
      render json: test.errors.messages, status: 422
    end
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

    if test.destroy
      render json: test
    else
      render json: test.errors.messages, status: 422
    end

  end

  private

  def test_params
    params.require(:test).permit(:name, :success_criterion, :required_score, :required_score_unit, :successful_sections_count)
  end

end
