local ccb = require("ccb")

ccb.content.define_mission {
    id = "MISSION_OLD_GUARD_REP_5",
    name = ccb.content.text("Assassinate Raider Leader"),
    description = ccb.content.text("The Old Guard have located a Hell's Raiders encampment that is coordinating attacks on the Free Merchants.  Pay them a visit and execute the area leadership."),
    goal = "MGOAL_ASSASSINATE",
    difficulty = 10,
    value = 300000,
    start = {
        target = { terrain = "bandit_camp_1", special = "bandit_camp", reveal_radius = 1, min_distance = 10 },
        map_updates = { { layout = { npc_placements = { { id = "bandit", x = 17, y = 9, target = true } } } } },
        item_rewards = {
            { item = "sw629" },
            { item = "44magnum", count = 17 },
            { item = "western_holster" },
            { item = "badge_marshal" },
        },
        handler = "become_prof_fed",
    },
    origins = { "ORIGIN_SECONDARY" },
    generic_rewards = false,
    followup = "MISSION_OLD_GUARD_REPEATER_BEGIN",
    dialogue = {
        describe = ccb.content.text("We need help…"),
        offer = ccb.content.text("I've located a Hell's Raiders encampment in the region that appears to be coordinating operations against the Free Merchants.  We know almost nothing about the command structure in the 'gang' so I need to send someone in to decapitate the leadership.  The raid will be held under orders of the U.S. Marshals Service and by agreeing to the mission you will become a marshal, swearing to assist the federal government in regaining order."),
        accepted = ccb.content.text("Now repeat after me… I do solemnly swear that I will support and defend the Constitution of the United States against all enemies, foreign and domestic… that I will bear true faith and allegiance to the same… that I take this obligation freely, without any mental reservation or purpose of evasion… and that I will well and faithfully discharge the duties of the office on which I am about to enter.  To establish justice, insure domestic tranquility, provide for the common defense, promote the general welfare and secure the blessings of liberty.  So help me God.  Congratulations Marshal, don't forget your badge and gun.  As a marshal all men or women assisting you are considered deputy marshals so keep them in line."),
        rejected = ccb.content.text("Come back when you get a chance, we could use a few good men."),
        advice = ccb.content.text("I'd recommend having two deputies… it would be a death trap if a single man got surrounded."),
        inquire = ccb.content.text("Has the leadership been dealt with?"),
        success = ccb.content.text("Marshal, you continue to impress us.  We may have some hope of long term survival yet thanks to you."),
        success_lie = ccb.content.text("What good does this do us?"),
        failure = ccb.content.text("It was a lost cause anyways…"),
    },
}
