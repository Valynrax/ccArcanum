local interactableData = {
    name = "",
    description = "",
    type = "QUEST",
    questID = 0
    currStage = 0,
    stages = {
        [0] = {
            type = "COLLECT",
            target = "XXX", -- item to collect
            npc = "XXX", -- NPC to speak with to turn in the items
            amount = 0,
            completes = true
        }
    },
    rewards = {
        [0] = {
            item = "",
            skill = "", -- For if item is "xp"
            amount = 0
        }
    },
    questComplete = false
}