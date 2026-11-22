local ccb = require("ccb")
local actions = ccb.content.dialogue_actions

ccb.content.define_dialogue_topic {
    id = "COMP_labyrinthine_safehouse_computer_blood_tax_yes",
    line = ccb.content.text("&You place your hand on the terminal.  There is a pinch, then a wet, mechanical hiss, as the needle draws a bit of blood.  Your vision blurs."),
    replies = {
        {
            text = ccb.content.text("…"),
            next_topic = "TALK_DONE",
            actions = { actions.handler("w16b_a_dda_b8aaa3e916db") },
        },
    },
}

ccb.content.define_dialogue_topic {
    id = "COMP_labyrinthine_safehouse_computer_blood_tax_reenter_yes",
    line = ccb.content.text("&You place your hand on the terminal.  There is a pinch, then a wet, mechanical hiss, as the needle draws a bit of blood.  Your vision blurs."),
    replies = {
        {
            text = ccb.content.text("…"),
            next_topic = "TALK_DONE",
            actions = { actions.handler("w16b_a_dda_f5a658ff055c") },
        },
    },
}

ccb.content.define_dialogue_topic {
    id = "COMP_labyrinthine_safehouse_missions_boiler",
    line = ccb.content.text("&<color_light_green> @User > update -ELECTRICPOWER\n\n .  .  .  .  .  .  %100\n\n Update to ELECTRIC POWER available from AltarOS remote.  Route a path to cache?  Y/N"),
    replies = {
        {
            text = ccb.content.text("Yes."),
            next_topic = "TALK_DONE",
            actions = { actions.handler("w16b_a_dda_0a191ced8577") },
        },
        {
            text = ccb.content.text("No."),
            next_topic = "COMP_labyrinthine_safehouse_computer",
        },
    },
}

ccb.content.define_dialogue_topic {
    id = "COMP_labyrinthine_safehouse_missions_utility_space",
    line = ccb.content.text("&<color_light_green> @User > update -HUMANDESIRES\n\n .  .  .  .  .  .  %100\n\n Update to HUMAN DESIRES: STORAGE available from AltarOS remote.  New dependencies required.  Download new system obelisk?  Y/N"),
    replies = {
        {
            text = ccb.content.text("Yes."),
            next_topic = "TALK_DONE",
            actions = { actions.handler("w16b_a_dda_ae5f66bc2c88") },
        },
        {
            text = ccb.content.text("No."),
            next_topic = "COMP_labyrinthine_safehouse_computer",
        },
    },
}

ccb.content.define_dialogue_topic {
    id = "COMP_labyrinthine_safehouse_missions_autodoc",
    line = ccb.content.text("&<color_light_green> @User > update -BIONICPOWER\n\n .  .  .  .  .  .  %100\n\n Update to BIONIC PIWER available from AltarOS remote.  New dependencies required.  Download new system obelisk?  Y/N"),
    replies = {
        {
            text = ccb.content.text("Yes."),
            next_topic = "TALK_DONE",
            actions = { actions.handler("w16b_a_dda_2569dac3f303") },
        },
        {
            text = ccb.content.text("No."),
            next_topic = "COMP_labyrinthine_safehouse_computer",
        },
    },
}

ccb.content.define_dialogue_topic {
    id = "COMP_labyrinthine_safehouse_missions_water_cooler",
    line = ccb.content.text("&<color_light_green> @User > update -HUMANNEEDS\n\n .  .  .  .  .  .  %100\n\n Update to HUMAN NEEDS: WATER available from AltarOS remote.  Route a path to cache?  Y/N"),
    replies = {
        {
            text = ccb.content.text("Yes."),
            next_topic = "TALK_DONE",
            actions = { actions.handler("w16b_a_dda_f36272c2c226") },
        },
        {
            text = ccb.content.text("No."),
            next_topic = "COMP_labyrinthine_safehouse_computer",
        },
    },
}

ccb.content.define_dialogue_topic {
    id = "COMP_labyrinthine_safehouse_missions_living_space_1",
    line = ccb.content.text("&<color_light_green> @User > update -HUMANDESIRES\n\n .  .  .  .  .  .  %100\n\n Update to HUMAN DESIRES: LIVING SPACE available from AltarOS remote.  New dependencies required.  Download new system obelisk?  Y/N"),
    replies = {
        {
            text = ccb.content.text("Yes."),
            next_topic = "TALK_DONE",
            actions = { actions.handler("w16b_a_dda_efee32ac911a") },
        },
        {
            text = ccb.content.text("No."),
            next_topic = "COMP_labyrinthine_safehouse_computer",
        },
    },
}
