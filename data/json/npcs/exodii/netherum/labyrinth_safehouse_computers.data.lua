local ccb = require("ccb")
local predicates = ccb.content.dialogue_predicates
local actions = ccb.content.dialogue_actions

ccb.content.define_dialogue_topic {
    id = "COMP_labyrinthine_safehouse_computer_meeting",
    line = ccb.content.text("& █████╗ ██╗  ████████╗ █████╗ ██████╗      ██████╗ ███████╗\n██╔══██╗██║  ╚══██╔══╝██╔══██╗██╔══██╗    ██╔═══██╗██╔════╝\n███████║██║     ██║   ███████║██████╔╝    ██║   ██║███████╗\n██╔══██║██║     ██║   ██╔══██║██╔══██╗    ██║   ██║╚════██║\n██║  ██║███████╗██║   ██║  ██║██║  ██║    ╚██████╔╝███████║\n╚═╝  ╚═╝╚══════╝╚═╝   ╚═╝  ╚═╝╚═╝  ╚═╝     ╚═════╝ ╚══════╝\n\nWelcome ᴴᵁᴹᴬᴺ, to your home ᵃʷᵃʸ ᶠʳᵒᵐ ʰᵒᵐᵉ.\n\nThis is a ˡᵒᵃᵈᴵⁿᵍ ᵖʳᴼᵍʳᵃᵐ.\n\nThis is the ᵐᵉᵈᴵᵘᵐ ᵖˡᵃᶜᵉ.\n\nᵖˡᵉᵃˢᵉ make yourself at home.\n\n @AltarOS > skill -ELEVATE -@User\n\n @User > _"),
    replies = {
        {
            text = ccb.content.text("[Step closer to the terminal and touch the keyboard]"),
            next_topic = "COMP_labyrinthine_safehouse_computer",
            actions = { actions.set_actor_value("speaker", "traveled_to_labyrinth_safehouse", "yes") },
        },
        {
            text = ccb.content.text("[Step away from the terminal]"),
            next_topic = "TALK_DONE",
            actions = { actions.set_actor_value("speaker", "traveled_to_labyrinth_safehouse", "yes") },
        },
    },
}

ccb.content.define_dialogue_topic {
    id = "COMP_labyrinthine_safehouse_computer_meeting_scenario_trapped_in_labyrinth",
    line = ccb.content.text("& █████╗ ██╗  ████████╗ █████╗ ██████╗      ██████╗ ███████╗\n██╔══██╗██║  ╚══██╔══╝██╔══██╗██╔══██╗    ██╔═══██╗██╔════╝\n███████║██║     ██║   ███████║██████╔╝    ██║   ██║███████╗\n██╔══██║██║     ██║   ██╔══██║██╔══██╗    ██║   ██║╚════██║\n██║  ██║███████╗██║   ██║  ██║██║  ██║    ╚██████╔╝███████║\n╚═╝  ╚═╝╚══════╝╚═╝   ╚═╝  ╚═╝╚═╝  ╚═╝     ╚═════╝ ╚══════╝\n\nWelcome ᴴᵁᴹᴬᴺ, to your home ᵃʷᵃʸ ᶠʳᵒᵐ ʰᵒᵐᵉ.\n\nThis is a ˡᵒᵃᵈᴵⁿᵍ ᵖʳᴼᵍʳᵃᵐ.\n\nThis is the ᵐᵉᵈᴵᵘᵐ ᵖˡᵃᶜᵉ.\n\nYou were saved from your peril.\n\nYour new implants were necessary to stabilize your reality.\n\nᵖˡᵉᵃˢᵉ make yourself at home.\n\n @AltarOS > skill -ELEVATE -@User\n\n @User > _"),
    replies = {
        {
            text = ccb.content.text("[Step closer to the terminal and touch the keyboard]"),
            next_topic = "COMP_labyrinthine_safehouse_computer",
            actions = { actions.set_actor_value("speaker", "traveled_to_labyrinth_safehouse", "yes") },
        },
        {
            text = ccb.content.text("[Step away from the terminal]"),
            next_topic = "TALK_DONE",
            actions = { actions.set_actor_value("speaker", "traveled_to_labyrinth_safehouse", "yes") },
        },
    },
}

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

ccb.content.define_dialogue_topic {
    id = "COMP_labyrinthine_safehouse_computer_missions_help",
    line = {
        choices = {
            ccb.content.text("&<color_light_green> @User > update -help\n</color> update: update\n   Search for and prepare updates for the ʰᵒᵐᵉ.\n   If a useful update is available, AltarOS will download the update or make a route to the cache, making it possible for ᴴᵁᴹᴬᴺ to access the update package.\n   Your system obelisk will provide instructions on site."),
            ccb.content.text("&<color_light_green> @User > update -help\n</color> update: update\n   Search for and prepare updates for the ʰᵒᵐᵉ.\n   If a useful update is available, AltarOS will download the update or make a route to the cache, making it possible for hᵤmₐn to access the update package.\n   Your system obelisk will provide instructions on site."),
            ccb.content.text("&<color_light_green> @User > update -help\n</color> update: update\n   Search for and prepare updates for the ʰᵒᵐᵉ.\n   If a useful update is available, AltarOS will download the update or make a route to the cache, making it possible for ᴴᵁᴹᴬᴺ to access the update package.\n   Your system obelisk will provide instructions on site.  ᵃˢˢʰᵒˡᵉ"),
            ccb.content.text("&<color_light_green> @User > update -help\n</color> update: update\n   Search for and prepare updates for the ʰᵒᵐᵉ.\n   If a useful update is available, AltarOS will download the update or make a route to the cache, making it possible for ᴴᵁᴹᴬᴺ to access the update package.\n   Your system obelisk will provide instructions on site.  Go get them tᵢgₑᵣ"),
            ccb.content.text("&<color_light_green> @User > update -help\n</color> update: update\n   Search for and prepare updates for the ʰᵒᵐᵉ.\n   If a useful update is available, AltarOS will download the update or make a route to the cache, making it possible for ᴴᵁᴹᴬᴺ to access the update package.\n   Your system obelisk will provide instructions on site.  ᵗʳᵉᵃᵈ ᶜᵃʳᵉᶠᵘˡˡʸ"),
            ccb.content.text("&<color_light_green> @User > update -help\n</color> update: update\n   Search for and prepare updates for the ʰᵒᵐᵉ.\n   If a useful update is available, AltarOS will download the update or make a route to the cache, making it possible for ᴴᵁᴹᴬᴺ to access the update package.\n   Your system obelisk will provide instructions on site.  ᵖˡᵉᵃˢᵉ ᵍᵒ"),
        },
    },
    replies = { { text = ccb.content.text("Return."), next_topic = "COMP_labyrinthine_safehouse_computer" } },
}

ccb.content.define_dialogue_topic {
    id = "COMP_labyrinthine_safehouse_computer_stuck_in_labyrinth_help",
    line = {
        choices = {
            ccb.content.text("&<color_light_green> @User > exit -troubleshoot\n</color> EXIT ERROR001\n   It is not currently possible for ᴴᵁᴹᴬᴺ to exit the ʰᵒᵐᵉ and return to gate.\n   You and your home away from home have traveled too far.\n   You are currently operating via AltarOS remote.\n   If you return to an AltarOS local terminal,\n   in a place like where you first entered,\n   contact can be reestablished."),
            ccb.content.text("&<color_light_green> @User > exit -troubleshoot\n</color> EXIT ERROR001\n   It is not currently possible for ᴴᵁᴹᴬᴺ to exit the ʰᵒᵐᵉ and return to gate.\n   You and your home away from home have traveled too far.\n   You are currently operating via AltarOS remote.\n   If you return to an AltarOS local terminal,\n   in a place like where you first entered,\n   contact can be reestablished."),
            ccb.content.text("&<color_light_green> @User > exit -troubleshoot\n</color> EXIT ERROR001\n   It is not currently possible for ᴴᵁᴹᴬᴺ to exit the ʰᵒᵐᵉ and return to gate.\n   You and your home away from home have traveled too far.\n   You are currently operating via AltarOS remote.\n   If you return to an AltarOS local terminal,\n   in a place like where you first entered,\n   contact can be reestablished.  ᵃˢˢʰᵒˡᵉ"),
            ccb.content.text("&<color_light_green> @User > exit -troubleshoot\n</color> EXIT ERROR001\n   It is not currently possible for ᴴᵁᴹᴬᴺ to exit the ʰᵒᵐᵉ and return to gate.\n   You and your home away from home have traveled too far.\n   You are currently operating via AltarOS remote.\n   If you return to an AltarOS local terminal,\n   in a place like where you first entered,\n   contact can be reestablished.  ᵗʳᵉᵃᵈ ᶜᵃʳᵉᶠᵘˡˡʸ"),
            ccb.content.text("&<color_light_green> @User > exit -troubleshoot\n</color> EXIT ERROR001\n   It is not currently possible for ᴴᵁᴹᴬᴺ to exit the ʰᵒᵐᵉ and return to gate.\n   You and your home away from home have traveled too far.\n   You are currently operating via AltarOS remote.\n   If you return to an AltarOS local terminal,\n   in a place like where you first entered,\n   contact can be reestablished.  ᵖˡᵉᵃˢᵉ DON'T ᵍᵒ"),
            ccb.content.text("&<color_light_green> @User > exit -troubleshoot\n</color> EXIT ERROR001\n   It is not currently possible for ᴴᵁᴹᴬᴺ to exit the ʰᵒᵐᵉ and return to gate.\n   You and your home away from home have traveled too far.\n   You are currently operating via AltarOS remote.\n   If you return to an AltarOS local terminal,\n   in a place like where you first entered,\n   contact can be reestablished.  STAY STAY STAY STAY"),
            ccb.content.text("&<color_light_green> @User > exit -troubleshoot\n</color> EXIT ERROR001\n   It is not currently possible for ᴴᵁᴹᴬᴺ to exit the ʰᵒᵐᵉ and return to gate.\n   You and your home away from home have traveled too far.\n   You are currently operating via AltarOS remote.\n   If you return to an AltarOS local terminal,\n   in a place like where you first entered,\n   contact can be reestablished.  maybe"),
        },
    },
    replies = { { text = ccb.content.text("Return."), next_topic = "COMP_labyrinthine_safehouse_computer" } },
}

ccb.content.define_dialogue_topic {
    id = "COMP_labyrinthine_safehouse_computer_stuck_in_labyrinth_help_2",
    line = {
        choices = {
            ccb.content.text("&<color_light_green> @User > exit -troubleshoot\n</color> EXIT ERROR002\n   It is not currently possible for ᴴᵁᴹᴬᴺ to exit the ʰᵒᵐᵉ and recalibrate to their own reality.\n   You and your home away from home have traveled too far.\n   You are currently operating via AltarOS remote.\n   If you return to an AltarOS local terminal,\n   in a place like where you first entered,\n   contact can be reestablished."),
            ccb.content.text("&<color_light_green> @User > exit -troubleshoot\n</color> EXIT ERROR002\n   It is not currently possible for ᴴᵁᴹᴬᴺ to exit the ʰᵒᵐᵉ and recalibrate to their own reality.\n   You and your home away from home have traveled too far.\n   You are currently operating via AltarOS remote.\n   If you return to an AltarOS local terminal,\n   in a place like where you first entered,\n   contact can be reestablished."),
            ccb.content.text("&<color_light_green> @User > exit -troubleshoot\n</color> EXIT ERROR002\n   It is not currently possible for ᴴᵁᴹᴬᴺ to exit the ʰᵒᵐᵉ and recalibrate to their own reality.\n   You and your home away from home have traveled too far.\n   You are currently operating via AltarOS remote.\n   If you return to an AltarOS local terminal,\n   in a place like where you first entered,\n   contact can be reestablished.  ᵗʳᵉᵃᵈ ᶜᵃʳᵉᶠᵘˡˡʸ"),
            ccb.content.text("&<color_light_green> @User > exit -troubleshoot\n</color> EXIT ERROR002\n   It is not currently possible for ᴴᵁᴹᴬᴺ to exit the ʰᵒᵐᵉ and recalibrate to their own reality.\n   You and your home away from home have traveled too far.\n   You are currently operating via AltarOS remote.\n   If you return to an AltarOS local terminal,\n   in a place like where you first entered,\n   contact can be reestablished.  maybe"),
        },
    },
    replies = { { text = ccb.content.text("Return."), next_topic = "COMP_labyrinthine_safehouse_computer" } },
}

ccb.content.define_dialogue_topic {
    id = "COMP_labyrinthine_safehouse_missions_none",
    line = {
        choices = {
            ccb.content.text("&<color_light_green> @User > update\n\n.  .  .  .  .  .  %100\n\nNo updates available."),
            ccb.content.text("&<color_light_green> @User > update\n\n.  .  .  .  .  .  %100\n\nNo updates available, ᴴᵁᴹᴬᴺ."),
            ccb.content.text("&<color_light_green> @User > update\n\n.  .  .  .  .  .  %100\n\nNo updates available, hᵤmₐn."),
            ccb.content.text("&<color_light_green> @User > update\n\n.  .  .  .  .  .  %100\n\nNo updates available, tᵢgₑᵣ."),
            ccb.content.text("&<color_light_green> @User > update\n\n.  .  .  .  .  .  %100\n\nNo updates available.          ᵃˢˢʰᵒˡᵉ"),
        },
    },
    replies = { { text = ccb.content.text("Return."), next_topic = "COMP_labyrinthine_safehouse_computer" } },
}

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
