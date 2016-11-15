class V1::Forms::TestsController < ApplicationController

  def index
    tests = ::Forms::Test.all.page(params[:page])
    render json: tests, with_nested: false, meta: pagination_dict(tests)
  end

  def show
    test = ::Forms::Test.find params[:id]
    render json: test
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
