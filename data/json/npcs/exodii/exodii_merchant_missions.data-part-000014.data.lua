local ccb = require("ccb")
local predicates = ccb.content.dialogue_predicates
local actions = ccb.content.dialogue_actions

ccb.content.define_dialogue_topic {
    id = "TALK_EXODII_MERCHANT_mission_4_intro",
    line = ccb.content.text(
        --~ Well, as it were, things are going well.  In fact, we've started doing some good deals, and not just with you.  And we've become aware of a group that calls themselves the Free Merchants.  We need a human from this earth to talk to them, so that maybe we can set up some more organized trade, with the time we have left on this rock.  We're willing to pay you to make introductions.  Interested?
        "&Rubik lets out a rather comfortable chuckle from their speakers, and slaps their robotic belly.  \"Well, well, things are goin' swell.  Us'n've started right an' proper jelly, and not wi' just you neither.  By the by we've come ken of some monicks themselves the \"Free Merchants,\" as it were.  Lots'o'scrap.  Stuff we like and need.  Need us a person'o'this'land t'parlay with'em, see if mayhap we can set up finer trade betwixt, for the good hours in the sun we've left here, 'least.  Us'nlll stand ye a mighty tidy reward for introductions.  What say, fruit gum?"),
    replies = {
        {
            text = ccb.content.text("So you want me to introduce you to the Free Merchants?  Sure, why not.  I'll do it."),
            when = predicates.any({ predicates.any_equal({ "yes", { scope = "speaker", key = "general_meeting_u_met_Gavin" } }), predicates.any_equal({ "yes", { scope = "speaker", key = "exodii_told_u_about_free_merchants" } }) }),
            actions = { actions.assign_mission("EXODII_MISSION_MEET_FREE_MERCHANTS") },
            next_topic = "TALK_EXODII_MERCHANT_mission_4_accepted",
        },
        {
            text = ccb.content.text("Who are the Free Merchants?"),
            when = predicates.all({ predicates.negate(predicates.any_equal({ "yes", { scope = "speaker", key = "general_meeting_u_met_Gavin" } })), predicates.negate(predicates.any_equal({ "yes", { scope = "speaker", key = "exodii_told_u_about_free_merchants" } })) }),
            actions = { actions.set_actor_value("speaker", "exodii_told_u_about_free_merchants", "yes") },
            next_topic = "TALK_EXODII_MERCHANT_mission_4_who",
        },
        {
            text = ccb.content.text("So, why can't an Exodii do this?  Why me?"),
            next_topic = "TALK_EXODII_MERCHANT_mission_4_explain",
        },
        {
            text = ccb.content.text("Don't you think my new cyborg body might be a problem?"),
            when = predicates.has_trait("speaker", "EXODII_CYBERFRAME_GENERIC"),
            next_topic = "TALK_EXODII_MERCHANT_mission_4_explain_cyborg",
        },
        {
            text = ccb.content.text("Maybe some other time.  See you later, Rubik."),
            next_topic = "TALK_DONE",
        },
    },
}

ccb.content.define_dialogue_topic {
    id = "TALK_EXODII_MERCHANT_mission_4_who",
    line = ccb.content.text(
        --~ Merchants held up in some sort of large building.  They're proper traders as far as I can tell.  To have caravans so soon after the end times speaks something to their ingenuity, but maybe should also inspire caution.  They're smart, but maybe conniving.  Either way, they're not secretive like that bunker, so that's good
        "Mongers holed up in some great clunk of a buildin'.  Proper traders, far as ol' Rubik can tell.  To run a caravan so soon past the dyin'o'the'world, that speaks a mite to their grit an' know-how, but mayhaps it'd be wise to keep one eye sharp, too.  Keen as a tack, but maybe slippery ta'boot.  Either way, they be ain't secret.  Not hidin' behind crete n' iron like the bunker-folk.  So that's a fair mercy."),
    replies = {
        {
            text = ccb.content.text("So you want me to introduce you to the Free Merchants?  Sure, why not.  I'll do it."),
            when = predicates.any({ predicates.any_equal({ "yes", { scope = "speaker", key = "general_meeting_u_met_Gavin" } }), predicates.any_equal({ "yes", { scope = "speaker", key = "exodii_told_u_about_free_merchants" } }) }),
            actions = { actions.assign_mission("EXODII_MISSION_MEET_FREE_MERCHANTS") },
            next_topic = "TALK_EXODII_MERCHANT_mission_4_accepted",
        },
        {
            text = ccb.content.text("Don't you think my new cyborg body might be a problem?"),
            when = predicates.has_trait("speaker", "EXODII_CYBERFRAME_GENERIC"),
            next_topic = "TALK_EXODII_MERCHANT_mission_4_explain_cyborg",
        },
        {
            text = ccb.content.text("Maybe some other time.  See you later, Rubik."),
            next_topic = "TALK_DONE",
        },
    },
}

ccb.content.define_dialogue_topic {
    id = "TALK_EXODII_MERCHANT_mission_4_explain",
    line = ccb.content.text(
        --~ Well, I think it's obvious that someone people might be intimidated by our cybernetic enhancements. Rightfully so.  Might even think we're part of the Enemy.  You, though?  Normal, by their standards.  I think we stand a better chance.
        "Well an' surely, some folk'll take a mightly long squint at the bright'n'steelies on me an' feel a MITE uneasy, aye?  And rightly so, an I'm ken.  Might even reckon us kin'o'the Enemy.  But you?  By their reckonin', yer ordinary.  Normal.  Regular clap.  Gives us a finer chance, I'd razz."),
    replies = {
        {
            text = ccb.content.text("So you want me to introduce you to the Free Merchants?  Sure, why not.  I'll do it."),
            when = predicates.any({ predicates.any_equal({ "yes", { scope = "speaker", key = "general_meeting_u_met_Gavin" } }), predicates.any_equal({ "yes", { scope = "speaker", key = "exodii_told_u_about_free_merchants" } }) }),
            actions = { actions.assign_mission("EXODII_MISSION_MEET_FREE_MERCHANTS") },
            next_topic = "TALK_EXODII_MERCHANT_mission_4_accepted",
        },
        {
            text = ccb.content.text("Don't you think my new cyborg body might be a problem?"),
            when = predicates.has_trait("speaker", "EXODII_CYBERFRAME_GENERIC"),
            next_topic = "TALK_EXODII_MERCHANT_mission_4_explain_cyborg",
        },
        {
            text = ccb.content.text("Maybe some other time.  See you later, Rubik."),
            next_topic = "TALK_DONE",
        },
    },
}

ccb.content.define_dialogue_topic {
    id = "TALK_EXODII_MERCHANT_mission_4_explain_cyborg",
    line = ccb.content.text(
        --~ Well, correct, these days we look a lot alike, being cyborgs and all.  But you speak normal English for this Earth, not Anglic like me.  Lower chance they mistake us for the Enemy, or something like that.
        "Well an' surely, these days ye an' ol' Rubik look near alike, what with the whole cyborgin' an' all.  But ye parley THEIR, or rather YOUR Anglic, not mine.  Less chance they wrongly ken us for mates o' the Enemy or summit."),
    replies = {
        {
            text = ccb.content.text("So you want me to introduce you to the Free Merchants?  Sure, why not.  I'll do it."),
            when = predicates.any({ predicates.any_equal({ "yes", { scope = "speaker", key = "general_meeting_u_met_Gavin" } }), predicates.any_equal({ "yes", { scope = "speaker", key = "exodii_told_u_about_free_merchants" } }) }),
            actions = { actions.assign_mission("EXODII_MISSION_MEET_FREE_MERCHANTS") },
            next_topic = "TALK_EXODII_MERCHANT_mission_4_accepted",
        },
        {
            text = ccb.content.text("Maybe some other time.  See you later, Rubik."),
            next_topic = "TALK_DONE",
        },
    },
}
