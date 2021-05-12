# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the bin/rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)
truck = FactoryBot.create(:truck)
FactoryBot.create(:ice_cream, truck: truck,
                              flavor: FactoryBot.create(:flavor, name: 'Chocolate', truck: truck), price: 100, sold: 0, remaining: 10, revenue: 0)
FactoryBot.create(:ice_cream, truck: truck,
                              flavor: FactoryBot.create(:flavor, name: 'Pistachio', truck: truck), price: 110, sold: 0, remaining: 11, revenue: 0)
FactoryBot.create(:ice_cream, truck: truck,
                              flavor: FactoryBot.create(:flavor, name: 'Strawberry', truck: truck), price: 120, sold: 0, remaining: 12, revenue: 0)
FactoryBot.create(:ice_cream, truck: truck,
                              flavor: FactoryBot.create(:flavor, name: 'Mint', truck: truck), price: 130, sold: 0, remaining: 13, revenue: 0)
FactoryBot.create(:shaved_ice, truck: truck, price: 200, sold: 0, remaining: 20, revenue: 0)
FactoryBot.create(:snack_bar, truck: truck, price: 300, sold: 0, remaining: 30, revenue: 0)
