local ccb = require("ccb")
local predicates = ccb.content.dialogue_predicates
local actions = ccb.content.dialogue_actions

ccb.content.define_dialogue_topic {
    id = "COMP_LS_Exit_Controls2_safehouse",
    line = ccb.content.text("&<color_light_green> @User > skill -EXIT -@User\n<color_light_green>Really exit?  You will not be able to return to the same place."),
    replies = {
        {
            text = ccb.content.text("Yes."),
            next_topic = "TALK_DONE",
            actions = { actions.set_actor_value("speaker", "stuck_in_labyrinth", "no"), actions.handler("w16b_a_dda_22211a43a198") },
        },
        {
            text = ccb.content.text("No."),
            next_topic = "TALK_DONE",
        },
    },
}

ccb.content.define_dialogue_topic {
    id = "COMP_LS_Exit_Controls_Temp_overgrown",
    line = {
        when = predicates.any_equal({ "yes", { scope = "speaker", key = "traveled_safehouse_to_labyrinth" } }),
        yes = {
            choices = {
                ccb.content.text("&You see a computer terminal with slender vines growing out of its case.\n\n<color_light_green> AltarOS remote connected\n\n Home ᵃʷᵃʸ ᶠʳᵒᵐ ʰᵒᵐᵉ translocated to this string\n\n @User > _</color>"),
                ccb.content.text("&You see a computer terminal with slender vines growing out of its case.\n\n<color_light_green> AltarOS remote connected\n\n Home ᵃʷᵃʸ ᶠʳᵒᵐ ʰᵒᵐᵉ translocated to this node\n\n @User > _</color>"),
                ccb.content.text("&You see a computer terminal with slender vines growing out of its case.\n\n<color_light_green> AltarOS remote connected\n\n Home ᵃʷᵃʸ ᶠʳᵒᵐ ʰᵒᵐᵉ translocated to this dimension\n\n @User > _</color>"),
                ccb.content.text("&You see a computer terminal with slender vines growing out of its case.\n\n<color_light_green> AltarOS remote connected\n\n Home ᵃʷᵃʸ ᶠʳᵒᵐ ʰᵒᵐᵉ translocated to this universe\n\n @User > _</color>"),
                ccb.content.text("&You see a computer terminal with slender vines growing out of its case.\n\n<color_light_green> AltarOS remote connected\n\n Home ᵃʷᵃʸ ᶠʳᵒᵐ ʰᵒᵐᵉ attuned to this string\n\n @User > _</color>"),
                ccb.content.text("&You see a computer terminal with slender vines growing out of its case.\n\n<color_light_green> AltarOS remote connected\n\n Home ᵃʷᵃʸ ᶠʳᵒᵐ ʰᵒᵐᵉ attuned to this node\n\n @User > _</color>"),
                ccb.content.text("&You see a computer terminal with slender vines growing out of its case.\n\n<color_light_green> AltarOS remote connected\n\n Home ᵃʷᵃʸ ᶠʳᵒᵐ ʰᵒᵐᵉ attuned to this dimension\n\n @User > _</color>"),
                ccb.content.text("&You see a computer terminal with slender vines growing out of its case.\n\n<color_light_green> AltarOS remote connected\n\n Home ᵃʷᵃʸ ᶠʳᵒᵐ ʰᵒᵐᵉ attuned to this universe\n\n @User > _</color>"),
                ccb.content.text("&You see a computer terminal with slender vines growing out of its case.\n\n<color_light_green> AltarOS remote connected\n\n Home ᵃʷᵃʸ ᶠʳᵒᵐ ʰᵒᵐᵉ dimensionally anchored\n\n @User > _</color>"),
            },
        },
        no = ccb.content.text("&You see a computer terminal with slender vines growing out of its case.\n\n<color_light_green> AltarOS remote connected\n\n Access granted.  Welcome to your home ᵃʷᵃʸ ᶠʳᵒᵐ ʰᵒᵐᵉ\n\n @User > _</color>"),
    },
    replies = {
        {
            text = ccb.content.text("<color_yellow>Activate exit protocol: Home ᵃʷᵃʸ ᶠʳᵒᵐ ʰᵒᵐᵉ"),
            next_topic = "COMP_LS_Exit_Controls_Temp_overgrown2_safehouse",
            when = predicates.any_equal({ "yes", { scope = "speaker", key = "traveled_safehouse_to_labyrinth" } }),
        },
        {
            text = ccb.content.text("<color_green>Activate exit protocol: Home ᵃʷᵃʸ ᶠʳᵒᵐ ʰᵒᵐᵉ"),
            next_topic = "TALK_DONE",
            when = predicates.negate(predicates.any_equal({ "yes", { scope = "speaker", key = "traveled_safehouse_to_labyrinth" } })),
            actions = { actions.handler("w16b_a_dda_22211a43a198") },
        },
        {
            text = ccb.content.text("<color_light_green>Log off"),
            next_topic = "TALK_DONE",
            when = predicates.any_equal({ "yes", { scope = "speaker", key = "traveled_safehouse_to_labyrinth" } }),
        },
        {
            text = ccb.content.text("<color_red>Log off"),
            next_topic = "TALK_DONE",
            when = predicates.negate(predicates.any_equal({ "yes", { scope = "speaker", key = "traveled_safehouse_to_labyrinth" } })),
        },
    },
}

ccb.content.define_dialogue_topic {
    id = "COMP_LS_Exit_Controls_Temp_overgrown2_safehouse",
    line = ccb.content.text("&<color_light_green> @User > skill -EXIT -@User\n\n<color_light_green> Really exit?  You </color><color_white>will</color><color_light_green> be able to return to this place, but </color><color_white>only</color><color_light_green> to this place."),
    replies = {
        {
            text = ccb.content.text("Yes."),
            next_topic = "TALK_DONE",
            actions = { actions.set_actor_value("speaker", "stuck_in_labyrinth", "yes"), actions.set_actor_value("speaker", "player_location_temp_labyrinth_return_dimension", "netherum_labyrinth2"), actions.handler("w16b_a_dda_96f1fcebedd8") },
        },
        {
            text = ccb.content.text("No."),
            next_topic = "TALK_DONE",
        },
    },
}
