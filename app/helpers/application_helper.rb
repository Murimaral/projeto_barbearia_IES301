module ApplicationHelper
  def admin?(user)
    user&.admin?
  end
end
