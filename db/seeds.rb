# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)

Admin.delete_all
Admin.create email: 'admin@instagrammer.com', password: 'testtest', password_confirmation: 'testtest'

Order.create post: Post.last, user_id:3