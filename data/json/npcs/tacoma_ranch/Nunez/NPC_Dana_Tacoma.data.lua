local ccb = require("ccb")
local predicates = ccb.content.dialogue_predicates
local actions = ccb.content.dialogue_actions

ccb.content.define_npc {
    id = "tacoma_DanaNunez",
    unique_name = ccb.content.text("Dana Nunez"),
    gender = "female",
    suffix = ccb.content.text("baker"),
    class = "NC_TACOMA_Dana",
    attitude = 0,
    mission = "GUARD",
    chat = "TALK_TACOMA_Dana_1",
    faction = "free_merchants",
    age = 26,
    height = 164,
    strength = 8,
    dexterity = 9,
    intelligence = 9,
    perception = 11,
    personality = { aggression = -2, bravery = -1, collector = 1, altruism = 4 },
}

-- Dana is a young woman who survived with her husband, but she was pregnant and lost the baby.  This class def is for after she moves to Tacoma.
ccb.content.define_npc_class {
    id = "NC_TACOMA_Dana",
    name = ccb.content.text("baker"),
    job_description = ccb.content.text("I'm just trying to survive."),
    common = false,
    worn = "TACOMA_Dana_worn",
    carry = "TACOMA_Dana_carried",
    weapon = "EMPTY_GROUP",
    traits = {
        { trait = "PAINRESIST" },
        { trait = "MYOPIC" },
        { trait = "NO_BASH" },
        { trait = "RETURN_TO_START_POS" },
        { trait = "hair_ponytail", variant = "red" },
        { trait = "SKIN_LIGHT" },
        { trait = "eye_color", variant = "blue" },
    },
    skills = {
        { skill = "cooking", bonus = 6 },
        { skill = "cutting", bonus = 3 },
        { skill = "driving", bonus = 2 },
        { skill = "fabrication", bonus = 1 },
        { skill = "melee", bonus = 3 },
        { skill = "speech", bonus = 1 },
        { skill = "survival", bonus = 1 },
        { skill = "unarmed", bonus = 1 },
    },
}

ccb.content.define_dialogue_topic {
    id = "TALK_TACOMA_Dana_1",
    line = ccb.content.gendered_line("*stands in the middle of a cramped kitchen, covered in flour.  The scene looks reminiscent of easier times, but the illusion is broken as he apron shifts to reveal a heavy machete and holstered pistol on her belt.  She looks up as you approach, then beams in recognition.  \"Welcome to Dana's Bakery, stranger!\"  She laughs brightly.  \"Glad you made out this way.  What can I do for you?\"", { "speaker" }),
    replies = {
        {
            text = ccb.content.text("Hi Dana, how are things here?"),
            next_topic = "TALK_TACOMA_Dana_2",
        },
        {
            text = ccb.content.text("Got any bread for sale?"),
            next_topic = "TALK_TACOMA_Dana_Baking",
        },
        {
            text = ccb.content.text("Hello, Dana!  What's with the trailer?"),
            next_topic = "TALK_TACOMA_Dana_Trailer1",
        },
        {
            text = ccb.content.text("Hey, Pablo!  Dana said you had some plans to build a bakery?"),
            next_topic = "TALK_TACOMA_Dana_Bakery1",
            when = predicates.any_equal({ "knows", { scope = "speaker", key = "knowledge_tacoma_bakery" } }),
        },
        {
            text = ccb.content.text("Nice to see you Dana, I'm just checking in."),
            next_topic = "TALK_DONE",
        },
    },
}

ccb.content.define_dialogue_topic {
    id = "TALK_TACOMA_Dana_2",
    line = ccb.content.text("Not bad.  Much better than before.  Pablo and I have privacy, and the folks here actually appreciate my bread instead of paying me a pittance for it and then taking it to the basement without so much as a 'thanks'."),
    replies = {
        {
            text = ccb.content.text("What's with the trailer?"),
            next_topic = "TALK_TACOMA_Dana_Trailer1",
        },
        {
            text = ccb.content.text("Any luck with the pregnancy?"),
            next_topic = "TALK_TACOMA_Dana_Pregnancy",
            when = predicates.any_equal({ "knows", { scope = "speaker", key = "knowledge_dana_pregnancy" } }),
        },
        {
            text = ccb.content.text("<end_talking_leave>  <end_talking_bye>"),
            next_topic = "TALK_DONE",
        },
    },
}

-- Remainder of this topic is stored in npcs/surface_refugees/NPC_Dana_Nunez.json with her other refugee talk_topics.
ccb.content.define_dialogue_topic {
    id = "TALK_TACOMA_Dana_Baking",
    replies = {
        {
            text = ccb.content.text("I'll look into that.  <done_conversation_section>"),
            next_topic = "TALK_NONE",
        },
        {
            text = ccb.content.text("I'll look into that.  <end_talking_leave>"),
            next_topic = "TALK_DONE",
        },
    },
}

ccb.content.define_dialogue_topic {
    id = "TALK_TACOMA_Dana_Trailer1",
    line = ccb.content.text("Ha, this thing!\"  She dusts the flour off her hands and tucks a loose lock of hair back behind her ear.  \"You remember, we signed on as caravan hands to get us out here.  Well, we had a bunch of stops along the way first.  We were headed to a little group of survivors that snagged themselves a huge stock of dry food somehow, and passed this trailer sales yard smack dab in the middle of nowhere, nobody to be seen for miles.  Pablo managed to sweet talk the group into taking a rest stop there.  We searched the yard, and a lot of the stuff wasn't suitable, but this baby was ready to go.  Long story short, we got the keys to that vintage truck outside, hitched this thing up, and upgraded our caravan."),
    replies = {
        {
            text = ccb.content.text("How did you get the keys to the truck?"),
            next_topic = "TALK_TACOMA_Dana_TrailerKeys",
        },
        {
            text = ccb.content.text("What made this trailer so good?"),
            next_topic = "TALK_TACOMA_Dana_Trailer2",
        },
        {
            text = ccb.content.text("Any luck with the pregnancy?"),
            next_topic = "TALK_TACOMA_Dana_Pregnancy",
            when = predicates.any_equal({ "knows", { scope = "speaker", key = "knowledge_dana_pregnancy" } }),
        },
        {
            text = ccb.content.text("<end_talking_leave>  <end_talking_bye>"),
            next_topic = "TALK_DONE",
        },
    },
}

ccb.content.define_dialogue_topic {
    id = "TALK_TACOMA_Dana_TrailerKeys",
    line = ccb.content.text("*turns serious.  \"We went inside the dealership to see if they were there.  Owner was still in there.  I… I think he took his own life, maybe figured destroying the brain would keep him from reviving.  It… it didn't.  The shotgun took out enough though, he couldn't, uh, he couldn't really see.  Just this miserable, half-faced… we put him down.  I think we did him a favor, if there was any of him left in there.  Didn't feel wrong going through his pockets.  Gross, but not wrong.\"  She blows out a stream of air, sending a small cloud of flour rising in the air, then shrugs."),
    replies = {
        {
            text = ccb.content.text("What made this trailer so good?"),
            next_topic = "TALK_TACOMA_Dana_Trailer2",
        },
        {
            text = ccb.content.text("<end_talking_leave>  <end_talking_bye>"),
            next_topic = "TALK_DONE",
        },
    },
}

ccb.content.define_dialogue_topic {
    id = "TALK_TACOMA_Dana_Trailer2",
    line = ccb.content.text("It's all propane!\"  She grins.  \"The oven, especially.  We don't need electric, which means we don't need to run the gennie and attract attention."),
    replies = {
        {
            text = ccb.content.text("Seems like a tiny kitchen for a bakery."),
            next_topic = "TALK_TACOMA_Dana_Trailer3",
        },
        {
            text = ccb.content.text("Won't you run out of propane?"),
            next_topic = "TALK_TACOMA_Dana_TrailerPropane",
            when = predicates.negate(predicates.any_equal({ "knows", { scope = "speaker", key = "knowledge_propane_scavenging" } })),
        },
        {
            text = ccb.content.text("<end_talking_leave>  <end_talking_bye>"),
            next_topic = "TALK_DONE",
        },
    },
}

ccb.content.define_dialogue_topic {
    id = "TALK_TACOMA_Dana_Trailer3",
    line = ccb.content.text("*sighs and nods.  \"Making do with what I've got, but yeah.  I can only crank out a couple loaves a day, and can't do anything fun.  Pablo has been talking about setting me up a separate kitchen to really get going, but we've got so much critical work to do, and fresh bread is a luxury, even if it's great for morale.\""),
    on_enter = { { actions = { actions.set_actor_value("speaker", "knowledge_tacoma_bakery", "knows") } } },
    replies = {
        {
            text = ccb.content.text("Seems like a tiny kitchen for a bakery."),
            next_topic = "TALK_TACOMA_Dana_Trailer3",
        },
        {
            text = ccb.content.text("Any luck with the pregnancy?"),
            next_topic = "TALK_TACOMA_Dana_Pregnancy",
            when = predicates.any_equal({ "knows", { scope = "speaker", key = "knowledge_dana_pregnancy" } }),
        },
        {
            text = ccb.content.text("<end_talking_leave>  <end_talking_bye>"),
            next_topic = "TALK_DONE",
        },
    },
}

ccb.content.define_dialogue_topic {
    id = "TALK_TACOMA_Dana_TrailerPropane",
    line = ccb.content.text("You bet we will.  We've been collecting tanks and have enough for a while, but I'm burning through it faster than the scavengers can bring in more.  Pablo is working out some plans with the others to get me a real wood fired kitchen soon, and that'll also boost my capacity.  Maybe he could give you some scavenging work if you ask."),
    on_enter = {
        {
            actions = { actions.set_actor_value("speaker", "knowledge_propane_scavenging", "knows") },
        },
    },
    replies = {
        {
            text = ccb.content.text("Seems like a tiny kitchen for a bakery."),
            next_topic = "TALK_TACOMA_Dana_Trailer3",
        },
        {
            text = ccb.content.text("<end_talking_leave>  <end_talking_bye>"),
            next_topic = "TALK_DONE",
        },
    },
}

ccb.content.define_dialogue_topic {
    id = "TALK_TACOMA_Dana_Pregnancy",
    line = ccb.content.text("*shrugs.  \"We got our hands on a few boxes of test strips so that's good.  Being stressed isn't good for conception and I've been pretty fuckin' stressed for a while.  I like our chances a lot better now, that's for sure.  And, well, we've got our own private space at least.\"  She smirks and then blushes slightly, hiding it by fiddling with her baking project."),
    replies = {
        {
            text = ccb.content.text("What's with the trailer?"),
            next_topic = "TALK_TACOMA_Dana_Trailer1",
        },
        {
            text = ccb.content.text("<end_talking_leave>  <end_talking_bye>"),
            next_topic = "TALK_DONE",
        },
    },
}
