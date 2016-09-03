class UserMailer < ApplicationMailer

  def send_user_confimation_email(user_id)
    @user = User.find_by(id: user_id)

    # Generate a new authentication tocken that will be used as an email
    # confirmation token
    @user.generate_authentication_token!
    @user.save

    mail to: @user.email, subject: 'Confirm your email'
  end
end