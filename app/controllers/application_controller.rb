class ApplicationController < ActionController::API
  include Knock::Authenticable
  undef_method :current_user

  private

  def pagination_dict object
    {
      current_page: object.current_page,
      next_page:    object.next_page,
      prev_page:    object.prev_page,
      total_pages:  object.total_pages,
      total_count:  object.total_count
    }
  end

end
