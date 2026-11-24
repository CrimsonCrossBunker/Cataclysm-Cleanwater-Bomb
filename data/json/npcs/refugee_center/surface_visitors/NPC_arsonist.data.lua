local ccb = require("ccb")
local predicates = ccb.content.dialogue_predicates

-- Appears in the refugee center as a unique trader and potential mission provider.
ccb.content.define_npc {
    id = "arsonist",
    unique_name = ccb.content.text("Makayla Sanchez"),
    suffix = ccb.content.text("Arsonist"),
    gender = "female",
    class = "NC_ARSONIST",
    attitude = 0,
    mission = "SHOPKEEP",
    age = 24,
    height = 165,
    chat = "TALK_ARSONIST",
    faction = "no_faction",
    missions_offered = "MISSION_ARSONIST_1_AMMONIUM_NITRATE",
}

ccb.content.define_npc_class {
    id = "NC_ARSONIST",
    name = ccb.content.text("Arsonist"),
    job_description = ccb.content.text("I'm just watching the world burn."),
    common = false,
    traits = {
        { group = "BG_survival_story_CRIMINAL" },
        { trait = "hair_long_over_eye", variant = "brown" },
        { trait = "natural_hair_color_brown" },
        { trait = "eye_color", variant = "blue" },
        { trait = "SKIN_LIGHT" },
        { trait = "QUICK" },
        { trait = "FASTHEALER" },
        { trait = "OPTIMISTIC" },
        { trait = "FELINE_EARS" },
        { trait = "MAKAYLA_MUTATOR" },
    },
    dexterity = { rng = { 2, 2 } },
    intelligence = { rng = { 1, 1 } },
    perception = { rng = { 2, 2 } },
    aggression = { rng = { 0, 1 } },
    collector = { rng = { 0, 2 } },
    shop_groups = "NC_ARSONIST_STOCK",
    price_rules = {
        { item = "FMCNote", fixed_adjustment = 0 },
        { item = "money_strap_FMCNote", fixed_adjustment = 0 },
        { item = "money_bundle_FMCNote", fixed_adjustment = 0 },
    },
    carry = "NC_ARSONIST_STOCK",
    worn = "NC_ARSONIST_worn",
    skills = {
        { skill = "firstaid", bonus = 3 },
        { skill = "cooking", bonus = 5 },
        { skill = "fabrication", bonus = 5 },
        { skill = "survival", bonus = 2 },
        { skill = "melee", bonus = 5 },
        { skill = "bashing", bonus = 4 },
        { skill = "gun", bonus = 4 },
        { skill = "pistol", bonus = 4 },
        { skill = "throw", bonus = 6 },
        { skill = "swimming", bonus = 3 },
        { skill = "driving", bonus = 3 },
        { skill = "speech", bonus = 3 },
    },
}

ccb.content.define_dialogue_topic {
    id = "TALK_ARSONIST",
    line = {
        when = predicates.wears("speaker", "badge_marshal"),
        yes = ccb.content.text("That sure is a shiny badge you got there!"),
        no = ccb.content.text("Heh, you look important."),
    },
    replies = {
        {
            text = ccb.content.text("I'm actually new."),
            next_topic = "TALK_ARSONIST_NEW",
        },
        {
            text = ccb.content.text("What are you doing here?"),
            next_topic = "TALK_ARSONIST_DOING",
        },
        {
            text = ccb.content.text("Heard anything about the outside world?"),
            next_topic = "TALK_ARSONIST_WORLD",
        },
        {
            text = ccb.content.text("Is there any way I can join your group?"),
            next_topic = "TALK_ARSONIST_JOIN",
        },
        {
            text = ccb.content.text("Do you have any jobs for me?"),
            next_topic = "TALK_MISSION_LIST",
        },
        {
            text = ccb.content.text("What's with your ears?"),
            next_topic = "TALK_ARSONIST_MUTATION",
            when = predicates.handler("dlg_p_dda_e3eb48cfc8df"),
        },
        {
            text = ccb.content.text("How are you doing these days?"),
            next_topic = "TALK_ARSONIST_TRADING",
            when = predicates.any_equal({ "yes", { scope = "speaker", key = "talk_flag_TALK_ARSONIST_SUPPLIED" } }),
        },
        {
            text = ccb.content.text("<end_talking_bye>"),
            next_topic = "TALK_DONE",
        },
    },
}

ccb.content.define_dialogue_topic {
    id = "TALK_ARSONIST_NEW",
    line = ccb.content.text("Guess that makes two of us.  Well, kind of.  I don't think we're open, though.  Full up as hell; it's almost a crowd downstairs.  Did you see the trader at the entrance?  There's the one to ask."),
    replies = { { text = ccb.content.text("Sucks…"), next_topic = "TALK_ARSONIST" } },
}

ccb.content.define_dialogue_topic {
    id = "TALK_ARSONIST_DOING_REBAR",
    line = ccb.content.text("Well, there's a guy downstairs who got a working pneumatic cannon.  It shoots metal like… like a cannon without the bang.  Cost-efficient as hell.  And there's no shortage of improvised weapons you can make.  The big thing though, seems to be continuing construction of fortifications.  Very few of those monsters seem to be able to break through a fence or wall constructed with the stuff."),
    replies = { { text = ccb.content.text("Well, then…"), next_topic = "TALK_ARSONIST" } },
}

ccb.content.define_dialogue_topic {
    id = "TALK_ARSONIST_WORLD",
    line = ccb.content.text("Nothing optimistic, at least.  Had a pal on the road with a ham radio, but she's gone and so is that thing.  Kaput."),
    replies = {
        { text = ccb.content.text("…"), next_topic = "TALK_ARSONIST" },
        {
            text = ccb.content.text("Nothing optimistic?"),
            next_topic = "TALK_ARSONIST_WORLD_OPTIMISTIC",
        },
    },
}

ccb.content.define_dialogue_topic {
    id = "TALK_ARSONIST_WORLD_OPTIMISTIC",
    line = ccb.content.text("Most of the emergency camps have dissolved by now.  The cities are mobbed, the forests crawling with glowing eyes and zombies.  Some insane shit out there, and everyone with a radio seems to feel like documenting their last awful moments."),
    replies = { { text = ccb.content.text("I feel bad for asking."), next_topic = "TALK_ARSONIST" } },
}

ccb.content.define_dialogue_topic {
    id = "TALK_ARSONIST_JOIN",
    line = ccb.content.text("I don't know.  I mean, if you can make yourself useful.  But that's become a real hazy thing nowadays.  It depends who you ask.  The merchant definitely doesn't want me here when I'm not selling, but… some people get away with it."),
    replies = { { text = ccb.content.text("…"), next_topic = "TALK_ARSONIST" } },
}

ccb.content.define_dialogue_topic {
    id = "TALK_ARSONIST_MUTATION",
    line = {
        when = predicates.has_any_trait("speaker", { "CANINE_EARS", "LUPINE_EARS", "FELINE_EARS", "URSINE_EARS", "ELFA_EARS" }),
        yes = ccb.content.text("Same way you got yours, I bet.  Keep quiet about it, some people here look down on people like us."),
        no = ccb.content.text("Ssh.  Some people in here hate… mutations.  This was an accident."),
    },
    replies = {
        { text = ccb.content.text("Sorry to ask."), next_topic = "TALK_ARSONIST" },
        {
            text = ccb.content.text("You're disgusting."),
            next_topic = "TALK_ARSONIST_MUTATION_INSULT",
        },
    },
}

ccb.content.define_dialogue_topic {
    id = "TALK_ARSONIST_DOING",
    line = ccb.content.text("I burn down buildings and sell the Free Merchants the materials.  No, seriously.  If you've seen burned wreckage in place of suburbs or even see the pile of rebar for sale, that's probably me.  They've kept me well off in exchange, I guess."),
    replies = {
        {
            text = ccb.content.text("I'll buy."),
            native_actions = { "start_trade" },
            next_topic = "TALK_ARSONIST",
        },
        { text = ccb.content.text("Who needs rebar?"), next_topic = "TALK_ARSONIST_DOING_REBAR" },
    },
}

ccb.content.define_mission {
    id = "MISSION_ARSONIST_1_AMMONIUM_NITRATE",
    name = ccb.content.text("Supply the arsonist"),
    description = ccb.content.text("Bring the arsonist 120 units of commercial fertilizer."),
    difficulty = 1,
    value = 500,
    origins = { "ORIGIN_SECONDARY" },
    goal = "MGOAL_FIND_ITEM",
    item = "fertilizer_commercial",
    item_count = 120,
    dialogue = {
        describe = ccb.content.text("I could use some help getting some materials."),
        offer = ccb.content.text("I could use some help getting some materials.  Molotovs are nice for burning down buildings but aren't all that for keeping yourself safe.  If you could get me 120 units of commercial fertilizer I could make something a lot more potent."),
        accepted = ccb.content.text("Oh man, thanks so much friend.  You won't regret it."),
        rejected = ccb.content.text("Think it over."),
        advice = ccb.content.text("Commercial fertilizer tends to be made from ammonium nitrate, which is also usable as an explosive.  Try looking for some around the abandoned farms."),
        inquire = ccb.content.text("Did you find any fertilizer?  Are you sure this is the ammonium nitrate kind?"),
        success = ccb.content.text("This is great!  I'll get to work making something of this.  You can have some of my Molotovs, I won't need quite so many now."),
        success_lie = ccb.content.text("I guess I could convince the shelter to sell me some."),
        failure = ccb.content.text("Damn.  Perhaps I wasn't the only one who thought of this."),
    },
    finish = {
        handler = "mark_talk_flag_TALK_ARSONIST_SUPPLIED",
        item_rewards = { { item = "molotov", count = 10 } },
    },
}

ccb.content.define_dialogue_topic {
    id = "TALK_ARSONIST_TRADING",
    line = ccb.content.text("I made some nice things with that ammonium nitrate you got me.  Want to trade?"),
    replies = {
        {
            text = ccb.content.text("I'll buy."),
            native_actions = { "start_trade" },
            next_topic = "TALK_ARSONIST",
        },
    },
}

ccb.content.define_dialogue_topic {
    id = "TALK_ARSONIST_MUTATION_INSULT",
    line = {
        when = predicates.has_any_trait("speaker", { "CANINE_EARS", "LUPINE_EARS", "FELINE_EARS", "URSINE_EARS", "ELFA_EARS" }),
        yes = ccb.content.gendered_line("As if you're one to talk.  Screw You.", { "speaker" }),
        no = ccb.content.gendered_line("Screw You!", { "speaker" }),
    },
    replies = {
        {
            text = ccb.content.text("…"),
            success = {
                native_actions = { "end_conversation" },
                opinion = { trust = -1, fear = -2, value = -1, anger = 1 },
                next_topic = "TALK_DONE",
            },
        },
    },
}
