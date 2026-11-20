local ccb = require("ccb")
local content = ccb.content

-- Native behavior trees and named Lua policies
do
local definition = content.Behavior {
    id = "SPLIT",
    strategy = "sequential",
    goal = "SPLIT",
}
definition:when_native("monster_not_hallucination", "", false)
definition:when_native("monster_split_possible", "", false)
definition:when_native("monster_special_available", "SPLIT", false)
content.add(definition)
end
do
local definition = content.Behavior {
    id = "ABSORB_ITEMS",
    strategy = "sequential",
    goal = "ABSORB_ITEMS",
}
definition:when_native("monster_not_hallucination", "", false)
definition:when_native("monster_split_possible", "", true)
definition:when_native("monster_special_available", "!SPLIT", false)
definition:when_native("monster_special_available", "ABSORB_ITEMS", false)
definition:when_native("monster_items_available", "", false)
content.add(definition)
end
do
local definition = content.Behavior {
    id = "EAT_CROP",
    strategy = "sequential",
    goal = "EAT_CROP",
}
definition:when_native("monster_not_hallucination", "", false)
definition:when_native("monster_special_available", "EAT_CROP", false)
definition:when_native("monster_adjacent_plants", "", false)
content.add(definition)
end
do
local definition = content.Behavior {
    id = "npc_decision",
    strategy = "fallback",
}
definition:child("npc_combat")
definition:child("npc_investigate")
definition:child("npc_priorities")
content.add(definition)
end
do
local definition = content.Behavior {
    id = "npc_combat",
    strategy = "fallback",
}
definition:child("npc_flee")
definition:child("npc_fight")
definition:when_native("npc_in_danger", "", false)
content.add(definition)
end
do
local definition = content.Behavior {
    id = "npc_flee",
    goal = "flee",
}
definition:when_native("npc_should_flee", "", false)
content.add(definition)
end
do
local definition = content.Behavior {
    id = "npc_fight",
    goal = "fight",
}
definition:when_native("npc_has_target", "", false)
content.add(definition)
end
do
local definition = content.Behavior {
    id = "npc_investigate",
    goal = "investigate_sound",
}
definition:when_native("npc_has_sound_alerts", "", false)
content.add(definition)
end
do
local definition = content.Behavior {
    id = "npc_priorities",
    strategy = "utility",
}
definition:child("npc_needs")
definition:child("npc_duty")
definition:child("npc_follow_embarked")
definition:child("npc_follow")
definition:child("npc_player_order")
definition:child("npc_camp_work")
definition:child("npc_return_to_camp")
definition:child("npc_free_time")
content.add(definition)
end
do
local definition = content.Behavior {
    id = "npc_duty",
    strategy = "fallback",
}
definition:child("npc_return_to_post")
definition:child("npc_hold_post")
definition:score_native("npc_duty_urgency", "")
content.add(definition)
end
do
local definition = content.Behavior {
    id = "npc_return_to_post",
    goal = "return_to_guard_pos",
}
definition:when_native("npc_on_shift", "", false)
definition:when_native("npc_displaced_from_post", "", false)
content.add(definition)
end
do
local definition = content.Behavior {
    id = "npc_hold_post",
    goal = "hold_position",
}
definition:when_native("npc_on_shift", "", false)
content.add(definition)
end
do
local definition = content.Behavior {
    id = "npc_follow_embarked",
    goal = "follow_embarked",
}
definition:when_native("npc_should_embark", "", false)
definition:score_native("npc_embark_urgency", "")
content.add(definition)
end
do
local definition = content.Behavior {
    id = "npc_follow",
    goal = "follow_player",
}
definition:when_native("npc_is_following", "", false)
definition:score_native("npc_following_urgency", "")
content.add(definition)
end
do
local definition = content.Behavior {
    id = "npc_player_order",
    goal = "goto_ordered_position",
}
definition:when_native("npc_has_goto_order", "", false)
definition:score_native("npc_goto_order_urgency", "")
content.add(definition)
end
do
local definition = content.Behavior {
    id = "npc_needs",
    strategy = "utility",
}
definition:child("npc_homeostasis")
definition:child("npc_thirst")
definition:child("npc_hunger")
definition:child("npc_sleepiness")
content.add(definition)
end
do
local definition = content.Behavior {
    id = "npc_homeostasis",
    strategy = "fallback",
}
definition:child("npc_obtain_warmth")
definition:child("npc_make_fire")
definition:when_native("npc_needs_warmth_badly", "", false)
definition:score_native("npc_warmth_urgency", "")
content.add(definition)
end
do
local definition = content.Behavior {
    id = "npc_obtain_warmth",
    goal = "seek_warmth",
}
definition:when_native("npc_can_obtain_warmth", "", false)
content.add(definition)
end
do
local definition = content.Behavior {
    id = "npc_make_fire",
    goal = "seek_warmth",
}
definition:when_native("npc_can_make_fire", "", false)
content.add(definition)
end
do
local definition = content.Behavior {
    id = "npc_thirst",
    strategy = "sequential",
}
definition:child("npc_obtain_water")
definition:when_native("npc_needs_water_badly", "", false)
definition:score_native("npc_thirst_urgency", "")
content.add(definition)
end
do
local definition = content.Behavior {
    id = "npc_obtain_water",
    strategy = "fallback",
}
definition:child("npc_drink_water")
definition:child("npc_seek_water")
content.add(definition)
end
do
local definition = content.Behavior {
    id = "npc_drink_water",
    goal = "drink_water",
}
definition:when_native("npc_has_water", "", false)
content.add(definition)
end
do
local definition = content.Behavior {
    id = "npc_seek_water",
    goal = "drink_water",
}
definition:when_native("npc_can_obtain_water", "", false)
content.add(definition)
end
do
local definition = content.Behavior {
    id = "npc_hunger",
    strategy = "sequential",
}
definition:child("npc_obtain_food")
definition:when_native("npc_needs_food_badly", "", false)
definition:score_native("npc_hunger_urgency", "")
content.add(definition)
end
do
local definition = content.Behavior {
    id = "npc_obtain_food",
    strategy = "fallback",
}
definition:child("npc_eat_food")
definition:child("npc_forage_food")
content.add(definition)
end
do
local definition = content.Behavior {
    id = "npc_eat_food",
    goal = "eat_food",
}
definition:when_native("npc_has_food", "", false)
content.add(definition)
end
do
local definition = content.Behavior {
    id = "npc_forage_food",
    goal = "eat_food",
}
definition:when_native("npc_can_obtain_food", "", false)
content.add(definition)
end
do
local definition = content.Behavior {
    id = "npc_sleepiness",
    strategy = "sequential",
}
definition:child("npc_go_to_sleep")
definition:when_native("npc_needs_sleep_badly", "", false)
definition:score_native("npc_sleepiness_urgency", "")
content.add(definition)
end
do
local definition = content.Behavior {
    id = "npc_go_to_sleep",
    goal = "go_to_sleep",
}
definition:when_native("npc_can_sleep", "", false)
content.add(definition)
end
do
local definition = content.Behavior {
    id = "npc_camp_work",
    goal = "camp_work",
}
definition:when_native("npc_has_camp_job", "", false)
definition:score_native("npc_camp_work_urgency", "")
content.add(definition)
end
do
local definition = content.Behavior {
    id = "npc_return_to_camp",
    goal = "return_to_camp",
}
definition:when_native("npc_is_away_from_camp", "", false)
definition:score_native("npc_return_to_camp_urgency", "")
content.add(definition)
end
do
local definition = content.Behavior {
    id = "npc_free_time",
    goal = "free_time",
}
definition:when_native("npc_is_camp_idle", "", false)
definition:score_native("npc_free_time_urgency", "")
content.add(definition)
end
