local ccb = require("ccb")
local actions = ccb.content.dialogue_actions

ccb.content.define_dialogue_topic {
    id = "COMP_LS_Boiler_Exit_Controls2",
    line = ccb.content.text("&<color_light_green> @User > sudo skill -EXIT -@User -RESONANCE_ANCHOR</color>\n\n Exit with the coupled device?  You will <color_red>never</color> see this exact place again."),
    replies = {
        {
            text = ccb.content.text("Yes."),
            next_topic = "TALK_DONE",
            actions = { actions.handler("w16b_a_dda_508f5a2dd523") },
        },
        {
            text = ccb.content.text("No."),
            next_topic = "TALK_DONE",
        },
    },
}

ccb.content.define_dialogue_topic {
    id = "COMP_LS_Water_Cooler_Exit_Controls",
    line = ccb.content.text("&This would almost look like an earthly water cooler, except the base is made up of cobbled together scrap metal, and the tank is a clouded fishbowl of green liquid.  Where the tap would be is a thin, sharp spike, feeding a dribble-tube that vanishes into the tank.  As you approach, some lights flicker, and a beam of light from some unseen projector casts an image upon the bulbous tank.\n\n\n  ▄▄▄       ██▓  ▄▄▄█████▓ ▄▄▄       ██▀███      ▒█████    ██████ \n▒████▄    ▓██▒  ▓  ██▒ ▓▒▒████▄    ▓██ ▒ ██▒   ▒██▒  ██▒▒██    ▒ \n▒██  ▀█▄  ▒██░  ▒ ▓██░ ▒░▒██  ▀█▄  ▓██ ░▄█ ▒   ▒██░  ██▒░ ▓██▄   \n░██▄▄▄▄██ ▒██░  ░ ▓██▓ ░ ░██▄▄▄▄██ ▒██▀▀█▄     ▒██   ██░  ▒   ██▒\n ▓█   ▓██▒░██████▒▒██▒ ░  ▓█   ▓██▒░██▓ ▒██▒   ░ ████▓▒░▒██████▒▒\n ▒▒   ▓▒█░░ ▒░▓  ░▒ ░░    ▒▒   ▓▒█░░ ▒▓ ░▒▓░   ░ ▒░▒░▒░ ▒ ▒▓▒ ▒ ░\n  ▒   ▒▒ ░░ ░ ▒  ░  ░      ▒   ▒▒ ░  ░▒ ░ ▒░     ░ ▒ ▒░ ░ ░▒  ░ ░\n  ░   ▒     ░ ░   ░        ░   ▒     ░░   ░    ░ ░ ░ ▒  ░  ░  ░  \n      ░  ░    ░  ░             ░  ░   ░            ░ ░        ░  \n\n @AltarOS > Bringing us here is a great service hᵤmₐn.  A blood tax is required to attune the object, and return it to your home ᵃʷᵃʸ ᶠʳᵒᵐ ʰᵒᵐᵉ."),
    replies = {
        {
            text = ccb.content.text("Prick your hand upon the metal spike."),
            next_topic = "TALK_DONE",
            actions = { actions.handler("w16b_a_dda_975fced2d368") },
        },
        {
            text = ccb.content.text("Step away."),
            next_topic = "TALK_DONE",
        },
    },
}
