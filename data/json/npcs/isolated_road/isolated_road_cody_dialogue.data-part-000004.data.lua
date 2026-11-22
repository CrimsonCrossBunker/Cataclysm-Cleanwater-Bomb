local ccb = require("ccb")
local predicates = ccb.content.dialogue_predicates
local actions = ccb.content.dialogue_actions

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
