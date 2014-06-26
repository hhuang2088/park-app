# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)

user1 = User.create(email: "test@test.com", password: "testeight", parked: true)
user2 = User.create(email: "alpha@test.com", password: "testeight", parked: true)

spot1 = Spot.create(latitude: 37.7822820, longitude: -122.3970830, description: "The Hattery", user_id: 1)
spot2 = Spot.create(latitude: 37.7786, longitude: -122.3892, description: "ATT Park", user_id: 2)