class ApplicationController < ActionController::API
  include DeviseTokenAuth::Concerns::SetUserByToken
  include Pundit

  rescue_from Pundit::NotAuthorizedError, with: :user_not_authorized

  private

  def pagination_dict object
    {
      current_page: object.current_page,
      total_pages:  object.total_pages,
      total_items:  object.total_count
    }
  end

  def user_not_authorized
    render json: {unauthorized: 'You are not authorized to perform this action.'}
  end

end
