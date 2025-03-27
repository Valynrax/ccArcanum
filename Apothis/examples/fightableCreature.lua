local interactableData = {
    type = "COMBAT",
    stats = {
        name = "",
        internalName = "", -- Must match quest target
        health = 0,
        combat = 0,
        drops = {
            [0] = {
                chance = 0, -- % based on "outOf" variable
                outOf = 100, -- max value for math.random of loot roll, default out of 100
                amt = 0, -- or { min = 0, max = 0 }
                item = ""
            }
        }
    }
}