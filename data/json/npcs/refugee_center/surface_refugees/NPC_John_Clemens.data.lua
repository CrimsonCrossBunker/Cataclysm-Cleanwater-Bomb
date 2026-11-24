local ccb = require("ccb")
local predicates = ccb.content.dialogue_predicates
local actions = ccb.content.dialogue_actions

ccb.content.define_npc {
    id = "refugee_JohnClemens",
    unique_name = ccb.content.text("John Clemens"),
    gender = "male",
    suffix = ccb.content.text("Refugee"),
    class = "NC_REFUGEE_John",
    attitude = 0,
    mission = "GUARD",
    chat = "TALK_REFUGEE_John_1",
    faction = "free_merchants",
}

-- John is a pseudonym.  This guy probably lived in a city before the Cataclysm, but now he either thinks he is or pretends to be a cowboy..
ccb.content.define_npc_class {
    id = "NC_REFUGEE_John",
    name = ccb.content.text("Refugee"),
    job_description = ccb.content.text("I'm just trying to survive."),
    common = false,
    strength = { rng = { -1, 2 } },
    dexterity = { rng = { -3, 2 } },
    intelligence = { rng = { -2, 1 } },
    perception = { rng = { -1, 3 } },
    worn = "REFUGEE_John_worn",
    carry = "REFUGEE_John_carried",
    weapon = "REFUGEE_John_wield",
    traits = {
        { group = "NPC_starting_traits" },
        { group = "Appearance_Caucasian" },
        { trait = "NO_BASH" },
        { trait = "RETURN_TO_START_POS" },
    },
    skills = {
        {
            skill = "ALL",
            level = { mul = { { one_in = 3 }, { sum = { { dice = { 2, 2 } }, { rng = { 0, -4 } } } } } },
        },
        { skill = "fabrication", bonus = { rng = { 0, 1 } } },
        { skill = "swimming", bonus = { rng = { 0, 2 } } },
    },
}

-- common talk responses
ccb.content.define_dialogue_topic {
    id = {
        "TALK_REFUGEE_John_2", "TALK_REFUGEE_John_Background", "TALK_REFUGEE_John_Background_cataclysm",
        "TALK_REFUGEE_John_Background_cataclysm2", "TALK_REFUGEE_John_Situation",
    },
    replies = {
        {
            text = ccb.content.text("I'm trying to put a cleanup crew together to tidy up the back room.  Can you help?"),
            when = predicates.all({ predicates.has_mission("MISSION_REFUGEE_Boris_CLEANUP"), predicates.negate(predicates.any_equal({ "yes", { scope = "interlocutor", key = "mission_Boris_mission_1_cleanup_asked" } })) }),
            next_topic = "TALK_REFUGEE_Refuse_Boris_Mission_1",
        },
        {
            text = ccb.content.text("What's your story?"),
            next_topic = "TALK_REFUGEE_John_Background",
        },
        {
            text = ccb.content.text("How are things here?"),
            next_topic = "TALK_REFUGEE_John_Situation",
        },
    },
}

ccb.content.define_dialogue_topic {
    id = "TALK_REFUGEE_John_1",
    line = ccb.content.gendered_line("*turns to look at you, lifting an enormous cowboy hat off his eyes.  He appears to be in the process of growing out a set of bushy muttonchops and a handlebar mustache.  Bright blue eyes peer out from his wrinkled face.  \"Howdy, pardner.  They call me Clemens.  John Clemens.  I'm an ol' cowhand.\"", { "speaker" }),
    on_enter = {
        {
            actions = {
                actions.set_actor_value("speaker", "general_meeting_u_met_John_Clemens", "yes"),
                actions.set_first_topic("TALK_REFUGEE_John_1a"),
            },
        },
    },
    replies = {
        {
            text = ccb.content.text("Nice to meet you, John."),
            next_topic = "TALK_REFUGEE_John_1_firstmeet",
        },
        {
            text = ccb.content.text("Hi John, nice to meet you.  <end_talking_leave>"),
            next_topic = "TALK_DONE",
        },
    },
}

ccb.content.define_dialogue_topic {
    id = "TALK_REFUGEE_John_1a",
    line = ccb.content.gendered_line("*tips his cowboy hat and sets his feet far apart as he faces you.  \"Howdy, pardner.\"", { "speaker" }),
    replies = {
        { text = ccb.content.text("Hi, John.  Got a minute?"), next_topic = "TALK_REFUGEE_John_2" },
        { text = ccb.content.text("Hi John.  <end_talking_leave>"), next_topic = "TALK_DONE" },
    },
}

ccb.content.define_dialogue_topic {
    id = "TALK_REFUGEE_John_1_firstmeet",
    line = ccb.content.text("Nice to meet you too.  I reckon' you got some questions 'bout this place."),
    replies = {
        { text = ccb.content.text("Yeah, I sure do."), next_topic = "TALK_REFUGEE_John_2" },
        {
            text = ccb.content.text_without_extraction("<end_talking_leave>"),
            next_topic = "TALK_DONE",
        },
    },
}

ccb.content.define_dialogue_topic {
    id = "TALK_REFUGEE_John_2",
    line = ccb.content.text("What can I do ya for?"),
    replies = {
        {
            text = ccb.content.text_without_extraction("<end_talking_leave>"),
            next_topic = "TALK_DONE",
        },
    },
}

ccb.content.define_dialogue_topic {
    id = "TALK_REFUGEE_John_Background",
    line = ccb.content.text("My story?  Just a wanderin' cowhand, eatin' dust on the trail.  I settled here for a spell after I came upon some hard times."),
    replies = {
        {
            text = ccb.content.text("You… you do know what's going on here, right?  With the evacuation and stuff?"),
            next_topic = "TALK_REFUGEE_John_Background_cataclysm",
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
    id = "TALK_REFUGEE_John_Background_cataclysm",
    line = ccb.content.text("Course I do, I ain't an idjit.  It's all the folks here c'n talk about."),
    replies = {
        {
            text = ccb.content.text("So what, uh, what happened to you?"),
            next_topic = "TALK_REFUGEE_John_Background_cataclysm2",
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
    id = "TALK_REFUGEE_John_Background_cataclysm2",
    line = ccb.content.text("*looks at you like you're in need of special help.  \"Just what I said.  I'm settled down here for a spell, then goin' back on the road with my sixgun.\""),
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
    id = "TALK_REFUGEE_John_Situation",
    line = {
        when = predicates.handler("dlg_p_dda_f4f8d93f10a9"),
        yes = ccb.content.text("I reckon I've done my job here.  Goan' be time to ride out into the sunset soon, if'n you catch m'drift.\"  He tilts his hat melodramatically.  \"Folks're comin' around to this here new world we live in."),
        no = ccb.content.text("Folks don't like bein' kept from the blue sky for too long.  Cooped up like cattle in a barn… we need pastures to run free, if'n y'get my drift.  'Til we got 'em, it's gonna be tense in here."),
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
