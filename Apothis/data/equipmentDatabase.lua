local Equipment = require "equipment"

local EquipmentDatabase = {}

-- Example Weapon
EquipmentDatabase["example_weapon_dual_wielding"] = Equipment.new("Example Weapon", "EitherHand", {
	description = "This is a developer item, how do you have this?",
	attackStyles = { "Slash", "Stab" },
	maxDamage = { Slash = 0, Stab = 0, Crush = 0 }, -- Maximum Damage
	accuracy = { Slash = 0, Stab = 0, Crush = 0 }, -- Percent scaling of Damage
	attackSpeed = 0,
	armorPenetration = { Slash = 0, Stab = 0, Crush = 0 }, -- Reduce defense of target by value
	criticalChance = 0, -- Percent Chance
	-- FUTURE: durability?
	weight = 0,

	modifiers = {
        defense = { Slash = 0, Stab = 0, Crush = 0 }
    }
})

-- Example Armor Piece
EquipmentDatabase["example_armor_piece"] = Equipment.new("Example Armor", "Head", {
	description = "This is a developer item, how do you have this?",
	defense = { Slash = 0, Stab = 0, Crush = 0 }, -- Reduces Accuracy by amount
	-- FUTURE: magicResistance?
	-- FUTURE: durability?
	weight = 0,

	modifiers = {
        accuracy = { Slash = 0, Stab = 0, Crush = 0 } -- Increases attack accuracy while worn
    }
})

function EquipmentDatabase.getItem(name)
	return EquipmentDatabase[name] or nil
end

return EquipmentDatabase

--[[
local function calculateDamage(attacker, defender, attackType)
    local weapon = attacker.equipment["MainHand"]
    local armor = defender.equipment["Chest"]

    local baseAccuracy = weapon.stats.accuracy[attackType] or 0
    local bonusAccuracy = attacker.stats.accuracy and attacker.stats.accuracy[attackType] or 0
    local totalAccuracy = baseAccuracy + bonusAccuracy -- Apply accuracy bonuses

    local defense = armor and armor.stats.defense[attackType] or 0
    local bonusDefense = defender.stats.defense and defender.stats.defense[attackType] or 0
    local totalDefense = defense + bonusDefense -- Apply defense bonuses

    local effectiveAccuracy = math.max(0, totalAccuracy - totalDefense)
    local maxDamage = weapon.stats.maxDamage[attackType] or 0
    local damage = math.max(1, (effectiveAccuracy / totalAccuracy) * maxDamage)

    return math.floor(damage) -- Round down for consistency
end

]]--