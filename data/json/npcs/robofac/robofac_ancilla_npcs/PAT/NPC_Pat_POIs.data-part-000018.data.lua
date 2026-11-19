local ccb = require("ccb")
local predicates = ccb.content.dialogue_predicates

ccb.content.define_dialogue_topic {
    id = "TALK_ROBOFAC_MERC_PAT_POI_radio_tower_reverberation_mp3",
    line = {
        when = predicates.has_mission("MISSION_ROBOFAC_PAT_RECON_11"),
        yes = ccb.content.text("&Your comm is filled with static and your HUD glitches.  Suddenly, the sound of soft, slightly distorted smooth jazz starts to play in your earpiece - it continues for a moment before you hear a chirp and Pat's voice:\n\n\"That's it!  That's the fahkin' sound I hear!  Pal, someone might be nearby with a transmittah, fahkin' with ya'.  There's not much but that radio towah we talked about, so maybe there.  Lock and load.  Ovah.\""),
        no = ccb.content.text("&Your comm is filled with static and your HUD glitches.  Suddenly, the sound of soft, slightly distorted smooth jazz starts to play in your earpiece - it continues for a moment before you hear a chirp and Pat's voice:\n\n\"What was that bullshit?  Pal, someone might be nearby with a transmittah, fahkin' with ya'.  There's not much but a radio towah nearby, so maybe there.  Lock and load.  Ovah.\""),
    },
    replies = {
        {
            text = ccb.content.text("I'll check it out.  Over and out."),
            next_topic = "TALK_ROBOFAC_MERC_PAT_POI_radio_tower_reverberation_mp3_1",
        },
    },
}
