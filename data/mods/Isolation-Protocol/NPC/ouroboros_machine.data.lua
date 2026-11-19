local ccb = require("ccb")

ccb.content.define_dialogue_topic {
    id = "ISO_CRAFTER_INTRO",
    line = ccb.content.text("Advanced Recycling and Manufacturing Ouroboros - Version EXPERIMENTAL 1.12.0\nDESIGNATION: Armorer\n\nALEXANDRIA database: 100% uptime\nProduction Datareader: Operational\nDisassembly Module: Operational\nPrinter Array: Operational\nCalibration Sensor Array: Operational\n\n>"),
    replies = {
        { text = ccb.content.text(">Help"), next_topic = "ISO_CRAFTER_HELP" },
        { text = ccb.content.text(">Quit"), next_topic = "TALK_DONE" },
    },
}

ccb.content.define_dialogue_topic {
    id = "ISO_CRAFTER_HELP",
    line = ccb.content.text("The Advanced Recycling and Manufacturing Ouroboros is a universal printer, fed by discs of condensed material.  The Armorer model is the first and presently only model of this experimental technology, tailored for the uses of DARPA and affiliated organizations.\n\nUnneeded equipment can be fed into the slot labeled INPUT, and material of similar use are bonded at the molecular level and condensed into discs to be provided through the OUTPUT.  Material Discs can be used to manufacture equipment in the same process."),
    replies = {
        { text = ccb.content.text(">Return"), next_topic = "ISO_CRAFTER_INTRO" },
        { text = ccb.content.text(">Quit"), next_topic = "TALK_DONE" },
    },
}
