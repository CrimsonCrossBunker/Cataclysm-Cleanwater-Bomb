local ccb = require("ccb")

ccb.content.define_dialogue_topic {
    id = { "TALK_UICA_VEHICLE_MERCHANT_BUY_VEHICLE_EARTH" },
    line = ccb.content.text("Here's the thing: A while back one of our patrol vehicles got totalled when some junior officers took it for a joy ride.  We are in queue to get a replacement issued to us and High Command just wants the old one broken down for parts.  Well the chief and I agree that's a little wasteful.  So I patched the damn thing back together with the parts we had on hand.  And now we're looking for a way to make it, disappear.  You follow?"),
    replies = {
        {
            text = ccb.content.text("How much do want for it?"),
            next_topic = "TALK_UICA_VEHICLE_MERCHANT_BUY_VEHICLE_EARTH_2",
        },
        { text = ccb.content.text("Maybe later."), next_topic = "TALK_DONE" },
    },
}
