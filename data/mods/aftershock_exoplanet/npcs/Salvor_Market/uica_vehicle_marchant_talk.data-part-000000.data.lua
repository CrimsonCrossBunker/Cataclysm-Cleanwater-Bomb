local ccb = require("ccb")
local predicates = ccb.content.dialogue_predicates

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
