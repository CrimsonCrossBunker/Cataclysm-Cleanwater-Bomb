local ccb = require("ccb")

ccb.content.define_mission {
    id = "MISSION_RANCH_DOCTOR_MEDICAL_GLOVES",
    name = ccb.content.text("Find 5 Pairs of Medical Gloves"),
    description = ccb.content.text("Bring the doctor 5 pairs of medical gloves."),
    goal = "MGOAL_FIND_ITEM",
    difficulty = 5,
    value = 3500,
    item = "gloves_medical",
    item_count = 5,
    origins = { "ORIGIN_SECONDARY" },
    generic_rewards = false,
    followup = "MISSION_RANCH_DOCTOR_MEDICAL_ANESTHETIC",
    dialogue = {
        describe = ccb.content.text("We need help…"),
        offer = ccb.content.text("We're getting a lot of scrapes and bruises coming in right now, but it's only a matter of time before we see a serious injury.  I'm not prepared for when that happens and I'm hoping you can help.  To start off, I'm going to need some more medical gloves to help prevent infections.  Can you bring me 5 pairs?"),
        accepted = ccb.content.text("I'm counting on you."),
        rejected = ccb.content.text("Come back when you get a chance.  We need skilled survivors."),
        advice = ccb.content.text("Hospitals or clinics might have a few sitting around."),
        inquire = ccb.content.text("Do you have the medical gloves?"),
        success = ccb.content.text("Thank you for your assistance."),
        success_lie = ccb.content.text("What good does this do us?"),
        failure = ccb.content.text("It was a lost cause anyways…"),
    },
    finish = {
        actions = {
            ccb.content.dialogue_actions.set_actor_value("interlocutor", "dialogue_tacoma_ranch_provides_aid", "yes"),
        },
    },
}
