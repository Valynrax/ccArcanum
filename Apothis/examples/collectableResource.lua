local interactableData = { -- Used for collectable resources that are not tied to Minecraft Blocks in interactableBlocks.lua
    name = "",
    description = "",
    type = "RESOURCE",
    resource = "",      -- energy_pale
    amount = 0,         -- or { min = 0, max = 0 }
    duration = 0,       -- in seconds
    cycles = 0,         -- How many times it will collect the resources based off one "interact" request
    skill = "",         -- Associated skill
    level = 0,          -- required level of skill
    xp = 0,             -- XP gained per gather
}