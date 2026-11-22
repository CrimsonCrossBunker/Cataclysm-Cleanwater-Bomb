local ccb = require("ccb")
local predicates = ccb.content.dialogue_predicates
local actions = ccb.content.dialogue_actions

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
