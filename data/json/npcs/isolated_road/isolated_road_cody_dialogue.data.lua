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

ccb.content.define_dialogue_topic {
    id = "TALK_BLACKSMITH_RESTOCK",
    line = ccb.content.text("With how the things are goin'? <restock_time_point>."),
    replies = {
        {
            text = ccb.content.text("I'll leave you to your work then.  <end_talking_bye>"),
            next_topic = "TALK_DONE",
        },
    },
}

ccb.content.define_dialogue_topic {
    id = "TALK_BLACKSMITH_ABOUT",
    line = {
        choices = {
            ccb.content.text("I'm Cody, was an engineer before everything went to hell.  I guess I still am, but I don't have to consult anymore, so I consider that a plus at least."),
        },
    },
    replies = {
        {
            text = ccb.content.text("What's with all the weapons and armor?"),
            next_topic = "TALK_BLACKSMITH_SHOP_ABOUT",
        },
        {
            text = ccb.content.text("What is this place?"),
            next_topic = "TALK_BLACKSMITH_LOCATION_ABOUT",
        },
        { text = ccb.content.text("Alright."), next_topic = "TALK_BLACKSMITH_SERVICES" },
    },
}

ccb.content.define_dialogue_topic {
    id = "TALK_BLACKSMITH_LOCATION_ABOUT",
    line = {
        choices = {
            ccb.content.text("I don't know if you've met Jay yet, but he and I split a garden out here.  We both work - well, worked - in technology, and we were convinced the world was ending so we both got property outside town.  We met when he moved in next door.  So this is our little homestead with a few upgrades.  We aren't really sweating property lines at this point."),
        },
    },
    on_enter = {
        {
            actions = {
                actions.set_actor_value("speaker", "dialogue_artisans_blacksmith_mentioned_jay", "yes"),
            },
        },
    },
    replies = {
        {
            text = ccb.content.text("What's with all the weapons and armor?"),
            next_topic = "TALK_BLACKSMITH_SHOP_ABOUT",
        },
        { text = ccb.content.text("Who are you?"), next_topic = "TALK_BLACKSMITH_ABOUT" },
        {
            text = ccb.content.text("Are you and Jay close?"),
            next_topic = "TALK_BLACKSMITH_JAY",
            when = predicates.negate(predicates.any_equal({ "yes", { scope = "speaker", key = "dialogue_artisans_blacksmith_accepted_quest" } })),
        },
        { text = ccb.content.text("Alright."), next_topic = "TALK_BLACKSMITH_SERVICES" },
    },
}

ccb.content.define_dialogue_topic {
    id = "TALK_BLACKSMITH_SHOP_ABOUT",
    line = {
        choices = {
            ccb.content.text("I make them myself!  I've always loved traditional armaments and am a proud member of the SCA!  Figured now that everything has gone to hell I can make it a full-time thing.  Lots of survivors in need of a big ol' hammer or some armored guards to keep the biters off."),
        },
    },
    on_enter = {
        {
            actions = {
                actions.set_actor_value("speaker", "dialogue_artisans_blacksmith_heard_the_deal", "yes"),
            },
        },
    },
    replies = {
        {
            text = ccb.content.text("It must take some serious equipment to make all this."),
            next_topic = "TALK_BLACKSMITH_SHOP_ABOUT_MORE",
        },
        {
            text = ccb.content.text("What is this place?"),
            next_topic = "TALK_BLACKSMITH_LOCATION_ABOUT",
        },
        { text = ccb.content.text("Alright."), next_topic = "TALK_BLACKSMITH_SERVICES" },
    },
}

ccb.content.define_dialogue_topic {
    id = "TALK_BLACKSMITH_SHOP_ABOUT_MORE",
    line = {
        choices = {
            ccb.content.text("Well, what can I say, I had lots of disposable income.  Kept me busy and all that.  So yeah, I've got a pretty impressive shop in the back."),
        },
    },
    on_enter = {
        {
            actions = {
                actions.set_actor_value("speaker", "dialogue_artisans_blacksmith_heard_the_deal", "yes"),
            },
        },
    },
    replies = {
        {
            text = ccb.content.text("Still this is a lot of equipment.  Wouldn't it have been easier to buy this stuff from a manufacturer?"),
            next_topic = "TALK_BLACKSMITH_SHOP_ABOUT_STUPID_QUESTION",
        },
        {
            text = ccb.content.text("Can anyone use the workshop?"),
            next_topic = "TALK_BLACKSMITH_COOP_ABOUT",
        },
        { text = ccb.content.text("Alright."), next_topic = "TALK_BLACKSMITH_SERVICES" },
    },
}

ccb.content.define_dialogue_topic {
    id = "TALK_BLACKSMITH_SHOP_ABOUT_STUPID_QUESTION",
    line = {
        choices = {
            ccb.content.text("Honey, I have a hard time finding a bra that fits.  Good luck finding a breastplate."),
        },
    },
    replies = {
        { text = ccb.content.text("…"), next_topic = "TALK_BLACKSMITH_SERVICES" },
        {
            text = ccb.content.text("Tell me about it, finding anything that fits in this apocalypse has been a nightmare."),
            next_topic = "TALK_BLACKSMITH_SERVICES",
        },
        { text = ccb.content.text("Oh, uh.  Right, uh."), next_topic = "TALK_BLACKSMITH_SERVICES" },
    },
}

ccb.content.define_dialogue_topic {
    id = "TALK_BLACKSMITH_COOP_ABOUT",
    line = {
        choices = {
            ccb.content.text("Well, not *anyone*, but I've always been a believer in community.  The shop is run as a co-op, so if you want access you'll have to buy a share.  As a partial owner, you will have full access to the shop.  Shares are currently 100 merch; I hate the currency but it's the closest thing we've got to a representation of labor."),
        },
    },
    on_enter = {
        { actions = { actions.set_actor_value("speaker", "dialogue_artisans_blacksmith_can_buy_coop", "yes"), actions.set_actor_value("speaker", "dialogue_artisans_blacksmith_hates_currency", "yes") } },
    },
    replies = {
        {
            text = ccb.content.text("Why do you hate merch?"),
            next_topic = "TALK_BLACKSMITH_MONEY_RAMBLE",
        },
        {
            text = ccb.content.text("[100 merch] Yeah, I can do that."),
            next_topic = "TALK_BLACKSMITH_BOUGHT_COOP",
            when = predicates.has_inventory("speaker", "FMCNote", 100),
            actions = { actions.transfer_items("FMCNote", 100), actions.handler("dlg_a_dda_5c74191e029c"), actions.set_actor_value("speaker", "dialogue_artisans_blacksmith_can_buy_coop", "no") },
        },
        {
            text = ccb.content.text("Alright."),
            next_topic = "TALK_BLACKSMITH_SERVICES",
        },
    },
}

ccb.content.define_dialogue_topic {
    id = "TALK_BLACKSMITH_BOUGHT_COOP",
    line = {
        choices = {
            ccb.content.text("There yah go, one co-op membership with your name on it.  Shop's in the back, keep it tidy and share if anyone else is around workin'.  Just as a heads-up, you'll need to bring your own charcoal.  There's a kiln in there too, so if you got things to burn, just throw 'em in there and light up."),
        },
    },
    replies = {
        { text = ccb.content.text("Thanks."), next_topic = "TALK_BLACKSMITH_SERVICES" },
        { text = ccb.content.text("Alright."), next_topic = "TALK_BLACKSMITH_SERVICES" },
    },
}

ccb.content.define_dialogue_topic {
    id = "TALK_BLACKSMITH_MONEY_RAMBLE",
    line = {
        choices = { ccb.content.text("Money is part of what got us into this mess in the first place.") },
    },
    replies = {
        {
            text = ccb.content.text("Is that why you don't carry any cash?"),
            next_topic = "TALK_BLACKSMITH_MONEY_NO_CASH",
        },
        { text = ccb.content.text("…"), next_topic = "TALK_BLACKSMITH_SERVICES" },
    },
}

ccb.content.define_dialogue_topic {
    id = "TALK_BLACKSMITH_MONEY_NO_CASH",
    line = {
        choices = { ccb.content.text("B-I-N-G-O.  If you bring it, I'll take it, but that's about it.") },
    },
    replies = { { text = ccb.content.text("…"), next_topic = "TALK_BLACKSMITH_SERVICES" } },
}

ccb.content.define_dialogue_topic {
    id = "TALK_BLACKSMITH_JAY",
    line = {
        choices = {
            ccb.content.text("Yeah, we've always got along great.  He comes over for supper every Friday.  Have a few drinks, maybe take some guns out.  Or, well… we used to.  A little while ago, we had a huge fight.  It was right after this stuff got real bad… I'm fuzzy on the details or what I said, all I remember was being so angry that I could kill him.  We haven't talked much since."),
        },
    },
    on_enter = {
        {
            actions = {
                actions.set_actor_value("speaker", "dialogue_artisans_blacksmith_mentioned_fight", "yes"),
            },
        },
    },
    replies = {
        {
            text = ccb.content.text("Have you apologized?"),
            next_topic = "TALK_BLACKSMITH_JAY_NOT_ENOUGH",
        },
        { text = ccb.content.text("I'm sorry."), next_topic = "TALK_BLACKSMITH_SERVICES" },
        {
            text = ccb.content.text("Is there anything I can do?"),
            next_topic = "TALK_BLACKSMITH_JAY_QUEST",
        },
        { text = ccb.content.text("…"), next_topic = "TALK_BLACKSMITH_SERVICES" },
    },
}

ccb.content.define_dialogue_topic {
    id = "TALK_BLACKSMITH_JAY_NOT_ENOUGH",
    line = {
        choices = {
            ccb.content.text("It just seemed like it wouldn't be enough.  I know it's silly but I have to do more than that."),
        },
    },
    replies = {
        { text = ccb.content.text("I'm sorry."), next_topic = "TALK_BLACKSMITH_SERVICES" },
        {
            text = ccb.content.text("Is there anything I can do?"),
            next_topic = "TALK_BLACKSMITH_JAY_QUEST",
        },
        { text = ccb.content.text("…"), next_topic = "TALK_BLACKSMITH_SERVICES" },
    },
}

ccb.content.define_dialogue_topic {
    id = "TALK_BLACKSMITH_JAY_QUEST",
    line = {
        choices = {
            ccb.content.text("If you're offering.  Before everything went to hell, Jay was talking about going to some gun show.  There was a guy there who had managed to sneak some Russian gun into the US.  It was a massive deal for Jay, it was all he could talk about.  I know it's a long shot, but maybe that guy was already at the gun show?  If you find the gun you can keep it, but it would mean a lot to Jay if he could take a look.  All he wanted was to pull it apart and put it back together."),
        },
    },
    replies = {
        {
            text = ccb.content.text("I'll bring you back a souvenir."),
            next_topic = "TALK_BLACKSMITH_SERVICES",
            actions = { actions.offer_mission("MISSION_BLACKSMITH_1"), actions.set_actor_value("speaker", "dialogue_artisans_blacksmith_accepted_quest", "yes") },
        },
        {
            text = ccb.content.text("Not really interested."),
            next_topic = "TALK_DONE",
        },
        {
            text = ccb.content.text("I'll think about it."),
            next_topic = "TALK_BLACKSMITH_SERVICES",
        },
    },
}

ccb.content.define_dialogue_topic {
    id = "TALK_BLACKSMITH_DEAL_NEGOTIATE",
    line = {
        choices = {
            ccb.content.text("Sure, honey!  I'm always in need of more material!  What's the price, though?"),
        },
    },
    replies = {
        {
            text = ccb.content.text("Well, how about 100 merch for every 70 pounds of metal…"),
            next_topic = "TALK_DONE",
            actions = { actions.handler("dlg_a_dda_01edabb98966") },
        },
    },
}

-- If you haven't completed the opening quest yet Cody will blow you off
ccb.content.define_dialogue_topic {
    id = "TALK_BLACKSMITH_NOT_INTERESTED_FABRICATE",
    line = {
        choices = {
            ccb.content.text("Sorry, I don't really have the time to work on something like that.  I've got lots of pieces for sale on the shelves."),
        },
    },
    replies = { { text = ccb.content.text("Alright."), next_topic = "TALK_BLACKSMITH_SERVICES" } },
}
