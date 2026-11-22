local ccb = require("ccb")
local predicates = ccb.content.dialogue_predicates
local actions = ccb.content.dialogue_actions

ccb.content.define_dialogue_topic {
    id = "TALK_EXODII_WEAPONMASTER",
    line = {
        when = predicates.handler("w16b_p_dda_1e86b617dd38"),
        yes = {
            choices = {
                ccb.content.text("&The Weaponmaster seems to be tinkering on something, and completely ignores you as you approach."),
                ccb.content.text("&The Weaponmaster seems to be cleaning some sort of weapon, and as you approach they don't acknowledge you at all."),
                ccb.content.text("&The Weaponmaster seems to be polishing some armor, giving no indication they've seen you as you enter the room."),
            },
        },
        no = {
            choices = {
                ccb.content.text("&The Weaponmaster seems to be tinkering on something, but turns their chair to you as you approach."),
                ccb.content.text("&The Weaponmaster seems to be cleaning some sort of weapon, but as you approach them, they signal to a bystanding worker to take the weapon, and turn to you."),
                ccb.content.text("&The Weaponmaster seems to be polishing some armor, but they turn towards you the second you enter the room."),
            },
        },
    },
    on_enter = {
        { once = "meeting_weaponmaster", actions = { actions.set_actor_value("speaker", "u_met_weaponmaster", "yes") } },
    },
    replies = {
        {
            text = ccb.content.text("[With a familiar movement, you place a variety of valuables onto the counter, proposing a trade.]"),
            next_topic = "TALK_DONE",
            when = predicates.handler("w16b_p_dda_f87ec3601d53"),
            actions = { "start_trade" },
        },
        {
            text = ccb.content.text("Hey!"),
            next_topic = "TALK_WEAPONMASTER_EXODII_DO_NOT_SPEAK_TO_FAIR_FOLK",
            when = predicates.handler("w16b_p_dda_1e86b617dd38"),
            actions = { actions.set_first_topic("TALK_WEAPONMASTER_EXODII_DO_NOT_SPEAK_TO_FAIR_FOLK") },
        },
    },
}
