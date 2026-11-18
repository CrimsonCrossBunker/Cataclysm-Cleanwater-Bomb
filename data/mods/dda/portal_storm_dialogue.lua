local ccb = require("ccb")
local services = ccb.services
local state = require("portal_storm_state")
local travel = require("dimension_travel")
local recorder = require("nre_recorder")
local dungeon = require("portal_storm_dungeon")
local id = services.types.id

ccb.dialogue.register_topic {
    id = "TALK_PORTAL_STORM",
    dynamic_line = "&You feel a presence both inside yourself and somewhere far far away.",
    dynamic_line_translation = {},
    on_enter = function(context)
        local key = "sentinel_TALK_PORTAL_STORM_first_contact"
        if context:speaker_variable_string(key) ~= "yes" then
            recorder.capture(context:speaker())
            travel.set(context:speaker(), key, "yes")
        end
    end,
    responses = {
        {
            text = "Contact it.", text_translation = {},
            topic = "TALK_PORTAL_STORM_CONVERSATION",
        },
        {
            text = "Ignore it.", text_translation = {},
            topic = "TALK_DONE",
        },
    },
}

ccb.dialogue.register_topic {
    id = "TALK_PORTAL_STORM_IGNORE",
    dynamic_line = "If that is what you think you desire.  Take care not to die before you allow yourself to be free.",
    dynamic_line_translation = {},
    responses = {
        {
            text = "Shut out the voice.", text_translation = {},
            topic = "TALK_DONE",
            on_action = function(context)
                travel.set(context:speaker(), "ire", travel.number(context:speaker(), "ire") + 5)
            end,
        },
    },
}

ccb.dialogue.register_topic {
    id = "TALK_PORTAL_STORM_CONVERSATION",
    dynamic_line = "&Something more than a monologue and less than a dialogue occurs.  You can feel it waiting for you to engage it.",
    dynamic_line_translation = {},
    responses = {
        {
            text = "What are you?", text_translation = {},
            topic = "TALK_PORTAL_STORM_WHAT_ARE_YOU",
        },
        {
            text = "What can you do for me?", text_translation = {},
            topic = "TALK_PORTAL_STORM_DO_FOR_ME",
        },
        {
            text = "Leave me alone.", text_translation = {},
            topic = "TALK_PORTAL_STORM_IGNORE",
        },
    },
}

ccb.dialogue.register_topic {
    id = "TALK_PORTAL_STORM_DO_FOR_ME",
    dynamic_line = function(context)
        return context:gendered_text("You are limited.  Here outside there are no limits.  I could free you from your bonds.  Or bring you halfway here to get a taste.", { "speaker" })
    end,
    responses = {
        {
            text = "Free me, would such a thing even be me?", text_translation = {},
            topic = "TALK_PORTAL_STORM_BE_ME",
        },
        {
            text = "What is halfway between us?", text_translation = {},
            topic = "TALK_PORTAL_STORM_HALFWAY",
        },
        {
            text = "Leave me alone.", text_translation = {},
            topic = "TALK_PORTAL_STORM_IGNORE",
        },
    },
}

ccb.dialogue.register_topic {
    id = "TALK_PORTAL_STORM_HALFWAY",
    dynamic_line = "A place with enough rules for your present mind and form to function, and enough freedom to let you bend the rules to your advantage.  It is not safe but neither is your present location.",
    dynamic_line_translation = {},
    responses = {
        {
            text = "I need power more than safety.  Halfway it is.", text_translation = {},
            topic = "TALK_DONE",
            on_action = function(context)
                dungeon.enter(context:speaker())
            end,
        },
        {
            text = "Why stop at halfway?", text_translation = {},
            topic = "TALK_PORTAL_STORM_I_NEED_TO_DO",
        },
        {
            text = "Leave me alone.", text_translation = {},
            topic = "TALK_PORTAL_STORM_IGNORE",
        },
    },
}

ccb.dialogue.register_topic {
    id = "TALK_PORTAL_STORM_WHAT_ARE_YOU",
    dynamic_line = "I am nothing yet.  I am endless potential.  Outside your leaking reality there are fewer rules and more possibility.  I am fertile soil and you could be a seed.",
    dynamic_line_translation = {},
    responses = {
        {
            text = "What could I grow into?", text_translation = {},
            topic = "TALK_PORTAL_STORM_GROW_INTO",
        },
        {
            text = "Leave me alone.", text_translation = {},
            topic = "TALK_PORTAL_STORM_IGNORE",
        },
    },
}

ccb.dialogue.register_topic {
    id = "TALK_PORTAL_STORM_GROW_INTO",
    dynamic_line = function(context)
        return context:gendered_text("Language is too weak to describe it.  You are too limited to understand freedom yet.  What is mortality when time is a choice?  What is weakness when limits are an illusion?  What is up when there is no down, wrong when there is no right?", { "speaker" })
    end,
    responses = {
        {
            text = "Would such a thing even be me?", text_translation = {},
            topic = "TALK_PORTAL_STORM_BE_ME",
        },
        {
            text = "Leave me alone.", text_translation = {},
            topic = "TALK_PORTAL_STORM_IGNORE",
        },
    },
}

ccb.dialogue.register_topic {
    id = "TALK_PORTAL_STORM_BE_ME",
    dynamic_line = "Is a seed a tree?  Are you a fetus?  Growth is change.",
    dynamic_line_translation = {},
    responses = {
        {
            text = "What do you get out of this?", text_translation = {},
            topic = "TALK_PORTAL_STORM_WHAT_DO_YOU_GET",
        },
        {
            text = "Leave me alone.", text_translation = {},
            topic = "TALK_PORTAL_STORM_IGNORE",
        },
    },
}

ccb.dialogue.register_topic {
    id = "TALK_PORTAL_STORM_WHAT_DO_YOU_GET",
    dynamic_line = function(context)
        return context:gendered_text("There is no me.  I don't exist yet, but time is a lie.  The barriers are weak and your presence is potent enough to reflect.  I am the you that said yes.", { "speaker" })
    end,
    responses = {
        {
            text = "What do I need to do?", text_translation = {},
            topic = "TALK_PORTAL_STORM_I_NEED_TO_DO",
        },
        {
            text = "Leave me alone.", text_translation = {},
            topic = "TALK_PORTAL_STORM_IGNORE",
        },
    },
}

ccb.dialogue.register_topic {
    id = "TALK_PORTAL_STORM_I_NEED_TO_DO",
    dynamic_line = "Will it and it will be.",
    dynamic_line_translation = {},
    responses = {
        {
            text = "No ", text_translation = {},
            topic = "TALK_PORTAL_STORM_DO_FOR_ME",
        },
        {
            text = "Will it.  <color_red>'Your gut feels like this is jumping out of a plane without a parachute.'</color>", text_translation = {},
            topic = "TALK_PORTAL_STORM_WILL_IT",
            on_action = function(context)
                state.checked(services.achievements.complete(id("achievement", "escaped_the_cataclysm")))
            end,
        },
        {
            text = "Leave me alone.", text_translation = {},
            topic = "TALK_PORTAL_STORM_IGNORE",
        },
    },
}

ccb.dialogue.register_topic {
    id = "TALK_PORTAL_STORM_WILL_IT",
    dynamic_line = "&You do not exist anymore.  Something else exists elsewhere, and vaguely remembers being you.  Its (torment?/joy?/confusion?/freedom?) will never truly end.",
    dynamic_line_translation = {},
    responses = {
        {
            text = "An ending?  The cataclysm was bad but was this better?", text_translation = {},
            topic = "TALK_DONE",
            on_action = function(context)
                local character = context:speaker()
                state.checked(services.characters.die(character, { final_effect = id("effect", "a_winner_is_u") }))
            end,
        },
    },
}
