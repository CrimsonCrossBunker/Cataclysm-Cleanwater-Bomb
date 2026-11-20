local ccb = require("ccb")
local content = ccb.content

-- Native skill definitions
do
local definition = content.Skill {
    id = "deduction",
    name = ccb.content.text("deduction"),
    description = ccb.content.text("Your ability to see the pattern behind a series of data points.  Allows you to ask questions that you otherwise couldn't ask and find things you might have missed otherwise."),
    display_category = "display_interaction",
    sort_rank = 26500,
    teachable = true,
    obsolete = false,
    consumes_focus = true,
}
definition:tag("combat_skill")
definition:companion_practice("speech", 1)
definition:companion_practice("devices", 1)
definition:level_description(0, ccb.content.text("You can't even think yourself out of a paper bag."), ccb.content.text("You can't even solve a simple Sudoku puzzle."))
definition:level_description(1, ccb.content.text("You get the gist of playing a round of chess."), ccb.content.text("You can deduce the whereabouts of your missing item in your house."))
definition:level_description(3, ccb.content.text("You realized that one weird tabloid paper you've read a long time ago might have been correct all this time."), ccb.content.text("You solve murder mysteries in the first chapter."))
definition:level_description(5, ccb.content.text("You probably know how to deduce an electronic lock's password."), ccb.content.text("You can figure out the workings of the world mundane and supernatural from some observations."))
definition:level_description(7, ccb.content.text("You can easily rule out non-magickal causes in a given situation."), ccb.content.text("You're basically modern day Sherlock Holmes."))
definition:level_description(9, ccb.content.text("You're aware of more supernatural happenings than everyone else."), ccb.content.text("No secret is safe from you."))
definition:level_description(10, ccb.content.text("You know even what you don't know."), ccb.content.text("Even the unknowable unknowns are known to you."))
definition:attack_time(60, 200, 14)
definition:companion_rank_factors(0, 0, 1)
content.add(definition)
end
do
local definition = content.Skill {
    id = "gramarye",
    name = ccb.content.text("gramarye"),
    description = ccb.content.text("Your ability to manipulate fae magicks."),
    display_category = "display_interaction",
    sort_rank = 26750,
    teachable = true,
    obsolete = false,
    consumes_focus = true,
}
definition:tag("combat_skill")
definition:attack_time(60, 200, 14)
definition:companion_rank_factors(0, 0, 0)
definition:requires_any_trait("ARVORE")
definition:requires_any_trait("SALAMANDER")
definition:requires_any_trait("CHANGELING_MAGIC")
content.add(definition)
end
