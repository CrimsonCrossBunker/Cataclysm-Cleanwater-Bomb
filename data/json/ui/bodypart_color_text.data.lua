local ccb = require("ccb")
local predicate = ccb.content.dialogue_predicates
local reading = ccb.content.widget_conditions

local function bodypart_widget(id, bodypart, label)
    ccb.content.define_widget {
        id = id,
        bodypart = bodypart,
        style = "text",
        default_clause = { text = label },
        clauses = {
            {
                id = "bleedingAndBitten3",
                text = label,
                color = "magenta_red",
                when = predicate.all { predicate.has_effect("speaker", "bite"), predicate.has_effect("speaker", "bleed", 21) },
            },
            {
                id = "bleedingAndBitten12",
                text = label,
                color = "magenta",
                when = predicate.all { predicate.has_effect("speaker", "bite"), predicate.has_effect("speaker", "bleed", 1), reading.compare("bodypart_effect_intensity", "<", 21, "bleed") },
            },
            { id = "bleeding3", text = label, color = "red_red", when = predicate.has_effect("speaker", "bleed", 21) },
            {
                id = "bleeding2",
                text = label,
                color = "red",
                when = predicate.all { predicate.has_effect("speaker", "bleed", 11), reading.compare("bodypart_effect_intensity", "<", 21, "bleed") },
            },
            {
                id = "bleeding1",
                text = label,
                color = "light_red",
                when = predicate.all { predicate.has_effect("speaker", "bleed", 1), reading.compare("bodypart_effect_intensity", "<", 11, "bleed") },
            },
            { id = "infected", text = label, color = "green", when = predicate.has_effect("speaker", "infected") },
            { id = "bitten", text = label, color = "blue", when = predicate.has_effect("speaker", "bite") },
        },
        flags = { "W_LABEL_NONE" },
    }
end

bodypart_widget("bodypart_head_status_text", "head", ccb.content.text("HEAD "))
bodypart_widget("bodypart_torso_status_text", "torso", ccb.content.text("TORSO"))
bodypart_widget("bodypart_larm_status_text", "arm_l", ccb.content.text("L ARM"))
bodypart_widget("bodypart_rarm_status_text", "arm_r", ccb.content.text("R ARM"))
bodypart_widget("bodypart_lleg_status_text", "leg_l", ccb.content.text("L LEG"))
bodypart_widget("bodypart_rleg_status_text", "leg_r", ccb.content.text("R LEG"))
