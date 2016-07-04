# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)

Comment.destroy_all
Topic.destroy_all
Category.destroy_all
User.destroy_all

admin = User.create(email: 'benimir@hotmail.com', password: '12345678', password_confirmation: '12345678', role: 2)
user = User.create(email: 'mail@example.com', password: '12345678', password_confirmation: '12345678', role: 0)
commenter = User.create(email: 'mail1@example.com', password: '12345678', password_confirmation: '12345678', role: 0)

5.times do |i|
	cat = Category.create(name: "Category #{i}", user: admin)

	2.times do |j|
		topic = cat.topics.build(subject: "Subject #{j}", body: "This is topic #{j}", user: user)
		topic.save
		3.times do |k|
			comment = topic.comments.build(content: "This is comment #{k}", user: commenter)
			comment.save
		end
	end
end