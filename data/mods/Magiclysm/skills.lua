local ccb = require("ccb")
local content = ccb.content

-- Native skill definitions
do
local definition = content.Skill {
    id = "spellcraft",
    name = ccb.content.text("spellcraft"),
    description = ccb.content.text("Your skill in the arcane.  Represents magic theory and all that entails.  A higher skill increases how quickly you can learn spells, and decreases their spell failure chance.  You learn this skill by studying books or spells."),
    display_category = "display_ranged",
    sort_rank = 14500,
    teachable = true,
    obsolete = false,
    consumes_focus = true,
}
definition:level_description(0, ccb.content.text("You can't tell a spellbook from a cookbook."), ccb.content.text("If you know a single spell, it will probably fizzle, spark, and die in your hands."))
definition:level_description(1, ccb.content.text("You probably have a utility spell or another for cleaning or other every day activities."), ccb.content.text("You probably have one utility spell or another for cleaning or other every day activities."))
definition:level_description(3, ccb.content.text("You understand the basics of magical flow and may have studied the arcane in middle school."), ccb.content.text("You weave spells with deliberate care and can get reliable results."))
definition:level_description(5, ccb.content.text("You have probably attended formal arcane education and can dissect most magical structures with ease."), ccb.content.text("Your incantations flow naturally, you adapt to magical feedback with ease."))
definition:level_description(7, ccb.content.text("You grasp the underlying logic of the arcane and have worked in some thaumaturgy research."), ccb.content.text("You cast complex spells effortlessly, as if speaking a native tongue."))
definition:level_description(9, ccb.content.text("You've dissected more spell structures than you care to count, and probably even improved a few spells."))
definition:level_description(10, ccb.content.text("You would have been known as the foremost expert in magical knowledge, if anyone were still around to care, that is."), ccb.content.text("Magic obeys your will before you even voice it."))
definition:companion_rank_factors(0, 0, 0)
content.add(definition)
end
