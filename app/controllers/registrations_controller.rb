class RegistrationsController < Devise::RegistrationsController
  skip_before_action :require_no_authentication, only: [:new, :create]

  def new
    super
  end

  def create
    User.create(user_params)

    redirect_to root_path
  end

  private

  def user_params
    params.require(:user).permit!
  end
end
