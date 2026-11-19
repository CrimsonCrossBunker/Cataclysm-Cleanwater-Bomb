local ccb = require("ccb")

ccb.content.define_dialogue_topic {
    id = { "TALK_VAMPIRE_MENTOR_NEWVAMPIRE" },
    line = ccb.content.text("[Drains a significant portion of your blood and begins speaking to you before you black out] Here you go.  You might not notice the effects at first, but keep some human blood close for when your thirst will appear and some shelter for when the sun will start to burn your skin.  There are levels of vampiric power that cannot be achieved through time alone.  When you'll reach that point, come back here and I'll help you reach them.  [Slits its own wrist and lets you drink, as the blood hits your tongue it energizes you and washes away the dizziness of blood loss]"),
    replies = {
        {
            text = ccb.content.text("Can we talk about something else?"),
            next_topic = "TALK_VAMPIRE_MENTOR_TALK",
        },
        { text = ccb.content.text("Got it.  See you."), next_topic = "TALK_DONE" },
    },
}
