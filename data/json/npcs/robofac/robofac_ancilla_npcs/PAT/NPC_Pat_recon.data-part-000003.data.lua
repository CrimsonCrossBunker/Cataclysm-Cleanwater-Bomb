local ccb = require("ccb")
local predicates = ccb.content.dialogue_predicates

ccb.content.define_dialogue_topic {
    id = "MISSION_ROBOFAC_PAT_RECON_9",
    line = {
        when = predicates.any_equal({ "yes", { scope = "speaker", key = "robofac_pat_chatting_on_radio" } }),
        yes = ccb.content.text("Merc told me she saw some sort'a creature in the woods.  I made her prove it.  She shows me this.\"  Pat uploads a scanned, blurry Polaroid photo showing a fence in the forest, with some small, dark smear of a creature moving behind it.  Pat then drops a digital pin in your HUDs map application.  \"Figure you can't see much, but this place is where the merc saw it.  Maybe worth a look."),
        no = ccb.content.text("Merc told me she saw some sort'a creature in the woods.  I made her prove it.  She shows me this.\"  Pat pulls out a blurry Polaroid photo showing a fence in the forest, with some small, dark smear of a creature moving behind it. \"Figure you can't see much, but this place is where the merc saw it.  Maybe worth a look."),
    },
    replies = { { text = ccb.content.text("Maybe I'll check it out.  Thanks."), next_topic = "TALK_DONE" } },
}
