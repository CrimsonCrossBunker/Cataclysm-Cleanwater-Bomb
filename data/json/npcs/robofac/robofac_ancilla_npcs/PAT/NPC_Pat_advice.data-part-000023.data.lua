local ccb = require("ccb")
local predicates = ccb.content.dialogue_predicates

ccb.content.define_dialogue_topic {
    id = "TALK_ROBOFAC_MERC_PAT_ADVICE_MISSION_CHOP_SHOP_INTEL",
    line = {
        when = predicates.any_equal({ "yes", { scope = "speaker", key = "robofac_pat_chatting_on_radio" } }),
        yes = ccb.content.text("&Your HUD flicks on and low-resolution version of Pat's computer desktop becomes visible.  They start to scan old, grainy satellite images downloaded from Google maps.  \"Old strip mall, yeah?  But looky-theah.  Looks like theah's some window-vents ovah the fahkin' hoppah - the head - the fahkin' toilet.  If I were you, I'd climb up in theah, find ya' way in, make sure ya' set up an escape, and do what needs doin'.\""),
        no = ccb.content.text("&Pat flips open their laptop and wiggles the cable attached to a makeshift battery.  It boots up after a moment and they clack away, looking at old, grainy satellite images downloaded from Google maps.  \"Old strip mall, yeah?  But looky-theah.  Looks like theah's some window-vents ovah the fahkin' hoppah - the head - the fahkin' toilet.  If I were you, I'd climb up in theah, find ya' way in, make sure ya' set up an escape, and do what needs doin'.\""),
    },
    replies = { { text = ccb.content.text("Thanks, Pat."), next_topic = "TALK_ROBOFAC_MERC_PAT_ADVICE" } },
}
