module ApplicationHelper

  def destroy_notifications



   notifics = current_user.notifications.where('notifiable_id = ?', project)

  end
end
