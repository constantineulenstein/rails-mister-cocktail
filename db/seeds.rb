# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)
require 'open-uri'
Dose.destroy_all
Ingredient.destroy_all
Cocktail.destroy_all


url = "https://www.thecocktaildb.com/api/json/v1/1/list.php?i=list"
ingredients_serialized = open(url).read
ingredients = JSON.parse(ingredients_serialized)

ingredients["drinks"].each do |ingredient|
  Ingredient.create(name: ingredient["strIngredient1"])
end


20.times do
  url_random = "https://www.thecocktaildb.com/api/json/v1/1/random.php"
  cocktail_random_serialized = open(url_random).read
  random_cocktail = JSON.parse(cocktail_random_serialized)["drinks"][0]

  cocktail = Cocktail.find_or_create_by!(name: random_cocktail["strDrink"], description: random_cocktail["strInstructions"])
  cocktail.remote_photo_url = random_cocktail["strDrinkThumb"]
  cocktail.save
  i = 1
  while random_cocktail["strIngredient#{i}"] != nil
    ingredient = Ingredient.find_or_create_by!(name: random_cocktail["strIngredient#{i}"])
    description = random_cocktail["strMeasure#{i}"].nil? ? "Add" : random_cocktail["strMeasure#{i}"]
    dose = Dose.create(description: description, cocktail_id: cocktail.id, ingredient_id: ingredient.id)
    i += 1
  end
end
