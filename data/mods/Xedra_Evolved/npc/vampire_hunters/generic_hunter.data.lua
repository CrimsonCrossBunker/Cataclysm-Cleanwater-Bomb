local ccb = require("ccb")
local predicates = ccb.content.dialogue_predicates

-- Generic class for the guards watching the base.  Another variant will be added for those participating in raid missions.
ccb.content.define_npc {
    id = "vampire_hunter_generic_guard",
    suffix = ccb.content.text("hunter"),
    class = "NC_vampire_hunter_generic_guard",
    attitude = 0,
    mission = "NULL",
    chat = "TALK_HUNTER_GENERIC_GUARD",
    faction = "vampire_hunters",
}

-- Basic guard guarding the base.  Can't risk the important non-combattants being killed within the base.
-- Good at combat, but not much else.
ccb.content.define_npc_class {
    id = "NC_vampire_hunter_generic_guard",
    name = ccb.content.text("guard"),
    job_description = ccb.content.text("I keep the place safe."),
    traits = {
        { group = "NPC_starting_traits" },
        { group = "Appearance_demographics" },
        { trait = "NO_BASH" },
        { trait = "RETURN_TO_START_POS" },
    },
    common = false,
    worn = "VAMPIRE_HUNTER_DEFAULT_worn",
    weapon = "VAMPIRE_HUNTER_DEFAULT_CROSSBOW_wield",
    skills = {
        { skill = "rifle", bonus = { rng = { 4, 7 } } },
        { skill = "gun", bonus = { rng = { 4, 7 } } },
        { skill = "melee", bonus = { rng = { 2, 5 } } },
        { skill = "stabbing", bonus = { rng = { 2, 5 } } },
        { skill = "dodge", bonus = { rng = { 2, 5 } } },
    },
}

ccb.content.define_dialogue_topic {
    id = "TALK_HUNTER_GENERIC_GUARD",
    line = {
        choices = {
            {
                when = predicates.has_trait("speaker", "VAMPIRE"),
                yes = ccb.content.text("If you're looking for a cure, you'll find that inside.  If you're not, go away now."),
                no = {
                    choices = {
                        ccb.content.text("I'm not in charge here, you're looking for someone else…"),
                        ccb.content.text("Keep civil or I'll bring the pain."),
                        ccb.content.text("Just on watch, move along."),
                        ccb.content.text("Don't distract me.  I'm on watch."),
                        {
                            when = predicates.conversation_state("daylight"),
                            yes = { choices = { ccb.content.text("Hello.  Welcome to our safe zone.") } },
                            no = {
                                choices = { ccb.content.text("Good evening.  Welcome to our safe zone.") },
                            },
                        },
                        {
                            when = predicates.actor_state("speaker", "male"),
                            yes = {
                                choices = {
                                    ccb.content.text("Sir."),
                                    ccb.content.text("Rough out there, isn't it?"),
                                },
                            },
                            no = {
                                choices = {
                                    ccb.content.text("Ma'am"),
                                    ccb.content.text("Ma'am, you really shouldn't be traveling out there."),
                                },
                            },
                        },
                    },
                },
            },
        },
    },
    replies = { { text = ccb.content.text("Don't mind me…"), next_topic = "TALK_DONE" } },
}
