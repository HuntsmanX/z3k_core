class V1::InitsController < ApplicationController
  before_action :authenticate_v1_user!

  def forms
    render json: {
      mistake_types: serialize(::Forms::Config::MistakeType.all)
    }
  end

  private

  def serialize resource
    ActiveModelSerializers::SerializableResource.new(resource).as_json
  end

end
