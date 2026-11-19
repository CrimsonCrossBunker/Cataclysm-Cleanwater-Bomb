local ccb = require("ccb")

-- Restore previous dialogue if we ever get multi-story rappelling. If so, make sure to leave at least one elevator as the teleporting elevator trap
ccb.content.define_dialogue_topic {
    id = "MISSION_ROBOFAC_INTERCOM_3_ADVICE_Location",
    line = ccb.content.text("I don't believe I'm cleared to-\"  You hear brief chatter.  \"Apologies; I was mistaken.  The manufacturer was, technically speaking, kept secret from the public.  As a result, it operated using an office tower as a front, and was located underground.  An elevator in the back of the building led to the basement, but it was likely destroyed in the damage and the shaft may well be inaccessible - as a result, you will need to find a way down yourself.  There is a maintenance staircase in the compound, which may provide a means of entry should you be able to find an access card on the premises."),
}

ccb.content.define_dialogue_topic {
    id = {
        "MISSION_ROBOFAC_INTERCOM_3_ADVICE_DANGERS", "MISSION_ROBOFAC_INTERCOM_3_ADVICE_DANGERS_Toxins",
        "MISSION_ROBOFAC_INTERCOM_3_ADVICE_DANGERS_Heat",
    },
    line = ccb.content.text("About that.\"  You hear papers shuffling.  \"Our drones are unable to approach the structure too closely, as a large amount of interference prevents surveillance, but long-distance measurements reveal a high concentration of toxic compounds in the air, as well as densely-clustered heat signatures.  We expect a high concentration of undead, and other dangers are likely."),
    replies = {
        {
            text = ccb.content.text("Toxic compounds?"),
            next_topic = "MISSION_ROBOFAC_INTERCOM_3_ADVICE_DANGERS_Toxins",
        },
        {
            text = ccb.content.text("Tell me about these heat signatures."),
            next_topic = "MISSION_ROBOFAC_INTERCOM_3_ADVICE_DANGERS_Heat",
        },
        {
            text = ccb.content.text("\"Other dangers\" is a little vague.  Do you have anything more substantial?"),
            next_topic = "MISSION_ROBOFAC_INTERCOM_3_ADVICE_DANGERS_Other",
        },
        {
            text = ccb.content.text("Back to the contract itself…"),
            next_topic = "MISSION_ROBOFAC_INTERCOM_3_OFFER_AnythingElse",
        },
    },
}

ccb.content.define_dialogue_topic {
    id = "MISSION_ROBOFAC_INTERCOM_3_ADVICE_DANGERS_Toxins",
    line = ccb.content.text("Correct.  The source of the chemicals is unknown, as is the exact composition; only trace amounts are present in the air itself.  We can, however, extrapolate that something within the ruins is creating highly poisonous emissions.  We do not know how strong these emissions will become, or what form they will take."),
}

ccb.content.define_dialogue_topic {
    id = "MISSION_ROBOFAC_INTERCOM_3_ADVICE_DANGERS_Heat",
    line = ccb.content.text("At the moment, their origin is unclear.  The temperature profile of the building is highly unusual, despite the damage, and is much denser than wandering hordes observed through remote scouting.  A large amount of heat consistent with an extremely high density of organisms appears to be emanating from the basement itself.  We are, unfortunately, in the dark about the cause of this density.  We would advise you remain observant and note down any abnormalities."),
}

ccb.content.define_dialogue_topic {
    id = "MISSION_ROBOFAC_INTERCOM_3_ADVICE_DANGERS_Other",
    line = ccb.content.text("To be specific, there have been anomalous readings that we are unable to explain.  Seismic disturbances have been recorded emanating from the ruins, with a magnitude ranging from two to four, and periodic vocalizations have been documented to exceed 150 decibels.  We are uncertain why or how these phenomena are created."),
    replies = {
        {
            text = ccb.content.text("The more I hear about this, the worse it sounds."),
            next_topic = "MISSION_ROBOFAC_INTERCOM_3_OFFER_Hesitating",
        },
        {
            text = ccb.content.text("Understood."),
            next_topic = "MISSION_ROBOFAC_INTERCOM_3_OFFER_AnythingElse",
        },
    },
}

ccb.content.define_dialogue_topic {
    id = "MISSION_ROBOFAC_INTERCOM_3_OFFER_AnythingElse",
    line = ccb.content.text("Did you have any other concerns?"),
}

ccb.content.define_dialogue_topic {
    id = "MISSION_ROBOFAC_INTERCOM_3_OFFER_Hesitating",
    line = ccb.content.text("Your hesitation is understandable.  Unfortunately, we have already taken all possible measures to obtain data and information remotely, but we are unable to develop our understanding further without a physical presence."),
}

ccb.content.define_dialogue_topic {
    id = "MISSION_ROBOFAC_INTERCOM_3_ACCEPTED",
    line = ccb.content.text("Excellent.  Thank you very much.\"  The intercom recites a series of coordinates.  \"Exercise a great deal of caution.  We do not know what the conditions on the ground are like.  Use your best judgment.  As before, we are willing to offer you better protective gear, if you would like it, we can't know if this mask will be enough without direct field tests."),
    replies = {
        {
            text = ccb.content.text("I would like that gear, yes.  Tell me about it."),
            next_topic = "TALK_ROBOFAC_INTERCOM_BUY_PROTECTIVE_GEAR",
        },
        { text = ccb.content.text("Understood."), next_topic = "TALK_ROBOFAC_INTERCOM_SERVICES" },
    },
}

ccb.content.define_dialogue_topic {
    id = "MISSION_ROBOFAC_INTERCOM_3_COMPLETE",
    line = ccb.content.text("Fantastic.\"  The intercom's tray slides shut, and then opens shortly afterwards with your payment.  \"You have our thanks and our payment."),
    replies = {
        {
            text = ccb.content.text("Do you have any idea what I just went through?"),
            next_topic = "MISSION_ROBOFAC_INTERCOM_3_COMPLETE_1",
        },
        {
            text = ccb.content.text("You certainly gave me a run for my money, I'll say that much."),
            next_topic = "MISSION_ROBOFAC_INTERCOM_3_COMPLETE_1",
        },
        { text = ccb.content.text("Thank you."), next_topic = "TALK_ROBOFAC_INTERCOM_SERVICES" },
    },
}
