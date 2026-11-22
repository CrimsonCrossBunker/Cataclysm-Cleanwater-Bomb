local ccb = require("ccb")
local predicates = ccb.content.dialogue_predicates
local actions = ccb.content.dialogue_actions

ccb.content.define_dialogue_topic {
    id = { "TALK_ROBOFAC_INTERCOM_SELL_HEW_DATA", "TALK_ROBOFAC_INTERCOM_SELL_HEW_DATA_PORTAL", "TALK_ROBOFAC_INTERCOM_SELL_HEW_DATA_STORM", "TALK_ROBOFAC_INTERCOM_SELL_HEW_DATA_VITRIFIED", "TALK_ROBOFAC_INTERCOM_SELL_HEW_DATA_EXODII", "TALK_ROBOFAC_INTERCOM_SELL_HEW_DATA_STRANGE_TEMPLE", "TALK_ROBOFAC_INTERCOM_SELL_HEW_DATA_LIXA", "TALK_ROBOFAC_INTERCOM_SELL_HEW_DATA_HIGHLANDS", "TALK_ROBOFAC_INTERCOM_SELL_HEW_DATA_LABYRINTH", "TALK_ROBOFAC_INTERCOM_SELL_HEW_DATA_PHYSICS_LAB", "TALK_ROBOFAC_INTERCOM_SELL_HEW_DATA_AMIGARA", "TALK_ROBOFAC_INTERCOM_SELL_HEW_DATA_RADIOSPHERE", "TALK_ROBOFAC_INTERCOM_SELL_HEW_DATA_MONSTER_CORPSE", "TALK_ROBOFAC_INTERCOM_SELL_HEW_DATA_CABIN_REVERB", "TALK_ROBOFAC_INTERCOM_SELL_HEW_DATA_CABIN_REVERB_DIMENSION", "TALK_ROBOFAC_INTERCOM_SELL_HEW_DATA_BARRICADED_CHURCH", "TALK_ROBOFAC_INTERCOM_SELL_HEW_DATA_MORGANTOWN", "TALK_ROBOFAC_INTERCOM_SELL_HEW_DATA_STRING_DIMENSION", "TALK_ROBOFAC_INTERCOM_SELL_HEW_DATA_SPIRAL_MINE", "TALK_ROBOFAC_INTERCOM_SELL_HEW_DATA_VOID_SPIDER_LAIR", "TALK_ROBOFAC_INTERCOM_SELL_HEW_DATA_INNER_CABINS", "TALK_ROBOFAC_INTERCOM_SELL_HEW_DATA_PORTAL_STORM_DUNGEON" },
    line = ccb.content.text("Excellent; please deposit the printouts in the intercom's tray."),
    replies = {
        {
            text = ccb.content.text("[Deposit a \"stable portal\" datasheet.]"),
            next_topic = "TALK_ROBOFAC_INTERCOM_SELL_HEW_DATA_PORTAL",
            when = predicates.handler("dlg_p_dda_aac75cf8768a"),
            actions = { actions.handler("dlg_a_dda_754d7f875bd1") },
        },
        {
            text = ccb.content.text("[Deposit a \"unstable portal\" datasheet.]"),
            next_topic = "TALK_ROBOFAC_INTERCOM_SELL_HEW_DATA_STORM",
            when = predicates.handler("dlg_p_dda_c2a99b57a75a"),
            actions = { actions.handler("dlg_a_dda_af49f71339ee") },
        },
        {
            text = ccb.content.text("[Deposit datasheet CC1044.]"),
            next_topic = "TALK_ROBOFAC_INTERCOM_SELL_HEW_DATA_VITRIFIED",
            when = predicates.handler("dlg_p_dda_d2f986e3ea6d"),
            actions = { actions.handler("dlg_a_dda_4751aabc51ba") },
        },
        {
            text = ccb.content.text("[Deposit datasheet IAE20.]"),
            next_topic = "TALK_ROBOFAC_INTERCOM_SELL_HEW_DATA_EXODII",
            when = predicates.handler("dlg_p_dda_fa1a5afc547e"),
            actions = { actions.handler("dlg_a_dda_c9cda4679366") },
        },
        {
            text = ccb.content.text("[Deposit datasheet WKG1.]"),
            next_topic = "TALK_ROBOFAC_INTERCOM_SELL_HEW_DATA_STRANGE_TEMPLE",
            when = predicates.handler("dlg_p_dda_f1dd7b15c41d"),
            actions = { actions.handler("dlg_a_dda_2e9eea0a3fa5") },
        },
        {
            text = ccb.content.text("[Deposit datasheet DP72063.]"),
            next_topic = "TALK_ROBOFAC_INTERCOM_SELL_HEW_DATA_LIXA",
            when = predicates.handler("dlg_p_dda_a157c71e578f"),
            actions = { actions.handler("dlg_a_dda_7febbe92e1db") },
        },
        {
            text = ccb.content.text("[Deposit datasheet TCOB1.]"),
            next_topic = "TALK_ROBOFAC_INTERCOM_SELL_HEW_DATA_HIGHLANDS",
            when = predicates.handler("dlg_p_dda_c17431e270ac"),
            actions = { actions.handler("dlg_a_dda_c2f7a8139984") },
        },
        {
            text = ccb.content.text("[Deposit datasheet DB86.]"),
            next_topic = "TALK_ROBOFAC_INTERCOM_SELL_HEW_DATA_LABYRINTH",
            when = predicates.handler("dlg_p_dda_b47377db4daf"),
            actions = { actions.handler("dlg_a_dda_78bc9cadb9aa") },
        },
        {
            text = ccb.content.text("[Deposit datasheet 22BMBS.]"),
            next_topic = "TALK_ROBOFAC_INTERCOM_SELL_HEW_DATA_PHYSICS_LAB",
            when = predicates.handler("dlg_p_dda_0e0ef696abb0"),
            actions = { actions.handler("dlg_a_dda_780722f802a0") },
        },
        {
            text = ccb.content.text("[Deposit datasheet 01ITO.]"),
            next_topic = "TALK_ROBOFAC_INTERCOM_SELL_HEW_DATA_AMIGARA",
            when = predicates.handler("dlg_p_dda_25dafcc3ab88"),
            actions = { actions.handler("dlg_a_dda_7517b5e57697") },
        },
        {
            text = ccb.content.text("[Deposit datasheet VKTRS.]"),
            next_topic = "TALK_ROBOFAC_INTERCOM_SELL_HEW_DATA_RADIOSPHERE",
            when = predicates.handler("dlg_p_dda_c93719a0ba1a"),
            actions = { actions.handler("dlg_a_dda_5d72456d1ad5") },
        },
        {
            text = ccb.content.text("[Deposit datasheet LKG1.]"),
            next_topic = "TALK_ROBOFAC_INTERCOM_SELL_HEW_DATA_MONSTER_CORPSE",
            when = predicates.handler("dlg_p_dda_911ebc8a27b4"),
            actions = { actions.handler("dlg_a_dda_60f9f01fb672") },
        },
        {
            text = ccb.content.text("[Deposit datasheet CITW01.]"),
            next_topic = "TALK_ROBOFAC_INTERCOM_SELL_HEW_DATA_CABIN_REVERB",
            when = predicates.handler("dlg_p_dda_3cfc230a3afb"),
            actions = { actions.handler("dlg_a_dda_c796f2e12fa3") },
        },
        {
            text = ccb.content.text("[Deposit datasheet CITW02.]"),
            next_topic = "TALK_ROBOFAC_INTERCOM_SELL_HEW_DATA_CABIN_REVERB_DIMENSION",
            when = predicates.handler("dlg_p_dda_f15dff4d4a58"),
            actions = { actions.handler("dlg_a_dda_7b88d52e4d58") },
        },
        {
            text = ccb.content.text("[Deposit datasheet ESFX.]"),
            next_topic = "TALK_ROBOFAC_INTERCOM_SELL_HEW_DATA_BARRICADED_CHURCH",
            when = predicates.handler("dlg_p_dda_d7ee61bf7e06"),
            actions = { actions.handler("dlg_a_dda_efab7034dde2") },
        },
        {
            text = ccb.content.text("[Deposit datasheet 01Z90.]"),
            next_topic = "TALK_ROBOFAC_INTERCOM_SELL_HEW_DATA_MORGANTOWN",
            when = predicates.handler("dlg_p_dda_6b0652c15d96"),
            actions = { actions.handler("dlg_a_dda_fb214d511ce0") },
        },
        {
            text = ccb.content.text("[Deposit datasheet IHS.]"),
            next_topic = "TALK_ROBOFAC_INTERCOM_SELL_HEW_DATA_STRING_DIMENSION",
            when = predicates.handler("dlg_p_dda_c3dc3402ba5e"),
            actions = { actions.handler("dlg_a_dda_49a658f92ec7") },
        },
        {
            text = ccb.content.text("[Deposit datasheet UJI98.]"),
            next_topic = "TALK_ROBOFAC_INTERCOM_SELL_HEW_DATA_SPIRAL_MINE",
            when = predicates.handler("dlg_p_dda_a3d245331fd2"),
            actions = { actions.handler("dlg_a_dda_5c2cdab017b9") },
        },
        {
            text = ccb.content.text("[Deposit datasheet NLL8.]"),
            next_topic = "TALK_ROBOFAC_INTERCOM_SELL_HEW_DATA_VOID_SPIDER_LAIR",
            when = predicates.handler("dlg_p_dda_ba009730232b"),
            actions = { actions.handler("dlg_a_dda_e9b68481bb9b") },
        },
        {
            text = ccb.content.text("[Deposit datasheet MROTS-S.]"),
            next_topic = "TALK_ROBOFAC_INTERCOM_SELL_HEW_DATA_PORTAL_STORM_DUNGEON",
            when = predicates.handler("dlg_p_dda_a417252a70db"),
            actions = { actions.handler("dlg_a_dda_8b17fea9c83e") },
        },
        {
            text = ccb.content.text("[Deposit datasheet CITW-BFα and give a verbal report.]"),
            next_topic = "TALK_ROBOFAC_INTERCOM_SELL_HEW_DATA_INNER_CABINS",
            when = predicates.handler("dlg_p_dda_fd7aecf5a7d0"),
            actions = { actions.handler("dlg_a_dda_f89b78acaa19") },
        },
        {
            text = ccb.content.text("[Deposit datasheet CITW-BFβ and give a verbal report.]"),
            next_topic = "TALK_ROBOFAC_INTERCOM_SELL_HEW_DATA_INNER_CABINS",
            when = predicates.handler("dlg_p_dda_c4801519cf29"),
            actions = { actions.handler("dlg_a_dda_e0b08fee1722") },
        },
        {
            text = ccb.content.text("[Deposit datasheet CITW-BFγ and give a verbal report.]"),
            next_topic = "TALK_ROBOFAC_INTERCOM_SELL_HEW_DATA_INNER_CABINS",
            when = predicates.handler("dlg_p_dda_7cf23cfab2c6"),
            actions = { actions.handler("dlg_a_dda_7236e065e066") },
        },
        {
            text = ccb.content.text("That would be all."),
            next_topic = "TALK_ROBOFAC_INTERCOM_SERVICES",
        },
    },
}
