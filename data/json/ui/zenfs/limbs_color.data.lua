local ccb = require("ccb")
local predicate = ccb.content.dialogue_predicates
local reading = ccb.content.widget_conditions

local function bodypart_widget(id, bodypart, labels)
    ccb.content.define_widget {
        id = id,
        style = "text",
        bodypart = bodypart,
        width = 6,
        default_clause = { id = "normal", text = labels[1] },
        clauses = {
            {
                id = "bandaged_bleeding_bitten",
                text = labels[2],
                when = predicate.all { predicate.has_effect("speaker", "bandaged"), predicate.has_effect("speaker", "bite"), predicate.has_effect("speaker", "bleed", 1) },
            },
            {
                id = "bleedingAndBitten3",
                text = labels[3],
                when = predicate.all { predicate.has_effect("speaker", "bite"), predicate.has_effect("speaker", "bleed", 21) },
            },
            {
                id = "bleedingAndBitten2",
                text = labels[1],
                color = "c_magenta",
                when = predicate.all { predicate.has_effect("speaker", "bite"), predicate.has_effect("speaker", "bleed", 1), reading.compare("effect_intensity", "<", 21, "bleed") },
            },
            {
                id = "bleedingAndBitten1",
                text = labels[1],
                color = "c_pink",
                when = predicate.all { predicate.has_effect("speaker", "bite"), predicate.has_effect("speaker", "bleed", 1), reading.compare("effect_intensity", "<", 11, "bleed") },
            },
            {
                id = "bandaged_bleeding",
                text = labels[4],
                when = predicate.all { predicate.has_effect("speaker", "bandaged"), predicate.has_effect("speaker", "bleed", 1) },
            },
            { id = "bleeding3", text = labels[5], when = predicate.has_effect("speaker", "bleed", 21) },
            {
                id = "bleeding2",
                text = labels[1],
                color = "c_red",
                when = predicate.all { predicate.has_effect("speaker", "bleed", 11), reading.compare("effect_intensity", "<", 21, "bleed") },
            },
            {
                id = "bleeding1",
                text = labels[1],
                color = "c_light_red",
                when = predicate.all { predicate.has_effect("speaker", "bleed", 1), reading.compare("effect_intensity", "<", 11, "bleed") },
            },
            {
                id = "bandaged_infected",
                text = labels[6],
                when = predicate.all { predicate.has_effect("speaker", "bandaged"), predicate.has_effect("speaker", "infected") },
            },
            { id = "infected", text = labels[1], color = "c_green", when = predicate.has_effect("speaker", "infected") },
            {
                id = "bandaged_bitten",
                text = labels[7],
                when = predicate.all { predicate.has_effect("speaker", "bandaged"), predicate.has_effect("speaker", "bite") },
            },
            { id = "bitten", text = labels[1], color = "c_blue", when = predicate.has_effect("speaker", "bite") },
            { id = "bandaged", text = labels[8], when = predicate.has_effect("speaker", "bandaged") },
        },
        flags = { "W_NO_LABEL" },
    }
end

bodypart_widget("zenfs_bp_head_text", "head", {
    ccb.content.text("HEAD  "),
    ccb.content.text("<color_pink_white>HEAD </color> "),
    ccb.content.text("<color_pink_red>HEAD </color> "),
    ccb.content.text("<color_light_red_white>HEAD </color> "),
    ccb.content.text("<color_light_red_red>HEAD </color> "),
    ccb.content.text("<color_green_white>HEAD </color> "),
    ccb.content.text("<color_blue_white>HEAD </color> "),
    ccb.content.text("<color_white_white>HEAD </color> "),
})
bodypart_widget("zenfs_bp_torso_text", "torso", {
    ccb.content.text("TORSO "),
    ccb.content.text("<color_pink_white>TORSO</color> "),
    ccb.content.text("<color_pink_red>TORSO</color> "),
    ccb.content.text("<color_light_red_white>TORSO</color> "),
    ccb.content.text("<color_light_red_red>TORSO</color> "),
    ccb.content.text("<color_green_white>TORSO</color> "),
    ccb.content.text("<color_blue_white>TORSO</color> "),
    ccb.content.text("<color_white_white>TORSO</color> "),
})
bodypart_widget("zenfs_bp_larm_text", "arm_l", {
    ccb.content.text("L.ARM "),
    ccb.content.text("<color_pink_white>L.ARM</color> "),
    ccb.content.text("<color_pink_red>L.ARM</color> "),
    ccb.content.text("<color_light_red_white>L.ARM</color> "),
    ccb.content.text("<color_light_red_red>L.ARM</color> "),
    ccb.content.text("<color_green_white>L.ARM</color> "),
    ccb.content.text("<color_blue_white>L.ARM</color> "),
    ccb.content.text("<color_white_white>L.ARM</color> "),
})
bodypart_widget("zenfs_bp_rarm_text", "arm_r", {
    ccb.content.text("R.ARM "),
    ccb.content.text("<color_pink_white>R.ARM</color> "),
    ccb.content.text("<color_pink_red>R.ARM</color> "),
    ccb.content.text("<color_light_red_white>R.ARM</color> "),
    ccb.content.text("<color_light_red_red>R.ARM</color> "),
    ccb.content.text("<color_green_white>R.ARM</color> "),
    ccb.content.text("<color_blue_white>R.ARM</color> "),
    ccb.content.text("<color_white_white>R.ARM</color> "),
})
bodypart_widget("zenfs_bp_lleg_text", "leg_l", {
    ccb.content.text("L.LEG "),
    ccb.content.text("<color_pink_white>L.LEG</color> "),
    ccb.content.text("<color_pink_red>L.LEG</color> "),
    ccb.content.text("<color_light_red_white>L.LEG</color> "),
    ccb.content.text("<color_light_red_red>L.LEG</color> "),
    ccb.content.text("<color_green_white>L.LEG</color> "),
    ccb.content.text("<color_blue_white>L.LEG</color> "),
    ccb.content.text("<color_white_white>L.LEG</color> "),
})
bodypart_widget("zenfs_bp_rleg_text", "leg_r", {
    ccb.content.text("R.LEG "),
    ccb.content.text("<color_pink_white>R.LEG</color> "),
    ccb.content.text("<color_pink_red>R.LEG</color> "),
    ccb.content.text("<color_light_red_white>R.LEG</color> "),
    ccb.content.text("<color_light_red_red>R.LEG</color> "),
    ccb.content.text("<color_green_white>R.LEG</color> "),
    ccb.content.text("<color_blue_white>R.LEG</color> "),
    ccb.content.text("<color_white_white>R.LEG</color> "),
})
