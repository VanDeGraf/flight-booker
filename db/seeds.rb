# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the bin/rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)


Airport.create(name:"Hartsfield-Jackson Atlanta",code:"ATL",timezone:-5)
Airport.create(name:"Beijing Capital",code:"PEK",timezone:+8)
Airport.create(name:"Narita Japan",code:"NRT",timezone:+9)
Airport.create(name:"Sheremetyevo Moscow",code:"SVO",timezone:+3)
Airport.create(name:"Toronto Pearson",code:"YYZ",timezone:-5)