local ccb = require("ccb")

ccb.content.define_mission {
    id = "MISSION_GODCO_JULIAN_RINGS",
    name = ccb.content.text("The Honeymooners"),
    description = ccb.content.text("Get two wedding rings for Julian."),
    goal = "MGOAL_FIND_ITEM",
    item = "ring_wedding",
    difficulty = 7,
    item_count = 2,
    value = 0,
    -- Native mission phases did not apply the giver opinion (trust +4, value +4).
    finish = {
        item_rewards = { { item = "icon", count = 20 } },
        handler = "set_world_godco_julian_wedding_to_1",
    },
    -- Native mission phases did not apply the giver opinion (anger +4).
    failure = {},
    origins = { "ORIGIN_SECONDARY" },
    followup = "MISSION_GODCO_JULIAN_DRESS",
    generic_rewards = false,
    dialogue = {
        describe = ccb.content.text("Get two wedding rings."),
        offer = ccb.content.text("Olwen and I have been dating for a while now, and I was planning on asking her to marry me.  I never got the chance to buy our rings before <the_cataclysm>, but I think I'll surprise her with some in a few days.  If you could get me two of them, I'll pay a fair price: $50 in icons."),
        accepted = ccb.content.text("Thanks <name_g>, I'm counting on you."),
        rejected = ccb.content.text("I'd mean so much to the both of us, and there's a lot of money involved."),
        advice = ccb.content.text("A jewelry store should have a pair.  If not, I'd check a wedding venue."),
        inquire = ccb.content.text("Have you found the rings?"),
        success = ccb.content.text("Here's the money, as per our terms.  I really do appreciate this."),
        success_lie = ccb.content.text("What good is this?"),
        failure = ccb.content.text("I'll have to look for them myself…"),
    },
}

ccb.content.define_mission {
    id = "MISSION_GODCO_JULIAN_DRESS",
    name = ccb.content.text("The Wedding"),
    description = ccb.content.text("Get a wedding dress for Julian's wedding with Olwen."),
    goal = "MGOAL_FIND_ITEM",
    item = "dress_wedding",
    difficulty = 7,
    value = 0,
    -- Native mission phases did not apply the giver opinion (trust +4, value +4).
    finish = {
        item_rewards = { { item = "icon", count = 25 } },
        handler = "set_world_godco_julian_wedding_to_2",
    },
    -- Native mission phases did not apply the giver opinion (anger +4).
    failure = {},
    origins = { "ORIGIN_SECONDARY" },
    generic_rewards = false,
    dialogue = {
        describe = ccb.content.text("Get a wedding dress."),
        offer = ccb.content.text("Olwen said yes!  I can't thank you enough <name_g>, she was delighted.  I now want to give her a proper wedding like the ones before <the_cataclysm>, but I can't find a good enough dress for her in here.  If you could get me a proper wedding dress, I'll reward you handsomely."),
        accepted = ccb.content.text("Thanks <name_g>, I knew I could count on you."),
        rejected = ccb.content.text("Please!  I only want to give her a beautiful day like she deserves, and if you help me I can pay you like before."),
        advice = ccb.content.text("A mall should have some in exhibition.  If not, I'd check a wedding venue or clothing store."),
        inquire = ccb.content.text("Have you found the dress?"),
        success = ccb.content.text("It's beautiful!  Thank you, she will love it, You are definitely invited to the wedding <name_g>!  I hope to see you there!"),
        success_lie = ccb.content.text("Why would you do this?!"),
        failure = ccb.content.text("Well, thanks for trying…"),
    },
}
