local ccb = require("ccb")
local predicates = ccb.content.dialogue_predicates
local actions = ccb.content.dialogue_actions

ccb.content.define_dialogue_topic {
    id = "COMP_labyrinthine_safehouse_earth_jaunt",
    line = ccb.content.text("&<color_light_green> @User > skill -RECALIBRATE -@User\n\n<color_light_green> Blood required for reality stabilization.\n\n @User > _</color>\n\nA drawer on the side of the terminal slides open, revealing a small, thin needle."),
    replies = {
        {
            text = ccb.content.text("Help."),
            next_topic = "COMP_labyrinthine_safehouse_earth_jaunt_help",
        },
        {
            text = ccb.content.text("[Prick yourself with the needle]"),
            next_topic = "COMP_labyrinthine_safehouse_earth_jaunt2",
            when = predicates.handler("w16b_p_dda_80b5b0d720d2"),
            actions = { actions.handler("w16b_a_dda_813d2b91872f") },
        },
        {
            text = ccb.content.text("ERROR - USER DIMENSIONALLY ANCHORED."),
            next_topic = "COMP_labyrinthine_safehouse_computer",
            when = predicates.handler("w16b_p_dda_0bba7149a4ea"),
        },
        {
            text = ccb.content.text("Return."),
            next_topic = "TALK_DONE",
        },
    },
}

ccb.content.define_dialogue_topic {
    id = "COMP_labyrinthine_safehouse_earth_jaunt_help",
    line = {
        choices = {
            ccb.content.text("&<color_light_green> @User > skill -RECALIBRATE -help\n</color> skill: RECALIBRATE\n   Available if ᴴᵁᴹᴬᴺ is not attuned to their own reality.\n   Blood is required for temporary reality stabilization.\n   The user will return to their reality, then be extracted by AltarOS remote after the estimated time, 4 EARTH HOURS, has elapsed.\n   The user will return to the home away from home.\n   Repeated visits will reattune the user to their own reality.\n   WARNING: Dimensional instability will make ᴴᵁᴹᴬᴺ communication impossible."),
            ccb.content.text("&<color_light_green> @User > skill -RECALIBRATE -help\n</color> skill: RECALIBRATE\n   Available if ᴴᵁᴹᴬᴺ is not attuned to their own reality.\n   Blood is required for temporary reality stabilization.\n   The user will return to their reality, then be extracted by AltarOS remote after the estimated time, 4 EARTH HOURS, has elapsed.\n   The user will return to the home away from home.  ʸᵒᵘ ᶜᵃⁿⁿᵒᵗ ˢᵗᵃʸ\n   Repeated visits will reattune the user to their own reality.\n   WARNING: Dimensional instability will make ᴴᵁᴹᴬᴺ communication impossible."),
            ccb.content.text("&<color_light_green> @User > skill -RECALIBRATE -help\n</color> skill: RECALIBRATE\n   Available if ᴴᵁᴹᴬᴺ is not attuned to their own reality.\n   Blood is required for temporary reality stabilization.\n   The user will return to their reality, then be extracted by AltarOS remote after the estimated time, 4 EARTH HOURS, has elapsed.\n   The user will return to the home away from home.  ᵍᵉᵗ ᵒᵇʲᵉᶜᵗˢ ᶠᵒʳ ᵘˢ\n   Repeated visits will reattune the user to their own reality.\n   WARNING: Dimensional instability will make ᴴᵁᴹᴬᴺ communication impossible."),
            ccb.content.text("&<color_light_green> @User > skill -RECALIBRATE -help\n</color> skill: RECALIBRATE\n   Available if ᴴᵁᴹᴬᴺ is not attuned to their own reality.\n   Blood is required for temporary reality stabilization.\n   The user will return to their reality, then be extracted by AltarOS remote after the estimated time, 4 EARTH HOURS, has elapsed.\n   The user will return to the home away from home.\n   Repeated visits will reattune the user to their own reality.  ᵖᵣₒᵐᵢˢₑ\n   WARNING: Dimensional instability will make ᴴᵁᴹᴬᴺ communication impossible."),
            ccb.content.text("&<color_light_green> @User > skill -RECALIBRATE -help\n</color> skill: RECALIBRATE\n   Available if ᴴᵁᴹᴬᴺ is not attuned to their own reality.\n   Blood is required for temporary reality stabilization.\n   The user will return to their reality, then be extracted by AltarOS remote after the estimated time, 4 EARTH HOURS, has elapsed.\n   The user will return to the home away from home.  ʸᵒᵘ ᶜᵃⁿⁿᵒᵗ ˢᵗᵃʸ\n   Repeated visits will reattune the user to their own reality.  ᵖᵣₒᵐᵢˢₑ\n   WARNING: Dimensional instability will make ᴴᵁᴹᴬᴺ communication impossible."),
            ccb.content.text("&<color_light_green> @User > skill -RECALIBRATE -help\n</color> skill: RECALIBRATE\n   Available if ᴴᵁᴹᴬᴺ is not attuned to their own reality.\n   Blood is required for temporary reality stabilization.\n   The user will return to their reality, then be extracted by AltarOS remote after the estimated time, 4 EARTH HOURS, has elapsed.\n   The user will return to the home away from home.  ᵍᵉᵗ ᵒᵇʲᵉᶜᵗˢ ᶠᵒʳ ᵘˢ\n   Repeated visits will reattune the user to their own reality.  ᵖᵣₒᵐᵢˢₑ\n   WARNING: Dimensional instability will make ᴴᵁᴹᴬᴺ communication impossible."),
            ccb.content.text("&<color_light_green> @User > skill -RECALIBRATE -help\n</color> skill: RECALIBRATE\n   Available if ᴴᵁᴹᴬᴺ is not attuned to their own reality.\n   Blood is required for temporary reality stabilization.\n   The user will return to their reality, then be extracted by AltarOS remote after the estimated time, 4 EARTH HOURS, has elapsed.\n   The user will return to the home away from home.\n   Repeated visits will reattune the user to their own reality.  ᵍʳᵃᵇ ʷʰᵃᵗ ʸᵒᵘ ᶜᵃⁿ\n   WARNING: Dimensional instability will make ᴴᵁᴹᴬᴺ communication impossible."),
            ccb.content.text("&<color_light_green> @User > skill -RECALIBRATE -help\n</color> skill: RECALIBRATE\n   Available if ᴴᵁᴹᴬᴺ is not attuned to their own reality.\n   Blood is required for temporary reality stabilization.\n   The user will return to their reality, then be extracted by AltarOS remote after the estimated time, 4 EARTH HOURS, has elapsed.\n   The user will return to the home away from home.  ʸᵒᵘ ᶜᵃⁿⁿᵒᵗ ˢᵗᵃʸ\n   Repeated visits will reattune the user to their own reality.  ᵍʳᵃᵇ ʷʰᵃᵗ ʸᵒᵘ ᶜᵃⁿ\n   WARNING: Dimensional instability will make ᴴᵁᴹᴬᴺ communication impossible."),
            ccb.content.text("&<color_light_green> @User > skill -RECALIBRATE -help\n</color> skill: RECALIBRATE\n   Available if ᴴᵁᴹᴬᴺ is not attuned to their own reality.\n   Blood is required for temporary reality stabilization.\n   The user will return to their reality, then be extracted by AltarOS remote after the estimated time, 4 EARTH HOURS, has elapsed.\n   The user will return to the home away from home.  ᵍᵉᵗ ᵒᵇʲᵉᶜᵗˢ ᶠᵒʳ ᵘˢ\n   Repeated visits will reattune the user to their own reality.  ᵍʳᵃᵇ ʷʰᵃᵗ ʸᵒᵘ ᶜᵃⁿ\n   WARNING: Dimensional instability will make ᴴᵁᴹᴬᴺ communication impossible."),
        },
    },
    replies = {
        {
            text = ccb.content.text("[Prick yourself with the needle]"),
            next_topic = "COMP_labyrinthine_safehouse_earth_jaunt2",
            when = predicates.handler("w16b_p_dda_80b5b0d720d2"),
            actions = { actions.handler("w16b_a_dda_813d2b91872f") },
        },
        {
            text = ccb.content.text("ERROR - USER DIMENSIONALLY ANCHORED."),
            next_topic = "COMP_labyrinthine_safehouse_computer",
            when = predicates.handler("w16b_p_dda_0bba7149a4ea"),
        },
        {
            text = ccb.content.text("Return."),
            next_topic = "TALK_DONE",
        },
    },
}

ccb.content.define_dialogue_topic {
    id = "COMP_labyrinthine_safehouse_earth_jaunt2",
    line = ccb.content.text("&There is a pinch, then a wet, mechanical hiss, as the needle draws a lot of blood.  Your vision blurs."),
    replies = {
        {
            text = ccb.content.text("…"),
            next_topic = "TALK_DONE",
            actions = { actions.handler("w16b_a_dda_93b9ffb868d3") },
        },
    },
}

ccb.content.define_dialogue_topic {
    id = "COMP_labyrinthine_safehouse_string_dimension_tunnel",
    line = ccb.content.text("&<color_light_green> @User > gatestatus -update -pass KÁ\n\n .  .  .  .  .  .  %100\n\n Passcode accepted.  Route path to node?  Y/N"),
    replies = {
        {
            text = ccb.content.text("Yes."),
            next_topic = "TALK_DONE",
            when = predicates.handler("w16b_p_dda_80b5b0d720d2"),
            actions = { actions.handler("w16b_a_dda_6783710c7166"), actions.set_actor_value("speaker", "stuck_in_labyrinth", "no") },
        },
        {
            text = ccb.content.text("ERROR - USER DIMENSIONALLY ANCHORED."),
            next_topic = "COMP_labyrinthine_safehouse_computer",
            when = predicates.handler("w16b_p_dda_0bba7149a4ea"),
        },
        {
            text = ccb.content.text("No."),
            next_topic = "COMP_labyrinthine_safehouse_computer",
            when = predicates.handler("w16b_p_dda_80b5b0d720d2"),
        },
    },
}
