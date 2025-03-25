local Recipe = require "recipe"

local RecipeDatabase = {}

-- (name, level, skill, xp, ingredients, amount (optional))
RecipeDatabase["example_recipe"] = Recipe.new("Example Recipe", 0, "", 0, {
	["example_item"] = 0
}, 0)

-- Smithing, Ingots
RecipeDatabase["ingot_bronze"] = Recipe.new("Smelt Bronze Ingot", 1, "smithing", 0, {
	["ore_copper"] = 3,
	["ore_tin"] = 1
})

RecipeDatabase["ingot_iron"] = Recipe.new("Smelt Iron Ingot", 10, "smithing", 0, {
	["ore_iron"] = 2
})

RecipeDatabase["ingot_steel"] = Recipe.new("Smelt Steel Ingot", 20, "smithing", 0, {
	["ore_iron"] = 1,
	["coal"] = 2
})

RecipeDatabase["ingot_gold"] = Recipe.new("Smelt Gold Ingot", 30, "smithing", 0, {
	["ore_gold"] = 2
})

RecipeDatabase["ingot_blue_steel"] = Recipe.new("Smelt Blue Steel Ingot", 30, "smithing", 0, {
	["ingot_steel"] = 1,
	["lapis"] = 3
})

RecipeDatabase["ingot_red_steel"] = Recipe.new("Smelt Red Steel Ingot", 40, "smithing", 0, {
	["ingot_steel"] = 1,
	["redstone"] = 4
})

RecipeDatabase["ingot_eldrinite"] = Recipe.new("Smelt Eldrinite Ingot", 50, "smithing", 0, {
	["ore_eldrinite"] = 5
})

RecipeDatabase["ingot_verdantite"] = Recipe.new("Smelt Verdantite Ingot", 60, "smithing", 0, {
	["ore_eldrinite"] = 3,
	["emerald"] = 4
})

RecipeDatabase["ingot_celestium_inert"] = Recipe.new("Smelt Inert Celestium Ingot", 70, "smithing", 0, {
	["ore_eldrinite"] = 3,
	["diamond"] = 4
})

-- Smithing, Weapons, Bronze
-- Smithing, Armor, Bronze
-- Smithing, Weapons, Iron
-- Smithing, Armor, Iron
-- Smithing, Weapons, Steel
-- Smithing, Armor, Steel
-- Smithing, Weapons, Blue Steel
-- Smithing, Armor, Blue Steel
-- Smithing, Weapons, Red Steel
-- Smithing, Armor, Red Steel
-- Smithing, Weapons, Eldrinite
-- Smithing, Armor, Eldrinite
-- Smithing, Weapons, Verdantite
-- Smithing, Armor, Verdantite
-- Smithing, Weapons, Celestium
-- Smithing, Armor, Celestium

return RecipeDatabase