local ccb = require("ccb")
local predicates = ccb.content.dialogue_predicates
local actions = ccb.content.dialogue_actions

ccb.content.define_dialogue_topic {
    id = { "TALK_BLACKSMITH_SERVICES", "TALK_BLACKSMITH_PROTOTYPE_EXODII_ITEMS_READY" },
    line = {
        choices = {
            ccb.content.text("Hiya darlin', welcome to the shop."),
            ccb.content.text("Hey, killer!  How's it going?"),
            ccb.content.gendered_line("You look like you haven't eaten in days.", { "speaker" }),
            ccb.content.text("Still the apocalypse out there, huh?"),
            ccb.content.text("See anything you like?"),
        },
    },
    on_enter = {
        { actions = { actions.set_actor_value("speaker", "u_met_isolated_road_artisans", "yes"), actions.set_actor_value("speaker", "u_met_isolated_road_cody", "yes"), actions.add_effect("interlocutor", "npc_said", { turns = 600 }) } },
    },
    replies = {
        {
            text = ccb.content.text("About that contract…"),
            next_topic = "TALK_MISSION_INQUIRE",
            when = predicates.assigned_missions(1, 1),
        },
        {
            text = ccb.content.text("Who are you?"),
            next_topic = "TALK_BLACKSMITH_ABOUT",
        },
        {
            text = ccb.content.text("What's with all the weapons and armor?"),
            next_topic = "TALK_BLACKSMITH_SHOP_ABOUT",
        },
        {
            text = ccb.content.text("What is this place?"),
            next_topic = "TALK_BLACKSMITH_LOCATION_ABOUT",
            when = predicates.negate(predicates.any_equal({ "yes", { scope = "speaker", key = "dialogue_artisans_blacksmith_mentioned_jay" } })),
        },
        {
            text = ccb.content.text("Are you and Jay close?"),
            next_topic = "TALK_BLACKSMITH_JAY",
            when = predicates.all({ predicates.any_equal({ "yes", { scope = "speaker", key = "dialogue_artisans_blacksmith_mentioned_jay" } }), predicates.negate(predicates.any_equal({ "yes", { scope = "speaker", key = "dialogue_artisans_blacksmith_accepted_quest" } })) }),
        },
        {
            text = ccb.content.text("[Motion to the sketches.] What is it that you are working on?"),
            next_topic = "TALK_BLACKSMITH_PROTOTYPE_NOT_FEELING_IT",
            when = predicates.all({ predicates.any_equal({ "yes", { scope = "speaker", key = "dialogue_artisans_seen_blacksmith_sketches" } }), predicates.negate(predicates.any_equal({ "yes", { scope = "speaker", key = "dialogue_artisans_artisans_made_up" } })) }),
        },
        {
            text = ccb.content.text("[Motion to the sketches.] You seem more excited about this stuff recently."),
            next_topic = "TALK_BLACKSMITH_PROTOTYPE_FEELING_IT",
            when = predicates.all({ predicates.any_equal({ "yes", { scope = "speaker", key = "dialogue_artisans_seen_blacksmith_sketches" } }), predicates.any_equal({ "yes", { scope = "speaker", key = "dialogue_artisans_artisans_made_up" } }) }),
        },
        {
            text = ccb.content.text("I'd like to know more about some of your 'special' projects."),
            next_topic = "TALK_BLACKSMITH_PROTOTYPE",
            when = predicates.all({ predicates.any_equal({ "yes", { scope = "speaker", key = "dialogue_artisans_blacksmith_can_prototype" } }) }),
        },
        {
            text = ccb.content.text("[Show the nomad jumpsuit blueprint.] Hey - I met a group with some interesting ideas for armor design.  Is any of this of use to you?"),
            next_topic = "TALK_BLACKSMITH_PROTOTYPE_EXODII",
            when = predicates.all({ predicates.has_inventory("speaker", "bp_nomad_jumpsuit", 1), predicates.negate(predicates.any_equal({ "yes", { scope = "speaker", key = "dialogue_artisans_blacksmith_crafting_EXODII" } })) }),
        },
        {
            text = ccb.content.text("[100 merch] I'd like to become a member of the co-op."),
            next_topic = "TALK_BLACKSMITH_BOUGHT_COOP",
            when = predicates.all({ predicates.has_inventory("speaker", "FMCNote", 100), predicates.any_equal({ "yes", { scope = "speaker", key = "dialogue_artisans_blacksmith_can_buy_coop" } }) }),
            actions = { actions.transfer_items("FMCNote", 100), actions.handler("dlg_a_dda_b93f2c539aff"), actions.set_actor_value("speaker", "dialogue_artisans_blacksmith_can_buy_coop", "no") },
        },
        {
            text = ccb.content.text("About those contracts…"),
            next_topic = "TALK_MISSION_LIST_ASSIGNED",
            when = predicates.assigned_missions(2),
        },
        {
            text = ccb.content.text("Why do you hate merch?"),
            next_topic = "TALK_BLACKSMITH_MONEY_RAMBLE",
            when = predicates.any_equal({ "yes", { scope = "speaker", key = "dialogue_artisans_blacksmith_hates_currency" } }),
        },
        {
            text = ccb.content.text("Any jobs you need done?"),
            next_topic = "TALK_MISSION_LIST",
            when = predicates.all({ predicates.any_equal({ "yes", { scope = "speaker", key = "dialogue_artisans_artisans_made_up" } }), predicates.all({ predicates.negate(predicates.assigned_missions(1, 1)), predicates.negate(predicates.assigned_missions(2)) }) }),
        },
        {
            text = ccb.content.text("Could you make me a suit of armor?"),
            next_topic = "TALK_BLACKSMITH_NOT_INTERESTED_FABRICATE",
            when = predicates.all({ predicates.negate(predicates.any_equal({ "yes", { scope = "speaker", key = "dialogue_artisans_gunsmith_mentioned_quest" } })), predicates.negate(predicates.any_equal({ "yes", { scope = "speaker", key = "dialogue_artisans_blacksmith_crafting" } })), predicates.any_equal({ "yes", { scope = "speaker", key = "dialogue_artisans_blacksmith_heard_the_deal" } }) }),
        },
        {
            text = ccb.content.text("Could you make me a suit of armor?"),
            next_topic = "TALK_BLACKSMITH_FABRICATE",
            when = predicates.all({ predicates.negate(predicates.any_equal({ "yes", { scope = "speaker", key = "dialogue_artisans_blacksmith_crafting" } })), predicates.any_equal({ "yes", { scope = "speaker", key = "dialogue_artisans_gunsmith_mentioned_quest" } }) }),
        },
        {
            text = ccb.content.text("Could you make me a weapon?"),
            next_topic = "TALK_BLACKSMITH_NOT_INTERESTED_FABRICATE",
            when = predicates.all({ predicates.negate(predicates.any_equal({ "yes", { scope = "speaker", key = "dialogue_artisans_gunsmith_mentioned_quest" } })), predicates.negate(predicates.any_equal({ "yes", { scope = "speaker", key = "dialogue_artisans_blacksmith_crafting" } })), predicates.any_equal({ "yes", { scope = "speaker", key = "dialogue_artisans_blacksmith_heard_the_deal" } }) }),
        },
        {
            text = ccb.content.text("Could you make me a weapon?"),
            next_topic = "TALK_BLACKSMITH_WEAPONSMITH",
            when = predicates.all({ predicates.negate(predicates.any_equal({ "yes", { scope = "speaker", key = "dialogue_artisans_blacksmith_crafting" } })), predicates.any_equal({ "yes", { scope = "speaker", key = "dialogue_artisans_gunsmith_mentioned_quest" } }) }),
        },
        {
            text = ccb.content.text("How is my armor coming?"),
            next_topic = "TALK_BLACKSMITH_ARMOR_READY",
            when = predicates.all({ predicates.any_equal({ "yes", { scope = "speaker", key = "dialogue_artisans_blacksmith_crafting" } }), predicates.any_equal({ "armor", { scope = "speaker", key = "dialogue_artisans_u_current_project" } }) }),
        },
        {
            text = ccb.content.text("How is my weapon coming?"),
            next_topic = "TALK_BLACKSMITH_WEAPON_READY",
            when = predicates.all({ predicates.any_equal({ "yes", { scope = "speaker", key = "dialogue_artisans_blacksmith_crafting" } }), predicates.any_equal({ "weapon", { scope = "speaker", key = "dialogue_artisans_u_current_project" } }) }),
        },
        {
            text = ccb.content.text("You mentioned you'd need some special materials to make that nomad armor?"),
            next_topic = "TALK_BLACKSMITH_PROTOTYPE_EXODII_ITEMS",
            when = predicates.all({ predicates.negate(predicates.any_equal({ "yes", { scope = "speaker", key = "dialogue_artisans_blacksmith_has_exodii_items" } })), predicates.any_equal({ "yes", { scope = "speaker", key = "dialogue_artisans_blacksmith_crafting_EXODII" } }) }),
        },
        {
            text = ccb.content.text("Let's trade."),
            next_topic = "TALK_BLACKSMITH_SERVICES",
            when = predicates.any_equal({ "yes", { scope = "speaker", key = "dialogue_artisans_blacksmith_heard_the_deal" } }),
            actions = { "start_trade" },
        },
        {
            text = ccb.content.text("Interesting.  When would be the next batch of merchandise ready?"),
            next_topic = "TALK_BLACKSMITH_RESTOCK",
        },
        {
            text = ccb.content.text("I heard you might want some metal…"),
            next_topic = "TALK_BLACKSMITH_DEAL_NEGOTIATE",
            when = predicates.has_mission("MISSION_SCRAPPER_SET_TRADE_ROUTE_BLACKSMITH"),
        },
        {
            text = ccb.content.text("<end_talking_leave>"),
            next_topic = "TALK_DONE",
        },
    },
}
