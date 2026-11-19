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
