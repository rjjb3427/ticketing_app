class UserMailer < ApplicationMailer

  def send_user_confimation_email(user_id)
    @user = User.find_by(id: user_id)

    # Generate a new authentication tocken that will be used as an email
    # confirmation token
    @user.generate_authentication_token!
    @user.save

    mail to: @user.email, subject: 'Confirm your email'
  end

  def send_user_reset_password_email(user_id)
    @user = User.find_by(id: user_id)
    mail to: @user.email, subject: 'Reset password email'
  end

  def ticket_status_change_notification(ticket_id, user_id)
    @user = User.find_by(id: user_id)
    @ticket = Ticket.find_by(id: ticket_id)

    mail to: @user.email, subject: 'Ticket status change notification'
  end
end
