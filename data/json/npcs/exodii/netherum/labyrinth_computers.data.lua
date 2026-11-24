local ccb = require("ccb")
local predicates = ccb.content.dialogue_predicates
local actions = ccb.content.dialogue_actions

ccb.content.define_dialogue_topic {
    id = "COMP_LS_Exit_Controls",
    line = ccb.content.text("&You see a strangely mundane black computer screen, with a blinking green cursor awaiting input.\n\n<color_light_green> @User > _</color>"),
    replies = {
        {
            text = ccb.content.text("<color_yellow>Activate exit protocol: Home ᵃʷᵃʸ ᶠʳᵒᵐ ʰᵒᵐᵉ"),
            when = predicates.any_equal({ "yes", { scope = "speaker", key = "traveled_safehouse_to_labyrinth" } }),
            next_topic = "COMP_LS_Exit_Controls2_safehouse",
        },
        {
            text = ccb.content.text("<color_red>Activate exit protocol: Earth gate"),
            when = predicates.any_equal({ "yes", { scope = "speaker", key = "traveled_home_to_labyrinth" } }),
            next_topic = "COMP_LS_Exit_Controls2_home",
        },
        {
            text = ccb.content.text("<color_red>Activate exit protocol: KÁ gate"),
            when = predicates.any_equal({ "yes", { scope = "speaker", key = "traveled_string_dimension_to_labyrinth" } }),
            next_topic = "COMP_LS_Exit_Controls2_string_dimension",
        },
        { text = ccb.content.text("<color_light_green>Log off"), next_topic = "TALK_DONE" },
    },
}

ccb.content.define_dialogue_topic {
    id = "COMP_LS2_MAP",
    line = ccb.content.text("&<color_light_green> AltarOS map-node ONLINE.\n<color_light_green> Connection to AltarOS remote FAILED.\n<color_light_green> @User > _"),
    replies = {
        { text = ccb.content.text("Download map data."), next_topic = "COMP_LS2_MAP_2" },
        { text = ccb.content.text("Log off."), next_topic = "TALK_DONE" },
    },
}

ccb.content.define_dialogue_topic {
    id = "COMP_LS2_MAP_2",
    line = ccb.content.text("&<color_light_green> @User > map get --update\n<color_light_green> Error: Insufficient confidence.  Blood tax requested.\n\n</color>A drawer on the side of the terminal slides open, revealing a a bloodstained stone with the outline of a human hand."),
    replies = {
        {
            text = ccb.content.text("[Place your hand on the stone]"),
            next_topic = "TALK_DONE",
            actions = { actions.handler("dlg_a_dda_f8667a737fe5") },
        },
        {
            text = ccb.content.text("Log off."),
            next_topic = "TALK_DONE",
        },
    },
}

ccb.content.define_dialogue_topic {
    id = "COMP_LS_Passcode_Door",
    line = ccb.content.text("&You see a strangely mundane black computer screen, with a blinking green cursor awaiting input.\n\n<color_light_green> @User > _</color>"),
    replies = {
        {
            text = ccb.content.text("Unlock connected doors"),
            next_topic = "COMP_LS_Passcode_Door2",
            when = predicates.handler("dlg_p_dda_71a22aa1f1e5"),
            actions = { actions.handler("dlg_a_dda_a367c3d39b59") },
        },
        {
            text = ccb.content.text("Lock connected doors"),
            next_topic = "COMP_LS_Passcode_Door3",
            when = predicates.handler("dlg_p_dda_030d3a2a8399"),
            actions = { actions.handler("dlg_a_dda_d9abc3d845b3") },
        },
        {
            text = ccb.content.text("Unlock connected doors"),
            next_topic = "COMP_LS_Passcode_Door4",
            when = predicates.handler("dlg_p_dda_2cae08f533b6"),
        },
        {
            text = ccb.content.text("Now all the doors are *gone*, what the hell."),
            next_topic = "COMP_LS_Passcode_Door5",
            when = predicates.handler("dlg_p_dda_01a3d73e8fc7"),
        },
        {
            text = ccb.content.text("Log off."),
            next_topic = "TALK_DONE",
        },
    },
}

ccb.content.define_dialogue_topic {
    id = "COMP_LS_Passcode_Door2",
    line = ccb.content.text("&<color_light_green> @User > doorstatus --update=unlock\n<color_light_green>Command accepted.\n<color_light_green>Nearby doors unlocked.\n<color_light_green>Thank you for using AltarOS.\n\n<color_light_green> @User > _"),
    replies = {
        {
            text = ccb.content.text("Log off."),
            next_topic = "TALK_DONE",
            actions = { actions.handler("w16b_a_dda_c965521e93b8") },
        },
    },
}

ccb.content.define_dialogue_topic {
    id = "COMP_LS_Passcode_Door3",
    line = ccb.content.text("&<color_light_green> @User > doorstatus --update=lock\n<color_light_green>Command accepted.\n<color_light_green>Nearby doors locked.\n<color_light_green>Warning: What is done cannot be undone.  This does not represent a return to how things were.  You can never go back.\n\n<color_light_green> @User > _"),
    replies = {
        {
            text = ccb.content.text("Log off."),
            next_topic = "TALK_DONE",
            actions = { actions.handler("w16b_a_dda_602258923b5d") },
        },
    },
}

ccb.content.define_dialogue_topic {
    id = "COMP_LS_Passcode_Door4",
    line = ccb.content.text("&<color_light_green> @User > doorstatus --update=unlock\n<color_light_green>Bad command or file name.\n<color_light_green>What is done cannot be undone.  Please see prior user warning.\n\n<color_light_green> @User > _"),
    replies = {
        {
            text = ccb.content.text("There must be some way to force the computer to do it."),
            next_topic = "COMP_LS_Passcode_Door4sudo",
        },
        { text = ccb.content.text("Log off."), next_topic = "TALK_DONE" },
    },
}

ccb.content.define_dialogue_topic {
    id = "COMP_LS_Passcode_Door4sudo",
    line = ccb.content.text("&<color_light_green> @User > doorstatus --update=unlock --force\n<color_light_green>Error: Insufficient confidence.\n<color_light_green>Aborted: No forceable process.\n @User > sudo doorstatus --update=unlock\n<color_light_green>Oh, is that how it will be?  Very well.\n<color_light_green>Blood tax requested.\nA drawer on the side of the terminal slides open, revealing a small, thin needle.\n\n<color_light_green> @User > _"),
    replies = {
        {
            text = ccb.content.text("[ Prick yourself on the needle ]"),
            next_topic = "COMP_LS_Passcode_Door4blood",
            actions = { actions.handler("dlg_a_dda_3844a4c79ca6") },
        },
        {
            text = ccb.content.text("Log off."),
            next_topic = "TALK_DONE",
        },
    },
}

ccb.content.define_dialogue_topic {
    id = "COMP_LS_Passcode_Door4blood",
    line = ccb.content.text("&As it enters your skin, the thin needle seems to pulse, greedily gulping from your offered hand, and you feel abruptly dizzy and lightheaded.  It feels like it took a *lot* of blood.\n\n<color_light_green> @User > Inflict --damage=lifeblood\n<color_light_green>Processing contribution of reality ||||||||| 100%\n<color_light_green>Nearby doors unlocked.\n\n<color_light_green> @User > _"),
    replies = {
        {
            text = ccb.content.text("Log off."),
            next_topic = "TALK_DONE",
            actions = { actions.handler("w16b_a_dda_ab90db3ee21f") },
        },
    },
}

ccb.content.define_dialogue_topic {
    id = "COMP_LS_Passcode_Door5",
    line = ccb.content.text("&<color_light_green> @User > doorstatus --list\n<color_light_green>12 drwxr-xr-x 1 @User\n<color_light_green>File lost or deleted.\n<color_light_green>A new, stronger reality has supplanted the previous.  Thank you for using AltarOS.\n<color_light_green> @User > _"),
    replies = { { text = ccb.content.text("Log off."), next_topic = "TALK_DONE" } },
}

ccb.content.define_dialogue_topic {
    id = { "COMP_LS_Bridge_control_deadend_1", "COMP_LS_Bridge_control_deadend_1_Retract", "COMP_LS_Bridge_control_deadend_1_Extend_nopasscode" },
    replies = {
        {
            text = ccb.content.text("Enter the Thief's Passcode to extend the bridge."),
            next_topic = "COMP_LS_Bridge_control_deadend_1_Extend_passcode0",
            when = predicates.handler("dlg_p_dda_d7ff7f872ba8"),
            actions = { actions.handler("dlg_a_dda_b9e11b3b4756") },
        },
        {
            text = ccb.content.text("Enter the Circle of Wings Passcode to extend the bridge."),
            next_topic = "COMP_LS_Bridge_control_deadend_1_Extend_passcode1",
            when = predicates.handler("dlg_p_dda_5297030f1842"),
            actions = { actions.handler("dlg_a_dda_6015d8edf9b2") },
        },
        {
            text = ccb.content.text("Enter the Hard Nails Passcode to extend the bridge."),
            next_topic = "COMP_LS_Bridge_control_deadend_1_Extend_passcode2",
            when = predicates.handler("dlg_p_dda_b1655aa596fc"),
            actions = { actions.handler("dlg_a_dda_511bfe0a2f04") },
        },
        {
            text = ccb.content.text("Enter the Laughing Man Passcode to extend the bridge."),
            next_topic = "COMP_LS_Bridge_control_deadend_1_Extend_passcode3",
            when = predicates.handler("dlg_p_dda_509946616d1f"),
            actions = { actions.handler("dlg_a_dda_fae4b4269f34") },
        },
        {
            text = ccb.content.text("Try to extend the bridge to the treasure room."),
            next_topic = "COMP_LS_Bridge_control_deadend_1_Extend_nopasscode",
            when = predicates.handler("dlg_p_dda_c0a8dade4e0d"),
        },
        {
            text = ccb.content.text("Retract the bridge"),
            next_topic = "COMP_LS_Bridge_control_deadend_1_Retract",
            when = predicates.handler("dlg_p_dda_7feef9b48ebf"),
        },
        {
            text = ccb.content.text("[Computers] Try to find a way to force it."),
            next_topic = "COMP_LS_Bridge_control_deadend_1_force",
            when = predicates.handler("dlg_p_dda_7bda4c3336de"),
        },
        {
            text = ccb.content.text("Log off."),
            next_topic = "TALK_DONE",
        },
    },
}

ccb.content.define_dialogue_topic {
    id = "COMP_LS_Bridge_control_deadend_1",
    line = ccb.content.text("&You see a strangely mundane black computer screen, with a blinking green cursor awaiting input.\n\n<color_light_green> @User > _</color>"),
}

ccb.content.define_dialogue_topic {
    id = "COMP_LS_Bridge_control_deadend_1_Extend_nopasscode",
    line = ccb.content.text("&<color_light_green> @User > bridge --update=extend\n<color_light_green>Error: No PASSCODE or CONFIDENCE.\n<color_light_green>If you have a PASSCODE, please enter using syntax --pass=\"your password\"\n<color_light_green>If you have not been granted a PASSCODE, contact your system obelisk for help.\n\n<color_light_green> @User > _"),
}

ccb.content.define_dialogue_topic {
    id = "COMP_LS_Bridge_control_deadend_1_Retract",
    line = ccb.content.text("&<color_light_green> @User > bridge --update=retract\n<color_light_green>Error: Insufficient confidence.\n<color_light_green>What is done cannot be undone.\n\n<color_light_green> @User > _</color>"),
    on_enter = {
        { actions = { actions.handler("dlg_a_dda_bbdf5436f867") } },
    },
}

ccb.content.define_dialogue_topic {
    id = "COMP_LS_Bridge_control_deadend_1_Extend_passcode0",
    line = ccb.content.text("&<color_light_green> @User > bridge --update=extend --pass=\"<ls_passcode0>\"\n<color_light_green>Command accepted.\n<color_light_green>Extending bridge.\n<color_light_green>Watch your step.\n\n<color_light_green> @User > _</color>"),
    replies = {
        {
            text = ccb.content.text("Log off."),
            next_topic = "TALK_DONE",
            actions = { actions.handler("w16b_a_dda_4a09dc5c1966") },
        },
    },
}

ccb.content.define_dialogue_topic {
    id = "COMP_LS_Bridge_control_deadend_1_Extend_passcode1",
    line = ccb.content.text("&<color_light_green> @User > bridge --update=extend --pass=\"<ls_passcode1>\"\n<color_light_green>Command accepted.\n<color_light_green>Extending bridge.\n<color_light_green>You are free.\n\n<color_light_green> @User > _</color>"),
    replies = {
        {
            text = ccb.content.text("Log off."),
            next_topic = "TALK_DONE",
            actions = { actions.handler("w16b_a_dda_95ccc09db2d6") },
        },
    },
}

ccb.content.define_dialogue_topic {
    id = "COMP_LS_Bridge_control_deadend_1_Extend_passcode2",
    line = ccb.content.text("&<color_light_green> @User > bridge --update=extend --pass=\"<ls_passcode2>\"\n<color_light_green>Command accepted.\n<color_light_green>Extending bridge.\n<color_light_green>Kick some ass.\n\n<color_light_green> @User > _</color>"),
    replies = {
        {
            text = ccb.content.text("Log off."),
            next_topic = "TALK_DONE",
            actions = { actions.handler("w16b_a_dda_0fe6fdd500c8") },
        },
    },
}

ccb.content.define_dialogue_topic {
    id = "COMP_LS_Bridge_control_deadend_1_Extend_passcode3",
    line = ccb.content.text("&<color_light_green> @User > bridge --update=extend --pass=\"<ls_passcode3>\"\n<color_light_green>Command accepted.\n<color_light_green>Extending bridge.\n<color_light_green>Asshole.\n\n<color_light_green> @User > _</color>"),
    replies = {
        {
            text = ccb.content.text("Log off."),
            next_topic = "TALK_DONE",
            actions = { actions.handler("w16b_a_dda_87ad9d7f3c89") },
        },
    },
}

ccb.content.define_dialogue_topic {
    id = "COMP_LS_Bridge_control_deadend_1_force",
    line = ccb.content.text("&<color_light_green> @User > help --retract\n<color_light_green>Help?  @User help request logged.\n<color_light_green>Error: \"Help\" - implied payment|cost detected.\n<color_light_green>Error: Payment|cost not implemented.  Try again some day.\n\n<color_light_green> @User > _</color>"),
    replies = { { text = ccb.content.text("Log off."), next_topic = "TALK_DONE" } },
}

ccb.content.define_dialogue_topic {
    id = "COMP_LS_Boiler_Exit_Controls",
    line = ccb.content.text("& ▄▄▄· ▄▄▌  ▄▄▄▄▄ ▄▄▄· ▄▄▄            .▄▄ ·\n▐█ ▀█ ██•  •██  ▐█ ▀█ ▀▄ █·    ▪     ▐█ ▀.\n▄█▀▀█ ██▪   ▐█.▪▄█▀▀█ ▐▀▀▄      ▄█▀▄ ▄▀▀▀█▄\n▐█ ▪▐▌▐█▌▐▌ ▐█▌·▐█ ▪▐▌▐█•█▌    ▐█▌.▐▌▐█▄▪▐█\n ▀  ▀ .▀▀▀  ▀▀▀  ▀  ▀ .▀  ▀     ▀█▄▀▪ ▀▀▀▀\n\n @AltarOS > echo -anchor -cargo -nt AUTO\n\n ANCHOR:CARGO RESONANCE LOCK = true.\n\n Start exit protocol.       ᵖˡᵉᵃˢᵉ\n\n @AltarOS > skill -ELEVATE -@User\n\n<color_light_green> @User > _</color>"),
    replies = {
        {
            text = ccb.content.text("<color_light_green>Activate exit protocol: Home ᵃʷᵃʸ ᶠʳᵒᵐ ʰᵒᵐᵉ"),
            next_topic = "COMP_LS_Boiler_Exit_Controls2",
        },
        { text = ccb.content.text("<color_red>Log off"), next_topic = "TALK_DONE" },
    },
}

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
