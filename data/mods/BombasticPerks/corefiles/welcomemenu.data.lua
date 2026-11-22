local ccb = require("ccb")
local actions = ccb.content.dialogue_actions

ccb.content.define_dialogue_topic {
    id = "TALK_PERK_MENU_WELCOME_FIRST_LEVEL",
    line = ccb.content.text("How much experience should be required to get to the first level?"),
    replies = {
        {
            text = ccb.content.text("Default (100 exp)"),
            next_topic = "TALK_PERK_MENU_WELCOME_EXP_INCREMENT",
            actions = { actions.handler("dlg_a_bombasticperks_faf98775bee5") },
        },
        {
            text = ccb.content.text("Custom Value"),
            next_topic = "TALK_PERK_MENU_WELCOME_EXP_INCREMENT",
            actions = { actions.handler("dlg_a_bombasticperks_74a2a4e87416") },
        },
        {
            text = ccb.content.text("Back"),
            next_topic = "TALK_PERK_MENU_WELCOME",
        },
    },
}

ccb.content.define_dialogue_topic {
    id = "TALK_PERK_MENU_WELCOME_EXP_INCREMENT",
    line = ccb.content.text("How much more experience should be required to get to each additional level?"),
    replies = {
        {
            text = ccb.content.text("Default (300 XP)"),
            next_topic = "TALK_PERK_MENU_WELCOME_REQUIREMENTS",
            actions = { actions.handler("dlg_a_bombasticperks_a9b50a016adf") },
        },
        {
            text = ccb.content.text("Custom Value"),
            next_topic = "TALK_PERK_MENU_WELCOME_REQUIREMENTS",
            actions = { actions.handler("dlg_a_bombasticperks_4294d34cab8d") },
        },
        {
            text = ccb.content.text("Back"),
            next_topic = "TALK_PERK_MENU_WELCOME_FIRST_LEVEL",
        },
    },
}

ccb.content.define_dialogue_topic {
    id = "TALK_PERK_MENU_WELCOME_REQUIREMENTS",
    line = ccb.content.text("Should some perks be allowed to be locked behind prerequisites?"),
    replies = {
        {
            text = ccb.content.text("Prerequisites (default)"),
            next_topic = "TALK_PERK_MENU_WELCOME_PLAYSTYLE",
            actions = { actions.handler("dlg_a_bombasticperks_3d3d57b35045"), actions.set_actor_value("speaker", "dialogue_perks_prereq_note", "Perks will have requirements.") },
        },
        {
            text = ccb.content.text("No Prerequisites"),
            next_topic = "TALK_PERK_MENU_WELCOME_PLAYSTYLE",
            actions = { actions.handler("dlg_a_bombasticperks_6da35b6693a4"), actions.set_actor_value("speaker", "dialogue_perks_prereq_note", "Perks will not have requirements.") },
        },
        {
            text = ccb.content.text("Back"),
            next_topic = "TALK_PERK_MENU_WELCOME_EXP_INCREMENT",
        },
    },
}

ccb.content.define_dialogue_topic {
    id = "TALK_PERK_MENU_WELCOME_PLAYSTYLE",
    line = ccb.content.text("Normal perks are considered lifestyle perks and are small bonuses to help your character progress.  Playstyle perks on the other hand can vary wildly in power, in some cases aren't well balanced, and will define your character's playstyle.  Do you want to enable playstyle perks and if so, how many lifestyle perks do you need before you can acquire one?"),
    replies = {
        {
            text = ccb.content.text("Default (6 lifestyle perks unlocks one playstyle perk)"),
            next_topic = "TALK_PERK_MENU_WELCOME_CONFIRM",
            actions = { actions.handler("dlg_a_bombasticperks_01b6c388a2e6"), actions.set_actor_value("speaker", "dialogue_perks_playstyle_note", "I will gain 1 playstyle perk option per 6 lifestyle perks.") },
        },
        {
            text = ccb.content.text("Enabled, Custom Cost"),
            next_topic = "TALK_PERK_MENU_WELCOME_CONFIRM",
            actions = { actions.handler("dlg_a_bombasticperks_c2566afa7fc4"), actions.set_actor_value("speaker", "dialogue_perks_playstyle_note", "I will gain 1 playstyle perk for a custom amount of lifestyle perks.") },
        },
        {
            text = ccb.content.text("Disabled"),
            next_topic = "TALK_PERK_MENU_WELCOME_CONFIRM",
            actions = { actions.handler("dlg_a_bombasticperks_8509fcf26aa1"), actions.set_actor_value("speaker", "dialogue_perks_playstyle_note", "I cannot select playstyle perks.") },
        },
        {
            text = ccb.content.text("Back"),
            next_topic = "TALK_PERK_MENU_WELCOME_REQUIREMENTS",
        },
    },
}

ccb.content.define_dialogue_topic {
    id = "TALK_PERK_MENU_WELCOME_CONFIRM",
    line = ccb.content.text("You are about to enable the mod with:\nFirst perk at: <u_val:exp_to_perk> exp.\nAdditional exp required per level: <u_val:exp_per_level>.\n<u_val:dialogue_perks_prereq_note>\n<u_val:dialogue_perks_playstyle_note>"),
    replies = {
        {
            text = ccb.content.text("Confirm"),
            next_topic = "TALK_DONE",
            actions = { actions.handler("dlg_a_bombasticperks_7a20bb3492bf"), actions.replace_mutation("speaker", "perk_perk_menu") },
        },
        {
            text = ccb.content.text("Back"),
            next_topic = "TALK_PERK_MENU_WELCOME_PLAYSTYLE",
        },
    },
}
