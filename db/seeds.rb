# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the bin/rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: "Star Wars" }, { name: "Lord of the Rings" }])
#   Character.create(name: "Luke", movie: movies.first)
    users = User.create([{name: "Jimmy", password: "hola", email: "ex@example.ex"},{name: "Jhoe", password: "hola", email: "ex@ex.ex"},{name: "Roberto", password: "hola", email: "robert@example.ex"}])
    games = Game.create([{},{}])
    game1 = Game.first.user_ids=[1,2]
    game2 = Game.second.user_ids=[3]