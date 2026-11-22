local ccb = require("ccb")
local actions = ccb.content.dialogue_actions

ccb.content.define_dialogue_topic {
    id = "TALK_DEFENSE_MODE_PRESET_GAME_MENU",
    replies = {
        {
            text = ccb.content.text("<color_yellow>Assault On Precinct 13</color>: (Hold out against the Exodii with five of your coworkers in your office building.)"),
            next_topic = "TALK_DONE",
            actions = { actions.handler("dlg_a_xedra_evolved_97107ed29271"), actions.update_map("precinct_13_spawns") },
        },
    },
}
