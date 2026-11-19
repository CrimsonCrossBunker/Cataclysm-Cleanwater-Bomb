local ccb = require("ccb")
local predicates = ccb.content.dialogue_predicates

ccb.content.define_dialogue_topic {
    id = "TALK_REFUGEE_Fatima_Situation",
    line = {
        when = predicates.any_equal({ "yes", { scope = "speaker", key = "mission_completed_Jenny_mission_2" } }),
        yes = ccb.content.text("Things are still tense, but I've been busy lately.  Jenny's had her project going and got me started helping her out with it, and for some reason that seems to have been the tipping point: I'm getting chances to do a lot more welding work now.  It's helping.  I feel a bit self-conscious praying in the common areas, and of course, we don't go outside if we can help it."),
        no = ccb.content.text("It's tense here.  I know I'd feel a lot better if I had something to do with my skills, or even if I just had a quiet place to pray sometimes.  I feel a bit self-conscious praying in the common areas.  Jenny was talking about some project ideas she had that could get me doing my job again, but I admit I'm pretty nervous about going outside."),
    },
}
