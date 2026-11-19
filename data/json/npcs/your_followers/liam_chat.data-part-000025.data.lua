local ccb = require("ccb")
local predicates = ccb.content.dialogue_predicates

ccb.content.define_dialogue_topic {
    id = "TALK_Liam_Opinions_MISSION_ISHERWOOD_EDDIE_1",
    line = {
        when = predicates.any_equal({ "yes", { scope = "speaker", key = "u_saved_barry_isherwood" } }),
        yes = ccb.content.text("Even if we work together it's gonna take a while to just find enough good rocks lying around.  We'll probably want to get a shovel and dig around a bit maybe?  Or break up bigger ones with a sledge.  I'm impressed at these guys, keeping going after everything that's happened."),
        no = ccb.content.text("Even if we work together it's gonna take a while to just find enough good rocks lying around.  We'll probably want to get a shovel and dig around a bit maybe?  Or break up bigger ones with a sledge.  Something about this stuff feels weird to me though.  Too pastoral for the apocalypse."),
    },
    replies = {
        {
            text = ccb.content.text("Yeah, I hear you.  I'd like your opinion on something else, actually."),
            next_topic = "TALK_Liam_Opinions",
        },
    },
}
