local ccb = require("ccb")

-- Beds in the barn
-- Beds in the barn
ccb.content.define_mission {
    id = "MISSION_RANCH_FOREMAN_2",
    name = ccb.content.text("Find 25 Blankets"),
    goal = "MGOAL_CONDITION",
    difficulty = 5,
    value = 50000,
    origins = { "ORIGIN_SECONDARY" },
    generic_rewards = false,
    followup = "MISSION_RANCH_FOREMAN_3",
    dialogue = {
        describe = ccb.content.text("We need help…"),
        offer = ccb.content.text("With the barn entrances enclosed, the refugees moving in there should feel safer, but the weather can be bitter here.  We're going to need to build makeshift beds in the stalls to ward off disease and frostbite.  We can take care of the frames, but will need your help looting blankets.  We'd need 25 blankets to provide the most basic sleeping accommodations."),
        accepted = ccb.content.text("I'd start with looting hotels or you could sew them together… but that would be a last resort."),
        rejected = ccb.content.text("Come back when you get a chance.  We need skilled survivors."),
        advice = ccb.content.text("Avoid destroying the furniture here, we'll be needing it."),
        inquire = ccb.content.text("Do you have them?"),
        success = ccb.content.text("Your assistance is always appreciated."),
        success_lie = ccb.content.text("What good does this do us?"),
        failure = ccb.content.text("It was a lost cause anyways…"),
    },
    finish = {
        map_updates = {
            {
                terrain = "ranch_camp_65",
                layout = {
                    nested = {
                        { x = 18, y = 1, id = "tacoma_commune_makeshift_bed" },
                        { x = 18, y = 5, id = "tacoma_commune_makeshift_bed" },
                        { x = 18, y = 7, id = "tacoma_commune_makeshift_bed" },
                        { x = 18, y = 11, id = "tacoma_commune_makeshift_bed" },
                        { x = 18, y = 13, id = "tacoma_commune_makeshift_bed" },
                        { x = 18, y = 17, id = "tacoma_commune_makeshift_bed" },
                        { x = 18, y = 19, id = "tacoma_commune_makeshift_bed" },
                        { x = 18, y = 23, id = "tacoma_commune_makeshift_bed" },
                    },
                },
            },
            {
                terrain = "ranch_camp_66",
                layout = {
                    nested = {
                        { x = 19, y = 1, id = "tacoma_commune_makeshift_bed" },
                        { x = 19, y = 5, id = "tacoma_commune_makeshift_bed" },
                        { x = 19, y = 7, id = "tacoma_commune_makeshift_bed" },
                        { x = 19, y = 11, id = "tacoma_commune_makeshift_bed" },
                        { x = 19, y = 13, id = "tacoma_commune_makeshift_bed" },
                        { x = 19, y = 17, id = "tacoma_commune_makeshift_bed" },
                        { x = 19, y = 19, id = "tacoma_commune_makeshift_bed" },
                        { x = 19, y = 23, id = "tacoma_commune_makeshift_bed" },
                        { x = 9, y = 1, id = "tacoma_commune_makeshift_bed" },
                        { x = 9, y = 5, id = "tacoma_commune_makeshift_bed" },
                        { x = 9, y = 19, id = "tacoma_commune_makeshift_bed" },
                        { x = 9, y = 23, id = "tacoma_commune_makeshift_bed" },
                        { x = 4, y = 1, id = "tacoma_commune_makeshift_bed" },
                        { x = 4, y = 5, id = "tacoma_commune_makeshift_bed" },
                        { x = 4, y = 19, id = "tacoma_commune_makeshift_bed" },
                        { x = 4, y = 23, id = "tacoma_commune_makeshift_bed" },
                    },
                    npc_placements = { { id = "ranch_construction_2", x = 19, y = 8 } },
                },
            },
        },
        handler = "deliver_mission_ranch_foreman_2",
    },
    complete_when = "complete_mission_ranch_foreman_2",
}
