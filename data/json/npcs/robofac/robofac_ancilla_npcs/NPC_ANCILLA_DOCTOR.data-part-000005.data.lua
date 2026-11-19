local ccb = require("ccb")
local predicates = ccb.content.dialogue_predicates
local actions = ccb.content.dialogue_actions

ccb.content.define_dialogue_topic {
    id = "TALK_ANCILLA_DOCTOR_BIONICS_BIONIC_LIMB_INTRO",
    line = ccb.content.text("That's right.\"  The doctor pulls out a vacuum-sealed package containing what is clearly a high-tech prosthetic arm, not too unlike those you saw before the Cataclysm.\n\n\"That annoying prick across the street has made some progress on those killer robots, I guess, and we figured out a way to improve standard prosthetics.  Missing limbs seems to be increasingly common.  Anyway, it's not superhuman stuff like some of these bionics, but it'll function like a normal limb, as long as you can keep it powered.  The benefit over the old-school stuff is the power, and that you control them with your neurobionic interface, and thus your brain, yeah?  So you may not be stronger or faster, but hey, at least your muscles won't get tired as easy.  Because you don't have'em!  Hah!"),
    replies = {
        {
            text = ccb.content.text("I'll keep that in mind in case I lose a limb.  See you around."),
            next_topic = "TALK_DONE",
        },
        {
            text = ccb.content.text("Actually… could you just cut off one of my limbs and install one of those instead?"),
            next_topic = "TALK_ANCILLA_DOCTOR_BIONICS_BIONIC_LIMB_PROPOSE_SWAP",
            actions = {
                actions.set_actor_value("speaker", "dialogue_ancilla_doctor_u_asked_about_swapping_limbs", "yes"),
            },
        },
    },
}
