# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)


require 'faker'
User.destroy_all
Project.destroy_all
ProjectTeam.destroy_all

5.times do

x = User.create(name: Faker::Name.first_name, last_name: Faker::Name.last_name, company: "faker company", password: "123456", email: Faker::Internet.email)
z = User.create(name: Faker::Name.first_name, last_name: Faker::Name.last_name, company: "faker company", password: "123456", email: Faker::Internet.email)

  3.times do
    v = Project.create(name: Faker::Beer.name, status: Project::STATUSES.sample , brand: Project::BRANDS.sample , deadline:(1.month.ago.to_date..2.month.from_now).to_a.sample   , brief: Faker::Lorem.paragraph(2))
    ProjectTeam.create(user_id: x.id, project_id: v.id, admin: true)
    ProjectTeam.create(user_id: z.id, project_id: v.id, admin: true)
  end
end

# def seed_image(file_name)
#   File.open(File.join(Rails.root, "/app/assets/images/#{file_name}"))
# end
