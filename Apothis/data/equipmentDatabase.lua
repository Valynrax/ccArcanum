local Equipment = require "equipment"

local EquipmentDatabase = {}

-- Bronze (Copper + Tin)
-- Iron
-- Steel (Iron + Coal)
-- Blue Steel (Steel + Lapis)
-- Red Steel (Steel + Redstone)
-- Eldrinite (Ancient Debris)
-- Verdantite (Ancient Debris + Emerald)
-- Celestium (Ancient Debris + Diamond)

-- Example Weapon
EquipmentDatabase["example_weapon_dual_wielding"] = Equipment.new("Example Weapon", "EitherHand", {
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
EquipmentDatabase["example_armor_piece"] = Equipment.new("Example Armor", "Head", {
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
EquipmentDatabase["dagger_bronze"] = Equipment.new("Bronze Dagger", "EitherHand", {
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
EquipmentDatabase["shortsword_bronze"] = Equipment.new("Bronze Shortsword", "EitherHand", {
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
EquipmentDatabase["scimitar_bronze"] = Equipment.new("Bronze Scimitar", "MainHand", {
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
EquipmentDatabase["mace_bronze"] = Equipment.new("Bronze Mace", "MainHand", {
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
EquipmentDatabase["warhammer_bronze"] = Equipment.new("Bronze Warhammer", "MainHand", {
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
EquipmentDatabase["rapier_bronze"] = Equipment.new("Bronze Rapier", "MainHand", {
	level = 1,
	description = "",
	attackType = "Melee",

	modifiers = {
		accuracy = { Stab = 4, Slash = -3, Crush = -3, Magic = 2, Ranged = 0 },
        defense = { Stab = 0, Slash = 0, Crush = 0, Magic = 0, Ranged = 0 },
		bonus = { Melee = 5, Magic = 0, Ranged = 0 },
		attackSpeed = 0, -- "Fast"
		criticalChance = 0,
		weight = 0
    }
})
EquipmentDatabase["battleaxe_bronze"] = Equipment.new("Bronze Battleaxe", "MainHand", {
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
EquipmentDatabase["longsword_bronze"] = Equipment.new("Bronze Longsword", "MainHand", {
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
EquipmentDatabase["greatsword_bronze"] = Equipment.new("Bronze Greatsword", "Two-Handed", {
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
EquipmentDatabase["maul_bronze"] = Equipment.new("Bronze Maul", "Two-Handed", {
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

-- Bronze Armor

-- Iron Weapons
EquipmentDatabase["dagger_iron"] = Equipment.new("Iron Dagger", "EitherHand", {
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

-- Iron Armor

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
EquipmentDatabase["wand_pale"] = Equipment.new("Pale Wand", "MainHand", {
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

EquipmentDatabase["core_pale"] = Equipment.new("Pale Core", "OffHand", {
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

EquipmentDatabase["staff_pale"] = Equipment.new("Pale Staff", "Two-Handed", {
	level = 1,
	description = "",
	attackType = "Magic",

	modifiers = {
		accuracy = { Stab = 0, Slash = 0, Crush = 0, Magic = 5, Ranged = 0 },
        defense = { Stab = 0, Slash = 0, Crush = 0, Magic = 0, Ranged = 0 },
		bonus = { Melee = 0, Magic = 11, Ranged = 0 },
		attackSpeed = 0,
		criticalChance = 0,
		weight = 0
    }
})


function EquipmentDatabase.getItem(name)
	return EquipmentDatabase[name] or nil
end

return EquipmentDatabase

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

		-- (((strengthLevel + potionBonus) * prayerBonus) + Style Bonus + 8) * Void Bonus
		local effectiveStrength = (((strengthLevel + 0) * 1) + 3 + 8) * 1
		local maxHit = math.floor(0.5 + (effectiveStrength * ((meleeBonus + 64) / 640)))
		local minHit = math.floor((1 + ((accuracy ^ 2) / 2) * (maxHit - 1)) + 0.5)

		local damage = math.floor((minHit + (maxHit - minHit) * math.random() ^ accuracy) + 0.5)
	else if attackType == "Magic" then
		local magicLevel = attacker.skills["magic"].level
		local magicBonus = attacker.stats["bonus"]["magic"]
		local playerAccuracy = attacker.stats["accuracy"][attackType]
		local defenseRating = defender.stats["defense"][attackType]

		local magicStat = magicLevel * (playerAccuracy + 64)
		local defenseStat = defenseLevel * (defenseRating + 64)

		local accuracy = magicStat / (magicStat + defenseStat)

		local effectiveMagic = (((magicLevel + 0) * 1) + magicBonus + 8) * 1
		local maxHit = math.floor(0.5 + (effectiveMagic * ((magicBonus + 64) / 640)))
		local minHit = math.floor((1 + ((accuracy ^ 2) / 2) * (maxHit - 1)) + 0.5)

		local damage = math.floor((minHit + (maxHit - minHit) * math.random() ^ accuracy) + 0.5)
	else if attackType == "Ranged" then

	end
end
]]--