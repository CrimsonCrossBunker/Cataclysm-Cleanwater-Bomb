local ccb = require("ccb")
local predicates = ccb.content.dialogue_predicates
local actions = ccb.content.dialogue_actions

-- Former prisoner with a melee or ranged weapon and prison clothing. Sometimes they also have prison guards' gear.
ccb.content.define_npc {
    id = "prisoner_generic",
    suffix = ccb.content.text("prisoner"),
    class = "NC_THUG_PRISONER",
    attitude = 0,
    mission = "GUARD_PATROL",
    chat = "TALK_PRISONER_GENERIC",
    faction = "prisoners",
}

-- Former prisoner with a melee or ranged weapon and prison clothing. Sometimes they also have prison guards' gear.
ccb.content.define_npc {
    id = "prisoner_greeter",
    suffix = ccb.content.text("gatekeeper"),
    class = "NC_THUG_PRISONER",
    attitude = 0,
    mission = "GUARD_PATROL",
    chat = "TALK_PRISONER_GREET",
    faction = "prisoners",
}

-- Former prisoner with a melee or ranged weapon and prison clothing. Sometimes they also have prison guards' gear.
ccb.content.define_npc {
    id = "prisoner_leader",
    suffix = ccb.content.text("leader of prisoners"),
    class = "NC_THUG_PRISONER",
    attitude = 0,
    mission = "GUARD_PATROL",
    chat = "TALK_PRISONER_LEADER_GREET",
    faction = "prisoners",
    missions_offered = "MISSION_PRISONER_LEADER_GET_ID_CARD",
}

ccb.content.define_npc_class {
    id = "NC_THUG_PRISONER",
    name = ccb.content.text("Prisoner"),
    job_description = ccb.content.text("I'm here to kick ass."),
    common = false,
    traits = {
        { group = "BG_survival_story_CRIMINAL" },
        { group = "NPC_starting_traits" },
        { group = "Appearance_demographics" },
        { trait = "IGNORE_SOUND" },
        { trait = "NO_BASH" },
    },
    strength = { rng = { 2, 4 } },
    dexterity = { rng = { 0, 2 } },
    skills = {
        { skill = "ALL", level = { sum = { { dice = { 3, 2 } }, { constant = -4 } } } },
        { skill = "dodge", bonus = { rng = { 1, 3 } } },
        { skill = "melee", bonus = { rng = { 2, 4 } } },
        { skill = "unarmed", bonus = { rng = { 1, 3 } } },
        { skill = "bashing", bonus = { rng = { 1, 5 } } },
        { skill = "stabbing", bonus = { rng = { 1, 5 } } },
        { skill = "cutting", bonus = { rng = { 1, 5 } } },
    },
    worn = "NC_THUG_PRISONER_worn",
    weapon = "NC_THUG_PRISONER_wield",
}

ccb.content.define_dialogue_topic {
    id = "TALK_PRISONER_GENERIC",
    line = ccb.content.text("Get the fuck out of here."),
    replies = {
        { text = ccb.content.text("Ok, sorry, I'm already leaving!"), next_topic = "TALK_DONE" },
        {
            text = ccb.content.text("Hey, fuck you, <name_b>!"),
            next_topic = "TALK_DONE",
            native_actions = { "hostile" },
        },
    },
}

ccb.content.define_dialogue_topic {
    id = "TALK_PRISONER_GREET",
    line = {
        when = predicates.any_equal({ "yes", { scope = "speaker", key = "dialogue_first_meeting_first_meeting" } }),
        yes = ccb.content.text("Do I need to repeat myself?  Get outta here, <name_b>."),
        no = ccb.content.gendered_line("Hey, who the fuck are you?  I haven't seen you 'round.  Ah, fuck it, it doesn't matter.\nHere's the rules.  The first and most important one: ALWAYS CLOSE THE FUCKING ENTRY DOOR BEHIND YOUR ASS!  If you're okay with that, the following rules are: don't fuck with us, don't steal from us, don't start a fight without a reason with someone from us.  Got it, punk?  Now get lost.", { "speaker" }),
    },
    on_enter = {
        {
            actions = { actions.set_actor_value("speaker", "dialogue_first_meeting_first_meeting", "yes") },
        },
    },
    replies = {
        {
            text = ccb.content.text("Yeah, I got it.  <end_talking_bye>"),
            next_topic = "TALK_DONE",
            when = predicates.negate(predicates.any_equal({ "yes", { scope = "speaker", key = "dialogue_first_meeting_first_meeting" } })),
        },
        {
            text = ccb.content.text("I just wanted to ask if you have a job for me."),
            next_topic = "TALK_PRISONER_ANNOYED",
            when = predicates.all({ predicates.any_equal({ "yes", { scope = "speaker", key = "dialogue_first_meeting_first_meeting" } }), predicates.negate(predicates.any_equal({ "yes", { scope = "speaker", key = "dialogue_annoyed_greeter_talked_to_greeter" } })) }),
        },
        {
            text = ccb.content.text("I'm just hungry, and I thought you might give me some food for some job."),
            next_topic = "TALK_PRISONER_ANGRY",
            when = predicates.all({ predicates.any_equal({ "yes", { scope = "speaker", key = "dialogue_first_meeting_first_meeting" } }), predicates.any_equal({ "yes", { scope = "speaker", key = "dialogue_annoyed_greeter_talked_to_greeter" } }), predicates.negate(predicates.any_equal({ "yes", { scope = "speaker", key = "dialogue_angry_greeter_talked_to_greeter" } })) }),
        },
        {
            text = ccb.content.text("Can we just talk it over?"),
            next_topic = "TALK_PRISONER_READY_TO_MUG",
            when = predicates.all({ predicates.any_equal({ "yes", { scope = "speaker", key = "dialogue_first_meeting_first_meeting" } }), predicates.any_equal({ "yes", { scope = "speaker", key = "dialogue_angry_greeter_talked_to_greeter" } }) }),
        },
        {
            text = ccb.content.text("Hey, fuck you, <name_b>!"),
            next_topic = "TALK_DONE",
            actions = { "hostile" },
        },
    },
}

ccb.content.define_dialogue_topic {
    id = "TALK_PRISONER_ANNOYED",
    line = {
        when = predicates.any_equal({ "yes", { scope = "speaker", key = "dialogue_annoyed_greeter_talked_to_greeter" } }),
        yes = ccb.content.text("Get out, loser."),
        no = ccb.content.text("Do I have a <freaking> exclamation sign over my <freaking> head, like I'm a <freaking> quest-giver from some <freaking> video game?"),
    },
    on_enter = {
        {
            actions = {
                actions.set_actor_value("speaker", "dialogue_annoyed_greeter_talked_to_greeter", "yes"),
            },
        },
    },
    replies = {
        {
            text = ccb.content.text("No, of course not!  Sorry, I'm leaving."),
            next_topic = "TALK_DONE",
            when = predicates.negate(predicates.any_equal({ "yes", { scope = "speaker", key = "dialogue_annoyed_greeter_talked_to_greeter" } })),
        },
        {
            text = ccb.content.text("Hey, fuck you, <name_b>!"),
            next_topic = "TALK_DONE",
            actions = { "hostile" },
        },
    },
}

ccb.content.define_dialogue_topic {
    id = "TALK_PRISONER_ANGRY",
    line = {
        when = predicates.any_equal({ "yes", { scope = "speaker", key = "dialogue_annoyed_greeter_talked_to_greeter" } }),
        yes = ccb.content.gendered_line("Are you deaf or stupid?  I said I don't give a fuck for you and your <freaking> problems.  Bother me one more time, and you'll regret that.  Get outta my sight.", { "speaker" }),
        no = ccb.content.text("Disappear, <name_b>."),
    },
    on_enter = {
        {
            actions = {
                actions.set_actor_value("speaker", "dialogue_angry_greeter_talked_to_greeter", "yes"),
            },
        },
    },
    replies = {
        {
            text = ccb.content.text("Ok, sorry, I promise I won't bother you anymore."),
            next_topic = "TALK_DONE",
            when = predicates.negate(predicates.any_equal({ "yes", { scope = "speaker", key = "dialogue_angry_greeter_talked_to_greeter" } })),
        },
        {
            text = ccb.content.text("Hey, fuck you, <name_b>!"),
            next_topic = "TALK_DONE",
            actions = { "hostile" },
        },
    },
}

ccb.content.define_dialogue_topic {
    id = "TALK_PRISONER_READY_TO_MUG",
    line = ccb.content.gendered_line("You think you're immortal, huh, <name_b>?", { "speaker" }),
    replies = {
        {
            text = ccb.content.text("Gee, what's the matter with you?  Okay, okay, I'm leaving."),
            next_topic = "TALK_PRISONER_MUG",
        },
        {
            text = ccb.content.text("It would be you who will regret talking to me like that."),
            next_topic = "TALK_DONE",
            native_actions = { "hostile" },
        },
    },
}

ccb.content.define_dialogue_topic {
    id = "TALK_PRISONER_MUG",
    line = ccb.content.text("Not so fast, I think you need to pay for breaking your promise and bothering me.  Give me your shit, now!"),
    replies = {
        {
            text = ccb.content.text("Please don't hurt me!  Take all that you want."),
            next_topic = "TALK_MUG",
        },
        {
            text = ccb.content.text("What, <no>!"),
            next_topic = "TALK_DONE",
            native_actions = { "hostile" },
        },
    },
}

ccb.content.define_dialogue_topic {
    id = "TALK_PRISONER_LEADER_GREET",
    line = {
        when = predicates.any_equal({ "yes", { scope = "speaker", key = "mission_military_id_prisoner_leader_mission" } }),
        yes = ccb.content.text("I have nothing more to say to you.  Get the fuck out of here."),
        no = {
            when = predicates.any_equal({ "yes", { scope = "speaker", key = "mission_accepted_prisoner_leader_mission" } }),
            yes = ccb.content.text("So, what are you waiting for?"),
            no = {
                when = predicates.any_equal({ "yes", { scope = "speaker", key = "mission_completed_prisoner_leader_mission" } }),
                yes = ccb.content.gendered_line("I don't know if you know, but there are sewers underneath the prison.  I was planning an escape long before <the_cataclysm>, and while I was working on cleaning the sewers, I noticed a damaged wall section.  There was a flow of fresh air coming out of it, so I think it's leading to the surface.  It could be your way to freedom.  Feel free to use it.", { "interlocutor" }),
                no = {
                    when = predicates.any_equal({ "yes", { scope = "speaker", key = "dialogue_first_meeting_talked_to_leader" } }),
                    yes = {
                        when = predicates.any_equal({ "yes", { scope = "speaker", key = "dialogue_cannibal_talked_to_leader" } }),
                        yes = ccb.content.text("You are what you eat, as they say."),
                        no = ccb.content.text("It's you again."),
                    },
                    no = ccb.content.text("Hello there.  Haven't seen you around before.  You must be from the other wing.  Managed to survive, huh?"),
                },
            },
        },
    },
    on_enter = {
        {
            actions = { actions.set_actor_value("speaker", "dialogue_first_meeting_talked_to_leader", "yes") },
        },
    },
    replies = {
        {
            text = ccb.content.text("Yeah, I've been through situations far worse than that."),
            next_topic = "TALK_PRISONER_LEADER_INQUIRY",
            when = predicates.all({ predicates.negate(predicates.any_equal({ "yes", { scope = "speaker", key = "dialogue_first_meeting_talked_to_leader" } })), predicates.negate(predicates.any_equal({ "yes", { scope = "speaker", key = "mission_completed_prisoner_leader_mission" } })) }),
        },
        {
            text = ccb.content.text("It was a nightmare, lots of <zombies>, blood everywhere!  Thank god I'm among living people again."),
            next_topic = "TALK_PRISONER_LEADER_FROWN",
            when = predicates.all({ predicates.negate(predicates.any_equal({ "yes", { scope = "speaker", key = "dialogue_first_meeting_talked_to_leader" } })), predicates.negate(predicates.any_equal({ "yes", { scope = "speaker", key = "mission_completed_prisoner_leader_mission" } })) }),
        },
        {
            text = ccb.content.text("[CANNIBAL] It's hard to die of hunger when there's so many tasty corpses lying around."),
            next_topic = "TALK_PRISONER_LEADER_LEARNED_ABOUT_CANNIBAL",
            when = predicates.all({ predicates.has_trait("speaker", "CANNIBAL"), predicates.negate(predicates.any_equal({ "yes", { scope = "speaker", key = "dialogue_first_meeting_talked_to_leader" } })), predicates.negate(predicates.any_equal({ "yes", { scope = "speaker", key = "dialogue_cannibal_talked_to_leader" } })), predicates.negate(predicates.any_equal({ "yes", { scope = "speaker", key = "mission_completed_prisoner_leader_mission" } })) }),
        },
        {
            text = ccb.content.text("I want to get out of this <freaking> prison.  I hoped you could help me with that."),
            next_topic = "TALK_PRISONER_LEADER_GIVES_WORK",
            when = predicates.all({ predicates.any_equal({ "yes", { scope = "speaker", key = "dialogue_first_meeting_talked_to_leader" } }), predicates.negate(predicates.any_equal({ "yes", { scope = "speaker", key = "mission_accepted_prisoner_leader_mission" } })), predicates.negate(predicates.any_equal({ "yes", { scope = "speaker", key = "mission_completed_prisoner_leader_mission" } })), predicates.negate(predicates.any_equal({ "yes", { scope = "speaker", key = "mission_military_id_prisoner_leader_mission" } })) }),
        },
        {
            text = ccb.content.text("I'm on my way."),
            next_topic = "TALK_DONE",
            when = predicates.any_equal({ "yes", { scope = "speaker", key = "mission_accepted_prisoner_leader_mission" } }),
        },
        {
            text = ccb.content.text("I don't know if I'll take your advice, but thanks nevertheless."),
            next_topic = "TALK_DONE",
            when = predicates.all({ predicates.any_equal({ "yes", { scope = "speaker", key = "mission_completed_prisoner_leader_mission" } }), predicates.negate(predicates.any_equal({ "yes", { scope = "speaker", key = "mission_military_id_prisoner_leader_mission" } })) }),
        },
        {
            text = ccb.content.text("Wait, what?  A <freaking> can of beans?!  I went through hell to get this <freaking> thing for you, and all you give me as reward is a <freaking> can of beans?!  I demand something more substantial."),
            next_topic = "TALK_PRISONER_LEADER_DEMANDED_SUBSTANTIAL_REWARD",
            when = predicates.all({ predicates.any_equal({ "yes", { scope = "speaker", key = "mission_completed_prisoner_leader_mission" } }), predicates.negate(predicates.any_equal({ "yes", { scope = "speaker", key = "mission_military_id_prisoner_leader_mission" } })) }),
        },
        {
            text = ccb.content.text("Nice talking to ya.  Farewell."),
            next_topic = "TALK_DONE",
            when = predicates.all({ predicates.any_equal({ "yes", { scope = "speaker", key = "dialogue_first_meeting_talked_to_leader" } }), predicates.negate(predicates.any_equal({ "yes", { scope = "speaker", key = "mission_accepted_prisoner_leader_mission" } })), predicates.negate(predicates.any_equal({ "yes", { scope = "speaker", key = "mission_completed_prisoner_leader_mission" } })), predicates.negate(predicates.any_equal({ "yes", { scope = "speaker", key = "mission_military_id_prisoner_leader_mission" } })) }),
        },
        {
            text = ccb.content.text("Okay."),
            next_topic = "TALK_DONE",
            when = predicates.any_equal({ "yes", { scope = "speaker", key = "mission_military_id_prisoner_leader_mission" } }),
        },
    },
}

ccb.content.define_dialogue_topic {
    id = "TALK_PRISONER_LEADER_LEARNED_ABOUT_CANNIBAL",
    line = ccb.content.text("Huh, even so?  I'm not saying I approve your… tastes, but I definitely respect people who use all possibilities life has to offer."),
    on_enter = {
        {
            actions = { actions.set_actor_value("speaker", "dialogue_cannibal_talked_to_leader", "yes") },
        },
    },
    replies = {
        {
            text = ccb.content.text("Yeah, we share the same opinions on this matter."),
            next_topic = "TALK_NONE",
        },
    },
}

ccb.content.define_dialogue_topic {
    id = "TALK_PRISONER_LEADER_INQUIRY",
    line = ccb.content.text("Well, that's a boastful statement.  Not that I don't believe it, it's just….  Ah, nevermind.  Let's get to the point.  What do you want?"),
    replies = {
        {
            text = ccb.content.text("I want to get out of this <freaking> prison.  I hoped you could help me with that."),
            next_topic = "TALK_PRISONER_LEADER_GIVES_WORK",
        },
    },
}

ccb.content.define_dialogue_topic {
    id = "TALK_PRISONER_LEADER_FROWN",
    line = ccb.content.text("Hold the horses, pal.  Nobody allowed you to stay here - yet."),
    replies = {
        {
            text = ccb.content.text("Please!  I don't want to go back there!  I'm tired and hungry!  I just need time to rest!"),
            next_topic = "TALK_PRISONER_LEADER_ANNOYED",
        },
        {
            text = ccb.content.text("Shit!  Looks like I'm on my own now.  Thanks for nothing.  <end_talking_bye>"),
            next_topic = "TALK_DONE",
        },
    },
}

ccb.content.define_dialogue_topic {
    id = "TALK_PRISONER_LEADER_ANNOYED",
    line = ccb.content.text("We don't have much space, and there's not much food.  Besides, I don't know you at all, and something tells me you won't survive another day."),
    replies = {
        {
            text = ccb.content.text("[STR 11] I'm tougher than it seems!"),
            next_topic = "TALK_PRISONER_LEADER_NO",
            when = predicates.minimum_attribute("speaker", "strength", 11),
        },
        {
            text = ccb.content.text("[Survival 2] I have some survival expertise!"),
            next_topic = "TALK_PRISONER_LEADER_NO",
            when = predicates.handler("dlg_p_dda_7fe93cb81db6"),
        },
        {
            text = ccb.content.text("I guess I need to find some other place…"),
            next_topic = "TALK_DONE",
        },
    },
}

ccb.content.define_dialogue_topic {
    id = "TALK_PRISONER_LEADER_NO",
    line = ccb.content.text("The answer is still no.  In fact it might be better for us to kill you right away - you know, the less mouths to feed, the better.  But I'm in a good mood today, so I've decided to help you get out of this island."),
    replies = {
        {
            text = ccb.content.text("Ok, I'm listening."),
            next_topic = "TALK_PRISONER_LEADER_GIVES_WORK",
        },
        {
            text = ccb.content.text("You know, I think I'll manage without your help.  <end_talking_bye>"),
            next_topic = "TALK_DONE",
        },
    },
}

ccb.content.define_dialogue_topic {
    id = "TALK_PRISONER_LEADER_GIVES_WORK",
    line = {
        when = predicates.any_equal({ "yes", { scope = "speaker", key = "mission_accepted_prisoner_leader_mission" } }),
        yes = ccb.content.text("So, what are you waiting for?"),
        no = ccb.content.text("I need you to retrieve some stuff from a locked safe.  Interested?"),
    },
    replies = {
        {
            text = ccb.content.text("[Show the military ID card.] You mean this stuff?"),
            next_topic = "TALK_PRISONER_LEADER_SHOW_MILITARY_ID",
            when = predicates.all({ predicates.has_item("speaker", "id_military"), predicates.negate(predicates.any_equal({ "yes", { scope = "speaker", key = "mission_accepted_prisoner_leader_mission" } })) }),
        },
        {
            text = ccb.content.text("What's in the safe?"),
            next_topic = "TALK_PRISONER_LEADER_ASKED_ABOUT_SAFE_CONTENTS",
            when = predicates.all({ predicates.negate(predicates.any_equal({ "yes", { scope = "speaker", key = "mission_military_id_prisoner_leader_mission" } })), predicates.negate(predicates.any_equal({ "yes", { scope = "speaker", key = "mission_accepted_prisoner_leader_mission" } })) }),
        },
        {
            text = ccb.content.text("What for do you need it?"),
            next_topic = "TALK_PRISONER_LEADER_ASKED_ABOUT_WHAT_FOR_DO_YOU_NEED_IT",
            when = predicates.all({ predicates.negate(predicates.any_equal({ "yes", { scope = "speaker", key = "mission_military_id_prisoner_leader_mission" } })), predicates.negate(predicates.any_equal({ "yes", { scope = "speaker", key = "mission_accepted_prisoner_leader_mission" } })) }),
        },
        {
            text = ccb.content.text("Yeah, sure."),
            next_topic = "TALK_MISSION_OFFER",
            when = predicates.all({ predicates.negate(predicates.any_equal({ "yes", { scope = "speaker", key = "mission_military_id_prisoner_leader_mission" } })), predicates.negate(predicates.any_equal({ "yes", { scope = "speaker", key = "mission_accepted_prisoner_leader_mission" } })) }),
        },
        {
            text = ccb.content.text("I have a bad feeling about this.  Sorry, I'll pass."),
            next_topic = "TALK_DONE",
            when = predicates.negate(predicates.any_equal({ "yes", { scope = "speaker", key = "mission_accepted_prisoner_leader_mission" } })),
        },
        {
            text = ccb.content.text("I'm on my way."),
            next_topic = "TALK_DONE",
            when = predicates.all({ predicates.negate(predicates.any_equal({ "yes", { scope = "speaker", key = "mission_military_id_prisoner_leader_mission" } })), predicates.any_equal({ "yes", { scope = "speaker", key = "mission_accepted_prisoner_leader_mission" } }) }),
        },
    },
}

ccb.content.define_dialogue_topic {
    id = "TALK_PRISONER_LEADER_ASKED_ABOUT_SAFE_CONTENTS",
    line = ccb.content.text("As I said, that's the thing I need.  You don't need to know what's that exactly.  Just grab all things you find in the safe, and call it a day."),
    replies = {
        { text = ccb.content.text("That's weird."), next_topic = "TALK_NONE" },
        {
            text = ccb.content.text("I have a bad feeling about this.  Sorry, I'll pass."),
            next_topic = "TALK_DONE",
        },
    },
}

ccb.content.define_dialogue_topic {
    id = "TALK_PRISONER_LEADER_ASKED_ABOUT_WHAT_FOR_DO_YOU_NEED_IT",
    line = ccb.content.text("Let's say that's none of your <freaking> business.  Other questions?"),
    replies = {
        { text = ccb.content.text("That's weird."), next_topic = "TALK_NONE" },
        {
            text = ccb.content.text("I have a bad feeling about this.  Sorry, I'll pass."),
            next_topic = "TALK_DONE",
        },
    },
}

ccb.content.define_dialogue_topic {
    id = "TALK_PRISONER_LEADER_SHOW_MILITARY_ID",
    line = ccb.content.text("Hey, where did you get it?  Nevermind, just give it to me.  Right now."),
    on_enter = {
        { actions = { actions.set_actor_value("speaker", "mission_military_id_prisoner_leader_mission", "yes") } },
    },
    replies = {
        {
            text = ccb.content.text("Hey, no need to be hostile.  Here you go, I don't need it anyway."),
            next_topic = "TALK_DONE",
            actions = { actions.transfer_items("id_military") },
        },
        {
            text = ccb.content.text("I went through incredible hardships to get it.  Please, can I keep this to myself?"),
            trial = { kind = "persuade", difficulty = 5, modifiers = { { score = "ALTRUISM", scale = 3 }, { score = "TRUST", scale = 1 } } },
            success = { next_topic = "TALK_PRISONER_LEADER_TRIAL_SUCCESS" },
            failure = { next_topic = "TALK_DONE", actions = { "hostile" } },
        },
        {
            text = ccb.content.text("I killed tons of <zombies> while I was trying to get this thing.  Do you really think you and your handful of losers pose a threat to me?"),
            trial = { kind = "intimidate", difficulty = 30, modifiers = { { score = "BRAVERY", scale = -1 }, { score = "FEAR", scale = 3 } } },
            success = { next_topic = "TALK_PRISONER_LEADER_TRIAL_SUCCESS" },
            failure = { next_topic = "TALK_DONE", actions = { "hostile" } },
        },
        {
            text = ccb.content.text("What, <no>!"),
            next_topic = "TALK_DONE",
            actions = { "hostile" },
        },
    },
}

ccb.content.define_dialogue_topic {
    id = "TALK_PRISONER_LEADER_TRIAL_SUCCESS",
    line = ccb.content.text("Okay.  It was convincing.  I'll still get what I want, one way or another.  You better watch your back from now on."),
    replies = { { text = ccb.content.text("Noted.  <end_talking_bye>"), next_topic = "TALK_DONE" } },
}

ccb.content.define_dialogue_topic {
    id = "TALK_PRISONER_LEADER_DEMANDED_SUBSTANTIAL_REWARD",
    on_enter = {
        {
            actions = {
                actions.set_actor_value("speaker", "mission_military_id_prisoner_leader_mission", "yes"),
            },
        },
    },
    line = ccb.content.text("I'm afraid you're not in the position to demand anything from me, <name_b>.  You're done here, leave."),
    replies = {
        {
            text = ccb.content.text("Hey, fuck you, <name_b>!  You'll regret that!"),
            next_topic = "TALK_DONE",
            actions = { "hostile" },
        },
        { text = ccb.content.text("Okay, fine.  Cheapskate!"), next_topic = "TALK_DONE" },
    },
}

ccb.content.define_mission {
    id = "MISSION_PRISONER_LEADER_GET_ID_CARD",
    name = ccb.content.text("Get The Thing from the chief's office"),
    difficulty = 1,
    value = 0,
    goal = "MGOAL_FIND_ITEM",
    item = "id_military",
    origins = { "ORIGIN_SECONDARY" },
    dialogue = {
        describe = ccb.content.text("Here's the job…"),
        offer = ccb.content.text("My snitch whispered in my ear that the thing I need is located in the chief's safe in his office.  You need to crack it open and bring the contents to me.  Don't try to use anything you find in there!  Just bring all the stuff to me, and I'll help you.  Deal?"),
        accepted = ccb.content.text("Great!  Don't forget that I need all stuff from the safe, try not to lose a thing."),
        rejected = ccb.content.text("Fine, I'll get the thing in any case, sooner or later."),
        advice = ccb.content.text("The chief's office is on the other side of the prison.  I think the road there is full of <zombies>, so you better find a weapon.  Also you probably will need some tools to crack the safe open."),
        inquire = ccb.content.text("Did you get the stuff already?"),
        success = ccb.content.text("At last!  Give me a few moments to check if it isn't damaged.  Here, take this for your troubles."),
        success_lie = ccb.content.text("Huh.  This isn't going to work like I thought."),
        failure = ccb.content.text("You're useless.  I should've killed you when I met you."),
    },
    generic_rewards = false,
    start = {
        actions = {
            ccb.content.dialogue_actions.set_actor_value("speaker", "mission_accepted_prisoner_leader_mission", "yes"),
        },
    },
    finish = {
        item_rewards = { { item = "can_beans", container = "can_medium" } },
        actions = {
            ccb.content.dialogue_actions.set_actor_value("speaker", "mission_completed_prisoner_leader_mission", "yes"),
            ccb.content.dialogue_actions.clear_actor_value("speaker", "mission_accepted_prisoner_leader_mission"),
        },
    },
}
