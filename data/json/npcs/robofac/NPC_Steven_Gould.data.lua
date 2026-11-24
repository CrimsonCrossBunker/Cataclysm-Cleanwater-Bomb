local ccb = require("ccb")
local predicates = ccb.content.dialogue_predicates
local actions = ccb.content.dialogue_actions

-- Appears at the field station during the quest Invasive "Meteorology:" contact the field team.
ccb.content.define_npc {
    id = "robofac_merc_monster_corpse_1",
    unique_name = ccb.content.text("Steven Gould"),
    suffix = ccb.content.text("Hub Mercenary"),
    class = "NC_ROBOFAC_MERC_MONSTER_CORPSE_1",
    attitude = 0,
    mission = "GUARD",
    chat = "TALK_ROBOFAC_MERC_MONSTER_CORPSE_1",
    faction = "robofac_auxiliaries",
}

ccb.content.define_npc_class {
    id = "NC_ROBOFAC_MERC_MONSTER_CORPSE_1",
    name = ccb.content.text("Hub Mercenary"),
    job_description = ccb.content.text("Fighting for the all-mighty dollar."),
    common = false,
    traits = {
        { trait = "hair_medium", variant = "black" },
        { trait = "natural_hair_color_black" },
        { trait = "eye_color", variant = "brown" },
        { trait = "SKIN_PINK" },
        { trait = "RETURN_TO_START_POS" },
    },
    strength = 1,
    dexterity = 1,
    perception = 1,
    intelligence = 4,
    worn = "NC_ROBOFAC_MERC_MONSTER_CORPSE_1_worn",
    carry = "NC_ROBOFAC_MERC_MONSTER_CORPSE_1_carry",
}

ccb.content.define_dialogue_topic {
    id = { "TALK_ROBOFAC_MERC_MONSTER_CORPSE_1" },
    line = ccb.content.text("Ah, the other contractor.  We've got things covered up here… but I guess you're going down into the \"thing.\"  If you've got coins, I've got a bit of spare equipment that might be useful."),
    replies = {
        {
            text = ccb.content.text("Any idea what's going on down there?"),
            next_topic = "TALK_ROBOFAC_MERC_MONSTER_CORPSE_1_RECON",
        },
        {
            text = ccb.content.text("What kind of equipment you looking to trade?"),
            next_topic = "TALK_ROBOFAC_MERC_MONSTER_CORPSE_1_EQUIPMENT",
            when = predicates.negate(predicates.any_equal({ "yes", { scope = "speaker", key = "bought_gear_monster_corpse_merc" } })),
        },
        { text = ccb.content.text("I'll see you around."), next_topic = "TALK_DONE" },
    },
}

ccb.content.define_dialogue_topic {
    id = "TALK_ROBOFAC_MERC_MONSTER_CORPSE_1_RECON",
    line = ccb.content.text("Well… guess I don't have to tell you about the giant hunk of meat outside.  We've finished our subsurface scans, and if I didn't know any better, I'd say this thing is a giant piece of calamari.  Nasty shit.  I'd be shocked if it weren't for all the other strange shit going on out there these days."),
    replies = { { text = ccb.content.text("Thanks."), next_topic = "TALK_DONE" } },
}

ccb.content.define_dialogue_topic {
    id = "TALK_ROBOFAC_MERC_MONSTER_CORPSE_1_EQUIPMENT",
    line = ccb.content.text("I've got an extra recon helmet and a powered air purifying respirator system.  The light amplification on the helmet still works.  The PAPR is a scavenged military mask with an old commercial blower.  Package deal.  Don't ask where I got 'em.  Ten coins."),
    replies = {
        {
            text = ccb.content.text("No, thanks."),
            next_topic = "TALK_DONE",
        },
        {
            text = ccb.content.text("[10 HGC] You have a deal."),
            next_topic = "TALK_ROBOFAC_MERC_MONSTER_CORPSE_1_EQUIPMENT_ACCEPTED",
            when = predicates.has_inventory("speaker", "RobofacCoin", 10),
            actions = { actions.handler("dlg_a_dda_ecb25882f709"), actions.set_actor_value("speaker", "bought_gear_monster_corpse_merc", "yes") },
        },
    },
}

ccb.content.define_dialogue_topic {
    id = "TALK_ROBOFAC_MERC_MONSTER_CORPSE_1_EQUIPMENT_ACCEPTED",
    line = ccb.content.text("You didn't get that from me, yeah?"),
    replies = { { text = ccb.content.text("Thanks."), next_topic = "TALK_DONE" } },
}

-- just a grunt
ccb.content.define_npc {
    id = "robofac_merc_monster_corpse_2",
    unique_name = ccb.content.text("armed mercenary"),
    class = "NC_ANCILLA_GRUNT",
    attitude = 0,
    mission = "GUARD",
    chat = "TALK_ROBOFAC_MERC_MONSTER_CORPSE_2",
    faction = "robofac_auxiliaries",
}

ccb.content.define_dialogue_topic {
    id = "TALK_ROBOFAC_MERC_MONSTER_CORPSE_2",
    line = ccb.content.text("I'm just paid to stand guard and watch the drones.  Talk to the boss in the pavilion if you need something."),
    replies = { { text = ccb.content.text("Thanks."), next_topic = "TALK_DONE" } },
}
