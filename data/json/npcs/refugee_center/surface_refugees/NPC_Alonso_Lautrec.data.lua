local ccb = require("ccb")
local predicates = ccb.content.dialogue_predicates
local actions = ccb.content.dialogue_actions

ccb.content.define_npc {
    id = "refugee_AlonsoLautrec",
    unique_name = ccb.content.text("Alonso Lautrec"),
    gender = "male",
    suffix = ccb.content.text("Refugee"),
    class = "NC_REFUGEE_Alonso",
    attitude = 0,
    mission = "GUARD",
    chat = "TALK_REFUGEE_Alonso_1",
    faction = "free_merchants",
    missions_offered = "MISSION_REFUGEE_Alonso_pants",
}

-- Alonso wants to be the town bicycle, but isn't getting as much interest as he'd hoped.  He'll trade a morale bonus for condoms.
ccb.content.define_npc_class {
    id = "NC_REFUGEE_Alonso",
    name = ccb.content.text("Refugee"),
    job_description = ccb.content.text("I'm just trying to survive."),
    common = false,
    strength = { rng = { -2, 1 } },
    dexterity = { rng = { -2, 4 } },
    intelligence = { rng = { -2, 2 } },
    perception = { rng = { -2, 2 } },
    worn = "REFUGEE_Alonso_worn",
    carry = "REFUGEE_Alonso_carried",
    weapon = "REFUGEE_Alonso_wield",
    traits = {
        { trait = "PRETTY" },
        { group = "Appearance_demographics" },
        { trait = "NO_BASH" },
        { trait = "RETURN_TO_START_POS" },
    },
    skills = {
        {
            skill = "ALL",
            level = { mul = { { one_in = 3 }, { sum = { { dice = { 2, 2 } }, { rng = { 0, -5 } } } } } },
        },
        { skill = "speech", bonus = { rng = { 0, 1 } } },
    },
}

ccb.content.define_dialogue_topic {
    id = { "TALK_REFUGEE_Alonso_2", "TALK_REFUGEE_Alonso_Background", "TALK_REFUGEE_Alonso_Situation" },
    replies = {
        {
            text = ccb.content.text("I'm trying to put a cleanup crew together to tidy up the back room.  Can you help?"),
            next_topic = "TALK_REFUGEE_Alonso_Refuse_Boris_Mission_1",
            when = predicates.all({ predicates.has_mission("MISSION_REFUGEE_Boris_CLEANUP"), predicates.negate(predicates.any_equal({ "yes", { scope = "interlocutor", key = "mission_Boris_mission_1_cleanup_asked" } })) }),
        },
        {
            text = ccb.content.text("You seem a little forward…"),
            next_topic = "TALK_REFUGEE_Alonso_Forward",
        },
        {
            text = ccb.content.text("[PER 10] What is up with you?  What's with the fake accent, and speaking in the third person?"),
            next_topic = "TALK_REFUGEE_Alonso_CalledOut1",
            when = predicates.all({ predicates.minimum_attribute("speaker", "perception", 10), predicates.negate(predicates.any_equal({ "asked", { scope = "interlocutor", key = "general_none_Alonso_accent" } })), predicates.negate(predicates.any_equal({ "accepted", { scope = "interlocutor", key = "general_none_Alonso_accent" } })) }),
        },
        {
            text = ccb.content.text("Why aren't you wearing any pants?"),
            next_topic = "TALK_REFUGEE_Alonso_Pants1",
            when = predicates.negate(predicates.any_equal({ "yes", { scope = "speaker", key = "mission_flag_Alonso_pants" } })),
        },
        {
            text = ccb.content.text("About those special pants a sexy clown hid in a shop for mysterious reasons…"),
            next_topic = "TALK_MISSION_INQUIRE",
            when = predicates.any_equal({ "in_progress", { scope = "speaker", key = "mission_flag_Alonso_pants" } }),
        },
        {
            text = ccb.content.text("What's your story?"),
            next_topic = "TALK_REFUGEE_Alonso_Background",
        },
        {
            text = ccb.content.text("How are things here?"),
            next_topic = "TALK_REFUGEE_Alonso_Situation",
        },
        {
            text = ccb.content.text("[PRETTY] Remember that nice thing I did for you?  Can you do something nice for me?"),
            next_topic = "TALK_REFUGEE_Alonso_Pretty_Action",
            when = predicates.handler("dlg_p_dda_78ae1d01ea65"),
        },
        {
            text = ccb.content.text("So about those condoms.  I thought of a good use for them…"),
            next_topic = "TALK_REFUGEE_Alonso_Normal_Action",
            when = predicates.handler("dlg_p_dda_70c3c5fe68ba"),
        },
        {
            text = ccb.content.text("[UGLY] I'm desperate.  You're my only chance."),
            next_topic = "TALK_REFUGEE_Alonso_Ugly_Action",
            when = predicates.handler("dlg_p_dda_a48324f18173"),
        },
        {
            text = ccb.content.text("So about those condoms.  I thought of a good use for them…"),
            next_topic = "TALK_REFUGEE_Alonso_Too_Young",
            when = predicates.handler("dlg_p_dda_4a83d5269f04"),
        },
    },
}

ccb.content.define_dialogue_topic {
    id = "TALK_REFUGEE_Alonso_1",
    line = {
        joined = {
            ccb.content.text("*is an uncharacteristically well-groomed young man, his hair trim and slicked back.  In this stark setting, he looks like a cartoon character on a live-action set piece.  \""),
            {
                when = predicates.actor_state("speaker", "male"),
                yes = ccb.content.text("Oh my, it's good to see such a strong and handsome fellow around here"),
                no = ccb.content.text("Oh my, you're a beautiful lady, so nice to see you"),
            },
            ccb.content.text(".\"  He slides his hand through his hair and smiles, his eyes half-lidded.  \"They call me Alonso.\""),
        },
    },
    on_enter = {
        {
            actions = {
                actions.set_actor_value("speaker", "general_meeting_u_met_Alonso_Lautrec", "yes"),
                actions.set_first_topic("TALK_REFUGEE_Alonso_1a"),
            },
        },
    },
    replies = {
        {
            text = ccb.content.text("Nice to meet you, Alonso."),
            next_topic = "TALK_REFUGEE_Alonso_1_firstmeet",
        },
        {
            text = ccb.content.text("Hi Alonso, nice to meet you.  <end_talking_leave>"),
            next_topic = "TALK_DONE",
        },
    },
}

ccb.content.define_dialogue_topic {
    id = "TALK_REFUGEE_Alonso_1a",
    line = ccb.content.gendered_line("*leans casually against the brick wall of the shelter.  \"Hello again, gorgeous\"", { "speaker" }),
    replies = {
        { text = ccb.content.text("Hi, Alonso.  What's up?"), next_topic = "TALK_REFUGEE_Alonso_2" },
        { text = ccb.content.text("Hi Alonso.  <end_talking_leave>"), next_topic = "TALK_DONE" },
    },
}

ccb.content.define_dialogue_topic {
    id = "TALK_REFUGEE_Alonso_1_firstmeet",
    line = ccb.content.text("Nice to meet you too.  Very nice.  It gets so lonely here in the center."),
    replies = {
        { text = ccb.content.text("What's up?"), next_topic = "TALK_REFUGEE_Alonso_2" },
        {
            text = ccb.content.text_without_extraction("<end_talking_leave>"),
            next_topic = "TALK_DONE",
        },
    },
}

ccb.content.define_dialogue_topic {
    id = "TALK_REFUGEE_Alonso_2",
    line = {
        when = predicates.any_equal({ "asked", { scope = "interlocutor", key = "general_none_Alonso_accent" } }),
        yes = ccb.content.text("Well, it's a lot better now that you're here.  Nice to see a familiar face."),
        no = ccb.content.text("Now that you are here, everything.  Is there anything Alonso can… *do for you*?"),
    },
    replies = {
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
    id = "TALK_REFUGEE_Alonso_Forward",
    line = {
        when = predicates.any_equal({ "asked", { scope = "interlocutor", key = "general_none_Alonso_accent" } }),
        yes = ccb.content.text("You know me, I gotta be me, right?"),
        no = ccb.content.text("Alonso cannot help himself, in the face of someone so fine as you."),
    },
    replies = {
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
    id = "TALK_REFUGEE_Alonso_CalledOut1",
    line = {
        joined = {
            {
                when = predicates.actor_state("speaker", "male"),
                yes = ccb.content.text("Aw man"),
                no = ccb.content.text("Aw come on"),
            },
            ccb.content.text(", why you gotta be like that?  I'm just tryin' to get an air of mystery okay?  Nobody wants to be with a slutty guy from Brooklyn, but Alonso the mysterious is another story."),
        },
    },
    replies = {
        {
            text = ccb.content.text("And how is that working out for you?"),
            next_topic = "TALK_REFUGEE_Alonso_CalledOut2",
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
    id = "TALK_REFUGEE_Alonso_CalledOut2",
    line = ccb.content.text("Better'n you'd maybe think, okay?  Can we drop it?"),
    replies = {
        {
            text = ccb.content.text("Just stop talking like that around me, maybe?  It's really obnoxious."),
            next_topic = "TALK_REFUGEE_Alonso_CalledOut3",
            actions = { actions.set_actor_value("interlocutor", "general_none_Alonso_accent", "asked") },
        },
        {
            text = ccb.content.text("You know what?  You do you.  It's all good."),
            next_topic = "TALK_REFUGEE_Alonso_CalledOut3",
            actions = { actions.set_actor_value("interlocutor", "general_none_Alonso_accent", "accepted"), actions.handler("dlg_a_dda_e1b9d929b004") },
        },
        {
            text = ccb.content.text("<done_conversation_section>"),
            next_topic = "TALK_NONE",
        },
        {
            text = ccb.content.text("I'll leave you to it then."),
            next_topic = "TALK_DONE",
        },
    },
}

ccb.content.define_dialogue_topic {
    id = "TALK_REFUGEE_Alonso_CalledOut3",
    line = {
        when = predicates.any_equal({ "asked", { scope = "interlocutor", key = "general_none_Alonso_accent" } }),
        yes = ccb.content.text("Fine.  As a favor to you, I'll be a guy from Brooklyn."),
        no = ccb.content.text("Alonso thanks you for your kindness, and will remain his glorious self."),
    },
    replies = { { text = ccb.content.text("Thanks.  <end_talking_leave>"), next_topic = "TALK_DONE" } },
}

ccb.content.define_dialogue_topic {
    id = "TALK_REFUGEE_Alonso_Background",
    line = {
        when = predicates.any_equal({ "asked", { scope = "interlocutor", key = "general_none_Alonso_accent" } }),
        yes = ccb.content.text("I'm tryin' ta forget, y'know?  Don't like thinkin' about the past.  Better to plan for the future, even if the future looks grim."),
        no = ccb.content.text("Alonso has many a tale to tell, all slow and drawn-out like, a sensual seduction of the -- how you say?  Ears.  There are dark days ahead, but perhaps together we can bring a little light?  Or at least a little heat.  This is a science joke I make for you.  Friction, it is the joke."),
    },
    replies = {
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
    id = "TALK_REFUGEE_Alonso_Pants1",
    line = {
        when = predicates.any_equal({ "asked", { scope = "interlocutor", key = "general_none_Alonso_accent" } }),
        yes = ccb.content.text("Yeah, I fucked up and got drunk at a kiddy party I crashed, broke into a van with the party clown I was seein' (hey don't judge me, it took me a long time to make that happen, clowns are very givin' lovers) and I lost my pants, includin' all my money and all my triple magnum condoms I stole off a dead priest at a bar.  I'd be mad, but at least I'm safe, I made it here.  But I got no game here y'know?  I look like the clown when I should be knee deep in hotness here.  Look around, it's straight hotties!"),
        no = ccb.content.text("Why were you looking though?  I kid, I know she is hard to miss!  In English, the special package she is a woman no?  No.  I see.  And so do you it seems.  Yes.  There was such a clown, a clown of enormous physical beauty.  The pale, perfect skin, the ruby red lips, amazing hair, and what a sense of humor.  I laugh still, though I have lost everything.  My pants, my money, my many illegal imported triple magnum condoms I stole from a priest.  All lost to that one beautiful night.  The candles, the balloons, the singing.  It was the most romantic children's birthday party you could hope to imagine.  I would do it all again, and there was so much we did.  It was the end of that party, but the beginning of something beautiful, for several hours in that open minivan we found.  But you do not want to hear of such pleasures, I do not want to get you excited, for what can I do when I look so foolish, and lack the protection needed for more serious excitement.  Though and you must understand, Alonso's tongue is good for more than just the telling of long and saucy stories yes?"),
    },
    replies = {
        { text = ccb.content.text("Can I help you out?"), next_topic = "TALK_MISSION_LIST" },
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
    id = "TALK_REFUGEE_Alonso_Situation",
    line = {
        when = predicates.any_equal({ "asked", { scope = "interlocutor", key = "general_none_Alonso_accent" } }),
        yes = ccb.content.text("Could be better.  I don't really got any friends here in the center, but seeing travelers like you always brightens my day."),
        no = ccb.content.text("Here in the center, Alonso is a bit lonely.  We get a few brave, strong travelers like yourself, though, and seeing them brightens Alonso's day.  Normally I am more popular, but something seems to be troubling the spirits of these people during these terrible times."),
    },
    replies = {
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

ccb.content.define_mission {
    id = "MISSION_REFUGEE_Alonso_pants",
    name = ccb.content.text("Alonso must have his special pants"),
    description = ccb.content.text("Find Alonso's leather pants in the 'toy shop' Alonso has marked on your map."),
    goal = "MGOAL_FIND_ITEM",
    difficulty = 2,
    value = 1000,
    item = "pants_leather",
    start = {
        target = { terrain = "cs_sex_shop", reveal_radius = 1, random = true, search_range = 240 },
        map_updates = {
            {
                terrain = "cs_sex_shop",
                layout = { item_placements = { { id = "pants_leather", x = 19, y = 20 } } },
            },
        },
        actions = {
            ccb.content.dialogue_actions.set_actor_value("speaker", "mission_flag_Alonso_pants", "in_progress"),
        },
    },
    finish = {
        before_rewards = {
            "mark_mission_flag_Alonso_pants",
            "advance_counter_refugee_center_refugee_happiness_by_2",
        },
        actions = {
            ccb.content.dialogue_actions.add_effect("interlocutor", "Alonso_pants_restored", { permanent = true }),
        },
    },
    origins = { "ORIGIN_SECONDARY" },
    generic_rewards = false,
    dialogue = {
        describe = ccb.content.text("I think I might know where those special pants might be though…"),
        offer = ccb.content.text("This clown was into some of the different things, not the vanilla, you understand me?  Yes.  I think you will find my valuables in a toy shop not so far."),
        accepted = ccb.content.text("You make me so happy I could give you little kisses, and some big kisses, and then something else maybe."),
        rejected = ccb.content.text("I know that you cannot resist me long.  I will wait, and perhaps some other pretty thing will help me instead?"),
        advice = ccb.content.text("It may be crowded no?  A popular place before, maybe is better to visit at night.  Sounds like Alonso's apartment no?  Ah, and if something strange grabs you and another pair of leather pants comes to you, maybe Alonso is even happier?"),
        inquire = ccb.content.text("Have you found what it is that you seek?  There may be something in it for you no?  Something big, but we take it slow yes?"),
        success = ccb.content.text("This is the best news since those lonely teachers asked me to be a nude model at the college for the blind.  Alas, the special condoms have all been used.  This is not a surprise, few could resist this seductive clown.  You find a condom, I find a use for it.  Safety, she was never more important than now, in *so* many ways."),
        success_lie = ccb.content.text("You give me confidence.  I trust you.  I do not know why this is."),
        failure = ccb.content.text("Disaster, but I thank you for to try.  You want a backrub some time, it will happen for sure.  And maybe you give me a rub too?"),
    },
}

ccb.content.define_dialogue_topic {
    id = "TALK_REFUGEE_Alonso_Pretty_Action",
    line = {
        joined = {
            {
            when = predicates.any_equal({ "asked", { scope = "interlocutor", key = "general_none_Alonso_accent" } }),
            yes = ccb.content.gendered_line("Yo, you're crazy hot!  I'm not stupid!", { "speaker" }),
            no = ccb.content.text("My jewel of the New England, I give to you my biggest prize."),
        },
            {
            when = predicates.handler("dlg_p_dda_e9d71f52da0b"),
            yes = ccb.content.text("\"\n\nLiam gives you a sly wink, heads to the door, theatrically produces a sock from - somewhere, you're not sure where - slides it on the doorknob, and leaves the room."),
            no = ccb.content.text("\""),
        },
        },
    },
    on_enter = {
        { once = "service_provided", actions = { actions.add_effect("speaker", "al_relaxed", { turns = 400 }), actions.handler("dlg_a_dda_13914f18c2f0") } },
    },
    replies = {
        {
            text = ccb.content.text("Sigh.  <done_conversation_section>"),
            next_topic = "TALK_NONE",
        },
        {
            text = ccb.content.text("All done.  <end_talking_leave>"),
            next_topic = "TALK_DONE",
        },
    },
}

ccb.content.define_dialogue_topic {
    id = "TALK_REFUGEE_Alonso_Normal_Action",
    line = {
        joined = {
            {
            when = predicates.any_equal({ "asked", { scope = "interlocutor", key = "general_none_Alonso_accent" } }),
            yes = ccb.content.text("Yeeeeah it's on!"),
            no = ccb.content.text("I give to you what of I got.  And this is Alonso so I mean it's a lot."),
        },
            {
            when = predicates.handler("dlg_p_dda_e9d71f52da0b"),
            yes = ccb.content.text("\"\n\nLiam gives you a sly wink, heads to the door, theatrically produces a sock from - somewhere, you're not sure where - slides it on the doorknob, and leaves the room."),
            no = ccb.content.text("\""),
        },
        },
    },
    on_enter = {
        { once = "service_provided", actions = { actions.add_effect("speaker", "al_relaxed", { turns = 360 }), actions.handler("dlg_a_dda_4482b3fae01c") } },
    },
    replies = {
        {
            text = ccb.content.text("Sigh.  <done_conversation_section>"),
            next_topic = "TALK_NONE",
        },
        {
            text = ccb.content.text("Yeah.  <end_talking_leave>"),
            next_topic = "TALK_DONE",
        },
    },
}

ccb.content.define_dialogue_topic {
    id = "TALK_REFUGEE_Alonso_Ugly_Action",
    line = {
        joined = {
            {
            when = predicates.any_equal({ "asked", { scope = "interlocutor", key = "general_none_Alonso_accent" } }),
            yes = ccb.content.gendered_line("Yo, you're crazy hot!  I'm not stupid!", { "speaker" }),
            no = ccb.content.text("My jewel of the New England, I give to you my biggest prize."),
        },
            {
            when = predicates.handler("dlg_p_dda_e9d71f52da0b"),
            yes = ccb.content.text("\"\n\nAfter shooting Alonso a smile of genuine respect, Liam gives you a sly wink, heads to the door, theatrically produces a sock from - somewhere, you're not sure where - slides it on the doorknob, and leaves the room."),
            no = ccb.content.text("\""),
        },
        },
    },
    on_enter = {
        { once = "service_provided", actions = { actions.add_effect("speaker", "al_relaxed", { turns = 300 }), actions.handler("dlg_a_dda_725517b225b5") } },
    },
    replies = {
        {
            text = ccb.content.text("Sigh.  <done_conversation_section>"),
            next_topic = "TALK_NONE",
        },
        {
            text = ccb.content.text("Yeah.  <end_talking_leave>"),
            next_topic = "TALK_DONE",
        },
    },
}

ccb.content.define_dialogue_topic {
    id = "TALK_REFUGEE_Alonso_Too_Young",
    line = {
        when = predicates.any_equal({ "asked", { scope = "interlocutor", key = "general_none_Alonso_accent" } }),
        yes = ccb.content.text("Sorry kid, you're younger than my little sister was.  Seems wrong."),
        no = ccb.content.text("Alonso thinks maybe we should wait a few years?"),
    },
    replies = { { text = ccb.content.text("Sigh."), next_topic = "TALK_DONE" } },
}

ccb.content.define_dialogue_topic {
    id = "TALK_REFUGEE_Alonso_Refuse_Boris_Mission_1",
    line = {
        when = predicates.any_equal({ "asked", { scope = "interlocutor", key = "general_none_Alonso_accent" } }),
        yes = ccb.content.text("I'm sorry.  I… saw things back there, when it all went sideways.  I can't go back, not for anything."),
        no = ccb.content.text("Alonso, alas, is sorry, but he cannot sully his hands with blood.  It is not that he does not wish to prove his strength, but he… he is not strong enough."),
    },
    on_enter = {
        {
            actions = {
                actions.set_actor_value("interlocutor", "mission_Boris_mission_1_cleanup_asked", "yes"),
            },
        },
    },
    replies = {
        {
            text = ccb.content.text("Thanks anyway.  <done_conversation_section>"),
            next_topic = "TALK_NONE",
        },
        { text = ccb.content.text("Well, thanks anyway."), next_topic = "TALK_DONE" },
    },
}
