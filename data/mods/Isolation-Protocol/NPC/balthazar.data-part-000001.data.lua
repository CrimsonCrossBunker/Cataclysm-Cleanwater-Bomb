local ccb = require("ccb")

ccb.content.define_dialogue_topic {
    id = "ISO_BALTHAZAR_WORK_TOGETHER",
    line = ccb.content.text("LOCAL LIFEFORM YOUR CAPACITY FOR VIOLENCE IS COMMENDABLE.  PROPOSAL: WE WORK TOGETHER TO ENSURE MUTUAL SURVIVAL WITHIN HOSTILE ENVIRONMENT.  OBJECTIVE: DESTRUCTION OF EXTRAPLANAR INCURSION AND IMPOSITION OF NORMALITY IN LOCAL VOLUME.  YOUR PHYSICAL PRESENCE COMPLEMENTS MY OWN CAPABILITIES IN THE PURSUIT OF THIS GOAL.  I AM BALTHAZAR.\n\nCONFIRM ALLIANCE."),
    replies = {
        {
            text = ccb.content.text("I accept.  Its the two of us against the world."),
            next_topic = "ISO_BALTHAZAR_CONFIRM",
        },
        {
            text = ccb.content.text("I dont need your help, machine."),
            next_topic = "ISO_BALTHAZAR_DENY_CONFIRM",
        },
    },
}
