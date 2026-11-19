local ccb = require("ccb")
local predicates = ccb.content.dialogue_predicates
local actions = ccb.content.dialogue_actions

ccb.content.define_dialogue_topic {
    id = "COMP_PREPPER_1_DOC_EVERYTHING",
    line = ccb.content.text("Enigma code cracked by Turing -> modern encryption technology -> internet sentience arises and gives birth to AI in Chinese lab using new forms of computation, aka: BIO-TECHNOLOGY, human AND robotic components TOGETHER.  State media announces as 'fusion technology'.  Bio-weapon escapes lab, OF COURSE.  Self-replicating bio-technology = imminent replacement of humanity.  US gov now ACTIVELY manufacturing cover-ups for escaped bio-weapon to maintain peace.  Follows same pattern as Roswell, Trinity (what they told the public), oil pollution coverup (in my opinion).  Recent New York 'mass psychosis events' instigated by them as cover.  PAID ACTORS on speed dial but the THREAT IS REAL.  They are buying time, but what is the play?"),
    replies = {
        {
            text = ccb.content.text("Back"),
            next_topic = "TALK_NONE",
            actions = { actions.set_actor_value("speaker", "mission_BGSS_prepper_1_found_computer", "yes") },
        },
    },
}

ccb.content.define_dialogue_topic {
    id = "COMP_PREPPER_1_DOC_ROBERT",
    line = ccb.content.text("Gov assigns names based off numerological conversions of house numbers.  Robert Williamson: 205 W Orchard Avenue.  Robert (78) + Williamson (127) = 205.  Despite the beautiful weather, he keeps the curtains closed and no one has even visited yet.  And he's been here for more than two weeks!  I only ever see him when he's coming or going from work.  I assume it's work, even if the hours are strange sometimes.  Black car, out of state plates, looks brand new.  Fed behavior, if you ask me… Is he actually going somewhere or just trying to convince me he's legitimate?  Is he on the job when he leaves or on the job when he's here?  Further investigation required."),
    replies = {
        {
            text = ccb.content.text("Back"),
            next_topic = "TALK_NONE",
            actions = { actions.set_actor_value("speaker", "mission_BGSS_prepper_1_found_computer", "yes") },
        },
    },
}
