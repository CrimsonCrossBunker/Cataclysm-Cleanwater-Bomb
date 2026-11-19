local ccb = require("ccb")

ccb.content.define_dialogue_topic {
    id = "TALK_OLD_GUARD_NEC_CPT_GOAL",
    line = ccb.content.text("I'm leading what remains of my company on a mission to re-secure this facility.  We entered the complex with two dozen men and immediately went about securing this control room.  From here I dispatched my men to secure vital systems located on this floor and the floors below this one.  If we are successful, this facility can be cleared and used as a permanent base of operations in the region.  Most importantly it will allow us to redirect refugee traffic away from overcrowded outposts and free up more of our forces to conduct recovery operations."),
    replies = { { text = ccb.content.text("Seems like a decent plan…"), next_topic = "TALK_NONE" } },
}

ccb.content.define_dialogue_topic {
    id = "TALK_OLD_GUARD_NEC_CPT_VAULT",
    line = ccb.content.text("This facility was constructed to provide a safe haven in the event of a global conflict.  The vault can support several thousand people for a few years if all systems are operational and sufficient notification is given.  Unfortunately, the power system was damaged or sabotaged at some point and released a single extremely lethal burst of radiation.  The catastrophic event lasted for several minutes and resulted in the deaths of most people located on the 2nd and lower floors.  Those working on this floor were able to seal the access ways to the lower floors before succumbing to radiation sickness.  The only other thing the logs tell us is that all water pressure was diverted to the lower levels."),
    replies = {
        {
            text = ccb.content.text("Whatever they did it must have worked since we are still alive…"),
            next_topic = "TALK_NONE",
        },
    },
}
