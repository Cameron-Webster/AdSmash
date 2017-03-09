class UserMailer < ApplicationMailer

  # Subject can be set in your I18n file at config/locales/en.yml
  # with the following lookup:
  #
  #   en.user_mailer.invite.subject
  #
  def invite(user, project_id)
     @email = user  # Instance variable => available in view

     @url = "http://localhost:3000/users/sign_up?project=#{project_id}"

    mail(to: @email, subject: 'Invitation to Adsmash')
  end
end
