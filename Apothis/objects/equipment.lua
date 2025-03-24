Equipment = {}
Equipment.__index = Equipment

function Equipment.new(name, slot, stats)
	local self = setmetatable({}, Equipment)

	self.name = name          -- Item Name
    self.slot = slot          -- Slot (MainHand, OffHand, EitherHand, Head, Chest, etc.)
    self.stats = stats or {}  -- Table storing item stats

    -- Function to Get an Item's Stat
    function self:getStat(statName)
        return self.stats[statName] or 0
    end

    -- Function to Print Item Info
    function self:describe()
        local desc = self.name .. " (" .. self.type .. ")\n"
        for stat, value in pairs(self.stats) do
            desc = desc .. "  " .. stat .. ": " .. tostring(value) .. "\n"
        end
        return desc
    end

    return self
end

return Equipment