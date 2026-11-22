local content = require("ccb").content

content.define_martial_art {
    id = "style_none",
    name = "Fighting Style",
    description = "Fight in accordance with your training or lack thereof.",
    initiate = { "You focus on your training.", "%s remembers their training." },
    allow_all_weapons = true,
    leg_block = 99,
    arm_block = 1,
    techniques = {
        "tec_perk_stagger_strike",
        "tec_perk_feint",
        "tec_perk_fore",
        "tec_perk_fore_stunned",
        "tec_perk_poise_parry",
        "tec_perk_execution_sword",
        "tec_perk_execution_axe",
        "tec_perk_execution_hammer",
        "tec_perk_shoulder_tackle",
        "tec_perk_vulgar_opening",
        "tec_perk_coiling_strike",
        "tec_perk_knife_counter_dodge",
        "tec_perk_knife_finisher",
        "tec_perk_make_way",
        "tec_perk_estocada",
        "tec_perk_duelist_lunge",
        "tec_perk_duelist_combo",
        "tec_perk_staff_kick",
    },
    onmove_buffs = {
        {
            id = "buff_perk_momentum",
            name = "Momentum",
            description = "Strike with the momentum of your previous movement.",
            buff_duration = 2,
            max_stacks = 6,
            unarmed_allowed = true,
            melee_allowed = true,
            required_char_flags = { "MELEE_PERK_MOMENTUM" },
            flat_bonuses = {
                { stat = "damage", scale = 0.2, type = "cut", scaling_stat = "dex" },
                { stat = "damage", scale = 0.2, type = "stab", scaling_stat = "dex" },
            },
        },
    },
    onattack_buffs = {
        {
            id = "buff_perk_tempo",
            name = "Tempo",
            description = "The rhythm of combat is in your favor.",
            buff_duration = 2,
            max_stacks = 3,
            unarmed_allowed = true,
            melee_allowed = true,
            required_char_flags = { "MELEE_PERK_TEMPO" },
            flat_bonuses = {
                { stat = "damage", scale = 0.2, type = "bash", scaling_stat = "str" },
                { stat = "damage", scale = 0.2, type = "stab", scaling_stat = "str" },
            },
        },
    },
    onblock_buffs = {
        {
            id = "MELEE_PERK_RIPOSTE",
            name = "Parry",
            description = "Successful blocking has left you in a favorable position.",
            buff_duration = 2,
            melee_allowed = true,
            required_char_flags = { "MELEE_PERK_RIPOSTE" },
            flat_bonuses = {
                { stat = "hit", scale = 1.0 },
            },
        },
    },
}

content.set_martial_art_handler("style_none", "static", "perk_style_static")
content.set_martial_art_handler("style_none", "move", "perk_style_moved")
content.set_martial_art_handler("style_none", "pause", "perk_style_paused")
content.set_martial_art_handler("style_none", "hit", "perk_style_hit")
content.set_martial_art_handler("style_none", "dodge", "perk_style_dodged")
content.set_martial_art_handler("style_none", "block", "perk_style_blocked")
content.set_martial_art_handler("style_none", "kill", "perk_style_killed")
