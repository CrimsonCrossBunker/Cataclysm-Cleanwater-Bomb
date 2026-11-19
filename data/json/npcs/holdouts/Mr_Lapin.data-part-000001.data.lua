local ccb = require("ccb")
local predicates = ccb.content.dialogue_predicates

ccb.content.define_dialogue_topic {
    id = "TALK_WARRENER",
    line = {
        when = predicates.wears("speaker", "badge_marshal"),
        yes = ccb.content.text("Are you here to protect us?"),
        no = ccb.content.text("Pleased to meet you."),
    },
    replies = {
        {
            text = ccb.content.text("I'm just trying to get by."),
            next_topic = "TALK_WARRENER_TRYING",
        },
        { text = ccb.content.text("What are you doing here?"), next_topic = "TALK_WARRENER_DOING" },
        {
            text = ccb.content.text("Heard anything about the outside world?"),
            next_topic = "TALK_WARRENER_WORLD",
        },
        { text = ccb.content.text("You look different?"), next_topic = "TALK_WARRENER_MUTATION" },
        { text = ccb.content.text("Anything I can help with?"), next_topic = "TALK_MISSION_LIST" },
        {
            text = ccb.content.text("About that work…"),
            next_topic = "TALK_MISSION_INQUIRE",
            when = predicates.assigned_missions(1, 1),
        },
        {
            text = ccb.content.text("About that work…"),
            next_topic = "TALK_MISSION_LIST_ASSIGNED",
            when = predicates.assigned_missions(2),
        },
        {
            text = ccb.content.text("Any jobs you need done?"),
            when = predicates.all({ predicates.negate(predicates.assigned_missions(1, 1)), predicates.negate(predicates.assigned_missions(2)) }),
            next_topic = "TALK_MISSION_LIST",
        },
        {
            text = ccb.content.text("Do you need any resources?"),
            next_topic = "TALK_LAPIN_RESOURCES",
        },
        {
            text = ccb.content.text("Where did you get that giant firefly terrarium?"),
            next_topic = "TALK_LAPIN_FIREFLY",
        },
        {
            text = ccb.content.text_without_extraction("<end_talking_bye>"),
            next_topic = "TALK_DONE",
        },
    },
}
