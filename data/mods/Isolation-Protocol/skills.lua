local ccb = require("ccb")
local content = ccb.content

-- Native skill definitions
if not content.is_mod_active("magiclysm") then
    local definition = content.Skill {
        id = "spellcraft",
        name = ccb.content.text("sorcery"),
        description = ccb.content.text("Your ability to control the hidden forces behind reality."),
        display_category = "display_ranged",
        sort_rank = 14500,
        teachable = true,
        obsolete = false,
        consumes_focus = true,
    }
    definition:companion_rank_factors(0, 0, 0)
    content.add(definition)
end
