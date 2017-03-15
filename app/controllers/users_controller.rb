class UsersController < Devise::RegistrationsController

def create
  super
  # find a way to associate user andf projectTeam
  # find this user and destroy it from pending invitations
  @user.save

  @user.avatar

  if  params[:user][:invite_project].present?
      project = Project.find(params[:user][:invite_project].to_i)
      ProjectTeam.create(project: project, user: @user, admin: false )

      TempUser.find_by(email: @user.email).destroy!

  end



end


protected

def update_resource(resource, params)
  resource.update_without_password(params)
end
end
