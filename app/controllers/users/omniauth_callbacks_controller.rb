# app/controllers/users/omniauth_callbacks_controller.rb

class Users::OmniauthCallbacksController < Devise::OmniauthCallbacksController


  def linkedin
    user = User.find_for_linkedin_oauth(request.env['omniauth.auth'])
    mail = TempUser.find_by(email: user.email)
      if mail
        ProjectTeam.create(user_id: user.id, project_id: mail.project_id)
      end

    if user.persisted?
      sign_in_and_redirect user, event: :authentication
      set_flash_message(:notice, :success, kind: 'Linkedin') if is_navigational_format?
    else
      session['devise.linkedin_data'] = request.env['omniauth.auth']
      redirect_to new_user_registration_url
    end
  end
end
