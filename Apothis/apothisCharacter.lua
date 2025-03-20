Character = {}
Character.__index = Character

local skillCap = 40

function Character.new()
    local self = setmetatable({}, Character)

    -- Core Stats
    self.health = 100
    self.maxHealth = 100
    self.position = { x = 0, y = 0, z = 0 }
    
    -- Inventory (Future Expansion)
    self.inventory = {}

    -- Skills & Abilities (Future Expansion)
    self.skills = {
        ["combat"] = {
            level = 1,
            xp = 0.0,
            mastery = 0
        },
        ["health"] = {
            level = 1,
            xp = 0.0,
            mastery = 0
        }
        ["mining"] = {
            level = 1,
            xp = 0.0,
            mastery = 0
        },
        ["woodcutting"] = {
            level = 0,
            xp = 0.0,
            mastery = 0
        },
        ["smithing"] = {
            level = 1,
            xp = 0.0,
            mastery = 0
        }
    }

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

    -- Add an Item to Inventory
    function self:addItem(itemName, quantity)
        self.inventory[itemName] = (self.inventory[itemName] or 0) + quantity
    end

    -- Check if the player has an Item
    function self:hasItem(itemName)
        if self.inventory[itemName] then
            return true, self.inventory[itemName]
        end

        return false, nil
    end

    -- Remove an Item from Inventory
    function self:removeItem(itemName, quantity)
        if self.inventory[itemName] then
            self.inventory[itemName] = math.max(0, self.inventory[itemName] - quantity)
            if self.inventory[itemName] == 0 then
                self.inventory[itemName] = nil -- Remove item if quantity is zero
            end
        end
    end

    -- Give the player an amount of XP in a Skill
    function self:gainXP(skill, amount)
        self.skills[skill].xp = self.skills[skill].xp + amount

        if self.skills[skill].xp >= 10 * (self.skills[skill].level ^ 2) and self.skills[skill].level < skillCap then
            self.skills[skill].level = self.skills[skill].level + 1
        end

        -- TODO: Implement Mastery system eventually.
    end

    return self
end

return ApothisCharacter
