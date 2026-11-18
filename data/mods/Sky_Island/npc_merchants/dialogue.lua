local ccb = require("ccb")

local function can_greet(key)
    return function(context)
        return context:speaker_variable_string(key) ~= "yes"
    end
end

local function record_greeting(key)
    return function(context)
        -- Match the native draw from the old one-entry value list.
        ccb.services.random.native_int(0, 0)
        context:set_speaker_variable_string(key, "yes")
    end
end

local function trade(context)
    context:start_trade()
end

ccb.dialogue.register_topic {
    id = "TALK_SI_EXODII_MERCHANT",
    dynamic_line = function()
        return ccb.services.translate("*looks up as you approach the merchant stall with a faint hum of what you guess are motors.  Most of their body is somewhat dingy metal carved with a fine series of characters you don't recognize, but a human face is still visible and they have a blue scarf wrapped around their upper right arm.  They nod at you and gesture to a series of devices spread out on the counter.")
    end,
    responses = function()
        return {
            {
                text = ccb.services.translate("Uh, hi?"),
                topic = "TALK_SI_EXODII_MERCHANT_HELLO",
                condition = can_greet("u_tried_talking_to_si_exodii_cbm_merchant"),
                on_action = record_greeting("u_tried_talking_to_si_exodii_cbm_merchant"),
            },
            {
                text = ccb.services.translate("What've you got for trade?"),
                topic = "TALK_SI_EXODII_MERCHANT",
                on_action = trade,
            },
            {
                text = ccb.services.translate("Later.  <end_talking_leave>"),
                topic = "TALK_DONE",
            },
        }
    end,
}

ccb.dialogue.register_topic {
    id = "TALK_SI_EXODII_MERCHANT_HELLO",
    dynamic_line = function()
        return ccb.services.translate("*looks at you and then touches two metallic knuckles to the side of their forehead.  They wobble their head from side to side and then say, \"┑└┘┝┝┥┯┄╤╨╱╳╲?  ╪╝╚╋┸┲┹╅.\"  When they're done, they look at you and smile.")
    end,
    responses = function()
        return {
            {
                text = ccb.services.translate("Uh, never mind then.  What've you got for trade?  Trade?  *you gesture at the things on the counter*"),
                topic = "TALK_SI_EXODII_MERCHANT",
                on_action = trade,
            },
            {
                text = ccb.services.translate("Bye."),
                topic = "TALK_DONE",
            },
        }
    end,
}

-- Tabani can speak Old English thanks to the phrasebook he has.  His native language is not found on Cataclysm Earth, and so not important.
ccb.dialogue.register_topic {
    id = "TALK_SI_HUMAN_AMMO_MERCHANT",
    dynamic_line = function()
        return ccb.services.translate("*looks at you as you approach the merchant stall.  As you draw near, he looks down and flips through the book he's carrying and when you get close enough, he smiles broadly.  \"Ah, Wes þu hāl, cuma!  Cumaþ and gesēoþ mīne feorma.\"")
    end,
    responses = function()
        return {
            {
                text = ccb.services.translate("Hello!  Nice to see another person up here."),
                topic = "TALK_SI_HUMAN_AMMO_MERCHANT_HELLO",
                condition = can_greet("u_tried_talking_to_si_human_ammo_merchant"),
                on_action = record_greeting("u_tried_talking_to_si_human_ammo_merchant"),
            },
            {
                text = ccb.services.translate("What've you got for trade?"),
                topic = "TALK_SI_HUMAN_AMMO_MERCHANT",
                on_action = trade,
            },
            {
                text = ccb.services.translate("Later.  <end_talking_leave>"),
                topic = "TALK_DONE",
            },
        }
    end,
}

ccb.dialogue.register_topic {
    id = "TALK_SI_HUMAN_AMMO_MERCHANT_HELLO",
    dynamic_line = function()
        return ccb.services.translate("*smiles and nods in a way you recognize as meaning he has no idea what you're saying.")
    end,
    responses = function()
        return {
            {
                text = ccb.services.translate("Well, fine.  What do you have there?  *you point at the counter*"),
                topic = "TALK_SI_HUMAN_AMMO_MERCHANT_TRADE_EXPLANATION",
            },
            {
                text = ccb.services.translate("Bye."),
                topic = "TALK_DONE",
            },
        }
    end,
}

ccb.dialogue.register_topic {
    id = "TALK_SI_HUMAN_AMMO_MERCHANT_TRADE_EXPLANATION",
    dynamic_line = function()
        return ccb.services.translate("*consults his book and says, \"We in ploom dælath, freond.\"")
    end,
    responses = function()
        return {
            {
                text = ccb.services.translate("Alright, well, give me some of that \"ploom\"."),
                topic = "TALK_SI_HUMAN_AMMO_MERCHANT",
                on_action = trade,
            },
            {
                text = ccb.services.translate("Bye."),
                topic = "TALK_DONE",
            },
        }
    end,
}

ccb.dialogue.register_topic {
    id = "TALK_SI_TRIFFID_DECOR_MERCHANT",
    dynamic_line = function()
        return ccb.services.translate("*waves its fronds gently as you approach.")
    end,
    responses = function()
        return {
            {
                text = ccb.services.translate("What."),
                topic = "TALK_SI_TRIFFID_DECOR_MERCHANT_HELLO",
                condition = can_greet("u_tried_talking_to_si_triffid_decor_merchant"),
                on_action = record_greeting("u_tried_talking_to_si_triffid_decor_merchant"),
            },
            {
                text = ccb.services.translate("Okay, sure, I guess we're doing this.  Let's trade."),
                topic = "TALK_SI_TRIFFID_DECOR_MERCHANT",
                on_action = trade,
            },
            {
                text = ccb.services.translate("<end_talking_leave>"),
                topic = "TALK_DONE",
            },
        }
    end,
}

ccb.dialogue.register_topic {
    id = "TALK_SI_TRIFFID_DECOR_MERCHANT_HELLO",
    dynamic_line = function()
        return ccb.services.translate("*waves one frond at a pad of paper on the table.  When you bend down to look at it, you see words in English on it:\n\n\"Greetings, mammal.  I come to trade.  Bring me fruits and seeds.\"")
    end,
    responses = function()
        return {
            {
                text = ccb.services.translate("Well, I guess that sounds fine."),
                topic = "TALK_SI_TRIFFID_DECOR_MERCHANT",
                on_action = trade,
            },
            {
                text = ccb.services.translate("Not at the moment, thanks."),
                topic = "TALK_DONE",
            },
        }
    end,
}
