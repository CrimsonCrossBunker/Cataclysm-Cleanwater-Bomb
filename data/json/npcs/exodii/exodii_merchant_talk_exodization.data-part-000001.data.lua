local ccb = require("ccb")
local predicates = ccb.content.dialogue_predicates
local actions = ccb.content.dialogue_actions

ccb.content.define_dialogue_topic {
    id = "TALK_EXODII_MERCHANT_ExodizeMe1",
    line = ccb.content.text(
        --~ Great, great, great!  Ha!  We'll fire up the old meat grinder.  Maybe you do a job for us, we do a job for you?  Or we could trade, maybe if you bring us a bit of good tea.  Not literally 'tea' of course.  That's my Anglic street slang.  I mean the stuff that puts you to sleep for surgery.  The Great Grey says your word for it is 'anesthetic'.  You bring us a thousand units of anesthetic, we'll fix you up with a wire and everything.
        "Fine an' fine, an' fine an' fine!  Ha!  Us'll rubber up the ol' gristle mill.  Mayhap a tit-for-tat, aye?  Or a trade, aye, mayhap wi' bringin' us a nip o' good tea.  Not 'tea', o'course.  I'm yarkin dockside Anglic here.  Us means the stuff what puts y'to sleep f'r a chirurgery.  The Great Grey says y'r assert for it is 'anus fetick'.  You bring us a thousand unit of 'anus fetick', us'll fix'n ye up with a wire an' a tiff."),
    replies = {
        {
            text = ccb.content.text("So I could bring you one thousand units of, uh, anesthetic?  And you'll give me this \"upgrade?\"  Sure, coming right up.  I'd better start looking."),
            when = predicates.negate(predicates.any({ predicates.has_mission("RUBIK_ANUS_FETICK"), predicates.any_equal({ "yes", { scope = "speaker", key = "mission_completed_anusfetick" } }) })),
            actions = { actions.assign_mission("RUBIK_ANUS_FETICK") },
            next_topic = "TALK_DONE",
        },
        {
            text = ccb.content.text("Could I do something else, maybe some kind of job, to earn this \"upgrade?\""),
            next_topic = "TALK_EXODII_MERCHANT_Jobs",
        },
    },
}
