local ccb = require("ccb")

-- just a grunt
ccb.content.define_npc {
    id = "robofac_chop_shop_merc_2",
    unique_name = ccb.content.text("armed mercenary"),
    class = "NC_ANCILLA_GRUNT_CHOP_SHOP",
    attitude = 0,
    mission = "GUARD",
    chat = "TALK_ROBOFAC_MERC_CHOP_SHOP",
    faction = "robofac_auxiliaries_chop_shop",
}

-- just a grunt
ccb.content.define_npc {
    id = "robofac_chop_shop_merc_3",
    unique_name = ccb.content.text("armed mercenary"),
    class = "NC_ANCILLA_GRUNT_CHOP_SHOP",
    attitude = 0,
    mission = "GUARD",
    chat = "TALK_ROBOFAC_MERC_CHOP_SHOP",
    faction = "robofac_auxiliaries_chop_shop",
}

-- just a grunt
ccb.content.define_npc {
    id = "robofac_chop_shop_merc_4",
    unique_name = ccb.content.text("armed mercenary"),
    class = "NC_ANCILLA_GRUNT",
    attitude = 0,
    mission = "GUARD",
    chat = "TALK_ROBOFAC_MERC_CHOP_SHOP",
    faction = "robofac_auxiliaries_chop_shop",
}

-- just a grunt
ccb.content.define_npc {
    id = "robofac_chop_shop_merc_5",
    unique_name = ccb.content.text("armed mercenary"),
    class = "NC_ANCILLA_GRUNT_CHOP_SHOP",
    attitude = 0,
    mission = "GUARD",
    chat = "TALK_ROBOFAC_MERC_CHOP_SHOP",
    faction = "robofac_auxiliaries_chop_shop",
}

-- just a grunt
ccb.content.define_npc {
    id = "robofac_chop_shop_merc_6",
    unique_name = ccb.content.text("armed mercenary"),
    class = "NC_ANCILLA_GRUNT_CHOP_SHOP",
    attitude = 0,
    mission = "GUARD",
    chat = "TALK_ROBOFAC_MERC_CHOP_SHOP",
    faction = "robofac_auxiliaries_chop_shop",
}

ccb.content.define_npc_class {
    id = "NC_ANCILLA_GRUNT_CHOP_SHOP",
    name = ccb.content.text("Mercenary"),
    job_description = ccb.content.text("Fighting in the name of Hub 01 and money, mostly money."),
    common = false,
    traits = {
        { group = "BG_survival_story_POLICE" },
        { group = "NPC_starting_traits" },
        { group = "Appearance_demographics" },
        { trait = "NO_BASH" },
        { trait = "RETURN_TO_START_POS" },
    },
    strength = { rng = { 0, 1 } },
    dexterity = { rng = { 0, 2 } },
    intelligence = { rng = { -2, 0 } },
    perception = { rng = { 0, 2 } },
    worn = "NC_ANCILLA_GRUNT_CHOP_SHOP_worn",
    carry = "NC_ANCILLA_GRUNT_CHOP_SHOP_carry",
    weapon = "NC_ANCILLA_GRUNT_CHOP_SHOP_wield",
    skills = {
        { skill = "ALL", level = { sum = { { dice = { 3, 2 } }, { constant = -3 } } } },
        { skill = "gun", bonus = { rng = { 2, 4 } } },
        { skill = "pistol", bonus = { rng = { 2, 4 } } },
        { skill = "rifle", bonus = { rng = { 2, 4 } } },
    },
}

ccb.content.define_dialogue_topic {
    id = "TALK_ROBOFAC_MERC_CHOP_SHOP",
    line = {
        choices = {
            ccb.content.text("&This merc's gear is drab, a bit bloody, and hangs loose on them.  They look like they haven't washed in some time.  Their eyes are wide and they stare off into the distance.  They address you in an emotionless tone: \"Talk to David.  He's the boss.\""),
            ccb.content.text("&The merc doesn't even look at you.  They just stare off at the horizon."),
            ccb.content.text("&The merc jumps nervously as you approach, stares a moment, and speaks, looking suddenly disgusted: \"Talk to David, not me.\""),
            ccb.content.text("&The merc sits slowly rubbing the back of their neck, staring at the ground.  They don't acknowledge you."),
            ccb.content.text("&The merc is silently cleaning the outside of their bloodied firearm.  \"Fuck off.\" they say, their voice completely lacking any emotion."),
            ccb.content.text("&You think the merc may be crying.  Their eyes are bloodshot and wet.  They ignore you."),
            ccb.content.text("&This merc is filthy, and clearly hasn't washed in a while.  They nervously rub their hands together before staring sternly at you.  Then, they look at the other mercs and just motion toward them with a nod of their head."),
            ccb.content.text("Fuck off.  I don't feel like talkin'.  Talk to the boss."),
            ccb.content.text("Get tha fuck outta'heah, ya' fuckin' shit."),
            ccb.content.text("I don't want anything to do with you, dude.  Go talk to Dave, or get the fuck outta dodge."),
        },
    },
    replies = { { text = ccb.content.text("Bye."), next_topic = "TALK_DONE" } },
}
