local ccb = require("ccb")
local predicates = ccb.content.dialogue_predicates

ccb.content.define_weakpoint_set {
    id = "wps_humanoid_body",
    points = {
        {
            id = "groin",
            name = ccb.content.text("the groin"),
            coverage = 5,
            critical_multiplier = { all = 1.1 },
            armor_multiplier = { physical = 0.75 },
            difficulty = { melee = 1, ranged = 5 },
            when = predicates.all({ predicates.conversation_state("has_speaker"), predicates.actor_state("speaker", "is_character"), predicates.has_trait("speaker", "perk_belowthebelt") }),
        },
    },
}
