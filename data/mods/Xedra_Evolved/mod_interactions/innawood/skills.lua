local ccb = require("ccb")
local content = ccb.content

-- Native skill definitions
do
local definition = content.Skill {
    id = "deduction",
    name = ccb.content.text("occult"),
    description = ccb.content.text("Your knowledge of spirits, the unseen world, and other mystical topics, occult is a path to abilities many might consider to be unnatural."),
    display_category = "display_interaction",
    sort_rank = 26500,
    teachable = true,
    obsolete = false,
    consumes_focus = true,
}
definition:tag("combat_skill")
definition:companion_practice("speech", 1)
definition:companion_practice("devices", 1)
definition:attack_time(60, 200, 14)
definition:companion_rank_factors(0, 0, 1)
content.replace(definition)
end
