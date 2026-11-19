local ccb = require("ccb")

ccb.content.define_dialogue_topic {
    id = "TALK_ROBOFAC_SCIENTIST_GARAGE_BOUNTY",
    line = ccb.content.text("That's right, bounty.  No doubt you've heard of the aliens known as the \"Exodii\", right?  Big killer-robot-vibes, am I right?  Well, I've spun off an initiative adjacent to our Cybernetic Enhancements Program.  The basic strategy is simple: learn what we can, synergize with our strengths, and fight fire with fire.\n\nSo here's the play: I'm actively sourcing \"decommissioned\" Exodii hardware for teardown and reverse engineering.\n\nIt's simple: you bring inactivated Exodii here, and I'll pay you for each one.  Think of yourself as a citizen scientist, yeah?  A community R&D effort.\n\nSmall note, though.  None of those \"zomborg\" things - the walking corpses with devices jammed into them.  Another team is running that pipeline, and honestly, the signals out of that aren't so great.\n\nRight now, the highest value pickups are worker drones, the big four-legged robots, and turret platforms.  They're hard to come by, but trust me, I'll pay a good price."),
    replies = {
        {
            text = ccb.content.text("I'll keep that in mind.  See you around."),
            next_topic = "TALK_DONE",
        },
    },
}
