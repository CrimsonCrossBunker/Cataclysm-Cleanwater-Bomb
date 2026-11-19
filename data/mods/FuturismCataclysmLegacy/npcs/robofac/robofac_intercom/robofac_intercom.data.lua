local ccb = require("ccb")

ccb.content.define_dialogue_topic {
    id = "TALK_EXODI_INTERCOM_AUTODOC_B_EXODII_INTERFACE",
    line = ccb.content.text("&The intercom is silent for a long moment, then it clicks off, then back on, with the same voice as before:  \"Interesting.  We'll inform Doc Stevens.  We would be willing to pay you to study this device, whether you wish to participate in the field testing units or not.  Unfortunately, based on our research, this Exodii technology was a complete dead end, with no room for improvement, and it carries significant risks, including cancer and increased risk of internal bleeding.  In fact, that technology has not considered making one exist as a human being at all.  Our improved interface is completely safe and will be of great benefit to u- to mankind.  To boot, it will work with local CBMs and remain compatible with whatever bionic modules we can continue to recover from the Exodii.  We suggest you have Doc Stevens swap it out immediately.\""),
}

ccb.content.define_dialogue_topic {
    id = "TALK_EXODI_INTERCOM_AUTODOC_B_CYBERNETICS_INFO",
    line = ccb.content.text("The Exodii made their \"workers\" out of human beings, each implanted with a computer-brain interface.  This is similar to CBMs technology before the cataclysm, but with more integrated interfaces.  Integrated tools and radios are familiar enough.  We have used that research to develop our own new interface.  Unfortunately, the Exodii interfaces are not particularly advanced or safe, and come with serious cancer risks, among other problems.  In fact, that technology has not considered making one exist as a human being at all.  Our improved interface is completely safe and will be of great benefit to u- to mankind.  To boot, it will work with local CBMs and remain compatible with whatever bionic modules we can continue to recover from the Exodii."),
}
