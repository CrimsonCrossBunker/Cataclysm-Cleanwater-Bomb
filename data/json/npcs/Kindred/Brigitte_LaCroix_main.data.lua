local ccb = require("ccb")

ccb.content.define_dialogue_topic {
    id = "TALK_BONE_SEER_COOPER3_FRIEND",
    line = ccb.content.text("You do not realize the gravity of your claim.  When you understand the Song better, you will understand the danger of his actions."),
    replies = { { text = ccb.content.text("I see, I'm sorry."), next_topic = "TALK_FRIEND_BONE_SEER" } },
}

ccb.content.define_dialogue_topic {
    id = "TALK_BONE_SEER_BONES_FRIEND",
    line = ccb.content.text("The song can be woven in many forms.  Carved bone charms, weapons and armor all hold immense power, and when the time comes, me and my Kindred shall amass enough Song to restore this world as it was before.  Restore it, or end it.  Makes no difference."),
    replies = {
        {
            text = ccb.content.text("End the world?  What?"),
            next_topic = "TALK_BONE_SEER_END_FRIEND",
        },
    },
}

ccb.content.define_dialogue_topic {
    id = "TALK_BONE_SEER_END_FRIEND",
    line = ccb.content.text("The Song holds immeasurable power.  A grand symphony could revert the Cataclysm - or accelerate it to a time beyond all.  But with the world looking as is, both options are preferable."),
    replies = {
        {
            text = ccb.content.text("Yes, that's right.  Thank you for reminding me."),
            next_topic = "TALK_FRIEND_BONE_SEER",
        },
    },
}
