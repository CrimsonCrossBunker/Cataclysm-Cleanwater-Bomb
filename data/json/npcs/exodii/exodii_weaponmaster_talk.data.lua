local ccb = require("ccb")
local predicates = ccb.content.dialogue_predicates
local actions = ccb.content.dialogue_actions

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

ccb.content.define_dialogue_topic {
    id = "TALK_WEAPONMASTER_INTRO_5",
    line = ccb.content.text("&They do not move and do not say anything."),
    replies = {
        {
            text = ccb.content.text("Hey?  Do you understand me?"),
            next_topic = "TALK_WEAPONMASTER_INTRO_6",
        },
    },
}

ccb.content.define_dialogue_topic {
    id = "TALK_WEAPONMASTER_INTRO_6",
    line = ccb.content.text("&They clearly do not understand you.  It seems they do not hear you either."),
    replies = {
        {
            text = ccb.content.text("[You pull off your backpack, and start to pull out items you deem worthy of trading.  The weaponmaster finally looks interested.]"),
            next_topic = "TALK_DONE",
            actions = { actions.set_first_topic("TALK_EXODII_WEAPONMASTER"), "start_trade" },
        },
    },
}

ccb.content.define_dialogue_topic {
    id = "TALK_EXODII_WEAPONMASTER",
    line = {
        when = predicates.handler("w16b_p_dda_1e86b617dd38"),
        yes = {
            choices = {
                ccb.content.text("&The Weaponmaster seems to be tinkering on something, and completely ignores you as you approach."),
                ccb.content.text("&The Weaponmaster seems to be cleaning some sort of weapon, and as you approach they don't acknowledge you at all."),
                ccb.content.text("&The Weaponmaster seems to be polishing some armor, giving no indication they've seen you as you enter the room."),
            },
        },
        no = {
            choices = {
                ccb.content.text("&The Weaponmaster seems to be tinkering on something, but turns their chair to you as you approach."),
                ccb.content.text("&The Weaponmaster seems to be cleaning some sort of weapon, but as you approach them, they signal to a bystanding worker to take the weapon, and turn to you."),
                ccb.content.text("&The Weaponmaster seems to be polishing some armor, but they turn towards you the second you enter the room."),
            },
        },
    },
    on_enter = {
        { once = "meeting_weaponmaster", actions = { actions.set_actor_value("speaker", "u_met_weaponmaster", "yes") } },
    },
    replies = {
        {
            text = ccb.content.text("[With a familiar movement, you place a variety of valuables onto the counter, proposing a trade.]"),
            next_topic = "TALK_DONE",
            when = predicates.handler("w16b_p_dda_f87ec3601d53"),
            actions = { "start_trade" },
        },
        {
            text = ccb.content.text("Hey!"),
            next_topic = "TALK_WEAPONMASTER_EXODII_DO_NOT_SPEAK_TO_FAIR_FOLK",
            when = predicates.handler("w16b_p_dda_1e86b617dd38"),
            actions = { actions.set_first_topic("TALK_WEAPONMASTER_EXODII_DO_NOT_SPEAK_TO_FAIR_FOLK") },
        },
    },
}

ccb.content.define_dialogue_topic {
    id = "TALK_WEAPONMASTER_INTRO_4",
    line = {
        when = predicates.handler("w16b_p_dda_1e86b617dd38"),
        yes = ccb.content.text("&Still completely mute, it looks at you more closely, and you can see subtle movements in some of the cameras.  Then, without a word, it turns back to the workbench."),
        no = ccb.content.text("&Still completely mute, it shows you something you had initially missed.  The entire wall behind the workbench is full of various weapons; some as big as modern rifles, a few as large as the machine guns installed on aircraft, and one that looks like a dismantled tank turret.  Melee weapons were not forgotten, from moderately-sized swords and clubs to war hammers twice the height of a human, and what you can describe only as \"boots for mecha\".  Then it points to a sign near you that shows three things: the carved pictograms of coins, some sign you are not familiar with, and a pictogram of a bullet - all things considered, this creature is either a weaponmaster, or a weapon merchant."),
    },
    replies = {
        {
            text = ccb.content.text("Woah.  Can I buy one?"),
            next_topic = "TALK_WEAPONMASTER_INTRO_5",
            when = predicates.handler("w16b_p_dda_f87ec3601d53"),
        },
        {
            text = ccb.content.text("Hey!"),
            next_topic = "TALK_WEAPONMASTER_EXODII_DO_NOT_SPEAK_TO_FAIR_FOLK",
            when = predicates.handler("w16b_p_dda_1e86b617dd38"),
            actions = { actions.set_first_topic("TALK_WEAPONMASTER_EXODII_DO_NOT_SPEAK_TO_FAIR_FOLK") },
        },
    },
}
