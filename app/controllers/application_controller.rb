class ApplicationController < ActionController::API
  include Knock::Authenticable
  undef_method :current_user

  private

  def pagination_dict object
    {
      current_page: object.current_page,
      total_pages:  object.total_pages,
      total_items:  object.total_count
    }
  end

end
