local ccb = require("ccb")

ccb.content.define_mission {
    id = "MISSION_ROBOFAC_INTERCOM_IVAS",
    name = ccb.content.text("Augmented Reality"),
    description = ccb.content.text("The intercom has asked me to retrieve something called a <color_yellow>Military Visual Augmentation System</color>, which looks like a VR headset.  They're sending me to an in-town office to fetch it.  Use the <color_yellow>ID card</color> to gain access."),
    goal = "MGOAL_NULL",
    destination = "office_warehouse_anduril",
    difficulty = 5,
    value = 0,
    start = {
        target = {
            terrain = "office_warehouse_anduril",
            special = "office_warehouse_anduril",
            reveal_radius = 2,
            random = false,
        },
    },
    finish = {
        item_rewards = { { item = "RobofacCoin", count = 4 } },
        handler = {
            "mark_dialogue_intercom_completed_robofac_intercom_ivas",
            "advance_hub01_completed_missions_by_1",
        },
    },
    origins = { "ORIGIN_SECONDARY" },
    generic_rewards = false,
    dialogue = {
        describe = ccb.content.text("…"),
        offer = ccb.content.text("…"),
        accepted = ccb.content.text("…"),
        rejected = ccb.content.text("…"),
        advice = ccb.content.text("…"),
        inquire = ccb.content.text("…"),
        success = ccb.content.text("…"),
        success_lie = ccb.content.text("…"),
        failure = ccb.content.text("…"),
    },
}
