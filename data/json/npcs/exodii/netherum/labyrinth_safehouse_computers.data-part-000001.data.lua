local ccb = require("ccb")

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
