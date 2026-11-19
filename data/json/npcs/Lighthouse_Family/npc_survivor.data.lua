local ccb = require("ccb")
local predicates = ccb.content.dialogue_predicates
local actions = ccb.content.dialogue_actions

-- Could use more variety.
ccb.content.define_dialogue_topic {
    id = "TALK_LIGHTHOUSE_SURVIVOR1",
    line = {
        joined = {
            {
                choices = {
                    ccb.content.gendered_line("During one of my night searches of food and supplies, I noticed a bright glow that came from somewhere far away.  I thought that one of the survivors had lit it to indicate their location.  As you can see, I was right.  I managed to find a boat near the nearest shore, on which I set sail.", { "interlocutor" }),
                    ccb.content.gendered_line("I have been sailing on my little boat from coast to coast for a long time.  In truth, the boat was not entirely mine, but it doesn't matter.  That way of life provided me with sufficient safety from the <zombies>, and I managed to get around the sea creatures deftly.  When I saw a distant light, at first, I could not believe my eyes.  Then, I decided to find out what it is.", { "interlocutor" }),
                },
            },
            {
                choices = {
                    ccb.content.gendered_line("  Unfortunately, during my 'voyage' to this lighthouse, luck turned away from me.  I was attacked by some dreadful creature from the underwater depths.  I couldn't fight off him and he dragged my ship to the bottom.  The waves brought me straight to the shore of this little island.  I still don't understand by what miracle I managed to survive, <name_g>.", { "interlocutor" }),
                    ccb.content.gendered_line("  Unfortunately, when I arrived here, I forgot to tie my boat, and during yesterday's storm it was carried off somewhere.  Well, you don't always have to be lucky, right?", { "interlocutor" }),
                    ccb.content.gendered_line("  I sailed here a few days ago.  Mikhail and his family are very hospitable.  Unfortunately, during our joint fishing, we were attacked by a swarm of underwater abominations, and my boat was smashed to pieces.  It was so scary, we could barely sail away on Mikhail's ship.", { "interlocutor" }),
                },
            },
        },
    },
    replies = {
        {
            text = ccb.content.text("I'm glad you are OK."),
            next_topic = "TALK_STRANGER_FRIENDLY",
            actions = { actions.set_first_topic("TALK_STRANGER_FRIENDLY") },
        },
    },
}
