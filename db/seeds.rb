# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)

User.create!(email: 'test1@test.com', password: 'jagkan', password_confirmation: 'jagkan')
User.create!(email: 'test2@test.com', password: 'jagkan', password_confirmation: 'jagkan')
User.create!(email: 'test3@test.com', password: 'jagkan', password_confirmation: 'jagkan')
User.create!(email: 'test4@test.com', password: 'jagkan', password_confirmation: 'jagkan')
User.create!(email: 'test5@test.com', password: 'jagkan', password_confirmation: 'jagkan')
User.create!(email: 'test6@test.com', password: 'jagkan', password_confirmation: 'jagkan')
User.create!(email: 'test7@test.com', password: 'jagkan', password_confirmation: 'jagkan')
User.create!(email: 'test8@test.com', password: 'jagkan', password_confirmation: 'jagkan')
User.create!(email: 'test9@test.com', password: 'jagkan', password_confirmation: 'jagkan')
User.create!(email: 'test10@test.com', password: 'jagkan', password_confirmation: 'jagkan')
User.create!(email: 'test11@test.com', password: 'jagkan', password_confirmation: 'jagkan')

Game.create!() do |g|
  g.players = User.limit(5).order('id asc').map { |u| Player.create(user: u, game: g, team: "spies")}
  g.missions = [2,3,2,3,3].map { |n| Mission.create(nbr_participants: n, game: g) }
end
Game.create!() do |g|
  g.players = User.limit(6).offset(1).order('id asc').map { |u| Player.create(user: u, game: g, team: "spies")}
  g.missions = [2,3,2,3,3].map { |n| Mission.create(nbr_participants: n, game: g) }
end
Game.create!() do |g|
  g.players = User.limit(7).offset(2).order('id asc').map { |u| Player.create(user: u, game: g, team: "spies")}
  g.missions = [2,3,2,3,3].map { |n| Mission.create(nbr_participants: n, game: g) }
end
Game.create!() do |g|
  g.players = User.limit(5).offset(5).order('id asc').map { |u| Player.create(user: u, game: g, team: "spies")}
  g.missions = [2,3,2,3,3].map { |n| Mission.create(nbr_participants: n, game: g) }
end
Game.create!() do |g|
  g.players = User.limit(11).order('id asc').map { |u| Player.create(user: u, game: g, team: "spies")}
  g.missions = [2,3,2,3,3].map { |n| Mission.create(nbr_participants: n, game: g) }
end
