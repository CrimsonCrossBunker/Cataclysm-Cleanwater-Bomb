local ccb = require("ccb")
local predicates = ccb.content.dialogue_predicates
local actions = ccb.content.dialogue_actions

ccb.content.define_dialogue_topic {
    id = { "TALK_FRIEND" },
    insert_before_standard_exits = true,
    replies = {
        {
            text = ccb.content.text("Can you tell me how much do you like me?"),
            next_topic = "TALK_FRIEND_FOLLOWER_SACRIFICE_MISSION",
            when = predicates.handler("dlg_p_xedra_evolved_f7e025645017"),
            actions = { actions.handler("dlg_a_xedra_evolved_f3e3449167a9") },
        },
    },
}

ccb.content.define_dialogue_topic {
    id = { "TALK_FRIEND" },
    insert_before_standard_exits = true,
    replies = {
        {
            text = ccb.content.text("Can you tell me how much do you like me?"),
            next_topic = "TALK_FRIEND_FOLLOWER_SACRIFICE_MISSION_2",
            when = predicates.handler("dlg_p_xedra_evolved_0ed2fb4e6714"),
        },
    },
}

ccb.content.define_dialogue_topic {
    id = { "TALK_FRIEND" },
    insert_before_standard_exits = true,
    replies = {
        {
            text = ccb.content.text("Can you tell me how much do you like me?"),
            next_topic = "TALK_FRIEND_FOLLOWER_SACRIFICE",
            when = predicates.handler("dlg_p_xedra_evolved_6ccc3d78c9e3"),
        },
    },
}

ccb.content.define_dialogue_topic {
    id = { "TALK_FRIEND" },
    insert_before_standard_exits = true,
    replies = {
        {
            text = ccb.content.text("Can you tell me how much do you like me?"),
            next_topic = "TALK_FRIEND_FOLLOWER_NOT_SACRIFICE",
            when = predicates.handler("dlg_p_xedra_evolved_fe36e8fba264"),
        },
    },
}

ccb.content.define_dialogue_topic {
    id = "TALK_FRIEND_FOLLOWER_NOT_SACRIFICE",
    line = ccb.content.text("You're a good friend.  I had better friends but I also had way worse."),
    replies = {
        {
            text = ccb.content.text("Thanks for telling me.  Can we talk about something else?"),
            next_topic = "TALK_FRIEND",
        },
        {
            text = ccb.content.text("Thanks for telling me.  See you later."),
            next_topic = "TALK_DONE",
        },
    },
}

ccb.content.define_dialogue_topic {
    id = "TALK_FRIEND_FOLLOWER_SACRIFICE_MISSION",
    line = {
        when = predicates.handler("dlg_p_xedra_evolved_a9d361425c82"),
        yes = ccb.content.text("I would love it if you could find my favorite book.  Could you help me find it?  It's an anthology of stories titled 'Apocalypse Now'.  I know it's weird to want to read a book about apocalypses during one, but it gives me hope we'll come out the other side of this one too."),
        no = {
            when = predicates.handler("dlg_p_xedra_evolved_3602997c83c2"),
            yes = ccb.content.text("I would love it if you could find my favorite book.  Could you help me find it?  It's Brave New World by Aldous Huxley.  It really spoke to me before the end and even more now."),
            no = {
                when = predicates.handler("dlg_p_xedra_evolved_a2107f3d14c6"),
                yes = ccb.content.text("I would love it if you could find my favorite book.  Could you help me find it?  It's All Things Weird, by Felicity Powell.  It gives a great sense of humor to the end of the world!"),
                no = {
                    when = predicates.handler("dlg_p_xedra_evolved_079cda004454"),
                    yes = ccb.content.text("PLEASE REPORT THIS ON GITHUB.  A RNG OF 1-3 PICKED A HIGHER NUMBER."),
                    no = ccb.content.text("ERROR: couldn't pick a mission for the book search."),
                },
            },
        },
    },
    replies = {
        {
            text = ccb.content.text("I will find that book for you."),
            next_topic = "TALK_DONE",
            when = predicates.handler("dlg_p_xedra_evolved_a9d361425c82"),
            actions = { actions.assign_mission("mission_best_friend_bookhunt1") },
            switch = true,
        },
        {
            text = ccb.content.text("I will find that book for you."),
            next_topic = "TALK_DONE",
            when = predicates.handler("dlg_p_xedra_evolved_3602997c83c2"),
            actions = { actions.assign_mission("mission_best_friend_bookhunt2") },
            switch = true,
        },
        {
            text = ccb.content.text("I will find that book for you."),
            next_topic = "TALK_DONE",
            when = predicates.handler("dlg_p_xedra_evolved_a2107f3d14c6"),
            actions = { actions.assign_mission("mission_best_friend_bookhunt3") },
            switch = true,
        },
        {
            text = ccb.content.text("It'll have to wait.  Maybe later."),
            next_topic = "TALK_DONE",
        },
    },
}

ccb.content.define_dialogue_topic {
    id = "TALK_FRIEND_FOLLOWER_SACRIFICE_MISSION_2",
    line = {
        when = predicates.handler("dlg_p_xedra_evolved_d5491a924f31"),
        yes = ccb.content.text("I would love it if you could find my favorite game.  Could you help me find it?  It's a board game called Pathogen.  At least the diseases in this game can be beaten."),
        no = {
            when = predicates.handler("dlg_p_xedra_evolved_d7f5e506e1e2"),
            yes = ccb.content.text("I would love it if you could find my favorite game.  Could you help me find it?  It's a board game called Steam Gears.  Alternate history is so much better than real history."),
            no = {
                when = predicates.handler("dlg_p_xedra_evolved_766b0181e6cf"),
                yes = ccb.content.text("I would love it if you could find my favorite game.  Could you help me find it?  It's a board game called Terraforming Mercury.  I guess terraforming anywhere is a pipe dream now."),
                no = {
                    when = predicates.handler("dlg_p_xedra_evolved_df132bd89a85"),
                    yes = ccb.content.text("PLEASE REPORT THIS ON GITHUB.  A RNG OF 0-3 PICKED A HIGHER NUMBER."),
                    no = ccb.content.text("ERROR: couldn't pick a mission for the game search."),
                },
            },
        },
    },
    replies = {
        {
            text = ccb.content.text("I will find that game for you."),
            next_topic = "TALK_DONE",
        },
    },
}

ccb.content.define_dialogue_topic {
    id = "TALK_FRIEND_FOLLOWER_SACRIFICE",
    line = {
        when = predicates.any_equal({ "yes", { scope = "speaker", key = "best_friend" } }),
        yes = ccb.content.text("You're the best person in the world for me.  I wouldn't ever hesitate to trust you with my life.  I feel that no matter what happens, it'll be fine as you'll be there."),
        no = ccb.content.text("I mean you're ok, I guess."),
    },
    replies = {
        {
            text = ccb.content.text("Thanks for telling me.  Can we talk about something else?"),
            next_topic = "TALK_FRIEND",
            actions = { actions.replace_mutation("interlocutor", "VAMPIRE_SACRIFICE") },
        },
        {
            text = ccb.content.text("Thanks for telling me.  See you later."),
            next_topic = "TALK_DONE",
            actions = { actions.replace_mutation("interlocutor", "VAMPIRE_SACRIFICE") },
        },
    },
}

ccb.content.define_mutation {
    id = "VAMPIRE_SACRIFICE",
    name = ccb.content.text_without_extraction("sacrificial mark"),
    points = 0,
    player_display = false,
    valid = false,
    purifiable = false,
    description = ccb.content.text_without_extraction("You're not supposed to see this.  Tracks that you are killing your best friend ever"),
    enchantments = { "sacrificial_marked" },
}

ccb.content.define_spell {
    id = "sacrificial_marked",
    name = ccb.content.text("sacrificial marked"),
    description = ccb.content.text("Shouldn't be visible.  Tracks that you are killing someone that considers you the best person in the world."),
    valid_targets = { "hostile" },
    min_range = 50,
    max_range = 50,
    min_duration = 500,
    max_duration = 500,
    difficulty = 5,
    flags = { "SILENT", "NO_SFX", "NO_LEGS", "NO_PROJECTILE" },
    shape = "blast",
    effect = "attack",
    effect_data = "about_to_kill_best_friend",
}

ccb.content.define_mission {
    id = "mission_best_friend_bookhunt1",
    name = ccb.content.text("Help me find my favorite book.  Apocalypse Now"),
    description = ccb.content.text("Could you help me find my favorite book?  It's an anthology of stories titled 'Apocalypse Now'.  I know it's weird to want to read a book about apocalypses during one, but it gives me hope we'll come out the other side of this one too."),
    goal = "MGOAL_FIND_ITEM",
    difficulty = 2,
    item = "book_anthology_an",
    origins = { "ORIGIN_SECONDARY" },
    value = 0,
    dialogue = {
        describe = ccb.content.text("I would love it if you could find my favorite book."),
        offer = ccb.content.text("I know you are my friend and I don't want to push you but if you come across my favorite book I'd appreciate it if you brought it to me."),
        accepted = ccb.content.text("Thank you!"),
        rejected = ccb.content.text("Let me know if you change your mind."),
        advice = ccb.content.text("Bookstores and libraries are the most likely places to find it or just wandering through houses."),
        inquire = ccb.content.text("Did you find it?"),
        success = ccb.content.text("You've found it!"),
        success_lie = ccb.content.text("This clearly isn't it."),
        failure = ccb.content.text("Well thanks anyway."),
    },
    finish = { handler = { "gamehunt_morale", "assign_sacrifice_gamehunt_mission" } },
}

ccb.content.define_mission {
    id = "mission_best_friend_bookhunt2",
    name = ccb.content.text("Help me find my favorite book.  Brave New World."),
    description = ccb.content.text("Could you help me find my favorite book?  It's Brave New World by Aldous Huxley.  It really spoke to me before the end and even more now."),
    goal = "MGOAL_FIND_ITEM",
    difficulty = 2,
    item = "book_fict_soft_scifi_brave",
    origins = { "ORIGIN_SECONDARY" },
    value = 0,
    dialogue = {
        describe = ccb.content.text("I would love it if you could find my favorite book."),
        offer = ccb.content.text("I know you are my friend and I don't want to push you but if you come across my favorite book I'd appreciate it if you brought it to me."),
        accepted = ccb.content.text("Thank you!"),
        rejected = ccb.content.text("Let me know if you change your mind."),
        advice = ccb.content.text("Bookstores and libraries are the most likely places to find it or just wandering through houses."),
        inquire = ccb.content.text("Did you find it?"),
        success = ccb.content.text("You've found it!"),
        success_lie = ccb.content.text("This clearly isn't it."),
        failure = ccb.content.text("Well thanks anyway."),
    },
    finish = { handler = { "gamehunt_morale", "assign_sacrifice_gamehunt_mission" } },
}

ccb.content.define_mission {
    id = "mission_best_friend_bookhunt3",
    name = ccb.content.text("Help me find my favorite book.  Cat's Cradle."),
    description = ccb.content.text("Could you help me find my favorite book?  It's Cat's Cradle, by Kurt Vonnegut.  It's an interesting take on an alternate cataclysmic scenario."),
    goal = "MGOAL_FIND_ITEM",
    difficulty = 2,
    item = "book_fict_soft_satire_cats",
    origins = { "ORIGIN_SECONDARY" },
    value = 0,
    dialogue = {
        describe = ccb.content.text("I would love it if you could find my favorite book."),
        offer = ccb.content.text("I know you are my friend and I don't want to push you but if you come across my favorite book I'd appreciate it if you brought it to me."),
        accepted = ccb.content.text("Thank you!"),
        rejected = ccb.content.text("Let me know if you change your mind."),
        advice = ccb.content.text("Bookstores and libraries are the most likely places to find it or just wandering through houses."),
        inquire = ccb.content.text("Did you find it?"),
        success = ccb.content.text("You've found it!"),
        success_lie = ccb.content.text("This clearly isn't it."),
        failure = ccb.content.text("Well thanks anyway."),
    },
    finish = { handler = { "gamehunt_morale", "assign_sacrifice_gamehunt_mission" } },
}

ccb.content.define_mission {
    id = "mission_best_friend_gamehunt1",
    name = ccb.content.text("Help me find my favorite game.  Pathogen"),
    description = ccb.content.text("Could you help me find my favorite game?  It's a board game called Pathogen.  At least the diseases in this game can be beaten."),
    goal = "MGOAL_FIND_ITEM",
    difficulty = 2,
    item = "pandemic",
    origins = { "ORIGIN_SECONDARY" },
    value = 0,
    dialogue = {
        describe = ccb.content.text("I would love it if you could find my favorite game."),
        offer = ccb.content.text("I know you are my friend and I don't want to push you but if you come across my favorite game I'd appreciate it if you brought it to me."),
        accepted = ccb.content.text("Thank you!"),
        rejected = ccb.content.text("Let me know if you change your mind."),
        advice = ccb.content.text("Bookstores and gameshops are the most likely places to find it or just wandering through houses."),
        inquire = ccb.content.text("Did you find it?"),
        success = ccb.content.text("You've found it!"),
        success_lie = ccb.content.text("This clearly isn't it."),
        failure = ccb.content.text("Well thanks anyway."),
    },
    finish = { handler = { "gamehunt_morale", "mark_best_friend" } },
}

ccb.content.define_mission {
    id = "mission_best_friend_gamehunt2",
    name = ccb.content.text("Help me find my favorite game.  Steam Gears"),
    description = ccb.content.text("Could you help me find my favorite game?  It's a board game called Steam Gears.  Alternate history is so much better than real history."),
    goal = "MGOAL_FIND_ITEM",
    difficulty = 2,
    item = "scythe_game",
    origins = { "ORIGIN_SECONDARY" },
    value = 0,
    dialogue = {
        describe = ccb.content.text("I would love it if you could find my favorite game."),
        offer = ccb.content.text("I know you are my friend and I don't want to push you but if you come across my favorite game I'd appreciate it if you brought it to me."),
        accepted = ccb.content.text("Thank you!"),
        rejected = ccb.content.text("Let me know if you change your mind."),
        advice = ccb.content.text("Bookstores and gameshops are the most likely places to find it or just wandering through houses."),
        inquire = ccb.content.text("Did you find it?"),
        success = ccb.content.text("You've found it!"),
        success_lie = ccb.content.text("This clearly isn't it."),
        failure = ccb.content.text("Well thanks anyway."),
    },
    finish = { handler = { "gamehunt_morale", "mark_best_friend" } },
}

ccb.content.define_mission {
    id = "mission_best_friend_gamehunt3",
    name = ccb.content.text("Help me find my favorite game.  Terraforming Mercury"),
    description = ccb.content.text("Could you help me find my favorite game?  It's a board game called Terraforming Mercury.  I guess terraforming anywhere is a pipe dream now."),
    goal = "MGOAL_FIND_ITEM",
    difficulty = 2,
    item = "terraforming_mercury",
    origins = { "ORIGIN_SECONDARY" },
    value = 0,
    dialogue = {
        describe = ccb.content.text("I would love it if you could find my favorite game."),
        offer = ccb.content.text("I know you are my friend and I don't want to push you but if you come across my favorite game I'd appreciate it if you brought it to me."),
        accepted = ccb.content.text("Thank you!"),
        rejected = ccb.content.text("Let me know if you change your mind."),
        advice = ccb.content.text("Bookstores and gameshops are the most likely places to find it or just wandering through houses."),
        inquire = ccb.content.text("Did you find it?"),
        success = ccb.content.text("You've found it!"),
        success_lie = ccb.content.text("This clearly isn't it."),
        failure = ccb.content.text("Well thanks anyway."),
    },
    finish = { handler = { "gamehunt_morale", "mark_best_friend" } },
}
