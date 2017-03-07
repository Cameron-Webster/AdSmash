# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)

x = User.create(name: "john", last_name: "gary", company: "faker company", password: "123456", email: "john@john.com")
User.create(name: "pete", last_name: "james", company: "faker company", password: "123456", email: "gary@john.com")
User.create(name: "malcom", last_name: "lawrence", company: "faker company", password: "123456", email: "je@john.com")

v = Project.create(name: "Coke", campaign_start: "2017-06-07", deadline: "2017-05-06", status: "live", brief: "some text")
ProjectTeam.create(user_id: x.id, project_id: v.id, admin: true)


