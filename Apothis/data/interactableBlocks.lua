local interactableBlocks = {
    -- Artisan Blocks
    ["minecraft:workbench"] = {
        skill = "",
        duration = 5
    },
    ["minecraft:furnance"] = {
        skill = "smithing",
        artisanType = "ore",
        duration = 9
    },
    
    -- Mining Materials
    ["minecraft:stone"] = {
        skill = "mining",
        reqLevel = 1,
        duration = {
            min = 2,
            max = 4
        },
        resource = "stone",
        amount = 1,
        xp = 3
    },
    ["minecraft:copper_ore"] = {
        skill = "mining",
        reqLevel = 1,
        duration = {
            min = 2,
            max = 4
        },
        resource = "ore_copper",
        amount = {
            min = 1,
            max = 2
        },
        xp = 17.5
    },
    ["minecraft:tin_ore"] = {
        skill = "mining",
        reqLevel = 1,
        duration = {
            min = 2,
            max = 4
        },
        resource = "ore_tin",
        amount = {
            min = 1,
            max = 2
        },
        xp = 17.5
    },
    ["minecraft:iron_ore"] = {
        skill = "mining",
        reqLevel = 10,
        duration = {
            min = 5,
            max = 7
        },
        resource = "ore_iron",
        amount = {
            min = 1,
            max = 3
        },
        xp = 26.5
    },
    ["minecraft:coal_ore"] = {
        skill = "mining",
        reqLevel = 20,
        duration = {
            min = 6,
            max = 8
        },
        resource = "coal",
        amount = {
            min = 1,
            max = 3
        },
        xp = 35.5
    },
    ["minecraft:lapis_ore"] = {
        skill = "mining",
        reqLevel = 30,
        duration = {
            min = 6,
            max = 8
        },
        resource = "lapis",
        amount = {
            min = 1,
            max = 3
        },
        xp = 50
    },
    ["minecraft:gold_ore"] = {
        skill = "mining",
        reqLevel = 30,
        duration = {
            min = 6,
            max = 8
        },
        resource = "ore_gold",
        amount = 1,
        xp = 45
    },
    ["minecraft:redstone_ore"] = {
        skill = "mining",
        reqLevel = 40,
        duration = {
            min = 7,
            max = 9
        },
        resource = "redstone",
        amount = {
            min = 1,
            max = 3
        },
        xp = 65
    },
    ["minecraft:ancient_debris"] = {
        skill = "mining",
        reqLevel = 50,
        duration = {
            min = 8,
            max = 10
        },
        resource = "diamond",
        amount = {
            min = 1,
            max = 3
        },
        xp = 75
    },
    ["minecraft:emerald_ore"] = {
        skill = "mining",
        reqLevel = 60,
        duration = {
            min = 7,
            max = 9
        },
        resource = "emerald",
        amount = {
            min = 1,
            max = 3
        },
        xp = 85
    },
    ["minecraft:diamond_ore"] = {
        skill = "mining",
        reqLevel = 70,
        duration = {
            min = 8,
            max = 10
        },
        resource = "diamond",
        amount = {
            min = 1,
            max = 3
        },
        xp = 95
    },

    -- Woodcutting Materials
    ["minecraft:oak_log"] = {
        skill = "woodcutting",
        reqLevel = 1,
        duration = {
            min = 2,
            max = 4
        },
        resource = "wood_oak",
        amount = {
            min = 1,
            max = 3
        },
        xp = 25
    },
    ["minecraft:birch_log"] = {
        skill = "woodcutting",
        reqLevel = 10,
        duration = {
            min = 2,
            max = 4
        },
        resource = "wood_birch",
        amount = {
            min = 1,
            max = 3
        },
        xp = 32
    },
    ["minecraft:spruce_log"] = {
        skill = "woodcutting",
        reqLevel = 20,
        duration = {
            min = 3,
            max = 5
        },
        resource = "wood_spruce",
        amount = {
            min = 1,
            max = 3
        },
        xp = 55
    },
    ["minecraft:jungle_log"] = {
        skill = "woodcutting",
        reqLevel = 30,
        duration = {
            min = 3,
            max = 5
        },
        resource = "wood_jungle",
        amount = {
            min = 1,
            max = 3
        },
        xp = 67.5
    },
    ["minecraft:acacia_log"] = {
        skill = "woodcutting",
        reqLevel = 40,
        duration = {
            min = 4,
            max = 6
        },
        resource = "wood_acacia",
        amount = {
            min = 1,
            max = 3
        },
        xp = 92.5
    },
    ["minecraft:dark_oak_log"] = {
        skill = "woodcutting",
        reqLevel = 50,
        duration = {
            min = 4,
            max = 6
        },
        resource = "wood_dark_oak",
        amount = {
            min = 1,
            max = 3
        },
        xp = 125
    },
    ["minecraft:mangrove_log"] = {
        skill = "woodcutting",
        reqLevel = 60,
        duration = {
            min = 5,
            max = 7
        },
        resource = "wood_mangrove",
        amount = {
            min = 1,
            max = 3
        },
        xp = 175
    },
    ["minecraft:crimson_stem"] = {
        skill = "woodcutting",
        reqLevel = 70,
        duration = {
            min = 5,
            max = 7
        },
        resource = "wood_crimson",
        amount = {
            min = 1,
            max = 3
        },
        xp = 235
    },
    ["minecraft:warped_stem"] = {
        skill = "woodcutting",
        reqLevel = 80,
        duration = {
            min = 6,
            max = 8
        },
        resource = "wood_warped",
        amount = {
            min = 1,
            max = 3
        },
        xp = 317.5
    },
}

return staticInteractables