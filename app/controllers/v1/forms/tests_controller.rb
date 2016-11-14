class V1::Forms::TestsController < ApplicationController

  def index
    @tests = ::Forms::Test.all
    render json: @tests, with_nested: false
  end

  def show
    @test = ::Forms::Test.find params[:id]
    render json: @test
  end

end
