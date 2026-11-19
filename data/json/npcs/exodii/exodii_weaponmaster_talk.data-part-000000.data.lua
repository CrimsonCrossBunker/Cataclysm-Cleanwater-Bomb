local ccb = require("ccb")

-- mute by choice, and deaf most of the time (don't like to turn on the hearing cbm unless for job)
ccb.content.define_dialogue_topic {
    id = "TALK_WEAPONMASTER_INTRO_1",
    line = ccb.content.text("&What you see looks like the back of a mechanical spider, with at least a dozen crude but polished metal arms coming from the enormously wide spine and shoulders.  The spine of the creature, meanwhile, sits in an awkward-looking chair, manipulating tools and geegaws on a wide, brightly lit workbench.  The creature seems to be busy with something."),
    replies = {
        { text = ccb.content.text("[Wait a bit.]"), next_topic = "TALK_WEAPONMASTER_INTRO_2A" },
        { text = ccb.content.text("Hello?"), next_topic = "TALK_WEAPONMASTER_INTRO_2B" },
    },
}

ccb.content.define_dialogue_topic {
    id = "TALK_WEAPONMASTER_INTRO_2A",
    line = ccb.content.text("&It doesn't react to your presence at all."),
    replies = {
        { text = ccb.content.text("[Wait for longer.]"), next_topic = "TALK_WEAPONMASTER_INTRO_3" },
        { text = ccb.content.text("Hello?"), next_topic = "TALK_WEAPONMASTER_INTRO_3" },
    },
}

ccb.content.define_dialogue_topic {
    id = "TALK_WEAPONMASTER_INTRO_2B",
    line = ccb.content.text("&It seems to not hear you at all."),
    replies = {
        { text = ccb.content.text("[Wait in silence.]"), next_topic = "TALK_WEAPONMASTER_INTRO_3" },
        { text = ccb.content.text("Hello!?"), next_topic = "TALK_WEAPONMASTER_INTRO_3" },
    },
}

ccb.content.define_dialogue_topic {
    id = "TALK_WEAPONMASTER_INTRO_3",
    line = ccb.content.text("&A few seconds later, they seem to finish whatever they were busy with and turn their chair towards you.  Their front looks no less exotic than their back; the abundance of metal arms are even more extraordinary next to the clear lack of any legs.  What you initially thought to be a chair is simply a rotating platform, sturdy enough to support the weight of the entire body of the creature.  A number of cameras, which seem to be a replacement for eyes, look at you motionlessly, while the forehead of the creature has the surprisingly familiar sign \"IX\" painted on."),
    replies = {
        {
            text = ccb.content.text("Who-…  Wha-…  What are you?"),
            next_topic = "TALK_WEAPONMASTER_INTRO_4",
        },
    },
}
