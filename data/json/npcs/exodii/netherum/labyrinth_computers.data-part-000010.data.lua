local ccb = require("ccb")

ccb.content.define_dialogue_topic {
    id = "COMP_LS_Bridge_control_deadend_1_force",
    line = ccb.content.text("&<color_light_green> @User > help --retract\n<color_light_green>Help?  @User help request logged.\n<color_light_green>Error: \"Help\" - implied payment|cost detected.\n<color_light_green>Error: Payment|cost not implemented.  Try again some day.\n\n<color_light_green> @User > _</color>"),
    replies = { { text = ccb.content.text("Log off."), next_topic = "TALK_DONE" } },
}

ccb.content.define_dialogue_topic {
    id = "COMP_LS_Boiler_Exit_Controls",
    line = ccb.content.text("& ▄▄▄· ▄▄▌  ▄▄▄▄▄ ▄▄▄· ▄▄▄            .▄▄ ·\n▐█ ▀█ ██•  •██  ▐█ ▀█ ▀▄ █·    ▪     ▐█ ▀.\n▄█▀▀█ ██▪   ▐█.▪▄█▀▀█ ▐▀▀▄      ▄█▀▄ ▄▀▀▀█▄\n▐█ ▪▐▌▐█▌▐▌ ▐█▌·▐█ ▪▐▌▐█•█▌    ▐█▌.▐▌▐█▄▪▐█\n ▀  ▀ .▀▀▀  ▀▀▀  ▀  ▀ .▀  ▀     ▀█▄▀▪ ▀▀▀▀\n\n @AltarOS > echo -anchor -cargo -nt AUTO\n\n ANCHOR:CARGO RESONANCE LOCK = true.\n\n Start exit protocol.       ᵖˡᵉᵃˢᵉ\n\n @AltarOS > skill -ELEVATE -@User\n\n<color_light_green> @User > _</color>"),
    replies = {
        {
            text = ccb.content.text("<color_light_green>Activate exit protocol: Home ᵃʷᵃʸ ᶠʳᵒᵐ ʰᵒᵐᵉ"),
            next_topic = "COMP_LS_Boiler_Exit_Controls2",
        },
        { text = ccb.content.text("<color_red>Log off"), next_topic = "TALK_DONE" },
    },
}
