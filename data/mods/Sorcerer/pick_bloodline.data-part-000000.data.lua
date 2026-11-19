local ccb = require("ccb")

ccb.content.define_dialogue_topic {
    id = "TALK_SORCERER_PICK_BLOODLINE",
    line = ccb.content.text("While wizards spend their lives buried in books to understand magic, your power stems from your innately magical bloodline.  Magic is your birthright.\nInstead of studying books, you increase in power by slaying monsters.\n\nThe standard sorcerer gains a caster level bonus based on their intelligence, but some bloodlines change this.\nThat being said, what exactly is your bloodline?"),
    replies = {
        {
            text = ccb.content.text("Standard bloodline"),
            next_topic = "TALK_SORCERER_GAIN_BLOODLINE_STANDARD",
        },
        {
            text = ccb.content.text("Bloodrager"),
            next_topic = "TALK_SORCERER_GAIN_BLOODLINE_BLOODRAGER",
        },
        {
            text = ccb.content.text("Spelldancer"),
            next_topic = "TALK_SORCERER_GAIN_BLOODLINE_SPELLDANCER",
        },
        { text = ccb.content.text("Quit."), next_topic = "TALK_DONE" },
    },
}
