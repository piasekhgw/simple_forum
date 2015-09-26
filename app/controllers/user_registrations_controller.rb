class UserRegistrationsController < ApplicationController

  def new
    render locals: { user_registration: UserRegistrationForm.build }
  end

  def create
    user_registration_form = UserRegistrationForm.build(user_registration_params).save
    if user_registration_form.success?
      redirect_to root_path
    else
      render :new, locals: { user_registration: user_registration_form }
    end
  end

  private

  def user_registration_params
    params.require(:user_registration).permit(:email, :name, :password, :password_confirmation)
  end
end
