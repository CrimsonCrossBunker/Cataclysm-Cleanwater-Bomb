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
