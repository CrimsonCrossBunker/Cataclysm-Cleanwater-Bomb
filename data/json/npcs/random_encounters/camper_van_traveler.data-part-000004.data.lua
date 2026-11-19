local ccb = require("ccb")

-- This should also be included as part of a randomly selected list of backgrounds in the future.
ccb.content.define_dialogue_topic {
    id = "TALK_NPC_CAMPER_VAN_TRAVELER_BACKSTORY",
    line = ccb.content.gendered_line("I used to travel a lot before <the_cataclysm>, and I've had this camper with me for a while now.  I was at home when the riots started, so I grabbed everything I could from my house and hopped in the camper.  I nearly wrecked on my way out of town when some crazy people tried to smash my van, but I made it out.  I've been on the move ever since.", { "interlocutor" }),
    replies = { { text = ccb.content.text_without_extraction("<end_talking>"), next_topic = "TALK_DONE" } },
}
