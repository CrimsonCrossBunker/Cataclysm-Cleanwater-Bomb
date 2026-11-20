local ccb = require("ccb")

ccb.content.define_mission {
    id = "MISSION_GODCO_RUSSELL_TROPHY3",
    name = ccb.content.text("Trophy Hunt III"),
    description = ccb.content.text("Bring one last trophy to Russell Connelly.  Harvest a sting from a bee."),
    goal = "MGOAL_FIND_ITEM",
    difficulty = 3,
    value = 0,
    start = { target = { terrain = "hive", special = "Bee Hive", reveal_radius = 3 } },
    item = "bee_sting",
    item_count = 1,
    origins = { "ORIGIN_SECONDARY" },
    generic_rewards = false,
    dialogue = {
        describe = ccb.content.text("I need your help…"),
        offer = ccb.content.text("It feels like I'm doing this for revenge.  I have one last mission for you.  Ever seen those ginormous bee hives?  Well, I can tell you where the closest one is.  Just kill off one stray bee, harvest its stinger and bring it to me."),
        accepted = ccb.content.text("I wish you the best of luck, may God guide your path."),
        rejected = ccb.content.text("This passion of mine may just be getting to me…"),
        advice = ccb.content.text("If I were you, I'd bring a gun and a butcher knife.  I don't think bug spray work anymore."),
        inquire = ccb.content.text("How is the hunt going, survivor?  Any luck?"),
        success = ccb.content.text("Well, partner, this might just be the end of the road.  I hope you enjoyed it as much as I have.  In the meantime… here's your reward, a handful of icons, that's all I have left.  Spend them all, I think you've deserved it."),
        success_lie = ccb.content.text("You liar!"),
        failure = ccb.content.text("You give up now?  This country fell apart because no one could find a good man to rely on… might as well give up, I guess."),
    },
    -- Native mission phases did not apply the giver opinion (trust +1, value +1).
    finish = {
        actions = {
            { item = "270win_jsp", count = 16 },
            { item = "icon", count = 8 },
            ccb.content.dialogue_actions.add_effect("interlocutor", "hunt_godco_russell", { permanent = true }),
        },
    },
    -- Native mission phases did not apply the giver opinion (anger +1).
    failure = {},
}
