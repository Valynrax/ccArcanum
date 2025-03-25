Recipe = {}
Recipe.__index = Recipe

function Recipe.new(name, level, skill, experience, ingredients, amount)
	local self = setmetatable({}, Recipe)

	self.name = name				-- Recipe Name
	self.level = level				-- Required level to complete the craft
	self.skill = skill				-- Associated skill
	self.xp = experience			-- XP to grant when crafted (in self.skill)
	self.ingredients = ingredients	-- Ingredients { ["ingredient"] = 0, ... }
	self.amount = amount or 1		-- Amount that is created
    
    return self
end

return Recipe