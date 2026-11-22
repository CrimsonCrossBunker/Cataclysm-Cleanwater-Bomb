local ccb = require("ccb")
local predicates = ccb.content.dialogue_predicates
local actions = ccb.content.dialogue_actions

ccb.content.define_dialogue_topic {
    id = { "COMP_MOM_SHADOW_URGE_COMPUTER_IMPROVE_STRENGTH_FUEL" },
    line = {
        when = predicates.any_equal({ "yes", { scope = "speaker", key = "activated_shadow_urge_machine" } }),
        yes = ccb.content.text("&You insert the matrix crystal and the screen opens up what looks like X-ray results, or some other type of medical diagrams.  You only get a moment to look at it before a soft humming fills your hearing and drowns out all other sounds and darkness steals across your vision."),
        no = ccb.content.text("&Without a BURNT NOVEMBER matrix crystal, the machine stubbornly refuses to work.  After clicking through menus a few times, you eventually give up and go back to the main menu."),
    },
    replies = {
        {
            text = ccb.content.text("I…"),
            next_topic = "TALK_DONE",
            when = predicates.any_equal({ "yes", { scope = "speaker", key = "activated_shadow_urge_machine" } }),
            actions = { actions.handler("dlg_a_mindovermatter_a8520dd3dbfd") },
        },
        {
            text = ccb.content.text("Fine, fine."),
            next_topic = "COMP_MOM_SHADOW_URGE_COMPUTER_MAIN_MENU",
            when = predicates.any_equal({ "no", { scope = "speaker", key = "activated_shadow_urge_machine" } }),
        },
    },
}

ccb.content.define_dialogue_topic {
    id = { "COMP_MOM_SHADOW_URGE_COMPUTER_IMPROVE_AGILITY_FUEL" },
    line = {
        when = predicates.any_equal({ "yes", { scope = "speaker", key = "activated_shadow_urge_machine" } }),
        yes = ccb.content.text("&You insert the matrix crystal and the screen opens up what looks like X-ray results, or some other type of medical diagrams.  You only get a moment to look at it before a soft humming fills your hearing and drowns out all other sounds and darkness steals across your vision."),
        no = ccb.content.text("&Without a BURNT NOVEMBER matrix crystal, the machine stubbornly refuses to work.  After clicking through menus a few times, you eventually give up and go back to the main menu."),
    },
    replies = {
        {
            text = ccb.content.text("I…"),
            next_topic = "TALK_DONE",
            when = predicates.any_equal({ "yes", { scope = "speaker", key = "activated_shadow_urge_machine" } }),
            actions = { actions.handler("dlg_a_mindovermatter_a13a804dd05f") },
        },
        {
            text = ccb.content.text("Fine, fine."),
            next_topic = "COMP_MOM_SHADOW_URGE_COMPUTER_MAIN_MENU",
            when = predicates.any_equal({ "no", { scope = "speaker", key = "activated_shadow_urge_machine" } }),
        },
    },
}

ccb.content.define_dialogue_topic {
    id = { "COMP_MOM_SHADOW_URGE_COMPUTER_IMPROVE_RESILIENCE_FUEL" },
    line = {
        when = predicates.any_equal({ "yes", { scope = "speaker", key = "activated_shadow_urge_machine" } }),
        yes = ccb.content.text("&You insert the matrix crystal and the screen opens up what looks like X-ray results, or some other type of medical diagrams.  You only get a moment to look at it before a soft humming fills your hearing and drowns out all other sounds and darkness steals across your vision."),
        no = ccb.content.text("&Without a SMOKE USHER matrix crystal, the machine stubbornly refuses to work.  After clicking through menus a few times, you eventually give up and go back to the main menu."),
    },
    replies = {
        {
            text = ccb.content.text("I…"),
            next_topic = "TALK_DONE",
            when = predicates.any_equal({ "yes", { scope = "speaker", key = "activated_shadow_urge_machine" } }),
            actions = { actions.handler("dlg_a_mindovermatter_88fa3d64e264") },
        },
        {
            text = ccb.content.text("Fine, fine."),
            next_topic = "COMP_MOM_SHADOW_URGE_COMPUTER_MAIN_MENU",
            when = predicates.any_equal({ "no", { scope = "speaker", key = "activated_shadow_urge_machine" } }),
        },
    },
}

ccb.content.define_dialogue_topic {
    id = { "COMP_MOM_SHADOW_URGE_COMPUTER_IMPROVE_RECOVERY_FUEL" },
    line = {
        when = predicates.any_equal({ "yes", { scope = "speaker", key = "activated_shadow_urge_machine" } }),
        yes = ccb.content.text("&You insert the matrix crystal and the screen opens up what looks like X-ray results, or some other type of medical diagrams.  You only get a moment to look at it before a soft humming fills your hearing and drowns out all other sounds and darkness steals across your vision."),
        no = ccb.content.text("&Without a SMOKE USHER matrix crystal, the machine stubbornly refuses to work.  After clicking through menus a few times, you eventually give up and go back to the main menu."),
    },
    replies = {
        {
            text = ccb.content.text("I…"),
            next_topic = "TALK_DONE",
            when = predicates.any_equal({ "yes", { scope = "speaker", key = "activated_shadow_urge_machine" } }),
            actions = { actions.handler("dlg_a_mindovermatter_01bb8aa35ac9") },
        },
        {
            text = ccb.content.text("Fine, fine."),
            next_topic = "COMP_MOM_SHADOW_URGE_COMPUTER_MAIN_MENU",
            when = predicates.any_equal({ "no", { scope = "speaker", key = "activated_shadow_urge_machine" } }),
        },
    },
}
