class V1::Forms::TestsController < ApplicationController

  def index
    tests = ::Forms::Test.all.page(params[:page])
    render json: tests, with_nested: false, meta: pagination_dict(tests)
  end

  def show
    @test = ::Forms::Test.find params[:id]
    render json: @test
  end

end
