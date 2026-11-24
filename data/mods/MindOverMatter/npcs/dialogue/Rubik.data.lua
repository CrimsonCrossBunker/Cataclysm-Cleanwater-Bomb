local ccb = require("ccb")
local predicates = ccb.content.dialogue_predicates
local actions = ccb.content.dialogue_actions

ccb.content.define_dialogue_topic {
    id = { "TALK_EXODII_MERCHANT_Talk" },
    insert_before_standard_exits = true,
    replies = {
        {
            text = ccb.content.text("What's with those clusters of weird plants I've seen around?"),
            next_topic = "TALK_EXODII_MERCHANT_alien_flora",
            when = predicates.handler("dlg_p_mindovermatter_62abf232ddd6"),
        },
    },
}

-- Oh, right, the alien plants.  The portals bring them.  As far as I've seen in the past, it's just going to keep getting worse.
ccb.content.define_dialogue_topic {
    id = { "TALK_EXODII_MERCHANT_alien_flora" },
    line = ccb.content.text("Sure, the plants o' otherworlds.  Them as comes from the wibbles.  Like as this'n's seen, 'tis all down 'n down, an I'm ken."),
    replies = {
        {
            text = ccb.content.text(" 'Down 'n down'?  So it's going to keep happening until…what?"),
            next_topic = "TALK_EXODII_MERCHANT_alien_flora2",
        },
        {
            text = ccb.content.text("From the portals…like you, right?  You've seen this before?"),
            next_topic = "TALK_EXODII_MERCHANT_alien_flora_source",
            when = predicates.any_equal({ "yes", { scope = "speaker", key = "knowledge_exodii_transdimensional_u_knows_exodiilore" } }),
        },
        {
            text = ccb.content.text("Can we talk about something else?"),
            next_topic = "TALK_EXODII_MERCHANT_Talk",
        },
        {
            text = ccb.content.text("I've gotta go.  See you later, Rubik."),
            next_topic = "TALK_DONE",
        },
    },
}

-- Until the normal world is covered in alien biomes and then all falls to dust.  That's just how it goes.
ccb.content.define_dialogue_topic {
    id = { "TALK_EXODII_MERCHANT_alien_flora2" },
    line = ccb.content.text("Til the green and brown be yellowred and blue afore it be to grey and black.  'Tis the course."),
    replies = {
        {
            text = ccb.content.text("Is there any way to stop it?  Can we cut them down or burn them or something?"),
            next_topic = "TALK_EXODII_MERCHANT_alien_flora_burn",
        },
        {
            text = ccb.content.text("The course?  What's going to happen?"),
            next_topic = "TALK_EXODII_MERCHANT_Talk_CataclysmTimeline",
        },
        {
            text = ccb.content.text("Can we talk about something else?"),
            next_topic = "TALK_EXODII_MERCHANT_Talk",
        },
        {
            text = ccb.content.text("I've gotta go.  See you later, Rubik."),
            next_topic = "TALK_DONE",
        },
    },
}

-- You could burn it, but the portals will just bring it back.  No, there's no stopping it at this point.  Even if you burned every single one you found, you're just one person and there's an endless supply of them, so it's futile.  There's only one way this goes.
ccb.content.define_dialogue_topic {
    id = { "TALK_EXODII_MERCHANT_alien_flora_burn" },
    line = ccb.content.text("Aye, mayhap, but more'll dribble through the wobbles.  You can't athwart all o' the bridges.  If'n you light each and every, you're only one against many.  'Twould be no point.  The road only goes one way."),
    replies = {
        {
            text = ccb.content.text("Well, we'll see about that.  Can we talk about something else?"),
            next_topic = "TALK_EXODII_MERCHANT_Talk",
        },
        {
            text = ccb.content.text("I've gotta go.  See you later, Rubik."),
            next_topic = "TALK_DONE",
        },
    },
}

-- Many times.  It doesn't always go the same, and sometimes they only show up right before we leave the world, but they always do.
ccb.content.define_dialogue_topic {
    id = { "TALK_EXODII_MERCHANT_alien_flora_source" },
    line = ccb.content.text("Time an' time.\"  Rubik pauses for a moment.  \"There be eddies and ripples, aye, an' sometime they come just afore we make to wobble on, but they surely do."),
    replies = {
        {
            text = ccb.content.text("Is there any way to stop it?  Can we cut them down or burn them or something?"),
            next_topic = "TALK_EXODII_MERCHANT_alien_flora_burn",
        },
        {
            text = ccb.content.text("Can we talk about something else?"),
            next_topic = "TALK_EXODII_MERCHANT_Talk",
        },
        {
            text = ccb.content.text("I've gotta go.  See you later, Rubik."),
            next_topic = "TALK_DONE",
        },
    },
}

ccb.content.define_dialogue_topic {
    id = { "TALK_EXODII_MERCHANT_New", "TALK_EXODII_MERCHANT_Talk" },
    replies = {
        {
            text = ccb.content.text("[Premonition] *Check for anything amiss*"),
            next_topic = "TALK_EXODII_MERCHANT_danger_sense",
            when = predicates.handler("dlg_p_mindovermatter_222d75bf80b0"),
        },
        {
            text = ccb.content.text("[Sense Hostility] *Determine if <npc_name> is a threat*"),
            next_topic = "TALK_EXODII_MERCHANT_sense_hostility",
            when = predicates.handler("dlg_p_mindovermatter_5b3ce0810487"),
        },
    },
}

ccb.content.define_dialogue_topic {
    id = { "TALK_EXODII_MERCHANT_danger_sense" },
    line = ccb.content.text("&You extend your senses, alert for danger, and are surprised at the result.  There is danger here, but it's muted, and certainly Rubik doesn't seem to bear you any malice.  If any place is safe in the hell that the Earth has become, this is it."),
    replies = { { text = ccb.content.text("…"), next_topic = "TALK_EXODII_MERCHANT_Talk" } },
}

-- TODO: Change this depending on how much Rubik trusts the PC.
ccb.content.define_dialogue_topic {
    id = { "TALK_EXODII_MERCHANT_sense_hostility" },
    line = ccb.content.text("&You extend your senses, probing at Rubik's attitude, and come away with a sense of relief.  Rubik certainly doesn't plan any violent action at this moment."),
    replies = { { text = ccb.content.text("…"), next_topic = "TALK_EXODII_MERCHANT_Talk" } },
}

ccb.content.define_dialogue_topic {
    id = { "TALK_EXODII_MERCHANT_New", "TALK_EXODII_MERCHANT_Talk", "TALK_EXODII_MERCHANT_Exodus", "TALK_EXODII_MERCHANT_Exodus2", "TALK_EXODII_MERCHANT_Exodus3", "TALK_EXODII_MERCHANT_Survival2" },
    replies = {
        {
            text = ccb.content.text("[Telepathy] *Read <npc_name>'s mind*"),
            next_topic = "TALK_EXODII_MERCHANT_scan",
            when = predicates.handler("dlg_p_mindovermatter_c24efe0eb6fd"),
        },
    },
}

ccb.content.define_dialogue_topic {
    id = { "TALK_EXODII_MERCHANT_scan" },
    line = ccb.content.text("&You weren't expecting to be able to understand Rubik's thoughts.  Whatever language it is, this \"Anglic\", the resemblance to English is clearly a fortunate coincidence.  But you are surprised that your telepathic scan doesn't pick up anything at all.  Just a faint static hum, rising and falling in an irregular pattern."),
    replies = {
        {
            text = ccb.content.text("*Withdraw from <npc_name>'s mind*."),
            next_topic = "TALK_EXODII_MERCHANT_Talk",
        },
        {
            text = ccb.content.text("[Telepathy] *Go deeper*."),
            next_topic = "TALK_EXODII_MERCHANT_deep_scan",
            when = predicates.handler("dlg_p_mindovermatter_ed589545a0d1"),
        },
    },
}

ccb.content.define_dialogue_topic {
    id = { "TALK_EXODII_MERCHANT_deep_scan" },
    line = ccb.content.text("&Your awareness of the outside world fades as you fall into Rubik's mind.\n\nYou see a child in a thriving metropolis, doing odd jobs for spare coins, playing in the alleys with friends, coming home at dusk for supper.  You see a young adult running from a group of zombies.  You see this castle, or near enough--some towers are missing, some missing towers are there, but obviously the same--and its denizens fending off an attack from a group of winged things.  You see a conversation in a language you've never heard before among a group of Exodii, before everyone files into rooms, secures themselves with restraints, and there's a brief moment of searing pain and then darkness, filled with static and bursts of light half-glimpsed in your peripheral vision.\n\nYou see worlds.  World after world, in a procession over…decades?  Centuries?  You can't tell; you have no sense of time during the vision.  Most worlds were less advanced than the Earth, and the few survivors fought the dead with human wave tactics and trench warfare, or lines of musketeers, or archers from behind the trees.  Sometimes, doughty warriors clad in iron or bronze hurled themselves at the enemy with sword and shield in hand, until they fell and their corpses rose again.  In one world, the survivors fought with powered armor and particle-beam weapons.  But on every world, slowly, inexorably, the dead or the fungus or the walking trees or things you have no name for ground down the defenders until humanity was on the brink of extinction and, with a few survivors in tow, the Exodii powered up their jump devices and continued the Long Retreat.\n\nIn the end, not once, in a dozen or a hundred or you know not how many worlds, was there anything left to save."),
    replies = {
        {
            text = ccb.content.text("*Withdraw from Rubik's mind*."),
            next_topic = "TALK_EXODII_MERCHANT_Post_Scan",
            actions = { actions.handler("dlg_a_mindovermatter_df936e254f08") },
        },
    },
}

ccb.content.define_dialogue_topic {
    id = { "TALK_EXODII_MERCHANT_Post_Scan" },
    line = ccb.content.text("&Rubik is looking at you oddly.  The silence is palpable."),
    replies = {
        {
            text = ccb.content.text("Sorry, I must have zoned out for a moment there.  It's been a long day.  You were saying?"),
            next_topic = "TALK_EXODII_MERCHANT_Talk",
        },
    },
}
