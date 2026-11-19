local ccb = require("ccb")

ccb.content.define_dialogue_topic {
    id = { "COMP_MOM_SHADOW_URGE_COMPUTER_RANDOM_PASS" },
    line = ccb.content.text("&You input the first combination of username and password that comes to mind, and of course it doesn't work.  Rather than trigger a lockout due to too many attempts, you decide to come back when you have some idea what to do."),
    replies = { { text = ccb.content.text("Log Off"), next_topic = "TALK_DONE" } },
}

ccb.content.define_dialogue_topic {
    id = { "COMP_MOM_SHADOW_URGE_COMPUTER_KNOWN_PASS" },
    line = ccb.content.text("&You input the access codes from the SHADOW URGE document you found and are greeted with a long text string that, from your quick skim, promises dire punishments as well as termination of employment for anyone who attempts to use the SHADOW URGE device without properly-approved experiment protocol beforehand.  Fortunately, all the HR departments are now shambling around on the surface, so you skip past it.  Following the instructions on the documents, you skip through a few menus, input at least two more access codes, and eventually arrive at what can only be the main menu."),
    replies = {
        {
            text = ccb.content.text("SHADOW URGE: Improve Strength."),
            next_topic = "COMP_MOM_SHADOW_URGE_COMPUTER_IMPROVE_STRENGTH",
        },
        {
            text = ccb.content.text("SHADOW URGE: Improve Agility."),
            next_topic = "COMP_MOM_SHADOW_URGE_COMPUTER_IMPROVE_AGILITY",
        },
        {
            text = ccb.content.text("SHADOW URGE: Improve Resilience."),
            next_topic = "COMP_MOM_SHADOW_URGE_COMPUTER_IMPROVE_RESILIENCE",
        },
        {
            text = ccb.content.text("SHADOW URGE: Improve Recovery."),
            next_topic = "COMP_MOM_SHADOW_URGE_COMPUTER_IMPROVE_RECOVERY",
        },
        { text = ccb.content.text("Do nothing and log off"), next_topic = "TALK_DONE" },
    },
}

ccb.content.define_dialogue_topic {
    id = { "COMP_MOM_SHADOW_URGE_COMPUTER_MAIN_MENU" },
    line = ccb.content.text("&Project SHADOW URGE.  Insert catalyst and select treatment."),
    replies = {
        {
            text = ccb.content.text("SHADOW URGE: Improve Strength."),
            next_topic = "COMP_MOM_SHADOW_URGE_COMPUTER_IMPROVE_STRENGTH",
        },
        {
            text = ccb.content.text("SHADOW URGE: Improve Agility."),
            next_topic = "COMP_MOM_SHADOW_URGE_COMPUTER_IMPROVE_AGILITY",
        },
        {
            text = ccb.content.text("SHADOW URGE: Improve Resilience."),
            next_topic = "COMP_MOM_SHADOW_URGE_COMPUTER_IMPROVE_RESILIENCE",
        },
        {
            text = ccb.content.text("SHADOW URGE: Improve Recovery."),
            next_topic = "COMP_MOM_SHADOW_URGE_COMPUTER_IMPROVE_RECOVERY",
        },
        { text = ccb.content.text("Do nothing and log off"), next_topic = "TALK_DONE" },
    },
}
