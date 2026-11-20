local ccb = require("ccb")
local content = ccb.content

-- Native skill definitions
do
local definition = content.Skill {
    id = "metaphysics",
    name = ccb.content.text("metaphysics"),
    description = ccb.content.text("Your ability to manipulate forces of energy often considered supernatural."),
    display_category = "display_ranged",
    sort_rank = 14500,
    teachable = true,
    obsolete = false,
    consumes_focus = true,
}
definition:companion_rank_factors(0, 0, 0)
content.add(definition)
end
