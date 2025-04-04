local Equipment = require "equipment"

local ItemDatabase = {}

-- Bronze (Copper + Tin)
-- Iron
-- Steel (Iron + Coal)
-- Blue Steel (Steel + Lapis)
-- Red Steel (Steel + Redstone)
-- Eldrinite (Ancient Debris)
-- Verdantite (Ancient Debris + Emerald)
-- Celestium (Ancient Debris + Diamond)

-- Example Weapon
ItemDatabase["example_weapon_dual_wielding"] = Equipment.new("Example Weapon", "EitherHand", {
	level = 1,
	description = "This is a developer item, how do you have this?",
	attackType = "Melee", -- Magic, or Ranged

	modifiers = {
		accuracy = { Stab = 0, Slash = 0, Crush = 0, Magic = 0, Ranged = 0 },
        defense = { Stab = 0, Slash = 0, Crush = 0, Magic = 0, Ranged = 0 },
		bonus = { Melee = 0, Magic = 0, Ranged = 0 },
		attackSpeed = 0,
		criticalChance = 0,
		weight = 0
    }
})

-- Example Armor Piece
ItemDatabase["example_armor_piece"] = Equipment.new("Example Armor", "Head", {
	level = 1,
	description = "This is a developer item, how do you have this?",

	modifiers = {
        accuracy = { Stab = 0, Slash = 0, Crush = 0, Magic = 0, Ranged = 0 },
		defense = { Stab = 0, Slash = 0, Crush = 0, Magic = 0, Ranged = 0 },
		bonus = { Melee = 0, Magic = 0, Ranged = 0 },
		attackSpeed = 0,
		criticalChance = 0,
		weight = 0
    }
})

-- Bronze Weapons
ItemDatabase["dagger_bronze"] = Equipment.new("Bronze Dagger", "EitherHand", {
	level = 1,
	description = "",
	attackType = "Melee",

	modifiers = {
		accuracy = { Stab = 4, Slash = 2, Crush = -4, Magic = 1, Ranged = 0 },
        defense = { Stab = 0, Slash = 0, Crush = 0, Magic = 1, Ranged = 0 },
		bonus = { Melee = 3, Magic = 0, Ranged = 0 },
		attackSpeed = 0, -- "Fast"
		criticalChance = 0,
		weight = 0
    }
})
ItemDatabase["shortsword_bronze"] = Equipment.new("Bronze Shortsword", "EitherHand", {
	level = 1,
	description = "",
	attackType = "Melee",

	modifiers = {
        accuracy = { Stab = 4, Slash = 3, Crush = -2, Magic = 0, Ranged = 0 },
        defense = { Stab = 0, Slash = 2, Crush = 1, Magic = 0, Ranged = 0 },
		bonus = { Melee = 5, Magic = 0, Ranged = 0 },
		attackSpeed = 0, -- "Medium"
		criticalChance = 0,
		weight = 0
    }
})
ItemDatabase["scimitar_bronze"] = Equipment.new("Bronze Scimitar", "MainHand", {
	level = 1,
	description = "",
	attackType = "Melee",

	modifiers = {
		accuracy = { Stab = 1, Slash = 7, Crush = -2, Magic = 0, Ranged = 0 },
        defense = { Stab = 0, Slash = 1, Crush = 0, Magic = 0, Ranged = 0 },
		bonus = { Melee = 6, Magic = 0, Ranged = 0 },
		attackSpeed = 0, -- "Fast"
		criticalChance = 0,
		weight = 0
    }
})
ItemDatabase["mace_bronze"] = Equipment.new("Bronze Mace", "MainHand", {
	level = 1,
	description = "",
	attackType = "Melee",

	modifiers = {
		accuracy = { Stab = 1, Slash = -2, Crush = 6, Magic = 0, Ranged = 0 },
        defense = { Stab = 0, Slash = 0, Crush = 0, Magic = 0, Ranged = 0 },
		bonus = { Melee = 5, Magic = 0, Ranged = 0 },
		attackSpeed = 0, -- "Medium"
		criticalChance = 0,
		weight = 0
    }
})
ItemDatabase["warhammer_bronze"] = Equipment.new("Bronze Warhammer", "MainHand", {
	level = 1,
	description = "",
	attackType = "Melee",

	modifiers = {
		accuracy = { Stab = -4, Slash = -4, Crush = 10, Magic = -4, Ranged = 0 },
        defense = { Stab = 0, Slash = 0, Crush = 0, Magic = 0, Ranged = 0 },
		bonus = { Melee = 8, Magic = 0, Ranged = 0 },
		attackSpeed = 0, -- "Slow"
		criticalChance = 0,
		weight = 0
    }
})
ItemDatabase["rapier_bronze"] = Equipment.new("Bronze Rapier", "MainHand", {
	level = 1,
	description = "",
	attackType = "Melee",

	modifiers = {
		accuracy = { Stab = 5, Slash = 3, Crush = 0, Magic = 0, Ranged = 0 },
        defense = { Stab = -1, Slash = -1, Crush = -1, Magic = 0, Ranged = -1 },
		bonus = { Melee = 6, Magic = 0, Ranged = 0 },
		attackSpeed = 0, -- "Fast"
		criticalChance = 0,
		weight = 0
    }
})
ItemDatabase["battleaxe_bronze"] = Equipment.new("Bronze Battleaxe", "MainHand", {
	level = 1,
	description = "",
	attackType = "Melee",

	modifiers = {
		accuracy = { Stab = -2, Slash = 6, Crush = 3, Magic = 0, Ranged = 0 },
        defense = { Stab = 0, Slash = 0, Crush = 0, Magic = 0, Ranged = -1 },
		bonus = { Melee = 9, Magic = 0, Ranged = 0 },
		attackSpeed = 0, -- "Slow"
		criticalChance = 0,
		weight = 0
    }
})
ItemDatabase["longsword_bronze"] = Equipment.new("Bronze Longsword", "MainHand", {
	level = 1,
	description = "",
	attackType = "Melee",

	modifiers = {
		accuracy = { Stab = 4, Slash = 5, Crush = -2, Magic = 0, Ranged = 0 },
        defense = { Stab = 0, Slash = 3, Crush = 2, Magic = 0, Ranged = 0 },
		bonus = { Melee = 7, Magic = 0, Ranged = 0 },
		attackSpeed = 0, -- "Medium"
		criticalChance = 0,
		weight = 0
    }
})
ItemDatabase["greatsword_bronze"] = Equipment.new("Bronze Greatsword", "Two-Handed", {
	level = 1,
	description = "",
	attackType = "Melee",

	modifiers = {
		accuracy = { Stab = 8, Slash = 9, Crush = -4, Magic = -4, Ranged = 0 },
        defense = { Stab = 0, Slash = 0, Crush = 0, Magic = 0, Ranged = -1 },
		bonus = { Melee = 10, Magic = 0, Ranged = 0 },
		attackSpeed = 0, -- "Slow"
		criticalChance = 0,
		weight = 0
    }
})
ItemDatabase["maul_bronze"] = Equipment.new("Bronze Maul", "Two-Handed", {
	level = 1,
	description = "",
	attackType = "Melee",

	modifiers = {
		accuracy = { Stab = -4, Slash = -4, Crush = 14, Magic = 0, Ranged = 0 },
        defense = { Stab = 0, Slash = 0, Crush = 0, Magic = 0, Ranged = 0 },
		bonus = { Melee = 12, Magic = 0, Ranged = 0 },
		attackSpeed = 0, -- "Slow"
		criticalChance = 0,
		weight = 0
    }
})
ItemDatabase["claws_bronze"] = Equipment.new("Bronze Claws", "Two-Handed", {
	level = 1,
	description = "",
	attackType = "Melee",

	modifiers = {
		accuracy = { Stab = 3, Slash = 4, Crush = -4, Magic = 0, Ranged = 0 },
        defense = { Stab = 1, Slash = 2, Crush = 1, Magic = 0, Ranged = 0 },
		bonus = { Melee = 5, Magic = 0, Ranged = 0 },
		attackSpeed = 0, -- "Fast"
		criticalChance = 0,
		weight = 0
    }
})

-- Bronze Armor
ItemDatabase["helmet_bronze"] = Equipment.new("Bronze Helmet", "Head", {
	level = 1,
	description = "",

	modifiers = {
        accuracy = { Stab = 0, Slash = 0, Crush = 0, Magic = -3, Ranged = 0 },
		defense = { Stab = 3, Slash = 4, Crush = 2, Magic = -1, Ranged = 3 },
		bonus = { Melee = 0, Magic = 0, Ranged = 0 },
		attackSpeed = 0,
		criticalChance = 0,
		weight = 0
    }
})
ItemDatabase["chainbody_bronze"] = Equipment.new("Bronze Chainbody", "Chest", {
	level = 1,
	description = "",

	modifiers = {
        accuracy = { Stab = 0, Slash = 0, Crush = 0, Magic = -15, Ranged = 0 },
		defense = { Stab = 7, Slash = 11, Crush = 13, Magic = -3, Ranged = 9 },
		bonus = { Melee = 0, Magic = 0, Ranged = 0 },
		attackSpeed = 0,
		criticalChance = 0,
		weight = 0
    }
})
ItemDatabase["r_chausses_bronze"] = Equipment.new("Bronze Reinforced Chausses", "Legs", {
	level = 1,
	description = "",

	modifiers = {
        accuracy = { Stab = 0, Slash = 0, Crush = 0, Magic = -11, Ranged = -7 },
		defense = { Stab = 4, Slash = 9, Crush = 10, Magic = -2, Ranged = 6 },
		bonus = { Melee = 0, Magic = 0, Ranged = 0 },
		attackSpeed = 0,
		criticalChance = 0,
		weight = 0
    }
})
ItemDatabase["r_gloves_bronze"] = Equipment.new("Bronze Reinforced Gloves", "Hands", {
	level = 1,
	description = "",

	modifiers = {
        accuracy = { Stab = 2, Slash = 2, Crush = 2, Magic = 1, Ranged = 2 },
		defense = { Stab = 2, Slash = 2, Crush = 2, Magic = 1, Ranged = 2 },
		bonus = { Melee = 2, Magic = 0, Ranged = 0 },
		attackSpeed = 0,
		criticalChance = 0,
		weight = 0
    }
})
ItemDatabase["r_boots_bronze"] = Equipment.new("Bronze Reinforced Boots", "Feet", {
	level = 1,
	description = "",

	modifiers = {
        accuracy = { Stab = 0, Slash = 0, Crush = 0, Magic = -3, Ranged = -1 },
		defense = { Stab = 1, Slash = 2, Crush = 3, Magic = 0, Ranged = 0 },
		bonus = { Melee = 0, Magic = 0, Ranged = 0 },
		attackSpeed = 0,
		criticalChance = 0,
		weight = 0
    }
})

ItemDatabase["plate_helmet_bronze"] = Equipment.new("Bronze Plate Helmet", "Head", {
	level = 5,
	description = "",

	modifiers = {
        accuracy = { Stab = 0, Slash = 0, Crush = 0, Magic = -6, Ranged = -3 },
		defense = { Stab = 4, Slash = 5, Crush = 3, Magic = -1, Ranged = 4 },
		bonus = { Melee = 0, Magic = 0, Ranged = 0 },
		attackSpeed = 0,
		criticalChance = 0,
		weight = 0
    }
})
ItemDatabase["chestplate_bronze"] = Equipment.new("Bronze Chestplate", "Chest", {
	level = 5,
	description = "",

	modifiers = {
        accuracy = { Stab = 0, Slash = 0, Crush = 0, Magic = -30, Ranged = -15 },
		defense = { Stab = 15, Slash = 14, Crush = 9, Magic = -6, Ranged = 14 },
		bonus = { Melee = 0, Magic = 0, Ranged = 0 },
		attackSpeed = 0,
		criticalChance = 0,
		weight = 0
    }
})
ItemDatabase["p_chausses_bronze"] = Equipment.new("Bronze Plate Chausses", "Legs", {
	level = 5,
	description = "",

	modifiers = {
        accuracy = { Stab = 0, Slash = 0, Crush = 0, Magic = -21, Ranged = -11 },
		defense = { Stab = 8, Slash = 7, Crush = 6, Magic = -4, Ranged = 7 },
		bonus = { Melee = 0, Magic = 0, Ranged = 0 },
		attackSpeed = 0,
		criticalChance = 0,
		weight = 0
    }
})
ItemDatabase["gauntlets_bronze"] = Equipment.new("Bronze Gauntlets", "Hands", {
	level = 5,
	description = "",

	modifiers = {
        accuracy = { Stab = 2, Slash = 2, Crush = 2, Magic = 1, Ranged = 2 },
		defense = { Stab = 4, Slash = 4, Crush = 4, Magic = 2, Ranged = 4 },
		bonus = { Melee = 3, Magic = 0, Ranged = 0 },
		attackSpeed = 0,
		criticalChance = 0,
		weight = 0
    }
})
ItemDatabase["p_greaves_bronze"] = Equipment.new("Bronze Plate Greaves", "Feet", {
	level = 5,
	description = "",

	modifiers = {
        accuracy = { Stab = 0, Slash = 0, Crush = 0, Magic = -5, Ranged = -2 },
		defense = { Stab = 3, Slash = 4, Crush = 5, Magic = 0, Ranged = 0 },
		bonus = { Melee = 0, Magic = 0, Ranged = 0 },
		attackSpeed = 0,
		criticalChance = 0,
		weight = 0
    }
})

-- Iron Weapons
ItemDatabase["dagger_iron"] = Equipment.new("Iron Dagger", "EitherHand", {
	level = 10,
	description = "",
	attackType = "Melee",

	modifiers = {
		accuracy = { Stab = 10, Slash = 5, Crush = -4, Magic = 1, Ranged = 0 },
        defense = { Stab = 0, Slash = 0, Crush = 0, Magic = 1, Ranged = 0 },
		bonus = { Melee = 7, Magic = 0, Ranged = 0 },
		attackSpeed = 0, -- "Fast"
		criticalChance = 0,
		weight = 0
    }
})
ItemDatabase["shortsword_iron"] = Equipment.new("Iron Shortsword", "EitherHand", {
	level = 10,
	description = "",
	attackType = "Melee",

	modifiers = {
        accuracy = { Stab = 14, Slash = 10, Crush = -2, Magic = 0, Ranged = 0 },
        defense = { Stab = 0, Slash = 2, Crush = 1, Magic = 0, Ranged = 0 },
		bonus = { Melee = 12, Magic = 0, Ranged = 0 },
		attackSpeed = 0, -- "Medium"
		criticalChance = 0,
		weight = 0
    }
})
ItemDatabase["scimitar_iron"] = Equipment.new("Iron Scimitar", "MainHand", {
	level = 10,
	description = "",
	attackType = "Melee",

	modifiers = {
		accuracy = { Stab = 4, Slash = 19, Crush = -2, Magic = 0, Ranged = 0 },
        defense = { Stab = 0, Slash = 1, Crush = 0, Magic = 0, Ranged = 0 },
		bonus = { Melee = 14, Magic = 0, Ranged = 0 },
		attackSpeed = 0, -- "Fast"
		criticalChance = 0,
		weight = 0
    }
})
ItemDatabase["mace_iron"] = Equipment.new("Iron Mace", "MainHand", {
	level = 10,
	description = "",
	attackType = "Melee",

	modifiers = {
		accuracy = { Stab = 8, Slash = -2, Crush = 16, Magic = 0, Ranged = 0 },
        defense = { Stab = 0, Slash = 0, Crush = 0, Magic = 0, Ranged = 0 },
		bonus = { Melee = 13, Magic = 0, Ranged = 0 },
		attackSpeed = 0, -- "Medium"
		criticalChance = 0,
		weight = 0
    }
})
ItemDatabase["warhammer_iron"] = Equipment.new("Iron Warhammer", "MainHand", {
	level = 10,
	description = "",
	attackType = "Melee",

	modifiers = {
		accuracy = { Stab = -4, Slash = -4, Crush = 22, Magic = -4, Ranged = 0 },
        defense = { Stab = 0, Slash = 0, Crush = 0, Magic = 0, Ranged = 0 },
		bonus = { Melee = 22, Magic = 0, Ranged = 0 },
		attackSpeed = 0, -- "Slow"
		criticalChance = 0,
		weight = 0
    }
})
ItemDatabase["rapier_iron"] = Equipment.new("Iron Rapier", "MainHand", {
	level = 10,
	description = "",
	attackType = "Melee",

	modifiers = {
		accuracy = { Stab = 12, Slash = 7, Crush = 0, Magic = 0, Ranged = 0 },
        defense = { Stab = 0, Slash = 0, Crush = 0, Magic = 0, Ranged = 0 },
		bonus = { Melee = 10, Magic = 0, Ranged = 0 },
		attackSpeed = 0, -- "Fast"
		criticalChance = 0,
		weight = 0
    }
})
ItemDatabase["battleaxe_iron"] = Equipment.new("Iron Battleaxe", "MainHand", {
	level = 10,
	description = "",
	attackType = "Melee",

	modifiers = {
		accuracy = { Stab = -2, Slash = 20, Crush = 15, Magic = 0, Ranged = 0 },
        defense = { Stab = 0, Slash = 0, Crush = 0, Magic = 0, Ranged = -1 },
		bonus = { Melee = 22, Magic = 0, Ranged = 0 },
		attackSpeed = 0, -- "Slow"
		criticalChance = 0,
		weight = 0
    }
})
ItemDatabase["longsword_iron"] = Equipment.new("Iron Longsword", "MainHand", {
	level = 10,
	description = "",
	attackType = "Melee",

	modifiers = {
		accuracy = { Stab = 13, Slash = 18, Crush = -2, Magic = 0, Ranged = 0 },
        defense = { Stab = 0, Slash = 3, Crush = 2, Magic = 0, Ranged = 0 },
		bonus = { Melee = 16, Magic = 0, Ranged = 0 },
		attackSpeed = 0, -- "Medium"
		criticalChance = 0,
		weight = 0
    }
})
ItemDatabase["greatsword_iron"] = Equipment.new("Iron Greatsword", "Two-Handed", {
	level = 10,
	description = "",
	attackType = "Melee",

	modifiers = {
		accuracy = { Stab = 18, Slash = 27, Crush = -4, Magic = -4, Ranged = 0 },
        defense = { Stab = 0, Slash = 0, Crush = 0, Magic = 0, Ranged = -1 },
		bonus = { Melee = 26, Magic = 0, Ranged = 0 },
		attackSpeed = 0, -- "Slow"
		criticalChance = 0,
		weight = 0
    }
})
ItemDatabase["maul_iron"] = Equipment.new("Iron Maul", "Two-Handed", {
	level = 10,
	description = "",
	attackType = "Melee",

	modifiers = {
		accuracy = { Stab = -4, Slash = -4, Crush = 27, Magic = 0, Ranged = 0 },
        defense = { Stab = 0, Slash = 0, Crush = 0, Magic = 0, Ranged = 0 },
		bonus = { Melee = 26, Magic = 0, Ranged = 0 },
		attackSpeed = 0, -- "Slow"
		criticalChance = 0,
		weight = 0
    }
})
ItemDatabase["claws_iron"] = Equipment.new("Iron Claws", "Two-Handed", {
	level = 10,
	description = "",
	attackType = "Melee",

	modifiers = {
		accuracy = { Stab = 10, Slash = 14, Crush = -4, Magic = 0, Ranged = 0 },
        defense = { Stab = 4, Slash = 7, Crush = 2, Magic = 0, Ranged = 0 },
		bonus = { Melee = 14, Magic = 0, Ranged = 0 },
		attackSpeed = 0, -- "Fast"
		criticalChance = 0,
		weight = 0
    }
})

-- Iron Armor
ItemDatabase["helmet_iron"] = Equipment.new("Iron Helmet", "Head", {
	level = 10,
	description = "",

	modifiers = {
        accuracy = { Stab = 0, Slash = 0, Crush = 0, Magic = -3, Ranged = 0 },
		defense = { Stab = 9, Slash = 10, Crush = 8, Magic = -1, Ranged = 9 },
		bonus = { Melee = 0, Magic = 0, Ranged = 0 },
		attackSpeed = 0,
		criticalChance = 0,
		weight = 0
    }
})
ItemDatabase["chainbody_iron"] = Equipment.new("Iron Chainbody", "Chest", {
	level = 10,
	description = "",

	modifiers = {
        accuracy = { Stab = 0, Slash = 0, Crush = 0, Magic = -15, Ranged = 0 },
		defense = { Stab = 22, Slash = 32, Crush = 39, Magic = -3, Ranged = 24 },
		bonus = { Melee = 0, Magic = 0, Ranged = 0 },
		attackSpeed = 0,
		criticalChance = 0,
		weight = 0
    }
})
ItemDatabase["r_chausses_iron"] = Equipment.new("Iron Reinforced Chausses", "Legs", {
	level = 10,
	description = "",

	modifiers = {
        accuracy = { Stab = 0, Slash = 0, Crush = 0, Magic = -21, Ranged = -11 },
		defense = { Stab = 19, Slash = 28, Crush = 8, Magic = -4, Ranged = 18 },
		bonus = { Melee = 0, Magic = 0, Ranged = 0 },
		attackSpeed = 0,
		criticalChance = 0,
		weight = 0
    }
})
ItemDatabase["r_gloves_iron"] = Equipment.new("Iron Reinforced Gloves", "Hands", {
	level = 10,
	description = "",

	modifiers = {
        accuracy = { Stab = 5, Slash = 5, Crush = 5, Magic = 3, Ranged = 5 },
		defense = { Stab = 5, Slash = 5, Crush = 5, Magic = 3, Ranged = 5 },
		bonus = { Melee = 5, Magic = 0, Ranged = 0 },
		attackSpeed = 0,
		criticalChance = 0,
		weight = 0
    }
})
ItemDatabase["r_boots_iron"] = Equipment.new("Iron Reinforced Boots", "Feet", {
	level = 10,
	description = "",

	modifiers = {
        accuracy = { Stab = 0, Slash = 0, Crush = 0, Magic = -3, Ranged = -1 },
		defense = { Stab = 7, Slash = 8, Crush = 9, Magic = 0, Ranged = 0 },
		bonus = { Melee = 0, Magic = 0, Ranged = 0 },
		attackSpeed = 0,
		criticalChance = 0,
		weight = 0
    }
})

ItemDatabase["plate_helmet_iron"] = Equipment.new("Iron Plate Helmet", "Head", {
	level = 15,
	description = "",

	modifiers = {
        accuracy = { Stab = 0, Slash = 0, Crush = 0, Magic = -6, Ranged = -3 },
		defense = { Stab = 12, Slash = 13, Crush = 10, Magic = -1, Ranged = 9 },
		bonus = { Melee = 0, Magic = 0, Ranged = 0 },
		attackSpeed = 0,
		criticalChance = 0,
		weight = 0
    }
})
ItemDatabase["chestplate_iron"] = Equipment.new("Iron Chestplate", "Chest", {
	level = 15,
	description = "",

	modifiers = {
        accuracy = { Stab = 0, Slash = 0, Crush = 0, Magic = -30, Ranged = -15 },
		defense = { Stab = 41, Slash = 40, Crush = 30, Magic = -6, Ranged = 40 },
		bonus = { Melee = 0, Magic = 0, Ranged = 0 },
		attackSpeed = 0,
		criticalChance = 0,
		weight = 0
    }
})
ItemDatabase["p_chausses_iron"] = Equipment.new("Iron Plate Chausses", "Legs", {
	level = 15,
	description = "",

	modifiers = {
        accuracy = { Stab = 0, Slash = 0, Crush = 0, Magic = -21, Ranged = -11 },
		defense = { Stab = 21, Slash = 20, Crush = 10, Magic = -4, Ranged = 20 },
		bonus = { Melee = 0, Magic = 0, Ranged = 0 },
		attackSpeed = 0,
		criticalChance = 0,
		weight = 0
    }
})
ItemDatabase["gauntlets_iron"] = Equipment.new("Iron Gauntlets", "Hands", {
	level = 15,
	description = "",

	modifiers = {
        accuracy = { Stab = 5, Slash = 5, Crush = 5, Magic = 3, Ranged = 5 },
		defense = { Stab = 7, Slash = 7, Crush = 7, Magic = 3, Ranged = 7 },
		bonus = { Melee = 6, Magic = 0, Ranged = 0 },
		attackSpeed = 0,
		criticalChance = 0,
		weight = 0
    }
})
ItemDatabase["p_greaves_iron"] = Equipment.new("Iron Plate Greaves", "Feet", {
	level = 15,
	description = "",

	modifiers = {
        accuracy = { Stab = 0, Slash = 0, Crush = 0, Magic = -3, Ranged = -1 },
		defense = { Stab = 9, Slash = 10, Crush = 11, Magic = 0, Ranged = 0 },
		bonus = { Melee = 0, Magic = 0, Ranged = 0 },
		attackSpeed = 0,
		criticalChance = 0,
		weight = 0
    }
})

-- Steel Weapons
-- Steel Armor

-- Blue Steel Weapons
-- Blue Steel Armor

-- Red Steel Weapons
-- Red Steel Armor

-- Eldrinite Weapons
-- Eldrinite Armor

-- Verdantite Weapons
-- Verdantite Armor

-- Celestium Weapons
-- Celestium Armor

-- Pale Weapons
ItemDatabase["wand_pale"] = Equipment.new("Pale Wand", "MainHand", {
	level = 1,
	description = "",
	attackType = "Magic",

	modifiers = {
		accuracy = { Stab = 0, Slash = 0, Crush = 0, Magic = 2, Ranged = 0 },
        defense = { Stab = 0, Slash = 0, Crush = 0, Magic = 0, Ranged = 0 },
		bonus = { Melee = 0, Magic = 5, Ranged = 0 },
		attackSpeed = 0,
		criticalChance = 0,
		weight = 0
    }
})

ItemDatabase["core_pale"] = Equipment.new("Pale Core", "OffHand", {
	level = 1,
	description = "",
	attackType = "Magic",

	modifiers = {
		accuracy = { Stab = 0, Slash = 0, Crush = 0, Magic = 2, Ranged = 0 },
        defense = { Stab = 0, Slash = 0, Crush = 0, Magic = 0, Ranged = 0 },
		bonus = { Melee = 0, Magic = 5, Ranged = 0 },
		attackSpeed = 0,
		criticalChance = 0,
		weight = 0
    }
})

ItemDatabase["staff_pale"] = Equipment.new("Pale Staff", "Two-Handed", {
	level = 1,
	description = "",
	attackType = "Magic",

	modifiers = {
		accuracy = { Stab = 0, Slash = 0, Crush = 0, Magic = 5, Ranged = 0 },
        defense = { Stab = 0, Slash = 0, Crush = 0, Magic = 0, Ranged = 0 },
		bonus = { Melee = 0, Magic = 14, Ranged = 0 },
		attackSpeed = 0,
		criticalChance = 0,
		weight = 0
    }
})
---------------

-- Flickering Weapons

ItemDatabase["staff_flickering"] = Equipment.new("Flickering Staff", "Two-Handed", {
	level = 10,
	description = "",
	attackType = "Magic",

	modifiers = {
		accuracy = { Stab = 0, Slash = 0, Crush = 0, Magic = 11, Ranged = 0 },
        defense = { Stab = 0, Slash = 0, Crush = 0, Magic = 0, Ranged = 0 },
		bonus = { Melee = 0, Magic = 21, Ranged = 0 },
		attackSpeed = 0,
		criticalChance = 0,
		weight = 0
    }
})
---------------------


-- Flaxweave Robes | Set: 5 Accuracy, 5 Magic Bonus
ItemDatabase["hat_flaxweave"] = Equipment.new("Flaxweave Hat", "Head", {
	level = 1,
	description = "",

	modifiers = {
        accuracy = { Stab = 0, Slash = 0, Crush = 0, Magic = 1, Ranged = 0 },
		defense = { Stab = 0, Slash = 0, Crush = 0, Magic = 1, Ranged = 0 },
		bonus = { Melee = 0, Magic = 1, Ranged = 0 },
		attackSpeed = 0,
		criticalChance = 0,
		weight = 0
    }
})
ItemDatabase["robe_flaxweave"] = Equipment.new("Flaxweave Robe", "Chest", {
	level = 1,
	description = "",

	modifiers = {
        accuracy = { Stab = 0, Slash = 0, Crush = 0, Magic = 2, Ranged = 0 },
		defense = { Stab = 0, Slash = 0, Crush = 0, Magic = 2, Ranged = 0 },
		bonus = { Melee = 0, Magic = 2, Ranged = 0 },
		attackSpeed = 0,
		criticalChance = 0,
		weight = 0
    }
})
ItemDatabase["skirt_flaxweave"] = Equipment.new("Flaxweave Skirt", "Legs", {
	level = 1,
	description = "",

	modifiers = {
        accuracy = { Stab = 0, Slash = 0, Crush = 0, Magic = 1, Ranged = 0 },
		defense = { Stab = 0, Slash = 0, Crush = 0, Magic = 1, Ranged = 0 },
		bonus = { Melee = 0, Magic = 1, Ranged = 0 },
		attackSpeed = 0,
		criticalChance = 0,
		weight = 0
    }
})
ItemDatabase["slippers_flaxweave"] = Equipment.new("Flaxweave Slippers", "Feet", {
	level = 1,
	description = "",

	modifiers = {
        accuracy = { Stab = 0, Slash = 0, Crush = 0, Magic = 1, Ranged = 0 },
		defense = { Stab = 0, Slash = 0, Crush = 0, Magic = 1, Ranged = 0 },
		bonus = { Melee = 0, Magic = 1, Ranged = 0 },
		attackSpeed = 0,
		criticalChance = 0,
		weight = 0
    }
})
-----------------

-- Moonwool Robes | Set: 9 Accuracy, 9 Magic Bonus
ItemDatabase["hood_moonwool"] = Equipment.new("Moonwool Hood", "Head", {
	level = 10,
	description = "",

	modifiers = {
        accuracy = { Stab = 0, Slash = 0, Crush = 0, Magic = 2, Ranged = 0 },
		defense = { Stab = 0, Slash = 0, Crush = 0, Magic = 5, Ranged = 0 },
		bonus = { Melee = 0, Magic = 2, Ranged = 0 },
		attackSpeed = 0,
		criticalChance = 0,
		weight = 0
    }
})
ItemDatabase["robe_moonwool"] = Equipment.new("Moonwool Robe", "Chest", {
	level = 10,
	description = "",

	modifiers = {
        accuracy = { Stab = 0, Slash = 0, Crush = 0, Magic = 3, Ranged = 0 },
		defense = { Stab = 0, Slash = 0, Crush = 0, Magic = 5, Ranged = 0 },
		bonus = { Melee = 0, Magic = 3, Ranged = 0 },
		attackSpeed = 0,
		criticalChance = 0,
		weight = 0
    }
})
ItemDatabase["skirt_moonwool"] = Equipment.new("Moonwool Skirt", "Legs", {
	level = 10,
	description = "",

	modifiers = {
        accuracy = { Stab = 0, Slash = 0, Crush = 0, Magic = 2, Ranged = 0 },
		defense = { Stab = 0, Slash = 0, Crush = 0, Magic = 5, Ranged = 0 },
		bonus = { Melee = 0, Magic = 2, Ranged = 0 },
		attackSpeed = 0,
		criticalChance = 0,
		weight = 0
    }
})
ItemDatabase["slippers_moonwool"] = Equipment.new("Moonwool Slippers", "Feet", {
	level = 10,
	description = "",

	modifiers = {
        accuracy = { Stab = 0, Slash = 0, Crush = 0, Magic = 2, Ranged = 0 },
		defense = { Stab = 0, Slash = 0, Crush = 0, Magic = 5, Ranged = 0 },
		bonus = { Melee = 0, Magic = 2, Ranged = 0 },
		attackSpeed = 0,
		criticalChance = 0,
		weight = 0
    }
})
-----------------

-- Verdant Robes
-----------------

-- Emberweave Robes
-----------------

-- Stormborn Robes
-----------------

-- Shadowbloom Robes
-----------------

-- Astralweave Robes
-----------------

-- Eldertree Robes
-----------------

-- Ethereal Robes
-----------------


function ItemDatabase.getItem(name)
	return ItemDatabase[name] or nil
end

return ItemDatabase

--[[
local function calculateDamage(attacker, defender, attackType)
	-- TODO: Crits; on crit, max hit
	-- TODO: Get Style Bonus

	if attackType == "Melee" then
		local attackLevel = attacker.skills["attack"].level
		local strengthLevel = attacker.skills["strength"].level
		local meleeBonus = attacker.stats["bonus"]["melee"]
		local defenseLevel = defender.skills["defense"].level

		local playerAccuracy = attacker.stats["accuracy"][attackType]
		local defenseRating = defender.stats["defense"][attackType]

		local attackStat = attackLevel * (playerAccuracy + 64)
		local defenseStat = defenseLevel * (defenseRating + 64)

		local accuracy = attackStat / (attackStat + defenseStat)
		if accuracy > 1 then accuracy = 1 end

		-- (((strengthLevel + potionBonus) * prayerBonus) + Style Bonus + 8) * Void Bonus
		local effectiveStrength = (((strengthLevel + 0) * 1) + 3 + 8) * 1
		local maxHit = math.floor(0.5 + (effectiveStrength * ((meleeBonus + 64) / 640)))
		local minHit = math.floor((1 + ((accuracy ^ 2) / 2) * (maxHit - 1)) + 0.5)

		local rand = math.random()
		local skewFactor = (maxHit - minHit) * (1 - accuracy)
		local skewedRand = rand ^ skewFactor
		local damage = math.floor((minHit + (maxHit - minHit) * skewedRand) + 0.5)

		--local damage = math.floor((minHit + (maxHit - minHit) * math.random() ^ accuracy) + 0.5)
	else if attackType == "Magic" then
		local magicLevel = attacker.skills["magic"].level
		local magicBonus = attacker.stats["bonus"]["magic"]
		local playerAccuracy = attacker.stats["accuracy"][attackType]
		local defenseRating = defender.stats["defense"][attackType]

		local magicStat = magicLevel * (playerAccuracy + 64)
		local defenseStat = defenseLevel * (defenseRating + 64)

		local accuracy = magicStat / (magicStat + defenseStat)
		if accuracy > 1 then accuracy = 1 end

		local effectiveMagic = (((magicLevel + 0) * 1) + magicBonus + 8) * 1
		local maxHit = math.floor(0.5 + (effectiveMagic * ((magicBonus + 64) / 640)))
		local minHit = math.floor((1 + ((accuracy ^ 2) / 2) * (maxHit - 1)) + 0.5)

		local rand = math.random()
		local skewFactor = (maxHit - minHit) * (1 - accuracy)
		local skewedRand = rand ^ skewFactor
		local damage = math.floor((minHit + (maxHit - minHit) * skewedRand) + 0.5)

		--local damage = math.floor((minHit + (maxHit - minHit) * math.random() ^ accuracy) + 0.5)
	else if attackType == "Ranged" then

	end
end
]]--