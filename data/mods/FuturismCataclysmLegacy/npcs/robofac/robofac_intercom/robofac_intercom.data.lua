local ccb = require("ccb")
local predicates = ccb.content.dialogue_predicates

ccb.content.define_dialogue_topic {
    id = "TALK_EXODI_INTERCOM_AUTODOC_B",
    line = {
        when = predicates.handler("dlg_p_futurismcataclysmlegacy_e885f8603cd2"),
        yes = ccb.content.text("&The intercom clicks off and there is a long moment of silence, before it clicks back on again with a new person on the other end.  \"Yes, hello.  Right.  Yes.  Indeed, we have been able to reconstruct the automatic medical device.  Thanks to your efforts, and those of other contractors and Hub scientists, we now understand how the Exodii use neural interfaces to control their mechanical bodies.  We have drawn on that work to develop a new interface for our existing CBM technology.  You can find a new, public medical suite across the street, in the old basement of the weather station - you should be able to find the stairs just inside the entrance.  Please feel free to make use of its services.  As previously discussed, we would like to invite you to join our new program, where select mercenaries will be allowed to field test new cybernetic enhancements.  Doctor Stevens at the facility will give you more information.  In fact, as a reward for your service, we are prepared to install this new interface and its supporting equipment at no charge.\""),
        no = {
            when = predicates.handler("dlg_p_futurismcataclysmlegacy_2ae6dc50d987"),
            yes = ccb.content.text("Our newest project will be ready for field testing within days.  We suggest checking back regularly."),
            no = {
                when = predicates.handler("dlg_p_futurismcataclysmlegacy_107ec80b5824"),
                yes = ccb.content.text("We expect the surgical suite to be ready in approximately one week."),
                no = ccb.content.text("The project is ongoing, and we expect it will take weeks or months until it is ready for testing.  We suggest you check back in next week."),
            },
        },
    },
}

ccb.content.define_dialogue_topic {
    id = "TALK_EXODI_INTERCOM_AUTODOC_B_EXODII_INTERFACE",
    line = ccb.content.text("&The intercom is silent for a long moment, then it clicks off, then back on, with the same voice as before:  \"Interesting.  We'll inform Doc Stevens.  We would be willing to pay you to study this device, whether you wish to participate in the field testing units or not.  Unfortunately, based on our research, this Exodii technology was a complete dead end, with no room for improvement, and it carries significant risks, including cancer and increased risk of internal bleeding.  In fact, that technology has not considered making one exist as a human being at all.  Our improved interface is completely safe and will be of great benefit to u- to mankind.  To boot, it will work with local CBMs and remain compatible with whatever bionic modules we can continue to recover from the Exodii.  We suggest you have Doc Stevens swap it out immediately.\""),
}

ccb.content.define_dialogue_topic {
    id = "TALK_EXODI_INTERCOM_AUTODOC_B_CYBERNETICS_INFO",
    line = ccb.content.text("The Exodii made their \"workers\" out of human beings, each implanted with a computer-brain interface.  This is similar to CBMs technology before the cataclysm, but with more integrated interfaces.  Integrated tools and radios are familiar enough.  We have used that research to develop our own new interface.  Unfortunately, the Exodii interfaces are not particularly advanced or safe, and come with serious cancer risks, among other problems.  In fact, that technology has not considered making one exist as a human being at all.  Our improved interface is completely safe and will be of great benefit to u- to mankind.  To boot, it will work with local CBMs and remain compatible with whatever bionic modules we can continue to recover from the Exodii."),
}
