local ccb = require("ccb")
local predicates = ccb.content.dialogue_predicates
local actions = ccb.content.dialogue_actions

ccb.content.define_dialogue_topic {
    id = "TALK_DEFENSE_MODE_ENEMY_SELECTION",
    line = ccb.content.text("What kinds of enemies do you want to see?"),
    replies = {
        {
            text = ccb.content.text("Allow regular zombies."),
            next_topic = "TALK_DEFENSE_MODE_ENEMY_SELECTION",
            when = predicates.handler("dlg_p_defense_mode_010eff7a1ea0"),
            actions = { actions.handler("dlg_a_defense_mode_0626ec5c1519") },
        },
        {
            text = ccb.content.text("Disable regular zombies."),
            next_topic = "TALK_DEFENSE_MODE_ENEMY_SELECTION",
            when = predicates.handler("dlg_p_defense_mode_5c817e0fd0d5"),
            actions = { actions.handler("dlg_a_defense_mode_c37cf0e24aff") },
        },
        {
            text = ccb.content.text("Allow special zombies."),
            next_topic = "TALK_DEFENSE_MODE_ENEMY_SELECTION",
            when = predicates.handler("dlg_p_defense_mode_94c0a1394fc8"),
            actions = { actions.handler("dlg_a_defense_mode_4ef780cfc6f7") },
        },
        {
            text = ccb.content.text("Disable special zombies."),
            next_topic = "TALK_DEFENSE_MODE_ENEMY_SELECTION",
            when = predicates.handler("dlg_p_defense_mode_33067f8c26d6"),
            actions = { actions.handler("dlg_a_defense_mode_e7dfde9075d3") },
        },
        {
            text = ccb.content.text("Allow spiders."),
            next_topic = "TALK_DEFENSE_MODE_ENEMY_SELECTION",
            when = predicates.handler("dlg_p_defense_mode_ef1a26f8fe4f"),
            actions = { actions.handler("dlg_a_defense_mode_0b3097475b40") },
        },
        {
            text = ccb.content.text("Disable spiders."),
            next_topic = "TALK_DEFENSE_MODE_ENEMY_SELECTION",
            when = predicates.handler("dlg_p_defense_mode_d51e85c0aeb5"),
            actions = { actions.handler("dlg_a_defense_mode_314185f49277") },
        },
        {
            text = ccb.content.text("Allow triffids."),
            next_topic = "TALK_DEFENSE_MODE_ENEMY_SELECTION",
            when = predicates.handler("dlg_p_defense_mode_50cf2f50deb1"),
            actions = { actions.handler("dlg_a_defense_mode_caf8c2fcafee") },
        },
        {
            text = ccb.content.text("Disable triffids."),
            next_topic = "TALK_DEFENSE_MODE_ENEMY_SELECTION",
            when = predicates.handler("dlg_p_defense_mode_92f29bde9172"),
            actions = { actions.handler("dlg_a_defense_mode_b450266f3530") },
        },
        {
            text = ccb.content.text("Allow robots."),
            next_topic = "TALK_DEFENSE_MODE_ENEMY_SELECTION",
            when = predicates.handler("dlg_p_defense_mode_0c5d3a6721cc"),
            actions = { actions.handler("dlg_a_defense_mode_0f61dd16c140") },
        },
        {
            text = ccb.content.text("Disable robots."),
            next_topic = "TALK_DEFENSE_MODE_ENEMY_SELECTION",
            when = predicates.handler("dlg_p_defense_mode_5dc0484a959a"),
            actions = { actions.handler("dlg_a_defense_mode_9b8b95c34e9b") },
        },
        {
            text = ccb.content.text("Allow eldritch horrors."),
            next_topic = "TALK_DEFENSE_MODE_ENEMY_SELECTION",
            when = predicates.handler("dlg_p_defense_mode_f9dc94df3cea"),
            actions = { actions.handler("dlg_a_defense_mode_686d24f617ab") },
        },
        {
            text = ccb.content.text("Disable eldritch horrors."),
            next_topic = "TALK_DEFENSE_MODE_ENEMY_SELECTION",
            when = predicates.handler("dlg_p_defense_mode_564c5858070e"),
            actions = { actions.handler("dlg_a_defense_mode_436e0bededc9") },
        },
        {
            text = ccb.content.text("Allow dinosaurs."),
            next_topic = "TALK_DEFENSE_MODE_ENEMY_SELECTION",
            when = predicates.handler("dlg_p_defense_mode_390bd7f03489"),
            actions = { actions.handler("dlg_a_defense_mode_80371da47fa7") },
        },
        {
            text = ccb.content.text("Disable dinosaurs."),
            next_topic = "TALK_DEFENSE_MODE_ENEMY_SELECTION",
            when = predicates.handler("dlg_p_defense_mode_05b2f45eb20e"),
            actions = { actions.handler("dlg_a_defense_mode_ebf6e9cf0d98") },
        },
        {
            text = ccb.content.text("Allow lizardfolk."),
            next_topic = "TALK_DEFENSE_MODE_ENEMY_SELECTION",
            when = predicates.handler("dlg_p_defense_mode_2fd89984e627"),
            actions = { actions.handler("dlg_a_defense_mode_c4e4057bc5cc") },
        },
        {
            text = ccb.content.text("Disable lizardfolk."),
            next_topic = "TALK_DEFENSE_MODE_ENEMY_SELECTION",
            when = predicates.handler("dlg_p_defense_mode_4902ac896cf4"),
            actions = { actions.handler("dlg_a_defense_mode_89e95b7d3ce7") },
        },
        {
            text = ccb.content.text("Allow golems."),
            next_topic = "TALK_DEFENSE_MODE_ENEMY_SELECTION",
            when = predicates.handler("dlg_p_defense_mode_edd65c70a3fe"),
            actions = { actions.handler("dlg_a_defense_mode_2266d3162f64") },
        },
        {
            text = ccb.content.text("Disable golems."),
            next_topic = "TALK_DEFENSE_MODE_ENEMY_SELECTION",
            when = predicates.handler("dlg_p_defense_mode_91a0faafcfd8"),
            actions = { actions.handler("dlg_a_defense_mode_1da1dea0a7ef") },
        },
        {
            text = ccb.content.text("Allow goblins."),
            next_topic = "TALK_DEFENSE_MODE_ENEMY_SELECTION",
            when = predicates.handler("dlg_p_defense_mode_fb734f59752e"),
            actions = { actions.handler("dlg_a_defense_mode_2484229866a2") },
        },
        {
            text = ccb.content.text("Disable goblins."),
            next_topic = "TALK_DEFENSE_MODE_ENEMY_SELECTION",
            when = predicates.handler("dlg_p_defense_mode_66d53dcd6a7f"),
            actions = { actions.handler("dlg_a_defense_mode_f666437aa566") },
        },
        {
            text = ccb.content.text("Allow orcs."),
            next_topic = "TALK_DEFENSE_MODE_ENEMY_SELECTION",
            when = predicates.handler("dlg_p_defense_mode_e3df65f69aca"),
            actions = { actions.handler("dlg_a_defense_mode_88e06bd214a2") },
        },
        {
            text = ccb.content.text("Disable orcs."),
            next_topic = "TALK_DEFENSE_MODE_ENEMY_SELECTION",
            when = predicates.handler("dlg_p_defense_mode_7c8935d2444e"),
            actions = { actions.handler("dlg_a_defense_mode_526696ee84e5") },
        },
        {
            text = ccb.content.text("Allow megafauna."),
            next_topic = "TALK_DEFENSE_MODE_ENEMY_SELECTION",
            when = predicates.handler("dlg_p_defense_mode_0104dd84936a"),
            actions = { actions.handler("dlg_a_defense_mode_e130fde79de8") },
        },
        {
            text = ccb.content.text("Disable megafauna."),
            next_topic = "TALK_DEFENSE_MODE_ENEMY_SELECTION",
            when = predicates.handler("dlg_p_defense_mode_80a4055c89a3"),
            actions = { actions.handler("dlg_a_defense_mode_2975b10c2135") },
        },
        {
            text = ccb.content.text("Allow psychics."),
            next_topic = "TALK_DEFENSE_MODE_ENEMY_SELECTION",
            when = predicates.handler("dlg_p_defense_mode_e7cc711dca97"),
            actions = { actions.handler("dlg_a_defense_mode_6b0d9131783d") },
        },
        {
            text = ccb.content.text("Disable psychics."),
            next_topic = "TALK_DEFENSE_MODE_ENEMY_SELECTION",
            when = predicates.handler("dlg_p_defense_mode_891a5d3f35ca"),
            actions = { actions.handler("dlg_a_defense_mode_e6dabda90a61") },
        },
        {
            text = ccb.content.text("Allow sweets."),
            next_topic = "TALK_DEFENSE_MODE_ENEMY_SELECTION",
            when = predicates.handler("dlg_p_defense_mode_804c05d3757b"),
            actions = { actions.handler("dlg_a_defense_mode_383e12c5b11e") },
        },
        {
            text = ccb.content.text("Disable sweets."),
            next_topic = "TALK_DEFENSE_MODE_ENEMY_SELECTION",
            when = predicates.handler("dlg_p_defense_mode_04db419293d7"),
            actions = { actions.handler("dlg_a_defense_mode_00bf3e71eead") },
        },
        {
            text = ccb.content.text("Mgah'ehye ya nyth'drnn."),
            next_topic = "TALK_DEFENSE_MODE_ENEMY_SELECTION",
            when = predicates.handler("dlg_p_defense_mode_0556c6ac9c61"),
            actions = { actions.handler("dlg_a_defense_mode_46d5597086d5") },
        },
        {
            text = ccb.content.text("Mgah ya nyth'drnn."),
            next_topic = "TALK_DEFENSE_MODE_ENEMY_SELECTION",
            when = predicates.handler("dlg_p_defense_mode_05b980dd9d45"),
            actions = { actions.handler("dlg_a_defense_mode_2c61c9b55399") },
        },
        {
            text = ccb.content.text("Allow Exodii."),
            next_topic = "TALK_DEFENSE_MODE_ENEMY_SELECTION",
            when = predicates.handler("dlg_p_defense_mode_e1a121653e98"),
            actions = { actions.handler("dlg_a_defense_mode_19603a34563d") },
        },
        {
            text = ccb.content.text("Disable Exodii."),
            next_topic = "TALK_DEFENSE_MODE_ENEMY_SELECTION",
            when = predicates.handler("dlg_p_defense_mode_683eca4b487d"),
            actions = { actions.handler("dlg_a_defense_mode_e8424f0dcb51") },
        },
        {
            text = ccb.content.text("Allow XEDRA offworlders."),
            next_topic = "TALK_DEFENSE_MODE_ENEMY_SELECTION",
            when = predicates.handler("dlg_p_defense_mode_146df0146c1a"),
            actions = { actions.handler("dlg_a_defense_mode_c55d4c71e4da") },
        },
        {
            text = ccb.content.text("Disable XEDRA offworlders."),
            next_topic = "TALK_DEFENSE_MODE_ENEMY_SELECTION",
            when = predicates.handler("dlg_p_defense_mode_64c23344a5d8"),
            actions = { actions.handler("dlg_a_defense_mode_fed9bfb21d5e") },
        },
        {
            text = ccb.content.text("Allow exoplanetary residents."),
            next_topic = "TALK_DEFENSE_MODE_ENEMY_SELECTION",
            when = predicates.handler("dlg_p_defense_mode_438ec38f3ce4"),
            actions = { actions.handler("dlg_a_defense_mode_264ba0f04fb3") },
        },
        {
            text = ccb.content.text("Disable exoplanetary residents."),
            next_topic = "TALK_DEFENSE_MODE_ENEMY_SELECTION",
            when = predicates.handler("dlg_p_defense_mode_4512b8bd747e"),
            actions = { actions.handler("dlg_a_defense_mode_a1befa35f64f") },
        },
        {
            text = ccb.content.text("Return to main menu."),
            next_topic = "TALK_DEFENSE_MODE_MAIN_MENU",
        },
    },
}

ccb.content.define_dialogue_topic {
    id = "TALK_DEFENSE_MODE_ADVANCED_GAME_OPTIONS",
    line = ccb.content.text("Please alter these game options as you wish, make the experience just like you want it."),
    replies = {
        {
            text = ccb.content.text("Disable merchant trading."),
            next_topic = "TALK_DEFENSE_MODE_ADVANCED_GAME_OPTIONS",
            when = predicates.handler("dlg_p_defense_mode_4f183993ed37"),
            actions = { actions.handler("dlg_a_defense_mode_490bc88ccc5c") },
        },
        {
            text = ccb.content.text("Enable merchant trading."),
            next_topic = "TALK_DEFENSE_MODE_ADVANCED_GAME_OPTIONS",
            when = predicates.handler("dlg_p_defense_mode_bc5a52f7992a"),
            actions = { actions.handler("dlg_a_defense_mode_d4b7eb50796f") },
        },
        {
            text = ccb.content.text("Disable special waves."),
            next_topic = "TALK_DEFENSE_MODE_ADVANCED_GAME_OPTIONS",
            when = predicates.handler("dlg_p_defense_mode_d67468dfedcf"),
            actions = { actions.handler("dlg_a_defense_mode_ac1594a283c0") },
        },
        {
            text = ccb.content.text("Enable special waves."),
            next_topic = "TALK_DEFENSE_MODE_ADVANCED_GAME_OPTIONS",
            when = predicates.handler("dlg_p_defense_mode_7e73c430b65d"),
            actions = { actions.handler("dlg_a_defense_mode_120b19157b58") },
        },
        {
            text = ccb.content.text("Disable portal storms."),
            next_topic = "TALK_DEFENSE_MODE_ADVANCED_GAME_OPTIONS",
            when = predicates.handler("dlg_p_defense_mode_c38900ae8853"),
            actions = { actions.handler("dlg_a_defense_mode_0d009cfd1f84") },
        },
        {
            text = ccb.content.text("Enable portal storms."),
            next_topic = "TALK_DEFENSE_MODE_ADVANCED_GAME_OPTIONS",
            when = predicates.handler("dlg_p_defense_mode_172920d3e0ef"),
            actions = { actions.handler("dlg_a_defense_mode_b133b259df0e") },
        },
        {
            text = ccb.content.text("Disable random events."),
            next_topic = "TALK_DEFENSE_MODE_ADVANCED_GAME_OPTIONS",
            when = predicates.handler("dlg_p_defense_mode_2d6d0ac2fd12"),
            actions = { actions.handler("dlg_a_defense_mode_9106a9753c6a") },
        },
        {
            text = ccb.content.text("Enable random events."),
            next_topic = "TALK_DEFENSE_MODE_ADVANCED_GAME_OPTIONS",
            when = predicates.handler("dlg_p_defense_mode_98997d9c77a9"),
            actions = { actions.handler("dlg_a_defense_mode_5ebe52eb6ba1") },
        },
        {
            text = ccb.content.text("Return to main menu."),
            next_topic = "TALK_DEFENSE_MODE_MAIN_MENU",
        },
    },
}

ccb.content.define_dialogue_topic {
    id = "TALK_DEFENSE_MODE_DIFFICULTY_SELECTION_MENU",
    line = ccb.content.text("How hard do you want your game to be?"),
    replies = {
        {
            text = ccb.content.text("<color_yellow>Easy</color>: No additional enemies spawn per wave, and you get a second chance when you die the first time.  Good for newcomers or those not familiar with isometric horde fighters."),
            next_topic = "TALK_DEFENSE_MODE_DIFFICULTY_SELECTION_MENU",
            actions = { actions.handler("dlg_a_defense_mode_b7ee22e84e8e") },
        },
        {
            text = ccb.content.text("<color_yellow>Normal</color>: The basic way to play, no additional enemies, with no safety nets.  This is considered the default."),
            next_topic = "TALK_DEFENSE_MODE_DIFFICULTY_SELECTION_MENU",
            actions = { actions.handler("dlg_a_defense_mode_a14361e899d7") },
        },
        {
            text = ccb.content.text("<color_yellow>Difficult</color>: More enemies spawn per wave, but nothing too extreme.  You'll have to fight harder to live, but more loot comes with it too."),
            next_topic = "TALK_DEFENSE_MODE_DIFFICULTY_SELECTION_MENU",
            actions = { actions.handler("dlg_a_defense_mode_7e858b22e91f") },
        },
        {
            text = ccb.content.text("<color_yellow>Hard</color>: Twice the number of enemies will spawn per wave.  A true challenge to test your metal."),
            next_topic = "TALK_DEFENSE_MODE_DIFFICULTY_SELECTION_MENU",
            actions = { actions.handler("dlg_a_defense_mode_b2468f9b2461") },
        },
        {
            text = ccb.content.text("<color_yellow>Nightmare</color>: Three times the number of enemies will attack you, making things a long and brutal slog though guts and blood.  Come prepared to possibly fail a few times."),
            next_topic = "TALK_DEFENSE_MODE_DIFFICULTY_SELECTION_MENU",
            actions = { actions.handler("dlg_a_defense_mode_70e40ed0a2a6") },
        },
        {
            text = ccb.content.text("<color_yellow>DOOM</color>: Fives times the number of enemies will attack you.  Armies will come to your door, and what they will be met with is up to you to decide.  Incredibly difficult."),
            next_topic = "TALK_DEFENSE_MODE_DIFFICULTY_SELECTION_MENU",
            actions = { actions.handler("dlg_a_defense_mode_7f0a26536973") },
        },
        {
            text = ccb.content.text("Make a custom difficulty."),
            next_topic = "TALK_DEFENSE_MODE_CUSTOM_DIFFICULTY_MENU",
        },
        {
            text = ccb.content.text("Return to main menu."),
            next_topic = "TALK_DEFENSE_MODE_MAIN_MENU",
        },
    },
}

ccb.content.define_dialogue_topic {
    id = "TALK_DEFENSE_MODE_CUSTOM_DIFFICULTY_MENU",
    line = ccb.content.text("What difficulty modifier would you prefer?  Current modifier: <global_val:diffulty_modifier>."),
    replies = {
        {
            text = ccb.content.text("Increase by 1"),
            next_topic = "TALK_DEFENSE_MODE_CUSTOM_DIFFICULTY_MENU",
            actions = { actions.handler("dlg_a_defense_mode_39cb13fc160b") },
        },
        {
            text = ccb.content.text("Increase by 5"),
            next_topic = "TALK_DEFENSE_MODE_CUSTOM_DIFFICULTY_MENU",
            actions = { actions.handler("dlg_a_defense_mode_e768e112cec6") },
        },
        {
            text = ccb.content.text("Decrease by 1"),
            next_topic = "TALK_DEFENSE_MODE_CUSTOM_DIFFICULTY_MENU",
            actions = { actions.handler("dlg_a_defense_mode_b5dfefacfcc9") },
        },
        {
            text = ccb.content.text("Decrease by 5"),
            next_topic = "TALK_DEFENSE_MODE_CUSTOM_DIFFICULTY_MENU",
            actions = { actions.handler("dlg_a_defense_mode_625fcbbd05df") },
        },
        {
            text = ccb.content.text("Choose a preset difficulty."),
            next_topic = "TALK_DEFENSE_MODE_DIFFICULTY_SELECTION_MENU",
        },
        {
            text = ccb.content.text("Return to main menu."),
            next_topic = "TALK_DEFENSE_MODE_MAIN_MENU",
        },
    },
}
