local ccb = require("ccb")

ccb.content.define_mission {
    id = "MISSION_RANCH_DOCTOR_SUPPLIES",
    name = ccb.content.text("Collect Office Supplies"),
    description = ccb.content.text("The doctor needs office supplies to keep track of medical records.  Bring them 10 Book binders and 500 paper."),
    goal = "MGOAL_CONDITION",
    difficulty = 1,
    value = 0,
    origins = { "ORIGIN_SECONDARY" },
    followup = "MISSION_RANCH_DOCTOR_CRUTCHES",
    generic_rewards = false,
    dialogue = {
        describe = ccb.content.text("…"),
        offer = ccb.content.text("…"),
        accepted = ccb.content.text("…"),
        rejected = ccb.content.text("…"),
        advice = ccb.content.text("…"),
        inquire = ccb.content.text("Have you found the supplies yet?"),
        success = ccb.content.text("Thanks!  This should help keep things organized for a while."),
        success_lie = ccb.content.text("…"),
        failure = ccb.content.text("…"),
    },
    finish = {
        map_updates = {
            {
                terrain = "ranch_camp_59",
                layout = {
                    item_group_placements = {
                        {
                            group = "ranch_doctor_filing_cabinets",
                            x = { 5, 8 },
                            chance = 100,
                            y = 0,
                            repetitions = 5,
                            faction = "tacoma_commune",
                        },
                        {
                            group = "ranch_doctor_filing_cabinets",
                            x = { 5, 8 },
                            chance = 100,
                            y = 2,
                            repetitions = 5,
                            faction = "tacoma_commune",
                        },
                    },
                    tile_edits = {
                        {
                            shape = "rectangle",
                            operation = "furniture",
                            id = "f_filing_cabinet",
                            x = 5,
                            y = 0,
                            end_x = 8,
                            end_y = 0,
                        },
                        {
                            shape = "rectangle",
                            operation = "furniture",
                            id = "f_filing_cabinet",
                            x = 5,
                            y = 2,
                            end_x = 8,
                            end_y = 2,
                        },
                    },
                },
            },
        },
        before_rewards = { "deliver_paper_500_items", "deliver_book_binder_10_items" },
        actions = {
            ccb.content.dialogue_actions.set_actor_value("interlocutor", "mission_tacoma_ranch_doctor_completed_supplies", "yes"),
        },
    },
    complete_when = "complete_mission_ranch_doctor_supplies",
}
