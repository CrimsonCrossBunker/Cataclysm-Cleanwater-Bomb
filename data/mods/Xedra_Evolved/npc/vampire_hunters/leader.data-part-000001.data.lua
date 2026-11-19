local ccb = require("ccb")

ccb.content.define_dialogue_topic {
    id = "TALK_VAMPIRE_HUNTER_LEADER_MISSIONS_ALL_DONE",
    line = {
        choices = {
            ccb.content.text("I don't have any more missions for you.  Thank you for all your help."),
        },
    },
    replies = {
        {
            text = ccb.content.text_without_extraction("<end_talking_bye>"),
            next_topic = "TALK_DONE",
        },
    },
}

ccb.content.define_dialogue_topic {
    id = "TALK_VAMPIRE_HUNTER_LEADER_MISSIONS_REWARDS",
    line = {
        choices = {
            ccb.content.text("I don't have much to offer except for a few services.  Elsa can give you leather and crossbow lessons while Blaine can spare some medical supplies and offer medical care in exchange for your help."),
        },
    },
    replies = {
        {
            text = ccb.content.text("I'll help you."),
            next_topic = "TALK_VAMPIRE_HUNTER_LEADER_MISSIONS",
        },
        {
            text = ccb.content.text_without_extraction("<end_talking_bye>"),
            next_topic = "TALK_DONE",
        },
    },
}

ccb.content.define_dialogue_topic {
    id = "TALK_KILL_LURKING_STRIGOI_COMPLETED",
    line = {
        choices = {
            ccb.content.text("This vampire was a lesser one, as seen by their resistance to the sun and lack of proper lair.  One day you will attack the lairs of true vampires alongside some of our hunters, but first we must find where they truly hide.  For now, we can enjoy some peace of mind and you can ask Elsa and Blaine for spare things to help you like you helped us."),
        },
    },
    replies = {
        { text = ccb.content.text("Let's talk about something else."), next_topic = "TALK_NONE" },
        {
            text = ccb.content.text_without_extraction("<end_talking_bye>"),
            next_topic = "TALK_DONE",
        },
    },
}

ccb.content.define_dialogue_topic {
    id = "TALK_KILL_RENFIELD_GANG_COMPLETED",
    line = {
        choices = {
            ccb.content.text("They were close to our base, yet they did not attack it.  They were either on another mission or awaiting reinforcements before their attack.  I hope it's the former, for this base is why we did not had to risk our lives in the cities for food.  If they force us to choose between facing a raid or becoming nomads, we might never recover from it.  For now, we're alive and well thanks in no small part to you."),
        },
    },
    replies = {
        { text = ccb.content.text("Let's talk about something else."), next_topic = "TALK_NONE" },
        {
            text = ccb.content.text_without_extraction("<end_talking_bye>"),
            next_topic = "TALK_DONE",
        },
    },
}

ccb.content.define_dialogue_topic {
    id = "TALK_KILL_RENFIELD_MONSTER_COMPLETED",
    line = {
        choices = {
            ccb.content.text("Renfields like that are rare and usually stay close to their masters to protect them.  If they're being sent to attack enemies, their masters are desperate or have many of them at their service.  It doesn't bode well, but at least you're able to kill them."),
        },
    },
    replies = {
        { text = ccb.content.text("Let's talk about something else."), next_topic = "TALK_NONE" },
        {
            text = ccb.content.text_without_extraction("<end_talking_bye>"),
            next_topic = "TALK_DONE",
        },
    },
}

ccb.content.define_dialogue_topic {
    id = "TALK_KILL_OR_CURE_COMPLETED_KILL",
    line = {
        choices = {
            ccb.content.text("Unfortunate, but necessary.  Some don't want to be cured.  Even if we could forcefully administer it, they would go and get infected again.  Thank you for killing a future monster."),
        },
    },
    replies = {
        { text = ccb.content.text("Let's talk about something else."), next_topic = "TALK_NONE" },
        {
            text = ccb.content.text_without_extraction("<end_talking_bye>"),
            next_topic = "TALK_DONE",
        },
    },
}

ccb.content.define_dialogue_topic {
    id = "TALK_KILL_OR_CURE_COMPLETED_CURE",
    line = {
        choices = {
            ccb.content.text("How fortunate that some of them are only regular people with an illness they want cured.  This is why we first try to cure: as long as they do not cross the point of no return with the horrible actions it requires, they are innocent until proven otherwise.  Thank you for saving an innocent from this plague."),
        },
    },
    replies = {
        { text = ccb.content.text("Let's talk about something else."), next_topic = "TALK_NONE" },
        {
            text = ccb.content.text_without_extraction("<end_talking_bye>"),
            next_topic = "TALK_DONE",
        },
    },
}

ccb.content.define_dialogue_topic {
    id = "TALK_VAMPIRE_HUNTER_LEADER_MISSIONS_STRIGOI_ADVICE",
    line = {
        choices = {
            ccb.content.text("Like all vampires, the best time to attack it is during the day.  This one won't burn under the sun like true vampires, but it will stop its regeneration.  The zombies will ignore it and attacking without cutting or stabbing weapons is a bad idea.  Lastly, don't get bitten or you're in risk of catching vampirism."),
        },
    },
    replies = {
        { text = ccb.content.text("Thanks for the advice."), next_topic = "TALK_NONE" },
        {
            text = ccb.content.text_without_extraction("<end_talking_bye>"),
            next_topic = "TALK_DONE",
        },
    },
}

ccb.content.define_dialogue_topic {
    id = "TALK_VAMPIRE_HUNTER_LEADER_MISSIONS_GANG_ADVICE",
    line = {
        choices = {
            ccb.content.text("They are all armed with firearms but they have very little ammo left, cannot aim well and have no consideration for friendly fire.  The best tactic would be to lure something hostile in range so they waste their ammo on it, like one of these pink crab-like creatures or a few walking plants.  If you can't, attacking them at night and making the most of their low night vision can give you an edge on them.  Just like their masters and the feral humans, they're too far gone to be targeted by zombies so don't bother luring zombies near them."),
        },
    },
    replies = {
        { text = ccb.content.text("Thanks for the advice."), next_topic = "TALK_NONE" },
        {
            text = ccb.content.text_without_extraction("<end_talking_bye>"),
            next_topic = "TALK_DONE",
        },
    },
}

ccb.content.define_dialogue_topic {
    id = "TALK_VAMPIRE_HUNTER_LEADER_MISSIONS_MONSTER_ADVICE",
    line = {
        choices = {
            ccb.content.text("This kind of renfield is massive, tough, quick, precise and can tear you apart like wet paper so never get close to it.  If I were you, I would find a decent gun with enough ammo and I would shoot it from a distance until it's dead.  Yes, this one is also far too gone to be attacked by zombies.  Only true vampires are attacked by the walking corpses."),
        },
    },
    replies = {
        { text = ccb.content.text("Thanks for the advice."), next_topic = "TALK_NONE" },
        {
            text = ccb.content.text_without_extraction("<end_talking_bye>"),
            next_topic = "TALK_DONE",
        },
    },
}

ccb.content.define_dialogue_topic {
    id = "TALK_VAMPIRE_HUNTER_LEADER_MISSIONS_KILL_OR_CURE_ADVICE",
    line = {
        choices = {
            ccb.content.text("We know little about them, but we noticed they lack super-speed and hypnotic eyes.  If they had, I wouldn't send you on your own against them.  Approach during the day, so combat will result in them slowly burning under the sun or attacking you with an umbrella.  Unlike the previous missions, this one can be completed by luring the undead hordes at the target so they kill each other.  However, try to speak with them first to see if they want to be cured."),
        },
    },
    replies = {
        { text = ccb.content.text("Thanks for the advice."), next_topic = "TALK_NONE" },
        {
            text = ccb.content.text_without_extraction("<end_talking_bye>"),
            next_topic = "TALK_DONE",
        },
    },
}
