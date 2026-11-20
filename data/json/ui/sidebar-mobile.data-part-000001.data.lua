local ccb = require("ccb")
local predicate = ccb.content.dialogue_predicates

local function bodypart_widget(id, bodypart, label)
    ccb.content.define_widget {
        id = id,
        width = 3,
        style = "text",
        bodypart = bodypart,
        clauses = {
            {
                id = "healthy",
                text = label,
                color = "c_light_gray",
                when = predicate.negate(predicate.has_effect("speaker", "infected")),
            },
            { id = "infected", text = label, color = "c_green", when = predicate.has_effect("speaker", "infected") },
        },
    }
end

bodypart_widget("l_bp_HD", "head", ccb.content.text("HD:"))
bodypart_widget("l_bp_CT", "torso", ccb.content.text("CT:"))
bodypart_widget("l_bp_LA", "arm_l", ccb.content.text("LA:"))
bodypart_widget("l_bp_RA", "arm_r", ccb.content.text("RA:"))
bodypart_widget("l_bp_LL", "leg_l", ccb.content.text("LL:"))
bodypart_widget("l_bp_RL", "leg_r", ccb.content.text("RL:"))
