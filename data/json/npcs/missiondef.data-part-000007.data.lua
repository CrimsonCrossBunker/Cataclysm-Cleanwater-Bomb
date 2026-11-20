local ccb = require("ccb")

ccb.content.define_mission {
    id = "MISSION_GET_HOLY_SYMBOL",
    name = ccb.content.text("Find a Holy Symbol"),
    goal = "MGOAL_FIND_ITEM",
    difficulty = 2,
    value = 100000,
    item = "holy_symbol",
    start = {
        reveal_terrain = { "church_1" },
        actions = { ccb.content.dialogue_actions.remove_items("interlocutor", "holy_symbol") },
    },
    origins = { "ORIGIN_OPENER_NPC", "ORIGIN_ANY_NPC" },
    followup = "MISSION_GET_RELIC",
    dialogue = {
        describe = ccb.content.text("Any variant is fine, I am not that choosy…"),
        offer = ccb.content.text("The sky has torn apart and creatures beyond our wildest imaginations lurk in the dark now.  I beg you, find me a holy symbol.  Maybe some faith can help me sleep better at night."),
        accepted = ccb.content.text("May whatever god or spirits that now reign the world protect you."),
        rejected = ccb.content.text("I guess the stress may just be getting to me…"),
        advice = ccb.content.text("A church must be full of them and who knows, maybe some of those <zombies> carry some.  But please, do not waste your time making one yourself."),
        inquire = ccb.content.text("Any luck?  Please find me a holy symbol.  Any of them will do."),
        success = ccb.content.text("Thank the heavens."),
        success_lie = ccb.content.text("What good does this do me?"),
        failure = ccb.content.text("It was a lost cause anyways…"),
    },
}
