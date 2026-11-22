local ccb = require("ccb")
local predicates = ccb.content.dialogue_predicates
local actions = ccb.content.dialogue_actions



ccb.content.define_dialogue_topic {
    id = "TALK_BLACKSMITH_WEAPONSMITH_STEEL",
    line = ccb.content.text("Okay.  What about the steel grade?  Tempering will make your weapon much more durable and a little sharper."),
    replies = {
        {
            text = ccb.content.text("No, high carbon steel is fine."),
            next_topic = "TALK_BLACKSMITH_WEAPONSMITH_PAYMENT",
            actions = { actions.set_string({ scope = "speaker", key = "general_artisans_blacksmith_weapon" }, { "hc_<u_val:general_artisans_blacksmith_weapon_type>" }, true) },
        },
        {
            text = ccb.content.text("[+50 merch, +2 days] Yes, tempered steel would be excellent."),
            next_topic = "TALK_BLACKSMITH_WEAPONSMITH_PAYMENT",
            actions = { actions.set_string({ scope = "speaker", key = "general_artisans_blacksmith_weapon" }, { "qt_<u_val:general_artisans_blacksmith_weapon_type>" }, true), actions.handler("dlg_a_dda_5c8c216dbf3f") },
        },
        {
            text = ccb.content.text("Forget it."),
            next_topic = "TALK_BLACKSMITH_SERVICES",
        },
    },
}

ccb.content.define_dialogue_topic {
    id = "TALK_BLACKSMITH_WEAPONSMITH_PAYMENT",
    line = ccb.content.text("Great, so I can make your <item_name:<u_val:general_artisans_blacksmith_weapon>> for <u_val:number_artisans_blacksmith_weapon_cost> merch and in <u_val:number_artisans_blacksmith_weapon_wait> days.  Deal?"),
    replies = {
        {
            text = ccb.content.text("[<u_val:number_artisans_blacksmith_weapon_cost> merch] Deal.  See you in <u_val:number_artisans_blacksmith_weapon_wait> days."),
            next_topic = "TALK_DONE",
            when = predicates.handler("dlg_p_dda_d1ef82a2d0b8"),
            actions = { actions.handler("dlg_a_dda_2865e9cfc962"), actions.set_actor_value("speaker", "dialogue_artisans_u_current_project", "weapon"), actions.set_actor_value("speaker", "dialogue_artisans_blacksmith_crafting", "yes"), actions.handler("dlg_a_dda_520abba74b5a") },
            switch = true,
        },
        {
            text = ccb.content.text("Um… wait, I don't have that kind of money right now."),
            next_topic = "TALK_BLACKSMITH_SERVICES",
            switch = true,
        },
        {
            text = ccb.content.text("Forget it."),
            next_topic = "TALK_BLACKSMITH_SERVICES",
        },
    },
}

ccb.content.define_dialogue_topic {
    id = "TALK_BLACKSMITH_WEAPONSMITH",
    line = {
        when = predicates.any_equal({ "", { scope = "speaker", key = "general_artisans_blacksmith_weapon" } }),
        yes = ccb.content.gendered_line("Sure.  After what you've done for me, I'll forge you the finest work of art.  The price and waiting time depend on the size of the weapon in question, but it will take me a fair amount of money to buy the quality steel I need from the scavengers, and even forging a short blade will take a few days.\n\nI can also temper your weapon, but that will cost an additional 50 merch and take an additional 2 days, but I assure you, it's worth it.", { "speaker" }),
        no = ccb.content.text("Do you still want to order your <item_name:<u_val:general_artisans_blacksmith_weapon>> or would you like to choose something else?"),
    },
    replies = {
        {
            text = ccb.content.text("Forget it."),
            next_topic = "TALK_BLACKSMITH_SERVICES",
        },
        {
            text = ccb.content.text("Yes, I want to order it."),
            next_topic = "TALK_BLACKSMITH_WEAPONSMITH_PAYMENT",
            when = predicates.negate(predicates.any_equal({ "", { scope = "speaker", key = "general_artisans_blacksmith_weapon" } })),
        },
        {
            text = ccb.content.text("[200 merch, 3 days] I need a mace."),
            next_topic = "TALK_BLACKSMITH_WEAPONSMITH_STEEL",
            actions = { actions.handler("w16b_a_dda_89f0361aa577") },
        },
        {
            text = ccb.content.text("[250 merch, 4 days] I need a war hammer."),
            next_topic = "TALK_BLACKSMITH_WEAPONSMITH_STEEL",
            actions = { actions.handler("w16b_a_dda_700d7ef9bffb") },
        },
        {
            text = ccb.content.text("[200 merch, 3 days] I need a steelshod quarterstaff."),
            next_topic = "TALK_BLACKSMITH_WEAPONSMITH_STEEL",
            actions = { actions.handler("w16b_a_dda_4169a5712356") },
        },
        {
            text = ccb.content.text("[250 merch, 4 days] I need a battle axe."),
            next_topic = "TALK_BLACKSMITH_WEAPONSMITH_STEEL",
            actions = { actions.handler("w16b_a_dda_2229dd3b8561") },
        },
        {
            text = ccb.content.text("[250 merch, 4 days] I need a longsword."),
            next_topic = "TALK_BLACKSMITH_WEAPONSMITH_STEEL",
            actions = { actions.handler("w16b_a_dda_f934a9ca1a8a") },
        },
        {
            text = ccb.content.text("[250 merch, 4 days] I need a nodachi."),
            next_topic = "TALK_BLACKSMITH_WEAPONSMITH_STEEL",
            actions = { actions.handler("w16b_a_dda_aa4b676392ac") },
        },
        {
            text = ccb.content.text("[250 merch, 4 days] I need a zweihander."),
            next_topic = "TALK_BLACKSMITH_WEAPONSMITH_STEEL",
            actions = { actions.handler("w16b_a_dda_5e934a89998e") },
        },
        {
            text = ccb.content.text("[200 merch, 3 days] I need an arming sword."),
            next_topic = "TALK_BLACKSMITH_WEAPONSMITH_STEEL",
            actions = { actions.handler("w16b_a_dda_ed1833396d01") },
        },
        {
            text = ccb.content.text("[200 merch, 3 days] I need a broadsword."),
            next_topic = "TALK_BLACKSMITH_WEAPONSMITH_STEEL",
            actions = { actions.handler("w16b_a_dda_de77851253a6") },
        },
        {
            text = ccb.content.text("[200 merch, 3 days] I need a cavalry saber."),
            next_topic = "TALK_BLACKSMITH_WEAPONSMITH_STEEL",
            actions = { actions.handler("w16b_a_dda_c7c30547d83a") },
        },
        {
            text = ccb.content.text("[200 merch, 3 days] I need a cutlass."),
            next_topic = "TALK_BLACKSMITH_WEAPONSMITH_STEEL",
            actions = { actions.handler("w16b_a_dda_395a239c0ce5") },
        },
        {
            text = ccb.content.text("[200 merch, 3 days] I need a katana."),
            next_topic = "TALK_BLACKSMITH_WEAPONSMITH_STEEL",
            actions = { actions.handler("w16b_a_dda_fa203ada633b") },
        },
        {
            text = ccb.content.text("[170 merch, 3 days] I need a wakizashi."),
            next_topic = "TALK_BLACKSMITH_WEAPONSMITH_STEEL",
            actions = { actions.handler("w16b_a_dda_399d99743ac8") },
        },
        {
            text = ccb.content.text("[150 merch, 2 days] I need a kukri."),
            next_topic = "TALK_BLACKSMITH_WEAPONSMITH_STEEL",
            actions = { actions.handler("w16b_a_dda_fb3b5ea761eb") },
        },
        {
            text = ccb.content.text("[250 merch, 4 days] I need an estoc."),
            next_topic = "TALK_BLACKSMITH_WEAPONSMITH_STEEL",
            actions = { actions.handler("w16b_a_dda_dccd4e701312") },
        },
        {
            text = ccb.content.text("[200 merch, 3 days] I need a rapier."),
            next_topic = "TALK_BLACKSMITH_WEAPONSMITH_STEEL",
            actions = { actions.handler("w16b_a_dda_1b67f85762e7") },
        },
        {
            text = ccb.content.text("[70 merch, 2 days] I need a trench knife."),
            next_topic = "TALK_BLACKSMITH_WEAPONSMITH_STEEL",
            actions = { actions.handler("w16b_a_dda_43313c5b582e") },
        },
    },
}

ccb.content.define_dialogue_topic {
    id = "TALK_BLACKSMITH_WEAPON_READY",
    line = {
        when = predicates.handler("w16b_p_dda_32f199590268"),
        yes = ccb.content.text("It's all done!  Sorry for the long wait; hopefully it's worth it."),
        no = ccb.content.text("Still working on it."),
    },
    replies = {
        {
            text = ccb.content.text("Thanks."),
            next_topic = "TALK_BLACKSMITH_SERVICES",
            when = predicates.handler("w16b_p_dda_32f199590268"),
            actions = { actions.set_actor_value("speaker", "dialogue_artisans_blacksmith_crafting", "no"), actions.set_actor_value("speaker", "dialogue_artisans_u_current_project", "none"), actions.handler("w16b_a_dda_a8019ce83bf5") },
            switch = true,
        },
        {
            text = ccb.content.text("See you when it's done."),
            next_topic = "TALK_DONE",
            switch = true,
        },
    },
}
