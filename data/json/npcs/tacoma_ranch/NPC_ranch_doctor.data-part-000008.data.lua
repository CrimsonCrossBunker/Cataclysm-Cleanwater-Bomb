local ccb = require("ccb")

ccb.content.define_mission {
    id = "MISSION_RANCH_DOCTOR_MEDICAL_ANESTHETIC",
    name = ccb.content.text("Anesthetic for the Doctor"),
    description = ccb.content.text("Bring the doctor 3000 units of anesthetic.  Ask around the commune for assistance in building an anesthetic machine."),
    goal = "MGOAL_CONDITION",
    difficulty = 5,
    value = 0,
    origins = { "ORIGIN_SECONDARY" },
    followup = "MISSION_NULL",
    generic_rewards = false,
    dialogue = {
        describe = ccb.content.text("We need help…"),
        offer = ccb.content.text("I want to make sure we are setup to handle any major surgeries that come our way, but pain management is going to be an issue.  For longer surgeries, we're going to need some anesthetic.  Can you bring me 3000 units to start?  We're also going to need an anesthetic machine to deliver it.  Maybe some people around the commune can help with that?"),
        accepted = ccb.content.text("I'm counting on you."),
        rejected = ccb.content.text("Come back when you get a chance.  We need skilled survivors."),
        advice = ccb.content.text("Hospitals or clinics might have some.  Labs could have some as well."),
        inquire = ccb.content.text("Any progress on getting some anesthetic or parts?"),
        success = ccb.content.text("The scavengers found more medical equipment than I expected and with the help from the scrappers, I've been able to get most of it up and running.  I should be able to perform more operations now."),
        success_lie = ccb.content.text("What good does this do us?"),
        failure = ccb.content.text("It was a lost cause anyways…"),
    },
    finish = {
        map_updates = {
            {
                terrain = "ranch_camp_50",
                layout = {
                    tile_edits = {
                        { shape = "point", operation = "furniture", id = "f_anesthetic", x = 19, y = 19 },
                    },
                },
            },
        },
        before_rewards = { "set_mission_flag_Doctor_rewarded_to_no", "deliver_anesthetic_3000_items" },
        actions = {
            ccb.content.dialogue_actions.set_actor_value("interlocutor", "dialogue_tacoma_ranch_provides_surgery", "yes"),
        },
    },
    complete_when = "complete_mission_ranch_doctor_medical_anesthetic",
}
