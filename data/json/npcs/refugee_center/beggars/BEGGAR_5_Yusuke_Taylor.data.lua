local ccb = require("ccb")
local predicates = ccb.content.dialogue_predicates
local actions = ccb.content.dialogue_actions

-- Mutant beggar in the refugee center.
ccb.content.define_npc {
    id = "refugee_beggar5",
    unique_name = ccb.content.text("Yusuke Taylor"),
    gender = "male",
    suffix = ccb.content.text("Computer Technician"),
    temporary_suffix = "Beggar",
    class = "NC_BEGGAR_5",
    attitude = 0,
    mission = "GUARD",
    chat = "TALK_REFUGEE_BEGGAR_5",
    faction = "lobby_beggars",
}

-- This is the only beggar with some skills, sort of the leader.
ccb.content.define_npc_class {
    id = "NC_BEGGAR_5",
    name = ccb.content.text("Beggar"),
    job_description = ccb.content.text("I'm just trying to survive."),
    common = false,
    strength = { rng = { -2, 4 } },
    dexterity = { rng = { 0, 2 } },
    intelligence = { rng = { -2, 2 } },
    perception = { rng = { 0, 4 } },
    worn = "NC_BEGGAR_5_worn",
    carry = "EMPTY_GROUP",
    weapon = "EMPTY_GROUP",
    traits = {
        { trait = "FUR" },
        { trait = "OPTIMISTIC" },
        { trait = "LIGHTSTEP" },
        { trait = "CLAWS_RETRACT" },
        { group = "Appearance_Mixed" },
    },
    skills = {
        { skill = "ALL", level = { sum = { { dice = { 3, 2 } }, { constant = -3 } } } },
        { skill = "electronics", bonus = { rng = { 3, 6 } } },
        { skill = "computer", bonus = { rng = { 3, 6 } } },
        { skill = "melee", bonus = { rng = { 0, 5 } } },
        { skill = "unarmed", bonus = { rng = { 0, 5 } } },
    },
}

-- STUB FILE: not all text implemented yet.  TK: different greetings and a whole segment on getting the beggars to join up.
ccb.content.define_dialogue_topic {
    id = "TALK_REFUGEE_BEGGAR_5",
    line = ccb.content.gendered_line("Hey there, friend.", { "speaker" }),
    replies = {
        {
            text = ccb.content.text("What are you doing out here?"),
            next_topic = "TALK_REFUGEE_BEGGAR_5_TALK1",
        },
        {
            text = ccb.content.text("I couldn't help but notice, you're covered in fur."),
            next_topic = "TALK_REFUGEE_BEGGAR_5_FUR",
        },
        {
            text = ccb.content.text("Would you like something to eat?"),
            next_topic = "TALK_REFUGEE_BEGGAR_5_FOOD",
        },
        { text = ccb.content.text("Sorry, not interested."), next_topic = "TALK_DONE" },
    },
}

ccb.content.define_dialogue_topic {
    id = "TALK_REFUGEE_BEGGAR_5_TALK1",
    line = ccb.content.text("I live here.  Too mutant to join the cool kids club, but not mutant enough to kill on sight."),
    replies = {
        {
            text = ccb.content.text("Why live out here?"),
            next_topic = "TALK_REFUGEE_BEGGAR_5_TALK2",
        },
        {
            text = ccb.content.text("I couldn't help but notice, you're covered in fur."),
            next_topic = "TALK_REFUGEE_BEGGAR_5_FUR",
        },
        {
            text = ccb.content.text("You seem like you can hold your own.  Why not travel with me?"),
            next_topic = "TALK_REFUGEE_BEGGAR_5_TRAVEL1",
        },
        {
            text = ccb.content.text("Would you like something to eat?"),
            next_topic = "TALK_REFUGEE_BEGGAR_5_FOOD",
        },
        {
            text = ccb.content.text_without_extraction("<end_talking_leave>"),
            next_topic = "TALK_DONE",
        },
    },
}

ccb.content.define_dialogue_topic {
    id = "TALK_REFUGEE_BEGGAR_5_TALK2",
    line = ccb.content.text("It's safer than making my own home.  I head out and forage when I have to.  As long as we keep it clean and do our part when a zombie comes, they let us squat here as an extra defense.  They don't like that I've been bringing food for the other squatters though… I think they are trying to slowly starve us out, and even though I can't keep everyone's bellies full, I've been able to bring back enough to keep these folk in better shape.  I suspect they'll find an excuse to kick me out eventually."),
    replies = {
        {
            text = ccb.content.text("I couldn't help but notice, you're covered in fur."),
            next_topic = "TALK_REFUGEE_BEGGAR_5_FUR",
        },
        {
            text = ccb.content.text("You seem like you can hold your own.  Why not travel with me?"),
            next_topic = "TALK_REFUGEE_BEGGAR_5_TRAVEL1",
        },
        {
            text = ccb.content.text("Would you like something to eat?"),
            next_topic = "TALK_REFUGEE_BEGGAR_5_FOOD",
        },
        {
            text = ccb.content.text("What did you do before <the_cataclysm>?"),
            next_topic = "TALK_REFUGEE_BEGGAR_5_PAST1",
        },
        {
            text = ccb.content.text_without_extraction("<end_talking_leave>"),
            next_topic = "TALK_DONE",
        },
    },
}

ccb.content.define_dialogue_topic {
    id = "TALK_REFUGEE_BEGGAR_5_FUR",
    line = ccb.content.text("Gross, isn't it?  Feels like pubes.  I just started growing it everywhere a little while after the Cataclysm.  No idea what caused it.  I can't blame them for hating it, I hate it."),
    replies = {
        {
            text = ccb.content.text("Why live out here?"),
            next_topic = "TALK_REFUGEE_BEGGAR_5_TALK2",
        },
        {
            text = ccb.content.text("You seem like you can hold your own.  Why not travel with me?"),
            next_topic = "TALK_REFUGEE_BEGGAR_5_TRAVEL1",
        },
        {
            text = ccb.content.text("Would you like something to eat?"),
            next_topic = "TALK_REFUGEE_BEGGAR_5_FOOD",
        },
        {
            text = ccb.content.text("What did you do before <the_cataclysm>?"),
            next_topic = "TALK_REFUGEE_BEGGAR_5_PAST1",
        },
        {
            text = ccb.content.text_without_extraction("<end_talking_leave>"),
            next_topic = "TALK_DONE",
        },
    },
}

ccb.content.define_dialogue_topic {
    id = "TALK_REFUGEE_BEGGAR_5_FOOD",
    line = ccb.content.text("I do okay for myself actually.  I eat a lot of things close to spoilage while I'm foraging.  If you've got food to spare, please give it to my friends."),
    replies = {
        {
            text = ccb.content.text("Why live out here?"),
            next_topic = "TALK_REFUGEE_BEGGAR_5_TALK2",
        },
        {
            text = ccb.content.text("I couldn't help but notice, you're covered in fur."),
            next_topic = "TALK_REFUGEE_BEGGAR_5_FUR",
        },
        {
            text = ccb.content.text("You seem like you can hold your own.  Why not travel with me?"),
            next_topic = "TALK_REFUGEE_BEGGAR_5_TRAVEL1",
        },
        {
            text = ccb.content.text("What did you do before <the_cataclysm>?"),
            next_topic = "TALK_REFUGEE_BEGGAR_5_PAST1",
        },
        {
            text = ccb.content.text_without_extraction("<end_talking_leave>"),
            next_topic = "TALK_DONE",
        },
    },
}

ccb.content.define_dialogue_topic {
    id = "TALK_REFUGEE_BEGGAR_5_PAST1",
    line = ccb.content.text("Nothing too exciting.  I was in trade college, learning to be a computer technician.  Those skills aren't too helpful, but when I was a kid I was an Eagle scout.  I learned all kinds of useful stuff about plants and foraging, and that's come in pretty handy."),
    replies = {
        {
            text = ccb.content.text("What about your family, stuff like that?"),
            next_topic = "TALK_REFUGEE_BEGGAR_5_PAST2",
        },
        {
            text = ccb.content.text("Why live out here?"),
            next_topic = "TALK_REFUGEE_BEGGAR_5_TALK2",
        },
        {
            text = ccb.content.text("I couldn't help but notice, you're covered in fur."),
            next_topic = "TALK_REFUGEE_BEGGAR_5_FUR",
        },
        {
            text = ccb.content.text("You seem like you can hold your own.  Why not travel with me?"),
            next_topic = "TALK_REFUGEE_BEGGAR_5_TRAVEL1",
        },
        {
            text = ccb.content.text("Would you like something to eat?"),
            next_topic = "TALK_REFUGEE_BEGGAR_5_FOOD",
        },
        {
            text = ccb.content.text_without_extraction("<end_talking_leave>"),
            next_topic = "TALK_DONE",
        },
    },
}

ccb.content.define_dialogue_topic {
    id = "TALK_REFUGEE_BEGGAR_5_PAST2",
    line = ccb.content.text("I don't want to think about it.  I grew up in Rhode Island, they're still there.  I haven't heard from them since the insanity with the Governor and that secession stuff.  All communication lines got closed off.  I haven't met anyone who knows what happened to the people there but I don't have much hope."),
    replies = {
        {
            text = ccb.content.text("Why don't you go back there?"),
            next_topic = "TALK_REFUGEE_BEGGAR_5_PAST_RETURN",
        },
        {
            text = ccb.content.text("Could you tell me more about what happened with Rhode Island?"),
            next_topic = "TALK_REFUGEE_BEGGAR_5_PAST_RHODE",
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
    id = "TALK_REFUGEE_BEGGAR_5_PAST_RETURN",
    line = ccb.content.text("Same reason as I'm stuck here… it's way too dangerous, for one thing.  Almost a hundred miles, through zombie infested territory, on foot, to get to the shoreline?  No, thank you.  And then, how would I get from the shore to Block Island?  My family moved out there when Dad retired, and I get the impression the ferry probably isn't running anymore.  Even if I got there, I don't know what I'd find, and I think maybe that scares me the most."),
    replies = {
        {
            text = ccb.content.text("Could you tell me more about what happened with Rhode Island?"),
            next_topic = "TALK_REFUGEE_BEGGAR_5_PAST_RHODE",
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
    id = "TALK_REFUGEE_BEGGAR_5_PAST_RHODE",
    line = ccb.content.text("You don't know?  The governor went nuts, like a lot of people did leading up to the end, only he had a lot more power to work with.  One day he just showed up to work with a militia of rowdies and loyalists and staged a coup, taking over the government completely, killing those that opposed him, and moving as many people as he could get behind him onto the islands.  The rumors I've heard is that most of them survived the Cataclysm and are still running the show there, but that seems kind of impossible to me."),
    replies = {
        {
            text = ccb.content.text("Do you think you'd go back and look for your family?"),
            next_topic = "TALK_REFUGEE_BEGGAR_5_PAST_RETURN",
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
    id = "TALK_REFUGEE_BEGGAR_5_TRAVEL1",
    line = ccb.content.gendered_line("Well now, that's quite a kind offer, and I appreciate you looking past my full-body pubic hair.  Sorry though.  I've come to feel sort of responsible for this little gaggle of squatters.  As long as I'm the only one providing for them, I don't think I can leave.", { "speaker" }),
    replies = {
        {
            when = predicates.all({ predicates.any_equal({ "yes", { scope = "speaker", key = "general_recruit_reena_recruited" } }), predicates.any_equal({ "yes", { scope = "speaker", key = "general_recruit_luo_recruited" } }), predicates.any_equal({ "yes", { scope = "speaker", key = "general_recruit_brendan_recruited" } }) }),
            text = ccb.content.text("I've spoken to all your friends, and except for Dave, they're good to go.  Dave wants to stay here.  How about you?"),
            next_topic = "TALK_REFUGEE_BEGGAR_5_TRAVEL2",
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
    id = "TALK_REFUGEE_BEGGAR_5_TRAVEL2",
    line = ccb.content.text("Huh.  Getting those three to sign on to a suicide mission is quite the feat… sounds like you're pretty dedicated to this.  OK, I'm with you.  Let's round up the others and hit the road."),
    on_enter = {
        {
            actions = { actions.set_actor_value("speaker", "general_recruit_beggars_recruited", "yes") },
        },
    },
    replies = {
        {
            text = ccb.content.text("Right.  <lets_go>"),
            next_topic = "TALK_DONE",
            actions = { "follow" },
        },
    },
}
