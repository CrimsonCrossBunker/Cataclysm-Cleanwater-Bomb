local ccb = require("ccb")
local content = ccb.content

-- Native skill definitions
do
local definition = content.Skill {
    id = "smartgun",
    name = ccb.content.text("smart guns"),
    description = ccb.content.text("Back in the 21st century marksmanship was an art whose mastery meant arduous years of constant training and preparation.  There are computers for that now."),
    display_category = "display_ranged",
    sort_rank = 10500,
    teachable = true,
    obsolete = false,
    consumes_focus = true,
}
definition:tag("combat_skill")
definition:companion_practice("combat", 25)
definition:attack_time(20, 30, 1)
definition:companion_rank_factors(0, 0, 0)
content.add(definition)
end
do
local definition = content.Skill {
    id = "metaphysics",
    name = ccb.content.text("metaphysics"),
    description = ccb.content.text("Your ability to manipulate psionic energy."),
    display_category = "display_ranged",
    sort_rank = 14500,
    teachable = true,
    obsolete = false,
    consumes_focus = true,
}
definition:companion_rank_factors(0, 0, 0)
content.add(definition)
end
