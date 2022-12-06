# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the bin/rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: "Star Wars" }, { name: "Lord of the Rings" }])
#   Character.create(name: "Luke", movie: movies.first)
20.times do |i|
	Product.create(
		title: "Product Nr #{i}",
		description: "Product description Nr #{i}",
		price: rand(1..10)
		);

	puts "Creating Product #{i+1}"
end