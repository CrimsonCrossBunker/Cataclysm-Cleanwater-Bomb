local ccb = require("ccb")

ccb.content.define_dialogue_topic {
    id = "BGSS_EVACUEE_2_STORY2",
    line = ccb.content.gendered_line("Things went south when our fearless leader decided we had to put down one of the other survivors that had been bitten.  Her husband felt a bit strongly against that, and I wasn't too keen on it either; by this point, he'd already been wrong about a lot.  Well, he took matters into his own hands and killed her.  Then her husband decided one good turn deserves another, and killed the idiot.  And then she got back up and I killed her again, and pulped our former leader.  Unfortunately she'd given her husband a hell of a nip during the struggle, when he couldn't get his shit together enough to fight back.  Not that I fucking blame him.  We made it out of there together, but it was too much for him, he clearly wasn't in it anymore… the bite got infected, but it was another <zombie> that finally killed him.  And then I was alone.", { "interlocutor" }),
    replies = {
        {
            text = ccb.content.text_without_extraction("<done_conversation_section>"),
            next_topic = "TALK_FRIEND_CONVERSATION",
        },
        { text = ccb.content.text_without_extraction("<end_talking>"), next_topic = "TALK_DONE" },
    },
}
