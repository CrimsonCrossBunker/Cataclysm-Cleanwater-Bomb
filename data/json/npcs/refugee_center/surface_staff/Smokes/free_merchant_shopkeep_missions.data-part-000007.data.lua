local ccb = require("ccb")
local predicates = ccb.content.dialogue_predicates
local actions = ccb.content.dialogue_actions

ccb.content.define_dialogue_topic {
    id = "TALK_FREE_MERCHANTS_MERCHANT_DavePermission3",
    line = ccb.content.text("*rubs his chin.  \"It's probably technically a fire hazard, but there's not much to light up there besides what Dave brings.  And a few of the guards are pretty attached to him, so we could maybe send folks up to keep an eye on him and make sure he's doing okay.  That wouldn't interfere with comings and goings, either.\"  He pauses a moment, looking at his ledger as if it contains answers.  \"You know what?  Sure.  If Dave is okay with it, I can talk the others into letting him have rooftop access to build himself a little shelter, as long as he continues to keep it clean up there like he has in here.\""),
    on_enter = { { actions = { actions.set_actor_value("speaker", "mission_Dave_Permission", "yes") } } },
    replies = { { text = ccb.content.text("Thanks.  I'll go let him know."), next_topic = "TALK_DONE" } },
}
