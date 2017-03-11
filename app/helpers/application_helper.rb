module ApplicationHelper

  def destroy_notifications(project)



   current_user.notifications.where('notifiable_id = ?', project).destroy_all

  end
end
