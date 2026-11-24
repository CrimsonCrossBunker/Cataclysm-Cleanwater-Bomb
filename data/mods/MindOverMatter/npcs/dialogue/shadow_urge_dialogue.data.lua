local ccb = require("ccb")
local predicates = ccb.content.dialogue_predicates
local actions = ccb.content.dialogue_actions

ccb.content.define_dialogue_topic {
    id = { "TALK_MOM_SHADOW_URGE_MACHINE" },
    line = {
        choices = {
            {
            when = predicates.handler("dlg_p_mindovermatter_e91697b237dd"),
            yes = ccb.content.text("&You sit down and activate the screen, trying to ignore your awkward positioning, and within a few moments are greeted with a login prompt.\n\n\"Project SHADOW URGE.  Enter login credentials.\""),
            no = ccb.content.text("&You poke at the computer, and while it does turn on and you see a login screen for a moment, it's quickly replaced with a popup that reads:\n\n\"No occupant detected.  SHADOW URGE functions unavailable.\""),
        },
        },
    },
    replies = {
        {
            text = ccb.content.text("Input the SHADOW URGE access codes you have."),
            next_topic = "COMP_MOM_SHADOW_URGE_COMPUTER_KNOWN_PASS",
            when = predicates.handler("dlg_p_mindovermatter_021703ba852f"),
        },
        {
            text = ccb.content.text("Try a random username and password."),
            next_topic = "COMP_MOM_SHADOW_URGE_COMPUTER_RANDOM_PASS",
            when = predicates.handler("dlg_p_mindovermatter_f86c1b9c97f9"),
        },
        {
            text = ccb.content.text("Better sit down."),
            next_topic = "TALK_DONE",
            when = predicates.handler("dlg_p_mindovermatter_32f7e13ae876"),
        },
    },
}

ccb.content.define_dialogue_topic {
    id = { "COMP_MOM_SHADOW_URGE_COMPUTER_RANDOM_PASS" },
    line = ccb.content.text("&You input the first combination of username and password that comes to mind, and of course it doesn't work.  Rather than trigger a lockout due to too many attempts, you decide to come back when you have some idea what to do."),
    replies = { { text = ccb.content.text("Log Off"), next_topic = "TALK_DONE" } },
}

ccb.content.define_dialogue_topic {
    id = { "COMP_MOM_SHADOW_URGE_COMPUTER_KNOWN_PASS" },
    line = ccb.content.text("&You input the access codes from the SHADOW URGE document you found and are greeted with a long text string that, from your quick skim, promises dire punishments as well as termination of employment for anyone who attempts to use the SHADOW URGE device without properly-approved experiment protocol beforehand.  Fortunately, all the HR departments are now shambling around on the surface, so you skip past it.  Following the instructions on the documents, you skip through a few menus, input at least two more access codes, and eventually arrive at what can only be the main menu."),
    replies = {
        {
            text = ccb.content.text("SHADOW URGE: Improve Strength."),
            next_topic = "COMP_MOM_SHADOW_URGE_COMPUTER_IMPROVE_STRENGTH",
        },
        {
            text = ccb.content.text("SHADOW URGE: Improve Agility."),
            next_topic = "COMP_MOM_SHADOW_URGE_COMPUTER_IMPROVE_AGILITY",
        },
        {
            text = ccb.content.text("SHADOW URGE: Improve Resilience."),
            next_topic = "COMP_MOM_SHADOW_URGE_COMPUTER_IMPROVE_RESILIENCE",
        },
        {
            text = ccb.content.text("SHADOW URGE: Improve Recovery."),
            next_topic = "COMP_MOM_SHADOW_URGE_COMPUTER_IMPROVE_RECOVERY",
        },
        { text = ccb.content.text("Do nothing and log off"), next_topic = "TALK_DONE" },
    },
}

ccb.content.define_dialogue_topic {
    id = { "COMP_MOM_SHADOW_URGE_COMPUTER_MAIN_MENU" },
    line = ccb.content.text("&Project SHADOW URGE.  Insert catalyst and select treatment."),
    replies = {
        {
            text = ccb.content.text("SHADOW URGE: Improve Strength."),
            next_topic = "COMP_MOM_SHADOW_URGE_COMPUTER_IMPROVE_STRENGTH",
        },
        {
            text = ccb.content.text("SHADOW URGE: Improve Agility."),
            next_topic = "COMP_MOM_SHADOW_URGE_COMPUTER_IMPROVE_AGILITY",
        },
        {
            text = ccb.content.text("SHADOW URGE: Improve Resilience."),
            next_topic = "COMP_MOM_SHADOW_URGE_COMPUTER_IMPROVE_RESILIENCE",
        },
        {
            text = ccb.content.text("SHADOW URGE: Improve Recovery."),
            next_topic = "COMP_MOM_SHADOW_URGE_COMPUTER_IMPROVE_RECOVERY",
        },
        { text = ccb.content.text("Do nothing and log off"), next_topic = "TALK_DONE" },
    },
}

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

ccb.content.define_dialogue_topic {
    id = { "COMP_MOM_SHADOW_URGE_COMPUTER_IMPROVE_STRENGTH" },
    line = ccb.content.text("&You select Improve Strength and after a moment, a screen pops up with the message: \"Catalyst required.  Insert BURNT NOVEMBER matrix crystal.\""),
    replies = {
        {
            text = ccb.content.text("Let me see…"),
            next_topic = "COMP_MOM_SHADOW_URGE_COMPUTER_IMPROVE_STRENGTH_FUEL",
            actions = { actions.handler("w16b_a_mindovermatter_e457d9286bc2") },
        },
        {
            text = ccb.content.text("Well, maybe not now."),
            next_topic = "COMP_MOM_SHADOW_URGE_COMPUTER_MAIN_MENU",
        },
    },
}

ccb.content.define_dialogue_topic {
    id = { "COMP_MOM_SHADOW_URGE_COMPUTER_IMPROVE_AGILITY" },
    line = ccb.content.text("&You select Improve Agility and after a moment, a screen pops up with the message: \"Catalyst required.  Insert BURNT NOVEMBER matrix crystal.\""),
    replies = {
        {
            text = ccb.content.text("Let me see…"),
            next_topic = "COMP_MOM_SHADOW_URGE_COMPUTER_IMPROVE_AGILITY_FUEL",
            actions = { actions.handler("w16b_a_mindovermatter_e457d9286bc2") },
        },
        {
            text = ccb.content.text("Well, maybe not now."),
            next_topic = "COMP_MOM_SHADOW_URGE_COMPUTER_MAIN_MENU",
        },
    },
}

ccb.content.define_dialogue_topic {
    id = { "COMP_MOM_SHADOW_URGE_COMPUTER_IMPROVE_RESILIENCE" },
    line = ccb.content.text("&You select Improve Agility and after a moment, a screen pops up with the message: \"Catalyst required.  Insert SMOKE USHER matrix crystal.\""),
    replies = {
        {
            text = ccb.content.text("Let me see…"),
            next_topic = "COMP_MOM_SHADOW_URGE_COMPUTER_IMPROVE_RESILIENCE_FUEL",
            actions = { actions.handler("w16b_a_mindovermatter_c6177b479547") },
        },
        {
            text = ccb.content.text("Well, maybe not now."),
            next_topic = "COMP_MOM_SHADOW_URGE_COMPUTER_MAIN_MENU",
        },
    },
}

ccb.content.define_dialogue_topic {
    id = { "COMP_MOM_SHADOW_URGE_COMPUTER_IMPROVE_RECOVERY" },
    line = ccb.content.text("&You select Improve Agility and after a moment, a screen pops up with the message: \"Catalyst required.  Insert SMOKE USHER matrix crystal.\""),
    replies = {
        {
            text = ccb.content.text("Let me see…"),
            next_topic = "COMP_MOM_SHADOW_URGE_COMPUTER_IMPROVE_RECOVERY_FUEL",
            actions = { actions.handler("w16b_a_mindovermatter_c6177b479547") },
        },
        {
            text = ccb.content.text("Well, maybe not now."),
            next_topic = "COMP_MOM_SHADOW_URGE_COMPUTER_MAIN_MENU",
        },
    },
}
