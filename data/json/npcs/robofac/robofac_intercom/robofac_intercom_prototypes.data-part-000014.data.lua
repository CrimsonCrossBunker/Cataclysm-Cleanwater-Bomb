local ccb = require("ccb")

ccb.content.define_dialogue_topic {
    id = "TALK_ROBOFAC_INTERCOM_HWP_EXODII_1",
    line = ccb.content.text("While the Exodii seem benign, our experience with extradimensional life thus far has been… unpleasant, shall we say, given the current state of the world.  We find it wise to approach with an abundance of caution.  We are incapable of knowing the true agenda and capabilities of this group, and we believe that understanding some degree of how they operate will allow us to make contact in a more educated way."),
}

-- this is a lie. if the hub has done any kind of surveillance at all, they'd know that the Exodii would consider melchior a heavy threat, and they are unwilling to approach until they're certain that they could effectively conceal its presence.
ccb.content.define_dialogue_topic {
    id = "TALK_ROBOFAC_INTERCOM_HWP_EXODII_2",
    line = ccb.content.text("Have you, now?  We are pleased to hear.  However, we still believe that approaching with an excess of wariness is a wise choice.  We feel that it would behoove us to understand more about this group before we approach directly, and so for the time being, understanding more about their general-use technology is our preferred course of action."),
}
