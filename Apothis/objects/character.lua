local EquipmentDatabase = require "equipmentDatabase"

Character = {}
Character.__index = Character

local function getXPForLevel(level)
    return math.floor(0.25 * ((level - 1) + 300 * math.pow(2, (level - 1) / 7)))
end

function Character.new()
    local self = setmetatable({}, Character)

    -- Core Stats
    self.health = 100
    self.maxHealth = 100
    self.position = { x = 0, y = 0, z = 0 }
    self.stats = {}
    
    -- Inventory
    self.inventory = {}

    function self:addItem(itemName, quantity)
        self.inventory[itemName] = (self.inventory[itemName] or 0) + quantity
    end

    function self:hasItem(itemName)
        if self.inventory[itemName] then
            return true, self.inventory[itemName]
        end

        return false, nil
    end

    function self:removeItem(itemName, quantity)
        if self.inventory[itemName] then
            self.inventory[itemName] = math.max(0, self.inventory[itemName] - quantity)
            if self.inventory[itemName] == 0 then
                self.inventory[itemName] = nil -- Remove item if quantity is zero
            end
        end
    end

    -- Equipment
    self.equipment = {
        Head = nil,
        Chest = nil,
        Hands = nil,
        Legs = nil,
        Feet = nil,
        Necklace = nil,
        RingLeft = nil,
        RingRight = nil,
        Quiver = nil,
        MainHand = nil,
        OffHand = nil
    }

    local validSlots = {
        Head = true, Chest = true, Hands = true, Legs = true, Feet = true,
        Necklace = true, RingLeft = true, RingRight = true, Quiver = true,
        MainHand = true, OffHand = true
    }

    function self:equip(slot, itemName)
        if not validSlots[slot] then
            return false, "Invalid equipment slot: " .. tostring(slot)
        end

        local item = EquipmentDatabase.getItem(itemName)
        if not item then
            return false, "Item not found"
        end

        -- Validate if item can be equipped in this slot
        local canEquip = (slot == item.slot) or (item.slot == "EitherHand" and (slot == "MainHand" or slot == "OffHand"))

        if not canEquip then
            return false, "Unable to equip item in " .. slot
        end

        -- Handle Two-Handed Weapons
        if item.slot == "Two-Handed" then
            if self.equipment["OffHand"] then
                self:unequip("OffHand") -- Unequip OffHand if occupied
            end
        elseif slot == "OffHand" and self.equipment["MainHand"] and self.equipment["MainHand"].slot == "Two-Handed" then
            return false, "Cannot equip OffHand while wielding a two-handed weapon"
        end

        if self.equipment[slot] then self:unequip(slot) end

        -- Equip new item
        self.equipment[slot] = item
        self:applyModifiers(item)

        return true, "Equipped " .. itemName .. " in " .. slot
    end

    function self:unequip(slot)
        if not validSlots[slot] then return false, "Invalid equipment slot: " .. tostring(slot) end

        local removedItem = self.equipment[slot]
        if not removedItem then return false, slot .. " slot is already empty." end

        self:removeModifiers(self.equipment[slot])
        self.equipment[slot] = nil
        self:addItem(removedItem, 1)

        return true, "Unequipped " .. removedItem .. " from " .. slot
    end

    function self:getEquipped(slot)
        return self.equipment[slot] and self.equipment[slot]:describe() or "Empty"
    end

    function self:applyModifiers(item)
        if item.stats and item.stats.modifiers then
            for statType, statTable in pairs(item.stats.modifiers) do
                if not self.stats[statType] then
                    self.stats[statType] = {}
                end
                for key, value in pairs(statTable) do
                    self.stats[statType][key] = (self.stats[statType][key] or 0) + value
                end
            end
        end
    end

    function self:removeModifiers(item)
        if item.stats and item.stats.modifiers then
            for statType, statTable in pairs(item.stats.modifiers) do
                if self.stats[statType] then
                    for key, value in pairs(statTable) do
                        self.stats[statType][key] = (self.stats[statType][key] or 0) - value
                        if self.stats[statType][key] == 0 then
                            self.stats[statType][key] = nil
                        end
                    end
                end
            end
        end
    end

    -- Skills
    self.skills = {
        ["attack"] = {
            level = 1,
            xp = 0.0
        },
        ["strength"] = {
            level = 1,
            xp = 0.0
        },
        ["defense"] = {
            level = 1,
            xp = 0.0
        },
        ["magic"] = {
            level = 1,
            xp = 0.0
        },
        ["ranged"] = {
            level = 1,
            xp = 0.0
        },
        ["health"] = {
            level = 1,
            xp = 0.0
        },
        ["mining"] = {
            level = 1,
            xp = 0.0
        },
        ["woodcutting"] = {
            level = 1,
            xp = 0.0
        },
        ["smithing"] = {
            level = 1,
            xp = 0.0
        },
        ["thaumaturgy"] = {
            level = 1,
            xp = 0.0
        },
        ["fletching"] = {
            level = 1,
            xp = 0.0
        },
        ["farming"] = {
            level = 1,
            xp = 0.0
        },
        ["cooking"] = {
            level = 1,
            xp = 0.0
        },
        ["fishing"] = {
            level = 1,
            xp = 0.0
        }
    }

    function self:gainXP(skill, amount)
        self.skills[skill].xp = self.skills[skill].xp + amount

        if self.skills[skill].xp >= getXPForLevel(self.skills[skill].level + 1) then
            self.skills[skill].level = self.skills[skill].level + 1
        end
    end

    -- Quests & Progress (Future Expansion)
    self.quests = {}

    -- Functions to Modify Data

    -- Heal Character
    function self:heal()
        self.health = self.maxHealth
    end

    -- Take Damage
    function self:takeDamage(amount)
        self.health = math.max(0, self.health - amount)
    end

    -- Move Character
    function self:setPosition(x, y, z)
        self.position.x = x
        self.position.y = y
        self.position.z = z
    end

    return self
end

return ApothisCharacter
