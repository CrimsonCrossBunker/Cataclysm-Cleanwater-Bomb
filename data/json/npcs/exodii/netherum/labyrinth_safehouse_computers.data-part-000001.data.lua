local ccb = require("ccb")
local predicates = ccb.content.dialogue_predicates
local actions = ccb.content.dialogue_actions

ccb.content.define_dialogue_topic {
    id = "COMP_labyrinthine_safehouse_computer_blood_tax",
    line = ccb.content.text("&<color_light_green> @User > skill -ENTER -@User\n\n<color_light_green> Blood required for reality stabilization.\n\nA drawer on the side of the terminal slides open, revealing a small, thin needle.\n\n<color_light_green> @User > _"),
    replies = {
        {
            text = ccb.content.text("[Prick yourself with the needle]"),
            next_topic = "COMP_labyrinthine_safehouse_computer_blood_tax_yes",
            actions = { actions.handler("dlg_a_dda_eee2a7701d07") },
        },
        {
            text = ccb.content.text("Log off."),
            next_topic = "TALK_DONE",
        },
    },
}

ccb.content.define_dialogue_topic {
    id = "COMP_labyrinthine_safehouse_computer_blood_tax_reenter",
    line = ccb.content.text("&<color_light_green> @User > skill -ENTER -@User\n\n<color_light_green> Blood required for reality stabilization.\n\nA drawer on the side of the terminal slides open, revealing a small, thin needle.\n\n<color_light_green> @User > _"),
    replies = {
        {
            text = ccb.content.text("[Prick yourself with the needle]"),
            next_topic = "COMP_labyrinthine_safehouse_computer_blood_tax_reenter_yes",
            actions = { actions.handler("dlg_a_dda_78acb5e38a82") },
        },
        {
            text = ccb.content.text("Log off."),
            next_topic = "TALK_DONE",
        },
    },
}

ccb.content.define_dialogue_topic {
    id = "COMP_labyrinthine_safehouse_missions_list",
    line = ccb.content.text("&<color_light_green> @User > update\n\n .  .  .  .  .  .  %100\n\n Update available from AltarOS remote."),
    replies = {
        {
            text = ccb.content.text("Help."),
            next_topic = "COMP_labyrinthine_safehouse_computer_missions_help",
        },
        {
            text = ccb.content.text("[Update ELECTRIC POWER available]"),
            next_topic = "COMP_labyrinthine_safehouse_missions_boiler",
            when = predicates.handler("dlg_p_dda_0149c21f0837"),
        },
        {
            text = ccb.content.text("[Update BIONIC POWER available]"),
            next_topic = "COMP_labyrinthine_safehouse_missions_autodoc",
            when = predicates.handler("dlg_p_dda_3ab4e518ac76"),
        },
        {
            text = ccb.content.text("[Update HUMAN DESIRES: STORAGE available]"),
            next_topic = "COMP_labyrinthine_safehouse_missions_utility_space",
            when = predicates.handler("dlg_p_dda_b7bda76e75e3"),
        },
        {
            text = ccb.content.text("[Update HUMAN NEEDS: WATER available]"),
            next_topic = "COMP_labyrinthine_safehouse_missions_water_cooler",
            when = predicates.handler("dlg_p_dda_75e73dcead33"),
        },
        {
            text = ccb.content.text("[Update HUMAN DESIRES: LIVING SPACE available]"),
            next_topic = "COMP_labyrinthine_safehouse_missions_living_space_1",
            when = predicates.handler("dlg_p_dda_ded7872af108"),
        },
        {
            text = ccb.content.text("Exit."),
            next_topic = "COMP_labyrinthine_safehouse_computer",
        },
    },
}
