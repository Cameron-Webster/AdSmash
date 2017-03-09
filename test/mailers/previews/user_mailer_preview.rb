class UserMailerPreview < ActionMailer::Preview
  def invite
    user = User.first.email
    UserMailer.invite(user)
  end
end
