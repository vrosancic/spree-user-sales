ApplicationController.class_eval do
  before_filter :set_current_user

  def set_current_user
    User.current = current_user
  end
end
