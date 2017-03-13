json.array! @notifications do |notification|
  json.id notification.id
  json.recipient notification.recipient
  json.actor notification.actor.name
  json.action notification.action
  json.notifiable notification.notifiable_id

end
