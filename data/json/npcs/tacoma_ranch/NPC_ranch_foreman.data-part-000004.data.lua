local ccb = require("ccb")

ccb.content.define_dialogue_topic {
    id = "TALK_RANCH_FOREMAN_Nunez_Clue",
    line = ccb.content.text("we're still in early stages of getting set up, but we're not overly flush for hands, that's for sure.  I don't think we'd turn many people away, of course, but besides strong hands and willing labor, we could really use someone who could cook.  I can't tell you what it'd do for morale.  You could try asking some of the people staying on the surface in the refugee center maybe, I don't think they were part of most of the original discussions about the ranch."),
    replies = { { text = ccb.content.text("I'll keep an eye out."), next_topic = "TALK_RANCH_FOREMAN" } },
}
