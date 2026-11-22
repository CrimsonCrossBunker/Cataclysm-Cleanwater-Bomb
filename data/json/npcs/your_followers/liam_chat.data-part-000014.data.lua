local ccb = require("ccb")
local predicates = ccb.content.dialogue_predicates

ccb.content.define_dialogue_topic {
    id = "TALK_Liam_Opinions_directions_hub01",
    line = {
        when = predicates.any_equal({ "yes", { scope = "speaker", key = "dialogue_intercom_u_discovered_robofac_intercom" } }),
        yes = {
            when = predicates.handler("dlg_p_dda_9183061634b4"),
            yes = ccb.content.text("Is that just that Hub place, with the intercom?  Not that it's not cool, but it's nothing new to us.  Woah… we've really seen some shit, haven't we."),
            no = ccb.content.text("It sounds to me like this might be that intercom we found out in that weird building?  I'm just guessing.  We should go confirm."),
        },
        no = ccb.content.text("Hell yeah, this sounds so badass!  Let's be careful though, 'secret lab' sounds like a place that's gonna have some defenses."),
    },
    replies = {
        {
            text = ccb.content.text("You bet.  I'd like your opinion on something else."),
            next_topic = "TALK_Liam_Opinions",
        },
    },
}
