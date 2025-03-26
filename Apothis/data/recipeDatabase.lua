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

RecipeDatabase["ingot_verdantite_inert"] = Recipe.new("Smelt Inert Verdantite Ingot", 60, "smithing", 0, {
	["ore_eldrinite"] = 3,
	["emerald"] = 4
})

RecipeDatabase["ingot_celestium_inert"] = Recipe.new("Smelt Inert Celestium Ingot", 70, "smithing", 0, {
	["ore_eldrinite"] = 3,
	["diamond"] = 4
})
-------------------------------------------------------

-- Smithing, Weapons, Bronze
RecipeDatabase["dagger_bronze"] = Recipe.new("Smith Bronze Dagger", 1, "smithing", 0, {
	["ingot_bronze"] = 1
})

RecipeDatabase["shortsword_bronze"] = Recipe.new("Smith Bronze Shortsword", 2, "smithing", 0, {
	["ingot_bronze"] = 1
})

RecipeDatabase["scimitar_bronze"] = Recipe.new("Smith Bronze Scimitar", 4, "smithing", 0, {
	["ingot_bronze"] = 2
})

RecipeDatabase["mace_bronze"] = Recipe.new("Smith Bronze Mace", 5, "smithing", 0, {
	["ingot_bronze"] = 1
})

RecipeDatabase["warhammer_bronze"] = Recipe.new("Smith Bronze Warhammer", 6, "smithing", 0, {
	["ingot_bronze"] = 3
})

RecipeDatabase["rapier_bronze"] = Recipe.new("Smith Bronze Rapier", 6, "smithing", 0, {
	["ingot_bronze"] = 1
})

RecipeDatabase["battleaxe_bronze"] = Recipe.new("Smith Bronze Battleaxe", 8, "smithing", 0, {
	["ingot_bronze"] = 3
})

RecipeDatabase["longsword_bronze"] = Recipe.new("Smith Bronze Longsword", 8, "smithing", 0, {
	["ingot_bronze"] = 2
})

RecipeDatabase["greatsword_bronze"] = Recipe.new("Smith Bronze Greatsword", 9, "smithing", 0, {
	["ingot_bronze"] = 4
})

RecipeDatabase["maul_bronze"] = Recipe.new("Smith Bronze Maul", 9, "smithing", 0, {
	["ingot_bronze"] = 4
})
----------------------------------------------------------------------------------

-- Smithing, Armor, Bronze
RecipeDatabase["helmet_bronze"] = Recipe.new("Smith Bronze Helmet", 2, "smithing", 0, {
	["ingot_bronze"] = 1
})

RecipeDatabase["chainbody_bronze"] = Recipe.new("Smith Bronze Chainbody", 2, "smithing", 0, {
	["ingot_bronze"] = 3
})

RecipeDatabase["r_chausses_bronze"] = Recipe.new("Smith Bronze Reinforced Chausses", 2, "smithing", 0, {
	["ingot_bronze"] = 2
})

RecipeDatabase["r_gloves_bronze"] = Recipe.new("Smith Bronze Reinforced Gloves", 2, "smithing", 0, {
	["ingot_bronze"] = 1
})

RecipeDatabase["r_boots_bronze"] = Recipe.new("Smith Bronze Reinforced Boots", 2, "smithing", 0, {
	["ingot_bronze"] = 1
})

RecipeDatabase["plate_helmet_bronze"] = Recipe.new("Smith Bronze Plate Helm", 5, "smithing", 0, {
	["ingot_bronze"] = 2
})

RecipeDatabase["chestplate_bronze"] = Recipe.new("Smith Bronze Chestplate", 5, "smithing", 0, {
	["ingot_bronze"] = 6
})

RecipeDatabase["p_chausses_bronze"] = Recipe.new("Smith Bronze Plate Chausses", 5, "smithing", 0, {
	["ingot_bronze"] = 4
})

RecipeDatabase["gauntlets_bronze"] = Recipe.new("Smith Bronze Gauntlets", 5, "smithing", 0, {
	["ingot_bronze"] = 2
})

RecipeDatabase["p_greaves_bronze"] = Recipe.new("Smith Bronze Plate Greaves", 5, "smithing", 0, {
	["ingot_bronze"] = 2
})
------------------------------------------------------------------------------------

-- Smithing, Weapons, Iron
RecipeDatabase[""] = Recipe.new("", 0, "smithing", 0, {
	[""] = 0
})

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

-- Thaumaturgy, Pale/Oak Weapons
RecipeDatabase["wand_pale"] = Recipe.new("Embue Pale Wand", 1, "thaumaturgy", 0, {
	["inert_wand_oak"] = 1,
	["pale_energy"] = 20
})

RecipeDatabase["core_pale"] = Recipe.new("Embue Pale Core", 1, "thaumaturgy", 0, {
	["inert_core_oak"] = 1,
	["pale_energy"] = 20
})

RecipeDatabase["staff_pale"] = Recipe.new("Embue Pale Staff", 1, "thaumaturgy", 0, {
	["inert_staff_oak"] = 1,
	["pale_energy"] = 40
})
--------------------------------

-- Thaumaturgy, Flickering/Birch Weapons
RecipeDatabase["wand_flickering"] = Recipe.new("Embue Flickering Wand", 10, "thaumaturgy", 0, {
	["inert_wand_birch"] = 1,
	["flickering_energy"] = 25
})

RecipeDatabase["core_flickering"] = Recipe.new("Embue Flickering Core", 10, "thaumaturgy", 0, {
	["inert_core_birch"] = 1,
	["flickering_energy"] = 25
})

RecipeDatabase["staff_flickering"] = Recipe.new("Embue Flickering Staff", 10, "thaumaturgy", 0, {
	["inert_staff_birch"] = 1,
	["flickering_energy"] = 50
})
-------------------------------------

-- Thaumaturgy, Bright/Spruce Weapons
RecipeDatabase["wand_bright"] = Recipe.new("Embue Bright Wand", 20, "thaumaturgy", 0, {
	["inert_wand_spruce"] = 1,
	["bright_energy"] = 30
})

RecipeDatabase["core_bright"] = Recipe.new("Embue Bright Core", 20, "thaumaturgy", 0, {
	["inert_core_spruce"] = 1,
	["bright_energy"] = 30
})

RecipeDatabase["staff_bright"] = Recipe.new("Embue Bright Staff", 20, "thaumaturgy", 0, {
	["inert_staff_spruce"] = 1,
	["bright_energy"] = 60
})
------------------------------------

-- Thaumaturgy, Glowing/Jungle Weapons
RecipeDatabase["wand_glowing"] = Recipe.new("Embue Glowing Wand", 30, "thaumaturgy", 0, {
	["inert_wand_jungle"] = 1,
	["glowing_energy"] = 35
})

RecipeDatabase["core_glowing"] = Recipe.new("Embue Glowing Core", 30, "thaumaturgy", 0, {
	["inert_core_jungle"] = 1,
	["glowing_energy"] = 35
})

RecipeDatabase["staff_glowing"] = Recipe.new("Embue Glowing Staff", 30, "thaumaturgy", 0, {
	["inert_staff_jungle"] = 1,
	["glowing_energy"] = 70
})
--------------------------------

-- Thaumaturgy, Sparkling/Acacia Weapons
RecipeDatabase["wand_sparkling"] = Recipe.new("Embue Sparkiling Wand", 40, "thaumaturgy", 0, {
	["inert_wand_acacia"] = 1,
	["sparkling_energy"] = 40
})
RecipeDatabase["core_sparkling"] = Recipe.new("Embue Sparkling Core", 40, "thaumaturgy", 0, {
	["inert_core_acacia"] = 1,
	["sparkling_energy"] = 40
})
RecipeDatabase["staff_sparkling"] = Recipe.new("Embue Sparkling Staff", 40, "thaumaturgy", 0, {
	["inert_staff_acacia"] = 1,
	["sparkling_energy"] = 80
})
--------------------------------

-- Thaumaturgy, Gleaming/Dark Oak Weapons
RecipeDatabase["wand_gleaming"] = Recipe.new("Embue Gleaming Wand", 50, "thaumaturgy", 0, {
	["inert_wand_dark_oak"] = 1,
	["gleaming_energy"] = 45
})
RecipeDatabase["core_gleaming"] = Recipe.new("Embue Gleaming Core", 50, "thaumaturgy", 0, {
	["inert_core_dark_oak"] = 1,
	["gleaming_energy"] = 45
})
RecipeDatabase["staff_gleaming"] = Recipe.new("Embue Gleaming Staff", 50, "thaumaturgy", 0, {
	["inert_staff_dark_oak"] = 1,
	["gleaming_energy"] = 90
})
----------------------------------

-- Thaumaturgy, Vibrant/Mangrove Weapons
RecipeDatabase["wand_vibrant"] = Recipe.new("Embue Vibrant Wand", 60, "thaumaturgy", 0, {
	["inert_wand_mangrove"] = 1,
	["vibrant_energy"] = 50
})
RecipeDatabase["core_vibrant"] = Recipe.new("Embue Vibrant Core", 60, "thaumaturgy", 0, {
	["inert_core_mangrove"] = 1,
	["vibrant_energy"] = 50
})
RecipeDatabase["staff_vibrant"] = Recipe.new("Embue Vibrant Staff", 60, "thaumaturgy", 0, {
	["inert_staff_mangrove"] = 1,
	["vibrant_energy"] = 100
})
----------------------------------

-- Thaumaturgy, Lustrous/Crimson Stem Weapons
RecipeDatabase["wand_lustrous"] = Recipe.new("Embue Lustrous Wand", 70, "thaumaturgy", 0, {
	["inert_wand_crimson"] = 1,
	["lustrous_energy"] = 55
})
RecipeDatabase["core_lustrous"] = Recipe.new("Embue Lustrous Core", 70, "thaumaturgy", 0, {
	["inert_core_crimson"] = 1,
	["lustrous_energy"] = 55
})
RecipeDatabase["staff_lustrous"] = Recipe.new("Embue Lustrous Staff", 70, "thaumaturgy", 0, {
	["inert_staff_crimson"] = 1,
	["lustrous_energy"] = 110
})
--------------------------------------

-- Thaumaturgy, Brilliant/Warped Steam Weapons
RecipeDatabase["wand_brilliant"] = Recipe.new("Embue Brilliant Wand", 80, "thaumaturgy", 0, {
	["inert_wand_warped"] = 1,
	["brilliant_energy"] = 60
})
RecipeDatabase["core_brilliant"] = Recipe.new("Embue Brilliant Core", 80, "thaumaturgy", 0, {
	["inert_core_warped"] = 1,
	["brilliant_energy"] = 60
})
RecipeDatabase["staff_brilliant"] = Recipe.new("Embue Brilliant Staff", 80, "thaumaturgy", 0, {
	["inert_staff_warped"] = 1,
	["brilliant_energy"] = 120
})
--------------------------------------

-- Thaumaturgy, Ingots
RecipeDatabase["ingot_verdantite"] = Recipe.new("Embue Verdantite Ingot", 60, "thaumaturgy", 0, {
	["ingot_verdantite_inert"] = 1,
	["vibrant_energy"] = 100
})

RecipeDatabase["ingot_celestium"] = Recipe.new("Embue Celestium Ingot", 70, "thaumaturgy", 0, {
	["ingot_celestium_inert"] = 1,
	["lustrous_energy"] = 100
})
----------------------

-- Fletching, Other
-- TODO: Figure out how to handle creating arrowshafts from the other woods
RecipeDatabase["arrowshaft"] = {
	[0] = Recipe.new("Carve Arrow Shafts x5", 1, "fletching", 3, { ["wood_oak"] = 1 }, 5),
	[1] = Recipe.new("Carve Arrow Shafts x10", 10, "fletching", 9, { ["wood_birch"] = 1 }, 10),
	[2] = Recipe.new("Carve Arrow Shafts x15", 20, "fletching", 17, { ["wood_spruce"] = 1 }, 15),
	[3] = Recipe.new("Carve Arrow Shafts x20", 30, "fletching", 0, { ["wood_jungle"] = 1 }, 20)
}




-------------------

-- Fletching, Wood to Inert Magical Weapons
RecipeDatabase["inert_wand_oak"] = Recipe.new("Carve Inert Oak Wand", 1, "fletching", 0, {
	["wood_oak"] = 1
})

RecipeDatabase["inert_core_oak"] = Recipe.new("Carve Inert Oak Core", 1, "fletching", 0, {
	["wood_oak"] = 1
})

RecipeDatabase["inert_staff_oak"] = Recipe.new("Carve Inert Oak Staff", 1, "fletching", 0, {
	["wood_oak"] = 3
})

RecipeDatabase["inert_wand_birch"] = Recipe.new("Carve Inert Birch Wand", 10, "fletching", 0, {
	["wood_birch"] = 1
})

RecipeDatabase["inert_core_birch"] = Recipe.new("Carve Inert Birch Core", 10, "fletching", 0, {
	["wood_birch"] = 1
})

RecipeDatabase["inert_staff_birch"] = Recipe.new("Carve Inert Birch Staff", 10, "fletching", 0, {
	["wood_birch"] = 3
})

RecipeDatabase["inert_wand_spruce"] = Recipe.new("Carve Inert Spruce Wand", 20, "fletching", 0, {
	["wood_spruce"] = 1
})

RecipeDatabase["inert_core_spruce"] = Recipe.new("Carve Inert Spruce Core", 20, "fletching", 0, {
	["wood_spruce"] = 1
})

RecipeDatabase["inert_staff_spruce"] = Recipe.new("Carve Inert Spruce Staff", 20, "fletching", 0, {
	["wood_spruce"] = 3
})

RecipeDatabase["inert_wand_jungle"] = Recipe.new("Carve Inert Jungle Wand", 30, "fletching", 0, {
	["wood_jungle"] = 1
})

RecipeDatabase["inert_core_jungle"] = Recipe.new("Carve Inert Jungle Core", 30, "fletching", 0, {
	["wood_jungle"] = 1
})

RecipeDatabase["inert_staff_jungle"] = Recipe.new("Carve Inert Jungle Staff", 30, "fletching", 0, {
	["wood_jungle"] = 3
})

RecipeDatabase["inert_wand_acacia"] = Recipe.new("Carve Inert Acacia Wand", 40, "fletching", 0, {
	["wood_acacia"] = 1
})

RecipeDatabase["inert_core_acacia"] = Recipe.new("Carve Inert Acacia Core", 40, "fletching", 0, {
	["wood_acacia"] = 1
})

RecipeDatabase["inert_staff_acacia"] = Recipe.new("Carve Inert Acacia Staff", 40, "fletching", 0, {
	["wood_acacia"] = 3
})

-------------------------------------------


return RecipeDatabase