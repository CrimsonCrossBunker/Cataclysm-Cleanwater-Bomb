local ccb = require("ccb")
local content = ccb.content

-- Native skill definitions
do
local definition = content.Skill {
    id = "metaphysics",
    name = ccb.content.text("woo woo"),
    description = ccb.content.text("Crystals, meditation, astral projection, remote viewing, channeling, ESP; it's all real, man.  It all works if you believe."),
    display_category = "display_ranged",
    sort_rank = 14500,
    teachable = true,
    obsolete = false,
    consumes_focus = true,
}
definition:companion_rank_factors(0, 0, 0)
content.replace(definition)
end
