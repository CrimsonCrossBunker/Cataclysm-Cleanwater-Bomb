local ccb = require("ccb")

ccb.content.define_mission {
    id = "MISSION_GODCO_HELENA_3",
    name = ccb.content.text("Purging Heresy"),
    description = ccb.content.text("Kill some bandits for Helena Misinter."),
    goal = "MGOAL_ASSASSINATE",
    difficulty = 13,
    value = 0,
    start = {
        target = { terrain = "church", special = "church", reveal_radius = 1, random = true },
        map_updates = {
            {
                layout = {
                    npc_placements = {
                        { id = "bandit", x = 15, y = 8, target = true },
                        { id = "thug", x = 12, y = 10, target = true },
                        { id = "bandit", x = 9, y = 13, target = true },
                        { id = "bandit", x = 8, y = 15, target = true },
                        { id = "thug", x = 17, y = 15, target = true },
                    },
                },
            },
        },
    },
    -- Native mission phases did not apply the giver opinion (trust +3, value +2).
    finish = { item_rewards = { { item = "icon", count = 60 } } },
    -- Native mission phases did not apply the giver opinion (anger +4).
    failure = {},
    followup = "MISSION_GODCO_HELENA_4",
    origins = { "ORIGIN_SECONDARY" },
    generic_rewards = false,
    dialogue = {
        describe = ccb.content.text("Purge the heretics."),
        offer = ccb.content.text("Blasphemy, heresy, the righteous judgment of God!  I have found the scum of Hell pillaging a church for valuables!  Even in <the_cataclysm>, I shall not stand for this.  I want you to go there and wipe those <freaking> <name_b>s from the Earth."),
        accepted = ccb.content.text("Righteous judgment shall come!"),
        rejected = ccb.content.text("Are you standing with them?"),
        advice = ccb.content.text("Attack at night to surprise them.  Barring that, go in full force, guns blazing.  I wouldn't try to call a horde in, I don't want to ruin such a holy place."),
        inquire = ccb.content.text("Are the heretics purged?"),
        success = ccb.content.text("Thank you."),
        success_lie = ccb.content.text("Why have you failed us?!"),
        failure = ccb.content.text("As expected of such a person…"),
    },
}
