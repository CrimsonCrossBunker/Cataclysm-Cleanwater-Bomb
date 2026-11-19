local ccb = require("ccb")

ccb.content.define_dialogue_topic {
    id = "TALK_FORGE_LORD_DIVINER_LAB",
    line = ccb.content.text("Deeply buried secret installations where shady government organizations conducted unethical experiments, free from moral constrains.  Did such places really exist before the Cataclysm, or did humanity's collective mistrust, superstition and conspiracy theories cause the portal storms to dream these places into existence?  I honestly can't tell, but I suppose it doesn't matter now.  These places do exist, and are ripe with mysteries, dangers, and loot.  You'll have to specify which kind you're looking for."),
    replies = {
        {
            text = ccb.content.text("Just a normal one."),
            next_topic = "TALK_FORGE_LORD_DIVINER_LAB_NORMAL",
        },
        {
            text = ccb.content.text("A nether lab."),
            next_topic = "TALK_FORGE_LORD_DIVINER_LAB_NETHER",
        },
        {
            text = ccb.content.text("On second thought, maybe I'll go for something else…"),
            next_topic = "TALK_NONE",
        },
        { text = ccb.content.text("You know what?  Never mind."), next_topic = "TALK_DONE" },
    },
}
