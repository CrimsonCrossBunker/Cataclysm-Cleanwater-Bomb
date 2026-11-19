local ccb = require("ccb")

ccb.content.define_dialogue_topic {
    id = "MISSION_ROBOFAC_INTERCOM_1_OFFER",
    line = ccb.content.text("One of our scientists recently left the building to perform a field test of a prototype robot, but failed to return.  We have not been able to contact them.  Your job would be to investigate the testing site, and return with her and the prototype.  Failing that, return with the data recorder that was attached to our prototype."),
    replies = {
        {
            text = ccb.content.text("That seems trivial.  Is there a catch?"),
            next_topic = "MISSION_ROBOFAC_INTERCOM_1_ADVICE",
        },
        { text = ccb.content.text("Not interested."), next_topic = "TALK_DONE" },
    },
}
