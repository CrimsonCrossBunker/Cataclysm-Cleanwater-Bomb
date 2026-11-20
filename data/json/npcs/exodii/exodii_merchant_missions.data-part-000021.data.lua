local ccb = require("ccb")
local predicates = ccb.content.dialogue_predicates
local actions = ccb.content.dialogue_actions

ccb.content.define_dialogue_topic {
    id = "TALK_EXODII_MERCHANT_ANUS_FETICK_ALT",
    line = ccb.content.text(
        --~ Maybe you could bring us a bit of good tea.  Not literally 'tea' of course.  That's my Anglic street slang.  I mean the stuff that puts you to sleep for surgery.  The Great Grey says your word for it is 'anesthetic'.  You bring us a thousand units of anesthetic, we'll fix you up with a wire and everything.
        "Mayhap ye bringin' us a nip o' good tea.  Not 'tea', o'course.  I'm yarkin dockside Anglic here.  Us means the stuff what puts y'to sleep f'r a chirurgery.  The Great Grey says y'r assert for it is 'anus fetick'.  You bring us a thousand unit of 'anus fetick', us'll fix'n ye up with a wire an' a tiff."),
    replies = {
        {
            text = ccb.content.text("One thousand units of, uh, anesthetic?  And you'll give me an upgrade?  Sure, I'd better start looking."),
            when = predicates.negate(predicates.any({ predicates.has_mission("RUBIK_ANUS_FETICK"), predicates.any_equal({ "yes", { scope = "speaker", key = "mission_completed_anusfetick" } }) })),
            actions = { actions.assign_mission("RUBIK_ANUS_FETICK") },
            next_topic = "TALK_DONE",
        },
        {
            text = ccb.content.text("What other work do you have?"),
            next_topic = "TALK_EXODII_MERCHANT_Jobs",
        },
    },
}
