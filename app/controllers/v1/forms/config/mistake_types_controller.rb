class V1::Forms::Config::MistakeTypesController < ApplicationController

  def index
    types = ::Forms::Config::MistakeType.all.page(params[:page]).per(params[:per])
    render json: types, meta: pagination_dict(types)
  end

  def show
    type = ::Forms::Config::MistakeType.find params[:id]
    render json: type
  end

  def update
    type = ::Forms::Config::MistakeType.find params[:id]

    if type.update_attributes(mistake_type_params)
      render json: type
    else
      render json: type.errors.messages, status: 422
    end

  end

  def create
    type = ::Forms::Config::MistakeType.new mistake_type_params
    if type.save
      render json: type
    else
      render json: type.errors.messages, status: 422
    end
  end

  def destroy
    type = ::Forms::Config::MistakeType.find params[:id]
    type.destroy
    render json: {}
  end

  private

  def mistake_type_params
    params.require(:mistake_type).permit(:name, :color, :penalty)
  end

end
