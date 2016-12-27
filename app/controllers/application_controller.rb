class ApplicationController < ActionController::API
  include DeviseTokenAuth::Concerns::SetUserByToken
  include Pundit

  alias_method :current_user, :current_v1_user

  rescue_from Pundit::NotAuthorizedError, with: :user_not_authorized

  respond_to :json

  private

  def pagination_dict object
    {
      current_page: object.current_page,
      total_pages:  object.total_pages,
      total_items:  object.total_count
    }
  end

  def user_not_authorized
    render json: {}, status: 403
  end

end
