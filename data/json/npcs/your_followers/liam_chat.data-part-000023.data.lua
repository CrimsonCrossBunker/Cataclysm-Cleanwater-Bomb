local ccb = require("ccb")
local predicates = ccb.content.dialogue_predicates

ccb.content.define_dialogue_topic {
    id = "TALK_Liam_Opinions_MISSION_ISHERWOOD_CLAIRE_1",
    line = {
        when = predicates.any_equal({ "yes", { scope = "speaker", key = "u_saved_barry_isherwood" } }),
        yes = ccb.content.text("After the shit these poor bastards have gone through, picking some dandelions for them seems kind of anticlimactic.  Still, I am a big fan of dandelion wine."),
        no = ccb.content.text("Picking flowers in a field seems okay to me.  I don't mind helping Claire out, she's a nice enough person.  Gotta say though, I get a bit of a weird vibe off these guys.  They're so… I don't know.  It's like we walked into a Norman Rockwell painting in the middle of the end of the world."),
    },
    replies = {
        {
            text = ccb.content.text("I'd like your opinion on something else, actually."),
            next_topic = "TALK_Liam_Opinions",
        },
    },
}
