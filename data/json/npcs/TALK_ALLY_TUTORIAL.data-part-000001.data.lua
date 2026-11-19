local ccb = require("ccb")

ccb.content.define_dialogue_topic {
    id = "TALK_ALLY_TUTORIAL_MUTINY",
    line = ccb.content.text("You and me, we better stick together to survive, right?  But that doesn't mean I'll tolerate infinite abuse.  Mistreat me too much, or especially fail to keep me fed, and I'll like you less and less.  If it gets bad enough, I'll mutiny - and if you have anyone else following you, I may convince some of them to join my mutiny and we'll form our own little band.\n  Obviously, if I quit in a huff, there's going to be bad blood between us, and you're probably going to want to kill me for betrayal and I may need to kill you to get my fair share of the loot.  So keep me fed and satisfied so it doesn't come to that."),
    replies = {
        {
            text = ccb.content.text("Sure.  Is there any easy way to keep you fed?"),
            next_topic = "TALK_CAMP_TUTORIAL_INTRO",
        },
    },
}

ccb.content.define_dialogue_topic {
    id = "TALK_ALLY_TUTORIAL_TALK",
    line = ccb.content.text("If we're next to each other, you can just bump into me and we'll start talking, right?  But if I'm farther away, you're going to have to shout a bit (use the 'C'hat command) for me to hear you.  You'll need to see me for us to have a conversation.  Or we can talk by radios if we both have them.\n  When we talk, you can give me instructions about how to fight or when to sleep or whatever.  I'll mostly do them, and you can ask me what my current instructions are.  Sometimes you'll give me two sets of instructions: a normal set, and an override for a specific situation.  I'll tell you which instructions are overridden.  You can set and clear overrides with shouted commands."),
    replies = {
        {
            text = ccb.content.text("We can talk with radios?"),
            next_topic = "TALK_ALLY_TUTORIAL_RADIO",
        },
        {
            text = ccb.content.text("How do shouted commands work?"),
            next_topic = "TALK_ALLY_TUTORIAL_SHOUTS",
        },
    },
}
