local ccb = require("ccb")

ccb.content.define_dialogue_topic {
    id = "TALK_ROBOFAC_MERC_PAT_TELL_U_CYBORG_HUB01_AR_INFOLINK_INSTALLED",
    line = ccb.content.text("&Pat plugs their laptop into your USB port and starts to clack away.  After 10 minutes, you hear a BEEP.  Your Infolink resets, and Pat unplugs you.  \"All done.  The Hub made that shit theah easy.  All I had to do… well, it isn't impahtant.  Should be able to toggle ya' integrated transpondah to keep connected to me, now.  You can also just call me up on the comm, now, yeah?\""),
    replies = { { text = ccb.content.text("Thanks, Pat."), next_topic = "TALK_ROBOFAC_MERC_PAT" } },
}
