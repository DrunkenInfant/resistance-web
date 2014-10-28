# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)

User.create!(email: 'test1@test.com',
             password: 'jagkan',
             password_confirmation: 'jagkan')
User.create!(email: 'test2@test.com',
             password: 'jagkan',
             password_confirmation: 'jagkan')
User.create!(email: 'test3@test.com',
             password: 'jagkan',
             password_confirmation: 'jagkan')
User.create!(email: 'test4@test.com',
             password: 'jagkan',
             password_confirmation: 'jagkan')
User.create!(email: 'test5@test.com',
             password: 'jagkan',
             password_confirmation: 'jagkan')
User.create!(email: 'test6@test.com',
             password: 'jagkan',
             password_confirmation: 'jagkan')
User.create!(email: 'test7@test.com',
             password: 'jagkan',
             password_confirmation: 'jagkan')
User.create!(email: 'test8@test.com',
             password: 'jagkan',
             password_confirmation: 'jagkan')
User.create!(email: 'test9@test.com',
             password: 'jagkan',
             password_confirmation: 'jagkan')
User.create!(email: 'test10@test.com',
             password: 'jagkan',
             password_confirmation: 'jagkan')
User.create!(email: 'test11@test.com',
             password: 'jagkan',
             password_confirmation: 'jagkan')

orig_teams = ["spies", "spies", "resistance", "resistance", "resistance"]
10.times do
  Game.create!() do |g|
    teams = orig_teams.dup
    teams.shuffle!
    g.players = User.limit(5).order('id asc').map do |u|
      Player.create(user: u, game: g, team: teams.pop, name: "Player #{u.id}")
    end
    g.missions = [2,3,2,3,3].map.with_index do |n, i|
      Mission.create(nbr_participants: n, game: g, index: i)
    end
    g.king = g.players.first
  end
end
