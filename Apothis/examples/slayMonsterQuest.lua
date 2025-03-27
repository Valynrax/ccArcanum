local interactableData = {
    name = "",
    description = "",
    type = "QUEST",
    questID = 0
    currStage = 0,
    stages = {
        [0] = {
            type = "SLAY",
            target = "XXX", -- Monster ID
            amount = 0,
            currAmount = 0,
            completes = false
        },
        [1] = {
            type = "SPEAK",
            target = "XXX", -- Interactable to speak with
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