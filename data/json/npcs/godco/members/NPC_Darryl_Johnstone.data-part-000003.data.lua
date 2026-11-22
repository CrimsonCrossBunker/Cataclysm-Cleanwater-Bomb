local ccb = require("ccb")
local predicates = ccb.content.dialogue_predicates
local actions = ccb.content.dialogue_actions

ccb.content.define_dialogue_topic {
    id = "TALK_GODCO_Darryl_Trade_Eggs",
    line = ccb.content.text("It's finished, and I've got eggs!  I'd be willing to sell ya some, a dozen for seven icons."),
    replies = {
        {
            text = ccb.content.text("I'll buy some."),
            next_topic = "TALK_GODCO_Darryl_1",
            when = predicates.has_inventory("speaker", "icon", 7),
            actions = { actions.transfer_items("icon", 7), actions.handler("dlg_a_dda_a4b64a894b0d") },
        },
        {
            text = ccb.content.text("That's a bit rich for my blood.  <end_talking_leave>"),
            next_topic = "TALK_DONE",
        },
    },
}

ccb.content.define_dialogue_topic {
    id = "TALK_GODCO_Darryl_Trade2",
    line = ccb.content.text("All right, this is what I've got:  I can give cucumber, barley or blackberry seeds for one icon; carrot, buckwheat or cranberry seeds for two icons; oat, sugar beet or potato seeds for three icons."),
    replies = {
        {
            text = ccb.content.text("I'll buy cucumber seeds."),
            next_topic = "TALK_GODCO_Darryl_Trade2",
            when = predicates.has_inventory("speaker", "icon", 1),
            actions = { actions.transfer_items("icon"), actions.handler("dlg_a_dda_6c850cbcb4f3") },
        },
        {
            text = ccb.content.text("I'll buy barley seeds."),
            next_topic = "TALK_GODCO_Darryl_Trade2",
            when = predicates.has_inventory("speaker", "icon", 1),
            actions = { actions.transfer_items("icon"), actions.handler("dlg_a_dda_e3e9d30006d6") },
        },
        {
            text = ccb.content.text("I'll buy blackberry seeds."),
            next_topic = "TALK_GODCO_Darryl_Trade2",
            when = predicates.has_inventory("speaker", "icon", 1),
            actions = { actions.transfer_items("icon"), actions.handler("dlg_a_dda_d8dfb1090c0c") },
        },
        {
            text = ccb.content.text("I'll buy carrot seeds."),
            next_topic = "TALK_GODCO_Darryl_Trade2",
            when = predicates.has_inventory("speaker", "icon", 2),
            actions = { actions.transfer_items("icon", 2), actions.handler("dlg_a_dda_c60894d72732") },
        },
        {
            text = ccb.content.text("I'll buy buckwheat seeds."),
            next_topic = "TALK_GODCO_Darryl_Trade2",
            when = predicates.has_inventory("speaker", "icon", 2),
            actions = { actions.transfer_items("icon", 2), actions.handler("dlg_a_dda_24f8b2f15533") },
        },
        {
            text = ccb.content.text("I'll buy cranberry seeds."),
            next_topic = "TALK_GODCO_Darryl_Trade2",
            when = predicates.has_inventory("speaker", "icon", 2),
            actions = { actions.transfer_items("icon", 2), actions.handler("dlg_a_dda_bd6e4ac73144") },
        },
        {
            text = ccb.content.text("I'll buy oat seeds."),
            next_topic = "TALK_GODCO_Darryl_Trade2",
            when = predicates.has_inventory("speaker", "icon", 3),
            actions = { actions.transfer_items("icon", 3), actions.handler("dlg_a_dda_194ff38eda8d") },
        },
        {
            text = ccb.content.text("I'll buy sugar beet seeds."),
            next_topic = "TALK_GODCO_Darryl_Trade2",
            when = predicates.has_inventory("speaker", "icon", 3),
            actions = { actions.transfer_items("icon", 3), actions.handler("dlg_a_dda_3131e9fb995f") },
        },
        {
            text = ccb.content.text("I'll buy potato seeds."),
            next_topic = "TALK_GODCO_Darryl_Trade2",
            when = predicates.has_inventory("speaker", "icon", 3),
            actions = { actions.transfer_items("icon", 3), actions.handler("dlg_a_dda_c048c0261c0a") },
        },
        {
            text = ccb.content.text("Can't you just give them to me for free?  You said you didn't need them."),
            when = predicates.negate(predicates.has_effect("speaker", "godco_darryl_bartered")),
            trial = { kind = "persuade", difficulty = 25, modifiers = { { score = "trust", scale = 5 } } },
            success = { next_topic = "TALK_GODCO_Darryl_BarterSuccess", actions = { actions.add_effect("interlocutor", "godco_darryl_bartered", { permanent = true }), actions.handler("dlg_a_dda_c048c0261c0a") } },
            failure = { next_topic = "TALK_GODCO_Darryl_BarterFail", opinion = { trust = -6 } },
        },
        {
            text = ccb.content.text("That's a bit rich for my blood.  <end_talking_leave>"),
            next_topic = "TALK_DONE",
        },
    },
}
