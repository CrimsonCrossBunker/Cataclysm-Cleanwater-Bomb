local ccb = require("ccb")
local predicates = ccb.content.dialogue_predicates
local actions = ccb.content.dialogue_actions

-- If you have met them already, let the player go directly to trading.
-- If you are Earthborn buying the car is much easier AND cheaper.
-- Not Earthborn so you have to do a little convincing to buy the car.
-- Not Earthborn but already convinced them to make the offer to you.
-- Introduction if you haven't met them and aren't Earthborn.
-- If you are Earthborn they pickup on that and will belay their introduction to nerd out about meeting a fellow Earthling
-- If you have met them you can ask them about why they are on Salus
ccb.content.define_dialogue_topic {
    id = { "TALK_UICA_VEHICLE_MERCHANT" },
    line = {
        joined = {
            ccb.content.text("&The workshop is a chaotic mess of spare parts, tools, and partially assembled components littering every surface.  <npc_name> is muttering to himself under his breath when you approach."),
            {
                when = predicates.has_trait("speaker", "BKGR_EARTH"),
                yes = ccb.content.text("\n\"Oh hello, do you need something?\""),
                no = ccb.content.text("\n\"Do you need something, salvor?\""),
            },
        },
    },
    replies = {
        {
            text = ccb.content.text("What do you have in stock?"),
            next_topic = "TALK_DONE",
            native_actions = { "start_trade" },
            when = predicates.any_equal({ "yes", { scope = "interlocutor", key = "player_has_met" } }),
        },
        {
            text = ccb.content.text("You said something about a special offer?"),
            next_topic = "TALK_UICA_VEHICLE_MERCHANT_BUY_VEHICLE_EARTH",
            when = predicates.all({ predicates.any_equal({ "yes", { scope = "interlocutor", key = "player_has_met" } }), predicates.negate(predicates.any_equal({ "yes", { scope = "interlocutor", key = "player_has_bought_car" } })), predicates.has_trait("speaker", "BKGR_EARTH") }),
        },
        {
            text = ccb.content.text("Do you sell any vehicles here?"),
            next_topic = "TALK_UICA_VEHICLE_MERCHANT_BUY_VEHICLE",
            when = predicates.all({ predicates.any_equal({ "yes", { scope = "interlocutor", key = "player_has_met" } }), predicates.negate(predicates.any_equal({ "yes", { scope = "interlocutor", key = "player_has_bought_car" } })), predicates.negate(predicates.any_equal({ "yes", { scope = "interlocutor", key = "player_has_pursuaded" } })), predicates.negate(predicates.has_trait("speaker", "BKGR_EARTH")), predicates.negate(predicates.has_effect("interlocutor", "afs_tried_to_buy_car")) }),
        },
        {
            text = ccb.content.text("Is that Lynx still for sale?"),
            next_topic = "TALK_UICA_VEHICLE_MERCHANT_BUY_VEHICLE_PASS_ALT",
            when = predicates.all({ predicates.any_equal({ "yes", { scope = "interlocutor", key = "player_has_met" } }), predicates.negate(predicates.any_equal({ "yes", { scope = "interlocutor", key = "player_has_bought_car" } })), predicates.any_equal({ "yes", { scope = "interlocutor", key = "player_has_pursuaded" } }), predicates.negate(predicates.has_trait("speaker", "BKGR_EARTH")), predicates.negate(predicates.has_effect("interlocutor", "afs_tried_to_buy_car")) }),
        },
        {
            text = ccb.content.text("What do you do here?"),
            next_topic = "TALK_UICA_VEHICLE_MERCHANT_INTRODUCTION",
            when = predicates.all({ predicates.negate(predicates.any_equal({ "yes", { scope = "interlocutor", key = "player_has_met" } })), predicates.negate(predicates.has_trait("speaker", "BKGR_EARTH")) }),
        },
        {
            text = ccb.content.text("What do you do here?"),
            next_topic = "TALK_UICA_VEHICLE_MERCHANT_INTRODUCTION_EARTH",
            when = predicates.all({ predicates.negate(predicates.any_equal({ "yes", { scope = "interlocutor", key = "player_has_met" } })), predicates.has_trait("speaker", "BKGR_EARTH") }),
        },
        {
            text = ccb.content.text("So, why did you come to Salus IV?"),
            next_topic = "TALK_UICA_VEHICLE_MERCHANT_WHY_HERE",
            when = predicates.any_equal({ "yes", { scope = "interlocutor", key = "player_has_met" } }),
        },
        { text = ccb.content.text("Maybe later."), next_topic = "TALK_DONE" },
    },
}

ccb.content.define_dialogue_topic {
    id = { "TALK_UICA_VEHICLE_MERCHANT_INTRODUCTION_EARTH" },
    line = ccb.content.text("Wait.  Hold on a second, please don't take this the wrong way, but wouldn't you happen to be from Earth by any chance?"),
    replies = {
        {
            text = ccb.content.text("How can you tell?"),
            next_topic = "TALK_UICA_VEHICLE_MERCHANT_INTRODUCTION_EARTH_TRUTH",
        },
        {
            text = ccb.content.text("Sorry, you're mistaken."),
            next_topic = "TALK_UICA_VEHICLE_MERCHANT_INTRODUCTION_EARTH_LIE",
        },
    },
}

ccb.content.define_dialogue_topic {
    id = { "TALK_UICA_VEHICLE_MERCHANT_INTRODUCTION_EARTH_TRUTH" },
    line = ccb.content.text("I knew it!  I'm from Earth too so I could just tell.  The way you carry yourself, it's not like the rest of the salvors around here.  But you get it right?"),
    replies = {
        {
            text = ccb.content.text("I know what you mean."),
            next_topic = "TALK_UICA_VEHICLE_MERCHANT_INTRODUCTION_EARTH_TRUTH_2",
        },
        {
            text = ccb.content.text("What are you doing here?"),
            next_topic = "TALK_UICA_VEHICLE_MERCHANT_INTRODUCTION_EARTH_EXPLAIN",
        },
    },
}

ccb.content.define_dialogue_topic {
    id = { "TALK_UICA_VEHICLE_MERCHANT_INTRODUCTION_EARTH_TRUTH_2" },
    line = ccb.content.text("Right?  Right!  Of course you do.  You understand!  This place is about as far a cry from civilization as you can get.  And the people, god, the people!  This post sees a never-ending deluge of criminals and brawn for brains.  And it's like none of them have even heard of a shower!  Just the other day, a man emerged from the icy waste covered in blood and viscera.  And everyone just ignored him acting like that was a completely normal thing to do!  I am going to get off this god-forsaken rock if it's the last thing I do, I swear it."),
    replies = {
        {
            text = ccb.content.text("What are you doing here?"),
            next_topic = "TALK_UICA_VEHICLE_MERCHANT_INTRODUCTION_EARTH_EXPLAIN",
        },
    },
}

ccb.content.define_dialogue_topic {
    id = { "TALK_UICA_VEHICLE_MERCHANT_INTRODUCTION_EARTH_LIE" },
    line = ccb.content.text("No, don't give me that!  I can tell, just by looking at you, I know.  Don't worry, I'm from Earth too!  I get it: some people around here get all weird when they find out where you're from.  But you won't get that from me. Us Earthers got to stick together, right?"),
    replies = {
        {
            text = ccb.content.text("What are you doing here?"),
            next_topic = "TALK_UICA_VEHICLE_MERCHANT_INTRODUCTION_EARTH_EXPLAIN",
        },
        {
            text = ccb.content.text("I don't know what you're talking about."),
            next_topic = "TALK_UICA_VEHICLE_MERCHANT_INTRODUCTION_EARTH_LIE2",
        },
    },
}

ccb.content.define_dialogue_topic {
    id = { "TALK_UICA_VEHICLE_MERCHANT_INTRODUCTION_EARTH_LIE2" },
    line = ccb.content.text("Sure, whatever you say, pal."),
    replies = {
        {
            text = ccb.content.text("What are you doing here?"),
            next_topic = "TALK_UICA_VEHICLE_MERCHANT_INTRODUCTION_EARTH_EXPLAIN",
        },
    },
}

ccb.content.define_dialogue_topic {
    id = { "TALK_UICA_VEHICLE_MERCHANT_INTRODUCTION_EARTH_EXPLAIN" },
    line = ccb.content.text("Right!  Sorry, this is the vehicle bay, and I run the place.  Mostly I just fix up the patrol vehicles.  But I am also in charge of maintaining our stock of vehicle parts.  As such: I've been authorized to trade with salvors in order to get what we need, and can offer you some of our excess stock or chits in exchange.  I'll give you a nice price, just: Don't tell my boss.  And one more thing, I've got something really special for sale, if you're interested."),
    replies = {
        {
            text = ccb.content.text("Can you show me your stock?"),
            next_topic = "TALK_DONE",
            actions = { actions.set_actor_value("interlocutor", "player_has_met", "yes"), "start_trade" },
        },
        {
            text = ccb.content.text("What's this special offer?"),
            next_topic = "TALK_UICA_VEHICLE_MERCHANT_BUY_VEHICLE_EARTH",
            actions = { actions.set_actor_value("interlocutor", "player_has_met", "yes") },
        },
        {
            text = ccb.content.text("Thanks, I don't need anything right now."),
            next_topic = "TALK_DONE",
            actions = { actions.set_actor_value("interlocutor", "player_has_met", "yes") },
        },
    },
}

ccb.content.define_dialogue_topic {
    id = { "TALK_UICA_VEHICLE_MERCHANT_INTRODUCTION" },
    line = ccb.content.text("This is the vehicle bay, and I run the place.  Please don't touch anything unless you're buying.  I fix up the patrol vehicles and maintain our stock of spare parts.  As such: I've been authorized to trade with outsiders in order to get what we need, and can offer you some of our excess stock or chits in exchange."),
    replies = {
        {
            text = ccb.content.text("Can you show me your stock?"),
            next_topic = "TALK_DONE",
            actions = { actions.set_actor_value("interlocutor", "player_has_met", "yes"), "start_trade" },
        },
        {
            text = ccb.content.text("Thanks, I don't need anything right now."),
            next_topic = "TALK_DONE",
            actions = { actions.set_actor_value("interlocutor", "player_has_met", "yes") },
        },
    },
}

ccb.content.define_dialogue_topic {
    id = { "TALK_UICA_VEHICLE_MERCHANT_BUY_VEHICLE_EARTH" },
    line = ccb.content.text("Here's the thing: A while back one of our patrol vehicles got totalled when some junior officers took it for a joy ride.  We are in queue to get a replacement issued to us and High Command just wants the old one broken down for parts.  Well the chief and I agree that's a little wasteful.  So I patched the damn thing back together with the parts we had on hand.  And now we're looking for a way to make it, disappear.  You follow?"),
    replies = {
        {
            text = ccb.content.text("How much do want for it?"),
            next_topic = "TALK_UICA_VEHICLE_MERCHANT_BUY_VEHICLE_EARTH_2",
        },
        { text = ccb.content.text("Maybe later."), next_topic = "TALK_DONE" },
    },
}

ccb.content.define_dialogue_topic {
    id = { "TALK_UICA_VEHICLE_MERCHANT_BUY_VEHICLE_EARTH_2" },
    line = ccb.content.text("I'll cut you a deal.  Let's say 30,000 USD and it's all yours."),
    replies = {
        {
            text = ccb.content.text("I'll take it."),
            next_topic = "TALK_DONE",
            actions = { actions.handler("w16b_a_aftershock_exoplanet_6616d9d8c75f") },
        },
        {
            text = ccb.content.text("Maybe later."),
            next_topic = "TALK_DONE",
        },
    },
}

ccb.content.define_dialogue_topic {
    id = { "TALK_UICA_VEHICLE_MERCHANT_BUY_VEHICLE" },
    line = ccb.content.text("As I've SAID before: I'm only authorized to trade vehicle parts and scraps.  Our patrol vehicles are not up for auction.  Now if you don't mind, I have work to do."),
    replies = {
        {
            text = ccb.content.text("Surely you can arrange for a patrol car to be 'lost'.  I can make it worth your while."),
            trial = { kind = "persuade", difficulty = 60 },
            success = {
                next_topic = "TALK_UICA_VEHICLE_MERCHANT_BUY_VEHICLE_PASS",
                actions = { actions.set_actor_value("interlocutor", "player_has_pursuaded", "yes") },
            },
            failure = {
                next_topic = "TALK_UICA_VEHICLE_MERCHANT_BUY_VEHICLE_FAIL",
                actions = { actions.add_effect("interlocutor", "afs_tried_to_buy_car", { turns = 86400 }) },
            },
        },
        { text = ccb.content.text("Nevermind then."), next_topic = "TALK_DONE" },
    },
}

ccb.content.define_dialogue_topic {
    id = { "TALK_UICA_VEHICLE_MERCHANT_BUY_VEHICLE_FAIL" },
    line = ccb.content.text("I'd report you if this sort of behavior wasn't already so laughably predictable.  Just go away."),
    replies = { { text = ccb.content.text("Your loss."), next_topic = "TALK_DONE" } },
}

ccb.content.define_dialogue_topic {
    id = { "TALK_UICA_VEHICLE_MERCHANT_BUY_VEHICLE_PASS" },
    line = ccb.content.text("Alright, alright.  Just not so loud.  Here's the thing: A while back one of our patrol vehicles got totalled when some junior officers took it for a joy ride.  We are in queue to get a replacement issued to us and High Command just wants the old one broken down for parts.  Well the chief and I agree that's a little wasteful.  So I patched the damn thing back together with the parts we had on hand.  And now we're looking for a way to make it, disappear."),
    replies = {
        {
            text = ccb.content.text("How much do want for it?"),
            next_topic = "TALK_UICA_VEHICLE_MERCHANT_BUY_VEHICLE_PASS_2",
        },
        { text = ccb.content.text("Maybe later."), next_topic = "TALK_DONE" },
    },
}

ccb.content.define_dialogue_topic {
    id = { "TALK_UICA_VEHICLE_MERCHANT_BUY_VEHICLE_PASS_ALT" },
    line = ccb.content.text("*sighs.  \"Yes it is, are you interested?\""),
    replies = {
        {
            text = ccb.content.text("How much do want for it again?"),
            next_topic = "TALK_UICA_VEHICLE_MERCHANT_BUY_VEHICLE_PASS_2",
        },
        { text = ccb.content.text("Maybe later."), next_topic = "TALK_DONE" },
    },
}

ccb.content.define_dialogue_topic {
    id = { "TALK_UICA_VEHICLE_MERCHANT_BUY_VEHICLE_PASS_2" },
    line = ccb.content.text("40,000 USD and it's all yours."),
    replies = {
        {
            text = ccb.content.text("I'll take it."),
            next_topic = "TALK_DONE",
            actions = { actions.handler("w16b_a_aftershock_exoplanet_7eed23eb2945") },
        },
        {
            text = ccb.content.text("Maybe later."),
            next_topic = "TALK_DONE",
        },
    },
}

ccb.content.define_dialogue_topic {
    id = { "TALK_UICA_VEHICLE_MERCHANT_WHY_HERE" },
    line = ccb.content.text("It wasn't my choice, obviously.  That fucking bastard back in Alpha Centauri had me transferred to this frozen hell.  Pulled strings with the staff in command.  I signed on to help put Earth back where it belongs: on top.  Not freeze my arse off fixing barely held-together scrap in the middle of fucking nowhere.  Mercurial doesn't even give a shit about this place.  I don't know why the UICA even bothers to station us here.  If you ask me this planet should have stayed abandoned."),
    replies = {
        {
            text = ccb.content.text("Who's the bastard?"),
            next_topic = "TALK_UICA_VEHICLE_MERCHANT_BKGR_BASTARD",
        },
        {
            text = ccb.content.text("What makes you think Mercurial doesn't care?"),
            next_topic = "TALK_UICA_VEHICLE_MERCHANT_MERCURIAL",
        },
        { text = ccb.content.text("Sorry I asked."), next_topic = "TALK_DONE" },
    },
}

ccb.content.define_dialogue_topic {
    id = { "TALK_UICA_VEHICLE_MERCHANT_BKGR_BASTARD" },
    line = ccb.content.text("My former superior officer, the prick.  Always hovering my shoulder like a damn drone.  I won't miss that uptight control freak.  We fought a lot and didn't see things eye to eye.  But this?  I never imagined the fucker would stoop this low.  Hell of a disciplinary action, I'll tell you that much."),
    replies = { { text = ccb.content.text("I'm sorry to hear that."), next_topic = "TALK_DONE" } },
}

ccb.content.define_dialogue_topic {
    id = { "TALK_UICA_VEHICLE_MERCHANT_MERCURIAL" },
    line = ccb.content.text("The last thing they did was set up their little clinic on the station, and they haven't done jack since.  No communications, no re-colonization efforts, no survey teams.  They hardly even seem to care about going down planetside.  Not like I blame them.  The colony didn't work out before so, why bother?  This place is clearly not worth the effort."),
    replies = {
        {
            text = ccb.content.text("I guess there are some rocks even Corpos won't touch."),
            next_topic = "TALK_DONE",
        },
    },
}
