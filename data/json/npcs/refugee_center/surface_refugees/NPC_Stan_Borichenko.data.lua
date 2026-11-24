local ccb = require("ccb")
local predicates = ccb.content.dialogue_predicates
local actions = ccb.content.dialogue_actions

ccb.content.define_npc {
    id = "refugee_StanBorichenko",
    unique_name = ccb.content.text("Stan Borichenko"),
    gender = "male",
    suffix = ccb.content.text("Refugee"),
    class = "NC_REFUGEE_Stan",
    attitude = 0,
    mission = "GUARD",
    chat = "TALK_REFUGEE_Stan_1",
    faction = "free_merchants",
}

-- Stan is a broken man since he and Boris lost their son in the Cataclysm.  It might be possible to help put him back together slowly.
ccb.content.define_npc_class {
    id = "NC_REFUGEE_Stan",
    name = ccb.content.text("Refugee"),
    job_description = ccb.content.text("I'm just trying to survive."),
    common = false,
    strength = { rng = { -2, 2 } },
    dexterity = { rng = { -2, 2 } },
    intelligence = { rng = { -2, 2 } },
    perception = { rng = { -2, 2 } },
    worn = "REFUGEE_Stan_worn",
    carry = "REFUGEE_Stan_carried",
    weapon = "REFUGEE_Stan_wield",
    traits = {
        { trait = "MYOPIC" },
        { group = "Appearance_Germanic" },
        { trait = "NO_BASH" },
        { trait = "RETURN_TO_START_POS" },
    },
    skills = {
        {
            skill = "ALL",
            level = { mul = { { one_in = 3 }, { sum = { { dice = { 2, 2 } }, { rng = { 0, -4 } } } } } },
        },
        { skill = "cooking", bonus = { rng = { 3, 4 } } },
        { skill = "computer", bonus = { rng = { 1, 2 } } },
    },
}

-- common talk responses
ccb.content.define_dialogue_topic {
    id = {
        "TALK_REFUGEE_Stan_2", "TALK_REFUGEE_Stan_Background", "TALK_REFUGEE_Stan_Situation",
        "TALK_REFUGEE_Stan_Boris", "TALK_REFUGEE_Stan_Garry",
    },
    replies = {
        {
            text = ccb.content.text("I'm trying to put a cleanup crew together to tidy up the back room.  Can you help?"),
            when = predicates.all({ predicates.has_mission("MISSION_REFUGEE_Boris_CLEANUP"), predicates.negate(predicates.any_equal({ "yes", { scope = "interlocutor", key = "mission_Boris_mission_1_cleanup_asked" } })) }),
            next_topic = "TALK_REFUGEE_Refuse_Boris_Mission_1",
        },
        {
            text = ccb.content.text("Do you want to talk about your story?"),
            next_topic = "TALK_REFUGEE_Stan_Background",
        },
        {
            text = ccb.content.text("How are things here?"),
            next_topic = "TALK_REFUGEE_Stan_Situation",
        },
    },
}

ccb.content.define_dialogue_topic {
    id = "TALK_REFUGEE_Stan_1",
    line = ccb.content.text("*seems to look past you for a while before realizing you are there.  \"Hello.  I'm sorry, if we've met before, I don't really remember.  I'm… I'm Stan.\""),
    on_enter = {
        {
            actions = {
                actions.set_actor_value("speaker", "general_meeting_u_met_Stan_Borichenko", "yes"),
                actions.set_first_topic("TALK_REFUGEE_Stan_1a"),
            },
        },
    },
    replies = {
        {
            text = ccb.content.text("Stan, hey?  Nice to meet you."),
            next_topic = "TALK_REFUGEE_Stan_1_firstmeet",
        },
        {
            text = ccb.content.text("Hi Stan, nice to meet you.  <end_talking_leave>"),
            next_topic = "TALK_DONE",
        },
    },
}

ccb.content.define_dialogue_topic {
    id = "TALK_REFUGEE_Stan_1a",
    line = {
        joined = {
            ccb.content.text("*seems to look past you for a while before realizing you are there.  \""),
            {
                choices = {
                    ccb.content.text("Hi."),
                    ccb.content.text("Hello."),
                    ccb.content.text("Hm?  Oh, hi."),
                    ccb.content.text("…Hi."),
                },
            },
            ccb.content.text("\""),
        },
    },
    replies = {
        { text = ccb.content.text("Hi, Stan.  What's up?"), next_topic = "TALK_REFUGEE_Stan_2" },
        { text = ccb.content.text("Hi Stan.  <end_talking_leave>"), next_topic = "TALK_DONE" },
    },
}

ccb.content.define_dialogue_topic {
    id = "TALK_REFUGEE_Stan_1_firstmeet",
    line = ccb.content.text("Huh?  Sorry, yes, nice to meet you too."),
    replies = {
        { text = ccb.content.text("You seem distracted."), next_topic = "TALK_REFUGEE_Stan_2" },
        {
            text = ccb.content.text("I just wanted to say hi.  <end_talking_leave>"),
            next_topic = "TALK_DONE",
        },
    },
}

ccb.content.define_dialogue_topic {
    id = "TALK_REFUGEE_Stan_2",
    line = ccb.content.text("I'm sorry, I've been through some hard stuff.  I'm not really myself lately."),
    replies = {
        {
            text = ccb.content.text("Sorry to hear that.  I'll leave you be."),
            next_topic = "TALK_DONE",
        },
    },
}

ccb.content.define_dialogue_topic {
    id = "TALK_REFUGEE_Stan_Background",
    line = ccb.content.text("No, I don't particularly want to talk about it, but I can I guess.  Before <the_cataclysm> I was an insurance adjuster.  My husband Boris and I were evacuated with my brother Garry, and from our evacuation center we caught a commissioned bus out here.  The bus was attacked by a monster, we lived.  Not everyone on the bus did.  We lost people dear to us, now we're stuck here with little to do but think about it."),
    replies = {
        { text = ccb.content.text("Tell me about Boris."), next_topic = "TALK_REFUGEE_Stan_Boris" },
        { text = ccb.content.text("Tell me about Garry."), next_topic = "TALK_REFUGEE_Stan_Garry" },
        {
            text = ccb.content.text("I'm sorry for your loss.  <done_conversation_section>"),
            next_topic = "TALK_NONE",
        },
        {
            text = ccb.content.text("Sorry to hear that.  I'll leave you be."),
            next_topic = "TALK_DONE",
        },
    },
}

ccb.content.define_dialogue_topic {
    id = "TALK_REFUGEE_Stan_Situation",
    line = {
        joined = {
            ccb.content.text("Mostly my family and I have just been mourning.  This isn't the best place to do it.  "),
            {
                when = predicates.any_equal({ "yes", { scope = "speaker", key = "mission_completed_Boris_mission_1" } }),
                yes = ccb.content.text("Still, now that we've found ways to make this community a bit of our own, I feel like maybe there's a chance things will get better.  Sometimes, when he's working, Boris seems like himself again and I have some hope."),
                no = ccb.content.text("I hope we'll have something productive to do soon; Boris, in particular, has skills to contribute that might help him feel alive again."),
            },
        },
    },
    replies = {
        { text = ccb.content.text("Tell me about Boris."), next_topic = "TALK_REFUGEE_Stan_Boris" },
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
    id = "TALK_REFUGEE_Stan_Boris",
    line = {
        joined = {
            ccb.content.text("He's a strong man.  The things we've been through… that he's been through, before any of this.  If anyone can survive the loss we've seen, it's him.  But he pushes it all down, "),
            {
                when = predicates.any_equal({ "yes", { scope = "speaker", key = "mission_completed_Boris_mission_1" } }),
                yes = ccb.content.text("if he's left with it too long.  Having work has been helping him.  Cleaning up that back room might seem small, but it was a big deal for him."),
                no = ccb.content.text("and if he keeps it up, I don't know how much of him will be left.  He needs something to *do*.  We can't just sit here, trapped like rats in a cage forever."),
            },
            {
                when = predicates.any_equal({ "yes", { scope = "speaker", key = "mission_completed_Boris_mission_3" } }),
                yes = ccb.content.text("  Even more, though, having a little memory of Ash has been more than we could ever have asked.  I thought it might hurt him, dwelling on those memories, but instead it's given both of us some strength back."),
                no = "",
            },
        },
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
    id = "TALK_REFUGEE_Stan_Garry",
    line = {
        joined = {
            ccb.content.text("*smiles thinly.  \"Best little brother a guy could ask for.  He's been with me through everything, literally everything."),
            {
            when = predicates.handler("dlg_p_dda_3845f6520b02"),
            yes = ccb.content.text("  I wouldn't wish this world we find ourselves in on anyone, but I'm glad Garry made it through with me.\"  Stan sighs, touching his neck."),
            no = ccb.content.text("\"  He seems to realize where he is suddenly, and the faint smile melts.  \"He's lost too much, too.\""),
        },
        },
    },
    replies = {
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
