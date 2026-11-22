local ccb = require("ccb")
local actions = ccb.content.dialogue_actions

ccb.content.define_dialogue_topic {
    id = { "TALK_AUGUSTMOON_GENETECH_ESPER_WARNING" },
    line = ccb.content.text("&The clerk picks up a small device, \"Alright, I just need to do a preliminary scan.  If you please.\"  They gesture to your arm and you allow them to place the device against your skin.  There is a moment while the clerk watches the screen and then their eyebrows shoot up.  \"Whoa, esper heritage?  They told me to keep an eye out but I've never seen that before.  Where did I put that disclaimer they gave me…\"  The clerk turns and consults their console for a short while before they begin reciting, \"While we can guarantee that all Mercurial Genetch products have been tested in a wide variety of conditions and on a wide variety of subjects, Hyperspace Era noetic treatments are notoriously prone to degradation when further genetic modifications are applied.  Mercurial is not responsible for any reduction of esper potential or capability that may or may not occur as a result of our Genetech treatments.  If you have any concerns about your esper potential, we urge you to consult a licensed physician with a specialty in esper families.\"  They pause.  \"And no, before you ask, there isn't one in the system.  It's up to you if you think it's worth the risk.\""),
    replies = {
        {
            text = ccb.content.text("Huh.  Well, I better give it some thought."),
            next_topic = "TALK_DONE",
            actions = { actions.handler("dlg_a_aftershock_exoplanet_e2d20d8f059a") },
        },
    },
}
