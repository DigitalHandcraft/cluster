# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)

Category.create([{name: "プログラミング", description: "IT全般"}, {name: "料理", description: "料理いろいろ"}])
Interest.create([{name: "Java", description: "Java全般", category_id: 1}, {name: "お菓子作り", description: "お菓子作り全般", category_id: 2}, {name: "Ruby", description: "Ruby言語やRailsについて", category_id: 1}])
Channel.create([{name: "Androidアプリ開発", interest_id: 1, user_id: 1}, {name: "洋菓子", interest_id: 2, user_id: 1}, {name: "和菓子", interest_id: 2, user_id: 1}, {name: "Rails", interest_id: 3, user_id: 1}])

