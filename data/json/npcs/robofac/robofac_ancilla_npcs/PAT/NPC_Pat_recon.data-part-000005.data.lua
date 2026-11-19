local ccb = require("ccb")
local predicates = ccb.content.dialogue_predicates

ccb.content.define_dialogue_topic {
    id = "MISSION_ROBOFAC_PAT_RECON_11",
    line = {
        when = predicates.any_equal({ "yes", { scope = "speaker", key = "robofac_pat_chatting_on_radio" } }),
        yes = ccb.content.text("Check this out.\"  Pat double clicks an audio file and an old version of Winamp opens up.  The sound starts immediately, but nothing but static fills your earpiece.  Pat stops it after a moment.  \"Nothin', right?  Wrong.  I recorded somethin' - someone talkin' - but it's just gone.  Just not theah.  Somethin's afoot.  I'm pretty sure the source is this radio tower, heah.  Check it out, maybe?"),
        no = ccb.content.text("Check this out.\"  Pat hits play on the recorder, and nothing but static plays for a moment before they stop it.  \"Nothin', right?  Wrong.  I recorded somethin' - someone talkin' - but it's just gone.  Just not theah.  Somethin's afoot.  I'm pretty sure the source is this radio tower, heah.  Check it out, maybe?"),
    },
    replies = { { text = ccb.content.text("Maybe I'll check it out.  Thanks."), next_topic = "TALK_DONE" } },
}

ccb.content.define_dialogue_topic {
    id = "MISSION_ROBOFAC_PAT_RECON_12",
    line = {
        when = predicates.any_equal({ "yes", { scope = "speaker", key = "robofac_pat_chatting_on_radio" } }),
        yes = ccb.content.text("Right, look at this heah.  Merc I talked to said they wandered deep into this fahkin' mine and found all these strange ass spirals.  Even drew a map.\"  Pat uploads a scan of a sketched map to your headset HUD.  \"Fahkah wasn't right in the head, I'll tell ya' that.  Anyway.  Sounds like the kinda strange shit that's right up your alley, though.  Check it out."),
        no = ccb.content.text("Right, look at this heah.  Merc I talked to said they wandered deep into this fahkin' mine and found all these strange ass spirals.  Even drew a map.\"  Pat flips over the paper to show you a sketched map.  \"Fahkah wasn't right in the head, I'll tell ya' that.  Anyway.  Sounds like the kinda strange shit that's right up your alley, though.  Check it out."),
    },
    replies = { { text = ccb.content.text("Maybe I'll check it out.  Thanks."), next_topic = "TALK_DONE" } },
}
