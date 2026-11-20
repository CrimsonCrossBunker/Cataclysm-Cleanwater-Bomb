local ccb = require("ccb")
local predicates = ccb.content.dialogue_predicates

ccb.content.define_weakpoint_set {
    id = "wps_xe_homullus_aleph",
    points = {
        {
            id = "aleph",
            name = ccb.content.text("the aleph"),
            coverage = 5,
            difficulty = { melee = 4, ranged = 5 },
            when = predicates.all({ predicates.conversation_state("has_speaker"), predicates.actor_state("speaker", "is_character") }),
            attack_coverage = { broad = 0.5 },
            effects = {
                {
                    effect = "staggered",
                    death_chance = 100,
                    chance = 100,
                    message = ccb.content.text("The aleph letter carving breaks, the word 'met' is formed, and the %s returns into a lifeless pile of clay."),
                    damage_percent = { 7, 100 },
                },
            },
        },
    },
}
