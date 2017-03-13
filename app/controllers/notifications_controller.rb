class NotificationsController < ApplicationController
  before_action :authenticate_user!
  def index
    @notifications = Notification.where(recipient: current_user).unread
  end

  def destroy
    info = eval(request.raw_post)

    project = info[:project]

     @notifications = Notification.where(recipient: current_user, notifiable_id: project)
     @notifications.delete_all

  end

end
