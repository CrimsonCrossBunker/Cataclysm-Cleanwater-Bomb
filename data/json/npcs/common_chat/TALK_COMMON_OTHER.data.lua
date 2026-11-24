local ccb = require("ccb")
local predicates = ccb.content.dialogue_predicates
local actions = ccb.content.dialogue_actions

ccb.content.define_dialogue_topic {
    id = "TALK_SHELTER",
    line = {
        choices = {
            ccb.content.text("Well, I guess it's just us."),
            ccb.content.text("At least we've got shelter."),
        },
    },
    replies = {
        { text = ccb.content.text("What should we do now?"), next_topic = "TALK_SHELTER_PLANS" },
        { text = ccb.content.text("Any tips?"), next_topic = "TALK_SHELTER_ADVICE" },
        { text = ccb.content.text("Can I do anything for you?"), next_topic = "TALK_MISSION_LIST" },
        {
            text = ccb.content.text("Want to travel with me?"),
            next_topic = "TALK_SUGGEST_FOLLOW",
            when = predicates.negate(predicates.actor_state("interlocutor", "following")),
        },
        {
            text = ccb.content.text("Let's trade items."),
            when = predicates.has_trait("interlocutor", "NPC_STARTING_NPC"),
            next_topic = "TALK_SHELTER",
            native_actions = { "start_trade" },
        },
        {
            text = ccb.content.text("Let's trade items."),
            when = predicates.negate(predicates.has_trait("interlocutor", "NPC_STARTING_NPC")),
            next_topic = "TALK_NONE",
            native_actions = { "start_trade" },
        },
        {
            text = ccb.content.text("Want to share some useful items with me?"),
            next_topic = "TALK_SHARE_EQUIPMENT",
        },
        {
            text = ccb.content.text_without_extraction("<end_talking_bye>"),
            next_topic = "TALK_DONE",
        },
    },
}

ccb.content.define_dialogue_topic {
    id = "TALK_SHELTER_PLANS",
    line = {
        choices = {
            ccb.content.text("I don't know, look for supplies and other survivors I guess."),
            ccb.content.text("Maybe we should start boarding up this place."),
            ccb.content.text("I suppose getting a car up and running would be really be useful if we have to move."),
            ccb.content.text("We could look for a farm.  They should have food and tools, and they aren't close to cities."),
            ccb.content.text("We should probably stay away from cities, even if they have lots of supplies."),
            ccb.content.text("Maybe we should go West, the further away from the urban coastline we are, the better.  It must be hell on earth over there in the East."),
        },
    },
    replies = { { text = ccb.content.text("Hmm, okay."), next_topic = "TALK_NONE" } },
}

ccb.content.define_dialogue_topic {
    id = "TALK_SHELTER_ADVICE",
    line = { special = "hint" },
    replies = { { text = ccb.content.text("Thanks!"), next_topic = "TALK_NONE" } },
}

ccb.content.define_dialogue_topic {
    id = "TALK_SHELTER_DENY_ADVICE",
    line = { when = predicates.handler("dlg_p_dda_8baf563d07a6"), yes = ccb.content.text("Focus on the road, mate!"), no = { when = predicates.handler("dlg_p_dda_11f4fe0cf4dc"), yes = ccb.content.text("I'm driving here!"), no = {
                when = predicates.handler("dlg_p_dda_7d19faa96245"),
                yes = ccb.content.text("I'm too thirsty, give me something to drink."),
                no = {
                    when = predicates.handler("dlg_p_dda_43c2f4328d3c"),
                    yes = ccb.content.text("I'm too hungry, give me something to eat."),
                    no = {
                        when = predicates.handler("dlg_p_dda_ea60ec832f23"),
                        yes = ccb.content.gendered_line("I'm too tired, let me rest first.", { "interlocutor" }),
                        no = {
                            when = predicates.has_effect("interlocutor", "asked_to_hint"),
                            yes = ccb.content.text("Nothing comes to my mind now.  Ask me later perhaps?"),
                            no = ccb.content.text("I have some reason for not telling you."),
                        },
                    },
                },
            } } },
    replies = {
        {
            text = ccb.content.text("Ah, okay."),
            next_topic = "TALK_NONE",
        },
    },
}

ccb.content.define_dialogue_topic {
    id = "TALK_SUGGEST_FOLLOW",
    line = {
        when = predicates.has_effect("interlocutor", "infection"),
        yes = ccb.content.text("Not until I get some antibiotics…"),
        no = {
            when = predicates.has_effect("interlocutor", "asked_to_follow"),
            yes = ccb.content.gendered_line("You asked me recently; ask again later.", { "speaker" }),
            no = ccb.content.text("Why should I travel with you?"),
        },
    },
    replies = {
        {
            text = ccb.content.text("Understood.  I'll get those antibiotics."),
            next_topic = "TALK_NONE",
            when = predicates.has_effect("interlocutor", "infection"),
            switch = true,
        },
        {
            text = ccb.content.text("Right, right, I'll ask later."),
            next_topic = "TALK_NONE",
            when = predicates.has_effect("interlocutor", "asked_to_follow"),
            switch = true,
        },
        {
            text = ccb.content.text("I can keep you safe."),
            switch = true,
            default = true,
            trial = { kind = "persuade", difficulty = 20, modifiers = { { score = "FEAR", scale = 8 }, { score = "VALUE", scale = 2 }, { score = "TRUST", scale = 2 }, { score = "BRAVERY", scale = -2 }, { score = "LOWFUNC_PSYCHOPATH", scale = -10 }, { score = "HIGHFUNC_PSYCHOPATH", scale = 2 } } },
            success = { next_topic = "TALK_AGREE_FOLLOW", actions = { "follow", actions.handler("dlg_a_dda_22a5bb9a10f5") }, opinion = { trust = 1, value = 1 } },
            failure = { next_topic = "TALK_DENY_FOLLOW", actions = { "deny_follow" }, opinion = { value = -1, anger = 1 } },
        },
        {
            text = ccb.content.text("You can keep me safe."),
            switch = true,
            default = true,
            trial = { kind = "persuade", difficulty = 0, modifiers = { { score = "ALTRUISM", scale = 6 }, { score = "POS_FEAR", scale = -6 }, { score = "BRAVERY", scale = 2 }, { score = "ANGER", scale = -6 }, { score = "VALUE", scale = 2 }, { score = "LOWFUNC_PSYCHOPATH", scale = -10 }, { score = "HIGHFUNC_PSYCHOPATH", scale = 2 } } },
            success = { next_topic = "TALK_AGREE_FOLLOW", actions = { "follow", actions.handler("dlg_a_dda_22a5bb9a10f5") }, opinion = { value = -1 } },
            failure = { next_topic = "TALK_DENY_FOLLOW", actions = { "deny_follow" }, opinion = { value = -1, anger = 1 } },
        },
        {
            text = ccb.content.text("We're friends, aren't we?"),
            switch = true,
            default = true,
            trial = { kind = "persuade", difficulty = 0, modifiers = { { score = "TRUST", scale = 3 }, { score = "VALUE", scale = 3 }, { score = "ANGER", scale = -3 }, { score = "LOWFUNC_PSYCHOPATH", scale = -10 }, { score = "HIGHFUNC_PSYCHOPATH", scale = 2 } } },
            success = { next_topic = "TALK_AGREE_FOLLOW", actions = { "follow", actions.handler("dlg_a_dda_22a5bb9a10f5") }, opinion = { trust = 2, anger = -1 } },
            failure = { next_topic = "TALK_DENY_FOLLOW", actions = { "deny_follow" }, opinion = { value = -1, anger = 1 } },
        },
        {
            text = ccb.content.text("I'll kill you if you don't."),
            switch = true,
            default = true,
            trial = { kind = "intimidate", difficulty = 20, modifiers = { { score = "FEAR", scale = 8 }, { score = "VALUE", scale = 2 }, { score = "TRUST", scale = 2 }, { score = "BRAVERY", scale = -2 }, { score = "LOWFUNC_PSYCHOPATH", scale = 5 }, { score = "HIGHFUNC_PSYCHOPATH", scale = 2 } } },
            success = { next_topic = "TALK_AGREE_FOLLOW", actions = { "follow", actions.handler("dlg_a_dda_22a5bb9a10f5") }, opinion = { trust = -4, fear = 3, value = -1, anger = 4 } },
            failure = { next_topic = "TALK_DENY_FOLLOW", actions = { "deny_follow" }, opinion = { trust = -4, value = -5, anger = 20 } },
        },
        {
            text = ccb.content.text("<end_talking_nevermind>"),
            next_topic = "TALK_NONE",
            switch = true,
            default = true,
        },
    },
}

ccb.content.define_dialogue_topic {
    id = "TALK_AGREE_FOLLOW",
    line = ccb.content.text("You got it, I'm with you!"),
    replies = {
        { text = ccb.content.text("Awesome!"), next_topic = "TALK_FRIEND" },
        { text = ccb.content.text_without_extraction("<lets_go>"), next_topic = "TALK_DONE" },
    },
}

ccb.content.define_dialogue_topic {
    id = "TALK_DENY_FOLLOW",
    line = ccb.content.text("Yeah… I don't think so."),
    replies = { { text = ccb.content.text("Oh, okay."), next_topic = "TALK_DONE" } },
}

ccb.content.define_dialogue_topic {
    id = "TALK_LEADER",
    line = ccb.content.text("What is it?"),
    replies = {
        {
            text = ccb.content.text("How much further?"),
            next_topic = "TALK_HOW_MUCH_FURTHER",
            when = predicates.handler("dlg_p_dda_378775caa047"),
        },
        {
            text = ccb.content.text("I'd like to lead for a while."),
            trial = { kind = "persuade", difficulty = 0, modifiers = { { score = "FEAR", scale = 1 }, { score = "VALUE", scale = 1 }, { score = "TRUST", scale = 1 }, { score = "BRAVERY", scale = -1 }, { score = "AGGRESSION", scale = -1 } } },
            success = { next_topic = "TALK_PLAYER_LEADS", actions = { "follow" } },
            failure = { next_topic = "TALK_LEADER_STAYS", opinion = { value = -1, anger = -1 } },
        },
        {
            text = ccb.content.text("Step aside.  I'm leader now."),
            trial = { kind = "intimidate", difficulty = 40 },
            success = { next_topic = "TALK_PLAYER_LEADS", actions = { "follow" }, opinion = { trust = -1, fear = 1, value = -1, anger = 1 } },
            failure = { next_topic = "TALK_LEADER_STAYS", opinion = { trust = -1, value = -1, anger = 1 } },
        },
        {
            text = ccb.content.text("Can I do anything for you?"),
            next_topic = "TALK_MISSION_LIST",
        },
        {
            text = ccb.content.text("Let's trade items."),
            next_topic = "TALK_NONE",
            actions = { "start_trade" },
        },
        {
            text = ccb.content.text("<lets_go>"),
            next_topic = "TALK_DONE",
        },
    },
}

ccb.content.define_dialogue_topic {
    id = "TALK_PLAYER_LEADS",
    line = ccb.content.text("Alright.  You can lead now."),
    replies = {
        { text = ccb.content.text("Good.  Something else…"), next_topic = "TALK_FRIEND" },
        { text = ccb.content.text_without_extraction("<lets_go>"), next_topic = "TALK_NONE" },
    },
}

ccb.content.define_dialogue_topic {
    id = "TALK_LEADER_STAYS",
    replies = { { text = ccb.content.text("Okay, okay."), next_topic = "TALK_NONE" } },
}

ccb.content.define_dialogue_topic {
    id = "TALK_DESCRIBE_MISSION",
    replies = {
        { text = ccb.content.text("I see."), next_topic = "TALK_NONE" },
        {
            text = ccb.content.text_without_extraction("<end_talking_bye>"),
            next_topic = "TALK_DONE",
        },
    },
}

ccb.content.define_dialogue_topic {
    id = "TALK_TRAIN_NPC_START",
    line = ccb.content.text("Alright, show me how it's done."),
    replies = {
        {
            text = ccb.content.text("Okay, let's begin."),
            next_topic = "TALK_DONE",
            when = predicates.handler("dlg_p_dda_9860d3f75191"),
            actions = { "start_training_npc" },
            switch = true,
        },
        {
            text = ccb.content.text("Okay.  Lead the way."),
            next_topic = "TALK_DONE",
            actions = { "lead_to_safety" },
            switch = true,
            default = true,
        },
        {
            text = ccb.content.text("No, we'll be okay here."),
            next_topic = "TALK_TRAIN_NPC_FORCE",
            switch = true,
            default = true,
        },
        {
            text = ccb.content.text("<end_talking_nevermind>"),
            next_topic = "TALK_NONE",
        },
    },
}

ccb.content.define_dialogue_topic {
    id = "TALK_TRAIN_SEMINAR_START",
    line = ccb.content.text("Alright, who should participate?"),
    replies = {
        {
            text = ccb.content.text("Let's see…"),
            next_topic = "TALK_DONE",
            when = predicates.handler("dlg_p_dda_9860d3f75191"),
            actions = { "start_training_seminar" },
            switch = true,
        },
        {
            text = ccb.content.text("<end_talking_nevermind>"),
            next_topic = "TALK_NONE",
        },
    },
}

ccb.content.define_dialogue_topic {
    id = "TALK_TRAIN_START",
    line = ccb.content.text("Alright, let's begin."),
    replies = {
        {
            text = ccb.content.text("Sounds good."),
            next_topic = "TALK_DONE",
            when = predicates.handler("dlg_p_dda_9860d3f75191"),
            actions = { "start_training" },
            switch = true,
        },
        {
            text = ccb.content.text("Okay.  Lead the way."),
            next_topic = "TALK_DONE",
            actions = { "lead_to_safety" },
            switch = true,
            default = true,
        },
        {
            text = ccb.content.text("No, we'll be okay here."),
            next_topic = "TALK_TRAIN_FORCE",
            switch = true,
            default = true,
        },
        {
            text = ccb.content.text("<end_talking_nevermind>"),
            next_topic = "TALK_NONE",
        },
    },
}

ccb.content.define_dialogue_topic {
    id = "TALK_DENY_TRAIN",
    line = { when = predicates.handler("dlg_p_dda_8baf563d07a6"), yes = ccb.content.text("I can't train you properly while you're operating a vehicle!"), no = { when = predicates.handler("dlg_p_dda_11f4fe0cf4dc"), yes = ccb.content.text("I can't train you properly while I'm operating a vehicle!"), no = {
                when = predicates.handler("dlg_p_dda_7d19faa96245"),
                yes = ccb.content.text("I'm too thirsty, give me something to drink."),
                no = {
                    when = predicates.handler("dlg_p_dda_43c2f4328d3c"),
                    yes = ccb.content.text("I'm too hungry, give me something to eat."),
                    no = {
                        when = predicates.handler("dlg_p_dda_ea60ec832f23"),
                        yes = ccb.content.gendered_line("I'm too tired, let me rest first.", { "interlocutor" }),
                        no = {
                            when = predicates.has_effect("interlocutor", "asked_to_train"),
                            yes = ccb.content.text("Give it some time, I'll show you something new later…"),
                            no = ccb.content.text("I have some reason for denying you training."),
                        },
                    },
                },
            } } },
    replies = {
        {
            text = ccb.content.text("Ah, okay."),
            next_topic = "TALK_NONE",
        },
    },
}

ccb.content.define_dialogue_topic {
    id = "TALK_DENY_TRAIN_SEMINAR",
    line = { when = predicates.handler("dlg_p_dda_8baf563d07a6"), yes = ccb.content.text("We'll talk about a training seminar after you're done operating that vehicle."), no = { when = predicates.handler("dlg_p_dda_11f4fe0cf4dc"), yes = ccb.content.text("I can't host a seminar while I'm operating a vehicle!"), no = {
                when = predicates.handler("dlg_p_dda_7d19faa96245"),
                yes = ccb.content.text("I'm too thirsty, give me something to drink."),
                no = {
                    when = predicates.handler("dlg_p_dda_43c2f4328d3c"),
                    yes = ccb.content.text("I'm too hungry, give me something to eat."),
                    no = {
                        when = predicates.handler("dlg_p_dda_ea60ec832f23"),
                        yes = ccb.content.gendered_line("I'm too tired, let me rest first.", { "interlocutor" }),
                        no = {
                            when = predicates.has_effect("interlocutor", "asked_to_train"),
                            yes = ccb.content.text("Give it some time, we'll talk about a training seminar later…"),
                            no = ccb.content.text("I have some reason to refuse hosting a training seminar."),
                        },
                    },
                },
            } } },
    replies = {
        {
            text = ccb.content.text("Ah, okay."),
            next_topic = "TALK_NONE",
        },
    },
}

ccb.content.define_dialogue_topic {
    id = "TALK_TRAIN_NPC_FORCE",
    line = ccb.content.text("Alright, show me how it's done."),
    replies = {
        {
            text = ccb.content.text("Okay, let's begin."),
            next_topic = "TALK_DONE",
            native_actions = { "start_training_npc" },
        },
        {
            text = ccb.content.text_without_extraction("<end_talking_nevermind>"),
            next_topic = "TALK_NONE",
        },
    },
}

ccb.content.define_dialogue_topic {
    id = "TALK_TRAIN_FORCE",
    line = ccb.content.text("Alright, let's begin."),
    replies = {
        {
            text = ccb.content.text("Sounds good."),
            next_topic = "TALK_DONE",
            native_actions = { "start_training" },
        },
        {
            text = ccb.content.text_without_extraction("<end_talking_nevermind>"),
            next_topic = "TALK_NONE",
        },
    },
}

ccb.content.define_dialogue_topic {
    id = "TALK_DENY_GUARD",
    line = ccb.content.text("Not a bloody chance, I'm going to get left behind!"),
    replies = { { text = ccb.content.text("Fine."), next_topic = "TALK_NONE" } },
}

ccb.content.define_dialogue_topic {
    id = "TALK_FRIEND_GUARD",
    line = ccb.content.text("I'm on watch."),
    replies = {
        {
            text = ccb.content.text("I need you to come with me."),
            next_topic = "TALK_FRIEND",
            native_actions = { "stop_guard" },
        },
        { text = ccb.content.text("Let's talk."), next_topic = "TALK_FRIEND" },
        {
            text = ccb.content.text_without_extraction("<end_talking_bye>"),
            next_topic = "TALK_DONE",
        },
    },
}

ccb.content.define_dialogue_topic {
    id = "TALK_FRIEND_GUARD_CAMP",
    line = ccb.content.text("I'm on watch."),
    replies = {
        {
            text = ccb.content.text("Go back to your camp duties."),
            next_topic = "TALK_FRIEND",
            actions = { "return_to_camp_duties" },
        },
        {
            text = ccb.content.text("I need you to come with me."),
            next_topic = "TALK_FRIEND",
            actions = { "stop_guard" },
        },
        { text = ccb.content.text("Let's talk."), next_topic = "TALK_FRIEND" },
        {
            text = ccb.content.text_without_extraction("<end_talking_bye>"),
            next_topic = "TALK_DONE",
        },
    },
}

ccb.content.define_dialogue_topic {
    id = "TALK_FRIEND_CAMP_RESIDENT",
    line = ccb.content.text("I'm working at the camp."),
    replies = {
        {
            text = ccb.content.text("I need you to come with me."),
            next_topic = "TALK_FRIEND",
            native_actions = { "stop_guard" },
        },
        { text = ccb.content.text("Let's talk."), next_topic = "TALK_FRIEND" },
        {
            text = ccb.content.text_without_extraction("<end_talking_bye>"),
            next_topic = "TALK_DONE",
        },
    },
}

ccb.content.define_dialogue_topic {
    id = "TALK_FRIEND_UNCOMFORTABLE",
    line = ccb.content.text("I really don't feel comfortable doing so…"),
    replies = { { text = ccb.content.text("I'll give you some space."), next_topic = "TALK_FRIEND" } },
}

ccb.content.define_dialogue_topic {
    id = "TALK_DENY_PERSONAL",
    line = ccb.content.text("I'd prefer to keep that to myself."),
    replies = { { text = ccb.content.text("I understand…"), next_topic = "TALK_FRIEND" } },
}

ccb.content.define_dialogue_topic {
    id = "TALK_SHARE_EQUIPMENT",
    line = {
        when = predicates.has_effect("interlocutor", "asked_for_item"),
        yes = ccb.content.gendered_line("You just asked me for stuff; ask later.", { "speaker" }),
        no = ccb.content.text("Why should I share my equipment with you?"),
    },
    replies = {
        {
            text = ccb.content.text("Okay, fine."),
            next_topic = "TALK_NONE",
            when = predicates.has_effect("interlocutor", "asked_for_item"),
            switch = true,
        },
        {
            text = ccb.content.text("Because I'm holding a thermal detonator!"),
            next_topic = "TALK_GIVE_EQUIPMENT",
            when = predicates.has_item("speaker", "mininuke"),
            actions = { actions.give_equipment({ { score = "TRUST", scale = 1 }, { score = "VALUE", scale = 3 }, { score = "ALTRUISM", scale = 2 }, { score = "TOTAL", scale = 300 } }) },
            opinion = { trust = -6, fear = 5, value = -1, anger = 5 },
            switch = true,
            default = true,
        },
        {
            text = ccb.content.text("Because I'm your friend!"),
            switch = true,
            default = true,
            trial = { kind = "persuade", difficulty = 10, modifiers = { { score = "TRUST", scale = 1 }, { score = "VALUE", scale = 3 }, { score = "ALTRUISM", scale = 2 }, { score = "LOWFUNC_PSYCHOPATH", scale = -2 }, { score = "HIGHFUNC_PSYCHOPATH", scale = 1 } } },
            success = { next_topic = "TALK_GIVE_EQUIPMENT", actions = { actions.give_equipment({ { score = "TRUST", scale = 1 }, { score = "VALUE", scale = 3 }, { score = "ALTRUISM", scale = 2 }, { score = "TOTAL", scale = 300 } }) }, opinion = { value = -1 } },
            failure = { next_topic = "TALK_DENY_EQUIPMENT", opinion = { value = -1, anger = 2 } },
        },
        {
            text = ccb.content.text("Well, I am helping you out…"),
            when = predicates.any({ predicates.assigned_missions(1, 1), predicates.assigned_missions(2) }),
            switch = true,
            default = true,
            trial = { kind = "persuade", difficulty = 12, modifiers = { { score = "TRUST", scale = 1 }, { score = "VALUE", scale = 2 }, { score = "ALTRUISM", scale = 1 }, { score = "MISSIONS", scale = 1 }, { score = "LOWFUNC_PSYCHOPATH", scale = -2 }, { score = "HIGHFUNC_PSYCHOPATH", scale = 1 } } },
            success = { next_topic = "TALK_GIVE_EQUIPMENT", actions = { "give_equipment" } },
            failure = { next_topic = "TALK_DENY_EQUIPMENT", opinion = { value = -1, anger = 2 } },
        },
        {
            text = ccb.content.text("I'll give it back!"),
            switch = true,
            default = true,
            trial = { kind = "lie", difficulty = 0, modifiers = { { score = "TRUST", scale = 2 }, { score = "VALUE", scale = 5 }, { score = "ALTRUISM", scale = 3 }, { score = "LOWFUNC_PSYCHOPATH", scale = -2 }, { score = "HIGHFUNC_PSYCHOPATH", scale = 1 } } },
            success = { next_topic = "TALK_GIVE_EQUIPMENT", actions = { actions.give_equipment({ { score = "TRUST", scale = 1 }, { score = "VALUE", scale = 3 }, { score = "ALTRUISM", scale = 2 }, { score = "TOTAL", scale = 300 } }) }, opinion = { value = -1 } },
            failure = { next_topic = "TALK_DENY_EQUIPMENT", opinion = { trust = -1, value = -1, anger = 2 } },
        },
        {
            text = ccb.content.text("Give it to me, or else!"),
            switch = true,
            default = true,
            trial = { kind = "intimidate", difficulty = 40 },
            success = { next_topic = "TALK_GIVE_EQUIPMENT", actions = { actions.give_equipment({ { score = "U_INTIMIDATE", scale = 1 }, { score = "NPC_INTIMIDATE", scale = -1 }, { score = "FEAR", scale = 1 }, { score = "BRAVERY", scale = -1 }, { score = "TOTAL", scale = 500 } }) }, opinion = { trust = -3, fear = 2, value = -2, anger = 3 } },
            failure = { next_topic = "TALK_DENY_EQUIPMENT", opinion = { trust = -3, fear = 1, value = -3, anger = 5 } },
        },
        {
            text = ccb.content.text("<end_talking_nevermind>"),
            next_topic = "TALK_NONE",
            when = predicates.has_effect("interlocutor", "asked_for_item"),
            switch = true,
            default = true,
        },
        {
            text = ccb.content.text("Never mind, I'll do without.  <end_talking_bye>"),
            next_topic = "TALK_DONE",
        },
    },
}

ccb.content.define_dialogue_topic {
    id = "TALK_GIVE_EQUIPMENT",
    line = ccb.content.text("Okay, here you go."),
    replies = {
        {
            text = ccb.content.text("Thank you!"),
            next_topic = "TALK_NONE",
            actions = { actions.add_effect("interlocutor", "asked_for_item", { turns = 86400 }) },
        },
        {
            text = ccb.content.text("Thanks!  But can I have some more?"),
            next_topic = "TALK_SHARE_EQUIPMENT",
            actions = { actions.add_effect("interlocutor", "asked_for_item", { turns = 86400 }) },
        },
        {
            text = ccb.content.text("Thanks, see you later!"),
            next_topic = "TALK_DONE",
            actions = { actions.add_effect("interlocutor", "asked_for_item", { turns = 86400 }) },
        },
    },
}

ccb.content.define_dialogue_topic {
    id = "TALK_STOLE_ITEM",
    line = ccb.content.text("You picked up something that does not belong to you…"),
    replies = {
        {
            text = ccb.content.text("Okay, okay, this is all a misunderstanding.  Sorry, I'll drop it now."),
            next_topic = "TALK_DONE",
            when = predicates.handler("dlg_p_dda_9dc70a1dd705"),
            actions = { "drop_stolen_item" },
            opinion = { anger = 5 },
        },
        {
            text = ccb.content.text("No, I'm keeping it.  Try and take it off me, I dare you."),
            when = predicates.handler("dlg_p_dda_9dc70a1dd705"),
            trial = { kind = "intimidate", difficulty = 30, modifiers = { { score = "FEAR", scale = 8 }, { score = "VALUE", scale = 2 }, { score = "TRUST", scale = 2 }, { score = "BRAVERY", scale = -2 }, { score = "LOWFUNC_PSYCHOPATH", scale = 5 }, { score = "HIGHFUNC_PSYCHOPATH", scale = 1 } } },
            success = { next_topic = "TALK_KEEPING_ITEM", actions = { actions.handler("dlg_a_dda_bf9db73e0c3c") } },
            failure = { next_topic = "TALK_DONE", actions = { "hostile", actions.handler("dlg_a_dda_f10f6ee920dd") } },
        },
        {
            text = ccb.content.text("Look, I really need this.  Please let me have it."),
            when = predicates.handler("dlg_p_dda_9dc70a1dd705"),
            trial = { kind = "persuade", difficulty = 20, modifiers = { { score = "TRUST", scale = 3 }, { score = "VALUE", scale = 3 }, { score = "ANGER", scale = -3 }, { score = "LOWFUNC_PSYCHOPATH", scale = -5 }, { score = "HIGHFUNC_PSYCHOPATH", scale = 1 } } },
            success = { next_topic = "TALK_ALLOW_KEEP_ITEM", actions = { actions.handler("dlg_a_dda_e9283e68fc6a") } },
            failure = { next_topic = "TALK_DISALLOW_KEEP_ITEM", actions = { actions.handler("dlg_a_dda_2a428b0a450a") }, opinion = { trust = -3, anger = 2 } },
        },
        {
            text = ccb.content.text("What, this?  It's not the same one, you are mistaken."),
            when = predicates.handler("dlg_p_dda_9dc70a1dd705"),
            trial = { kind = "lie", difficulty = 25, modifiers = { { score = "TRUST", scale = 3 }, { score = "LOWFUNC_PSYCHOPATH", scale = -5 }, { score = "HIGHFUNC_PSYCHOPATH", scale = 1 } } },
            success = { next_topic = "TALK_DONE", actions = { "remove_stolen_status" } },
            failure = { next_topic = "TALK_DISALLOW_KEEP_ITEM", opinion = { trust = -3, value = -1, anger = 2 } },
        },
        {
            text = ccb.content.text("I'm sorry.  Look, I already dropped it, okay?"),
            next_topic = "TALK_DONE",
            when = predicates.handler("dlg_p_dda_d89fcfbd2941"),
            actions = { "remove_stolen_status", actions.handler("dlg_a_dda_f3817b1673db") },
        },
    },
}

ccb.content.define_dialogue_topic {
    id = "TALK_DISALLOW_KEEP_ITEM",
    line = ccb.content.text("Don't try and talk yourself out of this, drop it now."),
    replies = {
        {
            text = ccb.content.text("Okay, I'm dropping it…"),
            native_actions = { "drop_stolen_item" },
            next_topic = "TALK_DONE",
        },
    },
}

ccb.content.define_dialogue_topic {
    id = "TALK_ALLOW_KEEP_ITEM",
    line = ccb.content.text("Just this once, you can keep it.  Don't tell anyone else."),
    replies = {
        {
            text = ccb.content.text("Thanks."),
            next_topic = "TALK_DONE",
            native_actions = { "remove_stolen_status" },
        },
    },
}

ccb.content.define_dialogue_topic {
    id = "TALK_KEEPING_ITEM",
    line = ccb.content.text("Right… I don't want any trouble."),
    replies = {
        {
            text = ccb.content.text("Smart choice."),
            next_topic = "TALK_DONE",
            native_actions = { "remove_stolen_status" },
        },
    },
}

ccb.content.define_dialogue_topic {
    id = "TALK_DENY_EQUIPMENT",
    line = {
        choices = {
            ccb.content.text("No, and if you ask again, I'll fucking obliterate you!"),
            ccb.content.text("No, fuck off!"),
        },
    },
    replies = {
        { text = ccb.content.text("Okay, okay, sorry."), next_topic = "TALK_NONE" },
        {
            text = ccb.content.text("Seriously, give me more stuff!"),
            next_topic = "TALK_SHARE_EQUIPMENT",
        },
        { text = ccb.content.text("Okay, fine, bye."), next_topic = "TALK_DONE" },
    },
}

ccb.content.define_dialogue_topic {
    id = { "TALK_SIZE_UP", "TALK_ASSESS_PERSON", "TALK_LOOK_AT", "TALK_OPINION", "TALK_SHOUT" },
    replies = { { text = ccb.content.text("Okay."), next_topic = "TALK_NONE" } },
}

ccb.content.define_dialogue_topic {
    id = "TALK_DELIVER_ASK",
    line = ccb.content.text("I'm willing to pay <topic_item_price> per batch for a total of <topic_item_your_total_price>."),
    replies = {
        { text = ccb.content.text("Works for me."), next_topic = "TALK_DELIVER_CONFIRM" },
        {
            text = ccb.content.text_without_extraction("<end_talking_later>"),
            next_topic = "TALK_DONE",
        },
    },
}

ccb.content.define_dialogue_topic {
    id = "TALK_DELIVER_CONFIRM",
    line = ccb.content.text("Pleasure doing business!"),
    replies = {
        {
            text = ccb.content.text("You might be seeing more of me…"),
            next_topic = "TALK_DONE",
            actions = { "u_bulk_trade_accept" },
        },
    },
}

ccb.content.define_dialogue_topic {
    id = "TALK_CHURL_FRIENDLY",
    line = ccb.content.text("Excuse me?  Um… you mean you want to trade?"),
    replies = {
        {
            text = ccb.content.text("Ye!"),
            next_topic = "TALK_DONE",
            native_actions = { "start_trade" },
        },
    },
}
