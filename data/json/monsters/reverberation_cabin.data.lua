local ccb = require("ccb")
local predicates = ccb.content.dialogue_predicates
local actions = ccb.content.dialogue_actions

ccb.content.define_monster {
    id = "mon_cabin_tunnel_shadow",
    name = ccb.content.plural_text("languorous spectre", "languorous spectres"),
    description = ccb.content.text("The translucent shape of a cloaked human, crawling upon the ground.  It is featureless, slow, and mumbling words you think you might understand.  Might it speak with you?"),
    default_faction = "nether",
    volume = "120 L",
    mass = "1 kg",
    species = { "NETHER" },
    body_type = "human",
    materials = { "flesh" },
    chat_topics = { "TALK_CABIN_TUNNEL_SHADOW" },
    speed = 10,
    symbol = "s",
    morale = 20,
    aggression = -20,
    aggressive_to_characters = false,
    hp = 100,
    color = "light_gray",
    vision_day = 0,
    vision_night = 100,
    anger_triggers = { "HURT" },
    flags = {
        "SEES", "HEARS", "GOODHEARING", "HAS_MIND", "NOHEAD", "NO_BREATHE", "PATH_AVOID_DANGER",
        "QUIETDEATH", "CONVERSATION",
    },
    armor = { bash = 20, cut = 20, acid = 20, heat = 20, bullet = 20 },
}

ccb.content.define_dialogue_topic {
    id = "TALK_CABIN_TUNNEL_SHADOW",
    line = {
        when = predicates.any_equal({ "yes", { scope = "speaker", key = "shade_sent_to_inner_cabins" } }),
        yes = ccb.content.text("&The creature doesn't pay you any attention."),
        no = ccb.content.text("&The creature rolls slowly onto its back, staring up at you with stark, white eyes.  \"Lay.  Sleep in the earth.  You can leave this place.  You will be safe.\""),
    },
    replies = {
        {
            text = ccb.content.text("Who are you?"),
            next_topic = "TALK_CABIN_TUNNEL_SHADOW_WHO",
            when = predicates.negate(predicates.any_equal({ "yes", { scope = "speaker", key = "shade_sent_to_inner_cabins" } })),
        },
        {
            text = ccb.content.text("[Lay beside the creature]"),
            next_topic = "TALK_CABIN_TUNNEL_SHADOW_SLEEP_1",
            when = predicates.negate(predicates.any_equal({ "yes", { scope = "speaker", key = "shade_sent_to_inner_cabins" } })),
        },
        {
            text = ccb.content.text("[Move away]"),
            next_topic = "TALK_DONE",
            when = predicates.negate(predicates.any_equal({ "yes", { scope = "speaker", key = "shade_sent_to_inner_cabins" } })),
        },
        {
            text = ccb.content.text("…"),
            next_topic = "TALK_DONE",
            when = predicates.any_equal({ "yes", { scope = "speaker", key = "shade_sent_to_inner_cabins" } }),
        },
    },
}

ccb.content.define_dialogue_topic {
    id = "TALK_CABIN_TUNNEL_SHADOW_WHO",
    line = {
        choices = {
            ccb.content.text("&The creature releases a slow, tired sigh.  \"Like you, but not.  We can escape.  Please, we must sleep.  It is the only way.\""),
        },
    },
    replies = {
        {
            text = ccb.content.text("[Lay beside the creature]"),
            next_topic = "TALK_CABIN_TUNNEL_SHADOW_SLEEP_1",
        },
        { text = ccb.content.text("[Move away]"), next_topic = "TALK_DONE" },
    },
}

ccb.content.define_dialogue_topic {
    id = "TALK_CABIN_TUNNEL_SHADOW_SLEEP_1",
    line = {
        choices = {
            ccb.content.text("&You lay beside the shade.  It is comfortable, but also unfamiliar.  You feel like you could stay here forever, though you might not be comfortable."),
        },
    },
    replies = {
        {
            text = ccb.content.text("[Close your eyes]"),
            next_topic = "TALK_CABIN_TUNNEL_SHADOW_SLEEP_2",
            actions = { actions.set_actor_value("speaker", "shade_sent_to_inner_cabins", "yes") },
        },
        {
            text = ccb.content.text("[Stand up]"),
            next_topic = "TALK_CABIN_TUNNEL_SHADOW_SLEEP_NICE_TRY",
            when = predicates.handler("w16b_p_dda_b12e6dcfc828"),
            actions = { actions.set_actor_value("speaker", "shade_sent_to_inner_cabins", "yes") },
        },
        {
            text = ccb.content.text("[Stand up]"),
            next_topic = "TALK_CABIN_TUNNEL_SHADOW_SLEEP_ESCAPE",
            when = predicates.handler("w16b_p_dda_4e415c428af8"),
        },
    },
}

ccb.content.define_dialogue_topic {
    id = "TALK_CABIN_TUNNEL_SHADOW_SLEEP_2",
    line = {
        choices = {
            ccb.content.text("&You close your eyes.  Sleep takes you.  Then, there is light beyond your eyelids, and your mind's eye is flooded with red and gold afterimages."),
        },
    },
    replies = {
        {
            text = ccb.content.text("…"),
            next_topic = "TALK_DONE",
            actions = { actions.handler("w16b_a_dda_552b8eb02578") },
        },
    },
}

ccb.content.define_dialogue_topic {
    id = "TALK_CABIN_TUNNEL_SHADOW_SLEEP_NICE_TRY",
    line = {
        choices = {
            ccb.content.text("&As you move to stand, the shade wipes a hand over your eyes.  Sleep takes you.  Then, there is light beyond your eyelids, and your mind's eye is flooded with red and gold afterimages."),
        },
    },
    replies = {
        {
            text = ccb.content.text("…"),
            next_topic = "TALK_DONE",
            actions = { actions.handler("w16b_a_dda_552b8eb02578") },
        },
    },
}

ccb.content.define_dialogue_topic {
    id = "TALK_CABIN_TUNNEL_SHADOW_SLEEP_ESCAPE",
    line = {
        choices = {
            ccb.content.text("&As you move to stand, you see the shade stir.  A buzzing sensation, neither sight nor sound, fills your senses, then passes.  Was it grabbing you?  Just reaching out to touch you?  You don't know, but you roll out of the way and stand up."),
        },
    },
    replies = { { text = ccb.content.text("…"), next_topic = "TALK_DONE" } },
}
