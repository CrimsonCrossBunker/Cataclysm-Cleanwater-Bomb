local ccb = require("ccb")
local predicates = ccb.content.dialogue_predicates

ccb.content.define_dialogue_topic {
    id = "TALK_EXODII_MERCHANT_mission_1_intro1",
    line = ccb.content.text(
        --~ It's a bit hard to explain, but I'll do my best.  The forces we send far out, what I'd call 'escolts'… explorers?  They've scouted a place with a bit of promise, as far as I can tell.  A wall of concrete around a bunker.  That's not so odd in a place like this, but this one has people coming and going.  There's something still in there, and I wonder who.  Are they friendly or not?  What would you think about doing some scouting yourself?
        "It be a right coddle to yark, but ol' Rubik'll do as can.  Them as we send a'far, what I'd assert as 'escolts'… explorers?  They's escolted a place with a mite o' promise, an I'm ken.  A wall o' crete-stone, abreast a rattlin' clunker… a 'bunker'.  Not so odd in a deadlands alas, but this'n gots the comin's and goin's.  Sommat's still in there, an' ol' Rubik wonders who.  Be they friend or foe?  What say ye t'helpin' with a mite o' escoltin' y'self?"),
    replies = {
        {
            text = ccb.content.text("Why can't one of you do this?"),
            next_topic = "TALK_EXODII_MERCHANT_mission_1_explain",
        },
        {
            text = ccb.content.text("Well, today's your lucky day, my metal friend.  I already know the place quite well."),
            when = predicates.any_equal({ "yes", { scope = "speaker", key = "dialogue_intercom_u_discovered_robofac_intercom" } }),
            next_topic = "TALK_EXODII_MERCHANT_mission_1_met_hub",
        },
        {
            text = ccb.content.text("What exactly do you want me to do?  Scout out this bunker and contact the people in it?"),
            next_topic = "TALK_EXODII_MERCHANT_mission_1_intro2",
        },
        {
            text = ccb.content.text_without_extraction("<done_conversation_section>"),
            next_topic = "TALK_EXODII_MERCHANT_Talk",
        },
        {
            text = ccb.content.text("<end_talking_leave>  See you later, Rubik."),
            next_topic = "TALK_DONE",
        },
    },
}
