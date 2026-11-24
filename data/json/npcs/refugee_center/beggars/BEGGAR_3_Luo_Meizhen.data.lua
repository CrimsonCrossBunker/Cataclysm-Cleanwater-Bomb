local ccb = require("ccb")
local predicates = ccb.content.dialogue_predicates
local actions = ccb.content.dialogue_actions

-- Angry beggar in the refugee center.
ccb.content.define_npc {
    id = "refugee_beggar3",
    unique_name = ccb.content.text("Luo Meizhen"),
    gender = "female",
    suffix = ccb.content.text("Mycologist"),
    temporary_suffix = "Beggar",
    class = "NC_BEGGAR_3",
    attitude = 0,
    mission = "GUARD",
    chat = "TALK_REFUGEE_BEGGAR_3",
    faction = "lobby_beggars",
    age = 31,
    height = 160,
    strength = 6,
    dexterity = 7,
    intelligence = 12,
    perception = 10,
    personality = { aggression = -10, bravery = -10, collector = 2, altruism = 1 },
    friend_chat = "TALK_FRIEND_Luo",
    friend_guard_chat = "TALK_FRIEND_GUARD_Luo",
}

-- All the beggars have been camping inside the evac shelter because they're too weak and unskilled to make it on their own.
ccb.content.define_npc_class {
    id = "NC_BEGGAR_3",
    name = ccb.content.text("Beggar"),
    job_description = ccb.content.text("I'm just trying to survive."),
    common = false,
    strength = { rng = { -1, 1 } },
    dexterity = { rng = { -1, 1 } },
    intelligence = { rng = { 0, 1 } },
    perception = { rng = { 0, 1 } },
    skills = {
        { skill = "computer", bonus = { rng = { 3, 5 } } },
        { skill = "cooking", bonus = { rng = { 1, 3 } } },
        { skill = "chemistry", bonus = { rng = { 7, 8 } } },
        { skill = "driving", bonus = { rng = { 2, 5 } } },
        { skill = "electronics", bonus = { rng = { 1, 2 } } },
        { skill = "fabrication", bonus = { rng = { 1, 3 } } },
        { skill = "firstaid", bonus = { rng = { 1, 4 } } },
        { skill = "speech", bonus = { rng = { 1, 4 } } },
    },
    proficiencies = {
        "prof_intro_chemistry",
        "prof_intro_biology",
        "prof_organic_chemistry",
        "prof_biochemistry",
        "prof_intro_chem_synth",
        "prof_mycology",
        "prof_mycology_advanced",
    },
    worn = "NC_BEGGAR_3_worn",
    carry = "EMPTY_GROUP",
    weapon = "EMPTY_GROUP",
    traits = {
        { trait = "SLOWHEALER2" },
        { trait = "SLOWRUNNER" },
        { trait = "HEAVYSLEEPER" },
        { trait = "FLIMSY2" },
        { trait = "FASTLEARNER" },
        { trait = "PACIFIST" },
        { trait = "Exp_Mycology2" },
        { group = "Appearance_EastAsian" },
    },
}

ccb.content.define_dialogue_topic {
    id = "TALK_REFUGEE_BEGGAR_3",
    line = {
        when = predicates.has_effect("interlocutor", "insulted_luo"),
        yes = ccb.content.gendered_line("Fuck off, dickwaddle.", { "speaker" }),
        no = {
            when = predicates.any_equal({ "yes", { scope = "speaker", key = "general_recruit_luo_recruited" } }),
            yes = ccb.content.text("Yo.  Anyone else keen on moving from this bus stop to your tent city?"),
            no = {
                when = predicates.any_equal({ "yes", { scope = "interlocutor", key = "general_conversation_dont_insult_luo" } }),
                yes = {
                    when = predicates.any_equal({ "yes", { scope = "interlocutor", key = "general_conversation_apology_luo" } }),
                    yes = {
                        when = predicates.has_effect("interlocutor", "beggar_has_eaten"),
                        yes = ccb.content.text("Hey there.  Good to see you again."),
                        no = ccb.content.text("Careful, I'm getting hangry again and am not totally responsible for my own actions."),
                    },
                    no = ccb.content.gendered_line("Look, I'm sorry for freaking out earlier.  You might be an asshole but I'm sure you didn't mean it like that.  My blood sugar is hella low, I get a bit cranky.  We cool?", { "speaker" }),
                },
                no = {
                    when = predicates.has_effect("interlocutor", "beggar_has_eaten"),
                    yes = ccb.content.gendered_line("Hey there, not-asshole.  Good to see you again.", { "speaker" }),
                    no = ccb.content.text("Don't bother with these assholes."),
                },
            },
        },
    },
    replies = {
        {
            when = predicates.any_equal({ "yes", { scope = "speaker", key = "general_recruit_beggars_recruited" } }),
            text = ccb.content.text("I've talked to the others, and they're all willing to come.  So, you joining us?"),
            next_topic = "TALK_REFUGEE_BEGGAR_3_RECRUITED2",
        },
        {
            when = predicates.all({ predicates.negate(predicates.has_effect("interlocutor", "beggar_has_eaten")), predicates.negate(predicates.has_effect("interlocutor", "insulted_luo")) }),
            text = ccb.content.text("What's up?"),
            next_topic = "TALK_REFUGEE_BEGGAR_3_COMPLAIN",
        },
        {
            when = predicates.all({ predicates.has_effect("interlocutor", "beggar_has_eaten"), predicates.negate(predicates.has_effect("interlocutor", "insulted_luo")) }),
            text = ccb.content.text("What's up?"),
            next_topic = "TALK_REFUGEE_BEGGAR_3_INTRO",
        },
        {
            when = predicates.all({ predicates.negate(predicates.has_effect("interlocutor", "beggar_has_eaten")), predicates.negate(predicates.has_effect("interlocutor", "insulted_luo")) }),
            text = ccb.content.text("I might have some food for you.  Are you hungry?"),
            next_topic = "TALK_REFUGEE_BEGGAR_3_GIVE_FOOD",
        },
        {
            when = predicates.all({ predicates.negate(predicates.any_equal({ "yes", { scope = "interlocutor", key = "general_conversation_apology_luo" } })), predicates.any_equal({ "yes", { scope = "interlocutor", key = "general_conversation_dont_insult_luo" } }), predicates.negate(predicates.has_effect("interlocutor", "insulted_luo")) }),
            text = ccb.content.text("We're cool.  Sorry for insulting you earlier."),
            actions = { actions.set_actor_value("interlocutor", "general_conversation_apology_luo", "yes") },
            next_topic = "TALK_REFUGEE_BEGGAR_3_APOLOGY",
        },
        {
            when = predicates.all({ predicates.has_item("speaker", "veggy_tainted"), predicates.any_equal({ "yes", { scope = "interlocutor", key = "general_recruit_luo_attempt_recruit" } }), predicates.negate(predicates.has_effect("interlocutor", "insulted_luo")) }),
            text = ccb.content.text("I found a sample of alien fungus for you."),
            next_topic = "TALK_REFUGEE_BEGGAR_3_MYCUS4_RECRUIT",
        },
        {
            when = predicates.all({ predicates.has_item("speaker", "veggy_tainted"), predicates.negate(predicates.any_equal({ "yes", { scope = "interlocutor", key = "general_recruit_luo_attempt_recruit" } })), predicates.negate(predicates.has_effect("interlocutor", "insulted_luo")) }),
            text = ccb.content.text("I found a sample of alien fungus for you."),
            next_topic = "TALK_REFUGEE_BEGGAR_3_MYCUS4_NOTREADY",
            actions = { actions.set_actor_value("interlocutor", "general_recruit_luo_owed", "yes") },
        },
        { text = ccb.content.text("Ok… see ya."), next_topic = "TALK_DONE" },
    },
}

ccb.content.define_dialogue_topic {
    id = "TALK_REFUGEE_BEGGAR_3_GIVE_FOOD",
    line = ccb.content.text("Actually yeah, I'm always hungry these days.  I don't like taking handouts, but I wouldn't say no."),
    replies = {
        {
            text = ccb.content.text_without_extraction("<done_conversation_section>"),
            next_topic = "TALK_NONE",
        },
        {
            text = ccb.content.text("I'm sorry, I was wrong.  I can't help you."),
            next_topic = "TALK_DONE",
        },
    },
    repeat_replies = {
        {
            categories = { "food" },
            reply = {
                text = ccb.content.text("Here, you can have this <topic_item>."),
                next_topic = "TALK_REFUGEE_BEGGAR_3_GAVE_FOOD",
            },
        },
    },
}

ccb.content.define_dialogue_topic {
    id = "TALK_REFUGEE_BEGGAR_3_GAVE_FOOD",
    line = ccb.content.text("Thanks, I really appreciate this."),
    on_enter = {
        { actions = { "u_bulk_donate" } },
        { actions = { actions.handler("w16b_a_dda_ee5ac56a72a9") } },
    },
    replies = {
        {
            text = ccb.content.text("What are you doing here?"),
            next_topic = "TALK_REFUGEE_BEGGAR_3_INTRO",
        },
        {
            text = ccb.content.text("No problem.  <end_talking_leave>"),
            next_topic = "TALK_DONE",
        },
    },
}

ccb.content.define_dialogue_topic {
    id = "TALK_REFUGEE_BEGGAR_3_COMPLAIN",
    line = ccb.content.text("They're 'too full'.  Won't share fuck-all."),
    replies = {
        {
            text = ccb.content.text("Why are you living here then?"),
            next_topic = "TALK_REFUGEE_BEGGAR_3_COMPLAIN2",
        },
        {
            when = predicates.negate(predicates.has_effect("interlocutor", "beggar_has_eaten")),
            text = ccb.content.text("Well, they might not share, but I can.  Are you hungry?"),
            next_topic = "TALK_REFUGEE_BEGGAR_3_GIVE_FOOD",
        },
        {
            text = ccb.content.text_without_extraction("<end_talking_leave>"),
            next_topic = "TALK_DONE",
        },
    },
}

ccb.content.define_dialogue_topic {
    id = "TALK_REFUGEE_BEGGAR_3_COMPLAIN2",
    line = ccb.content.text("Even without them helping, it's the safest place to squat.  As long as we keep it clean up here and don't cause sanitation problems, they don't mind us sitting around the entryway.  So kind and generous of them, to let us sit here and slowly starve."),
    replies = {
        {
            when = predicates.negate(predicates.has_effect("interlocutor", "beggar_has_eaten")),
            text = ccb.content.text("Well, they might not share, but I can.  Are you hungry?"),
            next_topic = "TALK_REFUGEE_BEGGAR_3_GIVE_FOOD",
        },
        {
            text = ccb.content.text_without_extraction("<end_talking_leave>"),
            next_topic = "TALK_DONE",
        },
    },
}

ccb.content.define_dialogue_topic {
    id = "TALK_REFUGEE_BEGGAR_3_INTRO",
    line = ccb.content.text("Oh, same old story at first.  I got evacuated on to the local concentration center, then picked up on a repurposed school bus and dragged out here.  Then the chick processing me to get in saw my face and Chinese name and conveniently 'lost' my paperwork.  I was sent out here to wait for further processing, while I watched busloads of people get processed and taken in.  By the time they 'found' it, the place was full up, wouldn't ya know it.  Now I'm stuck out here and they won't consider letting me in."),
    replies = {
        {
            text = ccb.content.text("You think you were treated like that because of your race?"),
            next_topic = "TALK_REFUGEE_BEGGAR_3_RACISM",
        },
        {
            text = ccb.content.text("Does that mean you were part of that back room evacuation I heard about?"),
            next_topic = "TALK_REFUGEE_BEGGAR_3_EVACUATION",
            when = predicates.any_equal({ "yes", { scope = "speaker", key = "general_conversation_told_about_FM_evacuation" } }),
        },
        {
            text = ccb.content.text("Why stay out here then?"),
            next_topic = "TALK_REFUGEE_BEGGAR_3_WHYSTAY",
        },
        {
            text = ccb.content.text("What did you do before <the_cataclysm>?"),
            next_topic = "TALK_REFUGEE_BEGGAR_3_EXPERTISE",
        },
        {
            text = ccb.content.text("I have a camp of my own, away from here.  No paperwork required.  Want to come?"),
            next_topic = "TALK_REFUGEE_BEGGAR_3_RECRUIT1",
            when = predicates.handler("dlg_p_dda_453225921210"),
        },
        {
            text = ccb.content.text("We're cool.  Sorry for insulting you earlier."),
            next_topic = "TALK_REFUGEE_BEGGAR_3_APOLOGY",
            when = predicates.all({ predicates.negate(predicates.any_equal({ "yes", { scope = "interlocutor", key = "general_conversation_apology_luo" } })), predicates.any_equal({ "yes", { scope = "interlocutor", key = "general_conversation_dont_insult_luo" } }), predicates.negate(predicates.has_effect("interlocutor", "insulted_luo")) }),
            actions = { actions.set_actor_value("interlocutor", "general_conversation_apology_luo", "yes") },
        },
        {
            text = ccb.content.text("I found a sample of alien fungus for you."),
            next_topic = "TALK_REFUGEE_BEGGAR_3_MYCUS4_RECRUIT",
            when = predicates.all({ predicates.has_item("speaker", "veggy_tainted"), predicates.any_equal({ "yes", { scope = "interlocutor", key = "general_recruit_luo_attempt_recruit" } }), predicates.negate(predicates.has_effect("interlocutor", "insulted_luo")) }),
        },
        {
            text = ccb.content.text("Ok… see ya."),
            next_topic = "TALK_DONE",
        },
        {
            text = ccb.content.text("<end_talking_leave>"),
            next_topic = "TALK_DONE",
        },
    },
}

ccb.content.define_dialogue_topic {
    id = "TALK_REFUGEE_BEGGAR_3_EVACUATION",
    line = ccb.content.text("Oh yeah, that was a hell of a shitstorm.  We were waiting back there for 'processing' for hours and hours, with the sick and wounded.  One guy died, we all thought he was sleeping until he got back up.  That started a panic, gunshots in a closed area, that kind of stuff.  In just a few minutes, a bunch more people were dead.  Then the assholes called it an 'outbreak' and tried to barricade us in… took us way too long to convince the panicking guards that we were alive and needed to get out.  I'll give the one guy credit, Sean: when he found out they'd locked living people in with zombies, he came in himself, as some of the newly dead were starting to get back up, and he held them off for us to escape.  That… that was probably the only actual good thing I've seen since before the end of the world: he owned his error and he put himself in harm's way to make up for it.  Massive respect to that guy.  So, of course, he's a zombie now.  Fuck, thanks for reminding me of all that sunny fun."),
    replies = {
        {
            text = ccb.content.text("Sorry for bringing it up. What were you saying?"),
            next_topic = "TALK_NONE",
        },
    },
}

ccb.content.define_dialogue_topic {
    id = "TALK_REFUGEE_BEGGAR_3_RACISM",
    line = ccb.content.text("Sure.  My grandparents were from China.  That means I'm obviously personally responsible for all this.  Do you think there's some other reason they let hundreds of other educated people in and I'm sitting out here?"),
    replies = {
        {
            when = predicates.negate(predicates.any_equal({ "yes", { scope = "speaker", key = "general_recruit_luo_recruited" } })),
            text = ccb.content.text("I don't care if you're Chinese.  You can travel with me if you want."),
            next_topic = "TALK_REFUGEE_BEGGAR_3_JOIN",
        },
        {
            when = predicates.all({ predicates.minimum_attribute("speaker", "perception", 9), predicates.negate(predicates.any_equal({ "yes", { scope = "speaker", key = "general_recruit_luo_recruited" } })), predicates.negate(predicates.any_equal({ "yes", { scope = "interlocutor", key = "general_conversation_dont_insult_luo" } })) }),
            text = ccb.content.text("I mean, racism could definitely be a part of it… but you are visibly in poor shape.  They need strong survivor material."),
            next_topic = "TALK_REFUGEE_BEGGAR_3_INSULTED",
        },
        {
            text = ccb.content.text_without_extraction("<end_talking_leave>"),
            next_topic = "TALK_DONE",
        },
    },
}

ccb.content.define_dialogue_topic {
    id = "TALK_REFUGEE_BEGGAR_3_JOIN",
    line = ccb.content.text("That's awful kind of you, but look at me.  I'm not traveling material, I've managed to stay fifty pounds overweight on a diet of pine nuts and wilted rhubarb, and I scream and shake uncontrollably at the sight of blood."),
    replies = {
        {
            text = ccb.content.text("Why stay out here then?"),
            next_topic = "TALK_REFUGEE_BEGGAR_3_WHYSTAY",
        },
        {
            text = ccb.content.text("What did you do before <the_cataclysm>?"),
            next_topic = "TALK_REFUGEE_BEGGAR_3_EXPERTISE",
        },
        {
            text = ccb.content.text("It'd be temporary.  I have a base set up.  There are only a few of us survivors left, we need to work together"),
            next_topic = "TALK_REFUGEE_BEGGAR_3_RECRUIT1",
            when = predicates.handler("dlg_p_dda_453225921210"),
        },
        {
            text = ccb.content.text("Okay, yeah, that's a bit of a problem.  <done_conversation_section>"),
            next_topic = "TALK_NONE",
        },
        {
            text = ccb.content.text("<end_talking_leave>"),
            next_topic = "TALK_DONE",
        },
    },
}

ccb.content.define_dialogue_topic {
    id = "TALK_REFUGEE_BEGGAR_3_WHYSTAY",
    line = ccb.content.text("It may not be much, but we've got a little community.  We can't live like this forever, but we're safer than out there, and we look out for each other.  One way or another we'll shake things out to something better."),
    replies = {
        {
            text = ccb.content.text("You sound more optimistic than usual."),
            next_topic = "TALK_REFUGEE_BEGGAR_3_WHYSTAY2",
        },
        {
            text = ccb.content.text("What did you do before <the_cataclysm>?"),
            next_topic = "TALK_REFUGEE_BEGGAR_3_EXPERTISE",
        },
        {
            text = ccb.content.text("It'd be temporary.  I have a base set up.  There are only a few of us survivors left, we need to work together"),
            next_topic = "TALK_REFUGEE_BEGGAR_3_RECRUIT1",
            when = predicates.handler("dlg_p_dda_453225921210"),
        },
        {
            text = ccb.content.text("So, about that doctorate of yours…"),
            next_topic = "TALK_REFUGEE_BEGGAR_3_DOCTORATE1",
            when = predicates.all({ predicates.any_equal({ "yes", { scope = "speaker", key = "general_conversation_luo_doctorate" } }), predicates.negate(predicates.any_equal({ "yes", { scope = "speaker", key = "general_recruit_luo_recruited" } })) }),
        },
        {
            text = ccb.content.text("<done_conversation_section>"),
            next_topic = "TALK_NONE",
        },
        {
            text = ccb.content.text("<end_talking_leave>"),
            next_topic = "TALK_DONE",
        },
    },
}

ccb.content.define_dialogue_topic {
    id = "TALK_REFUGEE_BEGGAR_3_WHYSTAY2",
    line = ccb.content.text("Don't get me wrong, I hate this place and this situation, and especially the selfish racist fucks that landed me here… but these other losers that landed out here with me?  I like them.  We might be miserable, but we're miserable together."),
    replies = {
        {
            text = ccb.content.text("What did you do before <the_cataclysm>?"),
            next_topic = "TALK_REFUGEE_BEGGAR_3_EXPERTISE",
        },
        {
            text = ccb.content.text("It'd be temporary.  I have a base set up.  There are only a few of us survivors left, we need to work together"),
            next_topic = "TALK_REFUGEE_BEGGAR_3_RECRUIT1",
            when = predicates.handler("dlg_p_dda_453225921210"),
        },
        {
            text = ccb.content.text("<done_conversation_section>"),
            next_topic = "TALK_NONE",
        },
        {
            text = ccb.content.text("<end_talking_leave>"),
            next_topic = "TALK_DONE",
        },
    },
}

ccb.content.define_dialogue_topic {
    id = "TALK_REFUGEE_BEGGAR_3_INSULTED",
    line = ccb.content.gendered_line("Oooooh.  Oh.  You did not just fucking go there.  Let's leave the fatties to die, hey?  Wanna know how easy it is to find fucking *thyroid medication* after the apocalypse, asshat?  Besides, there are more skills than heavy lifting needed now… no, you know what?  Screw it.  You're not worth my time.", { "speaker" }),
    on_enter = {
        {
            actions = {
                actions.add_effect("interlocutor", "insulted_luo", { turns = 28800 }),
                actions.set_actor_value("interlocutor", "general_conversation_dont_insult_luo", "yes"),
            },
        },
    },
    replies = { { text = ccb.content.text("…"), next_topic = "TALK_DONE" } },
}

ccb.content.define_dialogue_topic {
    id = "TALK_REFUGEE_BEGGAR_3_APOLOGY",
    line = ccb.content.text("Thanks for saying it.  So, what brings you around?"),
    replies = {
        {
            when = predicates.negate(predicates.has_effect("interlocutor", "beggar_has_eaten")),
            text = ccb.content.text("What's up?"),
            next_topic = "TALK_REFUGEE_BEGGAR_3_COMPLAIN",
        },
        {
            when = predicates.has_effect("interlocutor", "beggar_has_eaten"),
            text = ccb.content.text("What's up?"),
            next_topic = "TALK_REFUGEE_BEGGAR_3_INTRO",
        },
        {
            when = predicates.negate(predicates.has_effect("interlocutor", "beggar_has_eaten")),
            text = ccb.content.text("I might have some food for you.  Are you hungry?"),
            next_topic = "TALK_REFUGEE_BEGGAR_3_GIVE_FOOD",
        },
        {
            text = ccb.content.text("Just wanted to get square.  <end_talking_leave>"),
            next_topic = "TALK_DONE",
        },
    },
}

ccb.content.define_dialogue_topic {
    id = "TALK_REFUGEE_BEGGAR_3_RECRUIT1",
    line = ccb.content.text("Tempting offer, but I don't know how much I trust a random stranger offering me a place to live.  Call me crazy."),
    on_enter = {
        {
            actions = {
                actions.set_actor_value("interlocutor", "general_recruit_luo_attempt_recruit", "yes"),
            },
        },
    },
    replies = {
        {
            when = predicates.any_equal({ "yes", { scope = "interlocutor", key = "general_recruit_luo_owed" } }),
            text = ccb.content.text("Oh, come on.  I'm not a random stranger anymore, I brought you that crazy mushroom didn't I?"),
            next_topic = "TALK_REFUGEE_BEGGAR_3_RECRUITED1",
        },
        {
            when = predicates.negate(predicates.any_equal({ "yes", { scope = "interlocutor", key = "general_recruit_luo_owed" } })),
            text = ccb.content.text("What better choice do you have?  It's not like it would be just you and me, the others out here can come too."),
            next_topic = "TALK_REFUGEE_BEGGAR_3_RECRUIT2",
        },
        {
            when = predicates.all({ predicates.any_equal({ "yes", { scope = "speaker", key = "general_conversation_luo_doctorate" } }), predicates.negate(predicates.any_equal({ "yes", { scope = "speaker", key = "general_recruit_luo_recruited" } })) }),
            text = ccb.content.text("So, about that doctorate of yours…"),
            next_topic = "TALK_REFUGEE_BEGGAR_3_DOCTORATE1",
        },
        {
            text = ccb.content.text("What did you do before <the_cataclysm>?"),
            next_topic = "TALK_REFUGEE_BEGGAR_3_EXPERTISE",
        },
        {
            text = ccb.content.text_without_extraction("<done_conversation_section>"),
            next_topic = "TALK_NONE",
        },
        {
            text = ccb.content.text_without_extraction("<end_talking_leave>"),
            next_topic = "TALK_DONE",
        },
    },
}

ccb.content.define_dialogue_topic {
    id = "TALK_REFUGEE_BEGGAR_3_RECRUIT2",
    line = ccb.content.text("Like I said, sorry, it's just not happening.  It's not that I don't trust you, it's just that I don't really trust you."),
    replies = {
        {
            when = predicates.all({ predicates.any_equal({ "yes", { scope = "speaker", key = "general_conversation_luo_doctorate" } }), predicates.negate(predicates.any_equal({ "yes", { scope = "speaker", key = "general_recruit_luo_recruited" } })) }),
            text = ccb.content.text("So, about that doctorate of yours…"),
            next_topic = "TALK_REFUGEE_BEGGAR_3_DOCTORATE1",
        },
        {
            text = ccb.content.text("What did you do before <the_cataclysm>?"),
            next_topic = "TALK_REFUGEE_BEGGAR_3_EXPERTISE",
        },
        {
            text = ccb.content.text_without_extraction("<done_conversation_section>"),
            next_topic = "TALK_NONE",
        },
        {
            text = ccb.content.text_without_extraction("<end_talking_leave>"),
            next_topic = "TALK_DONE",
        },
    },
}

ccb.content.define_dialogue_topic {
    id = "TALK_REFUGEE_BEGGAR_3_RECRUITED1",
    line = ccb.content.text("Aw damn, I was worried you'd say that.  Okay, listen: you've got yourself a deal.  I'll come to your base, but you've gotta get me hooked up with a microscope as soon as you can.  This could be the beginning of something really cool.  Oh, and it should go without saying that I'm not coming unless you can find a place for my friends here in your base.  I'm sure you anticipated that.  Talk them into going and I'm in.  It should be easy, they're a bunch of sweet hearted saps."),
    on_enter = { { actions = { actions.set_actor_value("speaker", "general_recruit_luo_recruited", "yes") } } },
    replies = {
        {
            when = predicates.all({ predicates.any_equal({ "yes", { scope = "speaker", key = "general_conversation_luo_doctorate" } }), predicates.negate(predicates.any_equal({ "yes", { scope = "speaker", key = "general_recruit_luo_recruited" } })) }),
            text = ccb.content.text("So, about that doctorate of yours…"),
            next_topic = "TALK_REFUGEE_BEGGAR_3_DOCTORATE1",
        },
        {
            text = ccb.content.text("What did you do before <the_cataclysm>?"),
            next_topic = "TALK_REFUGEE_BEGGAR_3_EXPERTISE",
        },
        {
            text = ccb.content.text_without_extraction("<done_conversation_section>"),
            next_topic = "TALK_NONE",
        },
        {
            text = ccb.content.text_without_extraction("<end_talking_leave>"),
            next_topic = "TALK_DONE",
        },
    },
}

ccb.content.define_dialogue_topic {
    id = "TALK_REFUGEE_BEGGAR_3_EXPERTISE",
    line = ccb.content.text("Well, before <the_cataclysm> ended I was working at a university bookstore.  I know a little bit about a lot of things, I guess you could say.  I kinda loved the job, to be honest."),
    replies = {
        {
            when = predicates.all({ predicates.any({ predicates.minimum_attribute("speaker", "perception", 9), predicates.minimum_attribute("speaker", "intelligence", 9) }), predicates.negate(predicates.any_equal({ "yes", { scope = "speaker", key = "general_conversation_luo_doctorate" } })), predicates.negate(predicates.any_equal({ "yes", { scope = "speaker", key = "general_recruit_luo_recruited" } })) }),
            text = ccb.content.text("What had you working at the university bookstore in the first place?  Are you an academic yourself?"),
            actions = { actions.set_actor_value("speaker", "general_conversation_luo_doctorate", "yes") },
            next_topic = "TALK_REFUGEE_BEGGAR_3_DOCTORATE",
        },
        {
            when = predicates.all({ predicates.any_equal({ "yes", { scope = "speaker", key = "general_conversation_luo_doctorate" } }), predicates.negate(predicates.any_equal({ "yes", { scope = "speaker", key = "general_recruit_luo_recruited" } })) }),
            text = ccb.content.text("What's this I hear about you having a doctorate?"),
            next_topic = "TALK_REFUGEE_BEGGAR_3_DOCTORATE1",
        },
        {
            text = ccb.content.text_without_extraction("<done_conversation_section>"),
            next_topic = "TALK_NONE",
        },
        {
            text = ccb.content.text_without_extraction("<end_talking_leave>"),
            next_topic = "TALK_DONE",
        },
    },
}

ccb.content.define_dialogue_topic {
    id = "TALK_REFUGEE_BEGGAR_3_DOCTORATE",
    line = ccb.content.text("Yeah, yeah, it's all very glamorous.  Sure, I trained in the great ivory tower, got my PhD in mycology.  Did my dissertation on signaling pathways in hyphae formation, and a postdoc in plant-fungus communication in rhizomes.  Then I got the job at the bookstore because there wasn't a ton of work for a doctor of mycology, although I'd had a few nibbles before things really got crazy.  Now, people are just breaking down my door to get my sweet sweet knowledge of mold to help them fight the incoming zombie threat."),
    replies = {
        {
            text = ccb.content.text("Do you know about the fungal zombies though?"),
            next_topic = "TALK_REFUGEE_BEGGAR_3_MYCUS1",
        },
        {
            text = ccb.content.text_without_extraction("<done_conversation_section>"),
            next_topic = "TALK_NONE",
        },
        {
            text = ccb.content.text_without_extraction("<end_talking_leave>"),
            next_topic = "TALK_DONE",
        },
    },
}

ccb.content.define_dialogue_topic {
    id = "TALK_REFUGEE_BEGGAR_3_DOCTORATE1",
    line = ccb.content.text("Heh.  Yeah, that was a great use of my time.  As you can see it really helped my employment prospects.  Yeah, I have a PhD in mycology.  Did my dissertation on signaling pathways in hyphae formation, and a postdoc in plant-fungus communication in rhizomes.  Then I got the job at the bookstore because there wasn't a ton of work for a doctor of mycology, although I'd had a few nibbles before things really got crazy.  Now, people are just breaking down my door to get my sweet sweet knowledge of mold to help them fight the incoming zombie threat."),
    replies = {
        {
            text = ccb.content.text("Do you know about the fungal zombies though?"),
            next_topic = "TALK_REFUGEE_BEGGAR_3_MYCUS1",
        },
        {
            text = ccb.content.text_without_extraction("<done_conversation_section>"),
            next_topic = "TALK_NONE",
        },
        {
            text = ccb.content.text_without_extraction("<end_talking_leave>"),
            next_topic = "TALK_DONE",
        },
    },
}

ccb.content.define_dialogue_topic {
    id = "TALK_REFUGEE_BEGGAR_3_MYCUS1",
    line = ccb.content.text("No, no I don't, and I'd appreciate you not leaving me hanging on that.  There are fungal zombies?"),
    replies = {
        {
            text = ccb.content.text("Encroaching alien mushrooms, fungal towers, tough mycelium invading ground and trees, zombies taken over by aggressive mold… Yeah.  It's ugly stuff."),
            next_topic = "TALK_REFUGEE_BEGGAR_3_MYCUS2",
        },
        {
            text = ccb.content.text_without_extraction("<done_conversation_section>"),
            next_topic = "TALK_NONE",
        },
        {
            text = ccb.content.text_without_extraction("<end_talking_leave>"),
            next_topic = "TALK_DONE",
        },
    },
}

ccb.content.define_dialogue_topic {
    id = "TALK_REFUGEE_BEGGAR_3_MYCUS2",
    line = ccb.content.text("Okay, you've got my attention.  Listen, do you think you could bring me some kind of sample of these things?"),
    replies = {
        {
            text = ccb.content.text("It'd be dangerous.  What kind of benefit is there from taking a risk like that?"),
            next_topic = "TALK_REFUGEE_BEGGAR_3_MYCUS3",
        },
        {
            text = ccb.content.text_without_extraction("<done_conversation_section>"),
            next_topic = "TALK_NONE",
        },
        {
            text = ccb.content.text_without_extraction("<end_talking_leave>"),
            next_topic = "TALK_DONE",
        },
    },
}

ccb.content.define_dialogue_topic {
    id = "TALK_REFUGEE_BEGGAR_3_MYCUS3",
    line = {
        when = predicates.any_equal({ "yes", { scope = "interlocutor", key = "general_recruit_luo_attempt_recruit" } }),
        yes = ccb.content.text("If you get me a sample, I'll join your crazy camp expedition.  Hell, if you bring me a sample maybe I'll help you set up a lab to study this stuff.  Almost anything could work, but if this stuff is as dangerous as you make it sound, maybe make sure it's not a sporulating body."),
        no = ccb.content.text("I dunno, scientific interest?  If you don't bring me anything, no worries.  I'm positively swimming in entertainment here, as you can see."),
    },
    on_enter = {
        {
            actions = { actions.set_actor_value("interlocutor", "general_mission_luo_mycus_mission", "yes") },
        },
    },
    replies = {
        {
            when = predicates.all({ predicates.has_item("speaker", "veggy_tainted"), predicates.any_equal({ "yes", { scope = "interlocutor", key = "general_recruit_luo_attempt_recruit" } }) }),
            text = ccb.content.text("It just so happens I have a chunk of fungal matter on me right now."),
            next_topic = "TALK_REFUGEE_BEGGAR_3_MYCUS4_RECRUIT",
        },
        {
            when = predicates.all({ predicates.has_item("speaker", "veggy_tainted"), predicates.negate(predicates.any_equal({ "yes", { scope = "interlocutor", key = "general_recruit_luo_attempt_recruit" } })) }),
            text = ccb.content.text("It just so happens I have a chunk of fungal matter on me right now."),
            next_topic = "TALK_REFUGEE_BEGGAR_3_MYCUS4_NOTREADY",
            actions = { actions.set_actor_value("interlocutor", "general_recruit_luo_owed", "yes") },
        },
        {
            text = ccb.content.text_without_extraction("<done_conversation_section>"),
            next_topic = "TALK_NONE",
        },
        {
            text = ccb.content.text("Sure, I'd better get going.  I'll see if I can find you something."),
            next_topic = "TALK_DONE",
        },
    },
}

ccb.content.define_dialogue_topic {
    id = "TALK_REFUGEE_BEGGAR_3_MYCUS4_RECRUIT",
    line = ccb.content.text("Well.  Well, well, well.  This is really interesting.  Look, you can see reticulations here, it looks sort of like an enlarged piece of a stipe from a basidiocarp… but look at this, these fibers are clearly unlike anything I've seen before.  I wonder if they're motile?\n\nOkay, listen: you've got yourself a deal.  I'll come to your base, but you've gotta get me hooked up with a microscope as soon as you can.  This could be the beginning of something really cool.  Oh, and it should go without saying that I'm not coming unless you can find a place for my friends here in your base.  I'm sure you anticipated that.  Talk them into going and I'm in.  It should be easy, they're a bunch of sweet hearted saps."),
    on_enter = { { actions = { actions.set_actor_value("speaker", "general_recruit_luo_recruited", "yes") } } },
    replies = {
        {
            text = ccb.content.text("Great!  I'll go see what I can do about that."),
            next_topic = "TALK_DONE",
        },
    },
}

ccb.content.define_dialogue_topic {
    id = "TALK_REFUGEE_BEGGAR_3_MYCUS4_NOTREADY",
    line = ccb.content.text("Well.  Well, well, well.  This is really interesting.  Look, you can see reticulations here, it looks sort of like an enlarged piece of a stipe from a basidiocarp… but look at this, these fibers are clearly unlike anything I've seen before.  I wonder if they're motile?\n\nSorry.  I could stare at this all day.  I owe you one, a big one.  Thanks for this.  Let me know if you ever need a favor from a chubby beggar woman."),
    replies = {
        {
            text = ccb.content.text("Glad you like it.  If I think of something you can do in return, I'll let you know."),
            next_topic = "TALK_DONE",
        },
    },
}

ccb.content.define_dialogue_topic {
    id = "TALK_REFUGEE_BEGGAR_3_RECRUITED2",
    line = ccb.content.text("Well good.  Let's get going, I want to see some more of these crazy mushrooms."),
    replies = {
        {
            text = ccb.content.text("I'll see what I can do."),
            next_topic = "TALK_DONE",
            native_actions = { "follow" },
        },
    },
}
