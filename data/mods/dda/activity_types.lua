local ccb = require("ccb")
local content = ccb.content
local services = ccb.services

content.add(content.ActivityType {
    id = "ACT_CONTEXTUAL_ACTION",
    verb = ccb.content.text("performing queued actions"),
    based_on = "neither",
    activity_level = 1,
    can_resume = false,
})

content.add(content.ActivityType {
    id = "ACT_RELOAD",
    verb = ccb.content.text("reloading"),
    based_on = "speed",
    activity_level = 1,
    can_resume = false,
})

content.add(content.ActivityType {
    id = "ACT_FIND_MOUNT",
    verb = ccb.content.text("finding a mount"),
    based_on = "neither",
    activity_level = 2,
    can_resume = false,
})

content.add(content.ActivityType {
    id = "ACT_MOUNTED_CHARGE",
    verb = ccb.content.text("charging"),
    based_on = "neither",
    activity_level = 2,
    can_resume = false,
})

content.add(content.ActivityType {
    id = "ACT_READ",
    verb = ccb.content.text("reading"),
    based_on = "speed",
    activity_level = 1,
    rooted = true,
    refuel_fires = true,
    auto_needs = true,
})

content.add(content.ActivityType {
    id = "ACT_E_FILE",
    verb = ccb.content.text("managing files"),
    based_on = "time",
    activity_level = 1,
    rooted = true,
    auto_needs = true,
})

content.add(content.ActivityType {
    id = "ACT_EBOOKSAVE",
    verb = ccb.content.text("taking pictures of books"),
    based_on = "speed",
    activity_level = 1,
    rooted = true,
    auto_needs = true,
})

content.add(content.ActivityType {
    id = "ACT_MULTIPLE_CONSTRUCTION",
    verb = ccb.content.text("constructing"),
    based_on = "neither",
    activity_level = 1,
    multi_activity = true,
    fetch_items_to_zone = false,
    auto_needs = true,
})

content.add(content.ActivityType {
    id = "ACT_MULTIPLE_MINE",
    verb = ccb.content.text("mining"),
    based_on = "neither",
    activity_level = 10,
    multi_activity = true,
})

content.add(content.ActivityType {
    id = "ACT_MULTIPLE_MOP",
    verb = ccb.content.text("mopping"),
    based_on = "neither",
    activity_level = 1,
    multi_activity = true,
})

content.add(content.ActivityType {
    id = "ACT_MULTIPLE_READ",
    verb = ccb.content.text("reading"),
    based_on = "neither",
    activity_level = 1,
    can_resume = false,
    multi_activity = true,
    auto_needs = true,
})

content.add(content.ActivityType {
    id = "ACT_MULTIPLE_STUDY",
    verb = ccb.content.text("studying"),
    based_on = "neither",
    activity_level = 1,
    multi_activity = true,
    auto_needs = true,
})

content.add(content.ActivityType {
    id = "ACT_MOP",
    verb = ccb.content.text("mopping"),
    based_on = "speed",
    activity_level = 2,
})

content.add(content.ActivityType {
    id = "ACT_VEHICLE_DECONSTRUCTION",
    verb = ccb.content.text("deconstructing a vehicle"),
    based_on = "neither",
    activity_level = 6,
    multi_activity = true,
})

content.add(content.ActivityType {
    id = "ACT_VEHICLE_FOLD",
    verb = ccb.content.text("folding a vehicle"),
    based_on = "speed",
    activity_level = 2,
    can_resume = false,
    multi_activity = false,
})

content.add(content.ActivityType {
    id = "ACT_VEHICLE_UNFOLD",
    verb = ccb.content.text("unfolding a vehicle"),
    based_on = "speed",
    activity_level = 2,
    can_resume = false,
    multi_activity = false,
})

content.add(content.ActivityType {
    id = "ACT_VEHICLE_REPAIR",
    verb = ccb.content.text("repairing a vehicle"),
    based_on = "neither",
    activity_level = 4,
    multi_activity = true,
})

content.add(content.ActivityType {
    id = "ACT_VEHICLE_PART_REPAIR_SERVICE",
    verb = ccb.content.text("repairing a vehicle"),
    based_on = "time",
    activity_level = 1,
    rooted = true,
    interruptable = true,
    interruptable_with_keyboard = true,
    can_resume = false,
})

content.add(content.ActivityType {
    id = "ACT_VEHICLE_PART_INSTALL_SERVICE",
    verb = ccb.content.text("installing a vehicle part"),
    based_on = "time",
    activity_level = 1,
    rooted = true,
    interruptable = true,
    interruptable_with_keyboard = true,
    can_resume = false,
})

content.add(content.ActivityType {
    id = "ACT_VEHICLE_PART_REMOVE_SERVICE",
    verb = ccb.content.text("removing a vehicle part"),
    based_on = "time",
    activity_level = 1,
    rooted = true,
    interruptable = true,
    interruptable_with_keyboard = true,
    can_resume = false,
})

content.add(content.ActivityType {
    id = "ACT_BASH",
    verb = ccb.content.text("bashing"),
    based_on = "neither",
    activity_level = 4,
    can_resume = false,
})

content.add(content.ActivityType {
    id = "ACT_BIKERACK_RACKING",
    verb = ccb.content.text("mounting a vehicle onto rack"),
    based_on = "time",
    activity_level = 4,
    rooted = true,
    can_resume = false,
    refuel_fires = false,
    auto_needs = false,
})

content.add(content.ActivityType {
    id = "ACT_BIKERACK_UNRACKING",
    verb = ccb.content.text("taking a vehicle from rack"),
    based_on = "time",
    activity_level = 4,
    rooted = true,
    can_resume = false,
    refuel_fires = false,
    auto_needs = false,
})

content.add(content.ActivityType {
    id = "ACT_MULTIPLE_CHOP_PLANKS",
    verb = ccb.content.text("chopping logs"),
    based_on = "neither",
    activity_level = 10,
    multi_activity = true,
    auto_needs = true,
})

content.add(content.ActivityType {
    id = "ACT_MULTIPLE_CRAFT",
    verb = ccb.content.text("crafting"),
    based_on = "neither",
    activity_level = 1,
    can_resume = false,
    multi_activity = true,
    auto_needs = true,
})

content.add(content.ActivityType {
    id = "ACT_MULTIPLE_DIS",
    verb = ccb.content.text("disassembling things"),
    based_on = "neither",
    activity_level = 4,
    multi_activity = true,
    fetch_items_to_zone = false,
    auto_needs = true,
})

content.add(content.ActivityType {
    id = "ACT_MULTIPLE_BUTCHER",
    verb = ccb.content.text("butchering"),
    based_on = "neither",
    activity_level = 4,
    multi_activity = true,
    auto_needs = true,
})

content.add(content.ActivityType {
    id = "ACT_MULTIPLE_CHOP_TREES",
    verb = ccb.content.text("chopping trees"),
    based_on = "neither",
    activity_level = 10,
    multi_activity = true,
    auto_needs = true,
})

content.add(content.ActivityType {
    id = "ACT_MULTIPLE_FISH",
    verb = ccb.content.text("fishing"),
    based_on = "neither",
    activity_level = 1,
    multi_activity = true,
    auto_needs = true,
})

content.add(content.ActivityType {
    id = "ACT_HARVEST",
    verb = ccb.content.text("harvesting"),
    based_on = "speed",
    activity_level = 2,
})

content.add(content.ActivityType {
    id = "ACT_GENERIC_GAME",
    verb = ccb.content.text("playing"),
    based_on = "time",
    activity_level = 1,
    rooted = true,
})

content.add(content.ActivityType {
    id = "ACT_GAME",
    verb = ccb.content.text("playing"),
    based_on = "time",
    activity_level = 1,
    rooted = true,
})

content.add(content.ActivityType {
    id = "ACT_WAIT",
    verb = ccb.content.text("waiting"),
    based_on = "time",
    activity_level = 1,
    rooted = true,
    can_resume = false,
    refuel_fires = true,
    auto_needs = true,
})

content.add(content.ActivityType {
    id = "ACT_HELP_PARTNER",
    verb = ccb.content.text("helping your partner"),
    based_on = "time",
    activity_level = 4,
    rooted = true,
    can_resume = false,
    auto_needs = true,
})

content.add(content.ActivityType {
    id = "ACT_CRAFT",
    verb = ccb.content.text("crafting"),
    based_on = "neither",
    activity_level = 4,
    refuel_fires = true,
    auto_needs = true,
})

content.add(content.ActivityType {
    id = "ACT_CRAFT_WAIT",
    verb = ccb.content.text("waiting for craft step"),
    based_on = "time",
    activity_level = 1,
    rooted = true,
    can_resume = false,
    refuel_fires = true,
    auto_needs = true,
})

content.add(content.ActivityType {
    id = "ACT_DISASSEMBLE",
    verb = ccb.content.text("disassembling"),
    based_on = "neither",
    activity_level = 4,
    rooted = true,
    can_resume = false,
    refuel_fires = true,
    auto_needs = true,
})

content.add(content.ActivityType {
    id = "ACT_BLEED",
    verb = ccb.content.text("bleeding"),
    based_on = "speed",
    activity_level = 2,
})

content.add(content.ActivityType {
    id = "ACT_BUTCHER",
    verb = ccb.content.text("butchering"),
    based_on = "speed",
    activity_level = 6,
})

content.add(content.ActivityType {
    id = "ACT_BUTCHER_FULL",
    verb = ccb.content.text("butchering"),
    based_on = "speed",
    activity_level = 6,
})

content.add(content.ActivityType {
    id = "ACT_FIELD_DRESS",
    verb = ccb.content.text("field dressing"),
    based_on = "speed",
    activity_level = 4,
})

content.add(content.ActivityType {
    id = "ACT_SKIN",
    verb = ccb.content.text("skinning"),
    based_on = "speed",
    activity_level = 4,
})

content.add(content.ActivityType {
    id = "ACT_QUARTER",
    verb = ccb.content.text("quartering"),
    based_on = "speed",
    activity_level = 8,
})

content.add(content.ActivityType {
    id = "ACT_DISMEMBER",
    verb = ccb.content.text("dismembering"),
    based_on = "speed",
    activity_level = 8,
})

content.add(content.ActivityType {
    id = "ACT_DISSECT",
    verb = ccb.content.text("dissecting"),
    based_on = "speed",
    activity_level = 2,
})

content.add(content.ActivityType {
    id = "ACT_LONGSALVAGE",
    verb = ccb.content.text("salvaging"),
    based_on = "speed",
    activity_level = 6,
    can_resume = false,
    refuel_fires = true,
    auto_needs = true,
})

content.add(content.ActivityType {
    id = "ACT_FORAGE",
    verb = ccb.content.text("foraging"),
    based_on = "speed",
    activity_level = 2,
})

content.add(content.ActivityType {
    id = "ACT_BUILD",
    verb = ccb.content.text("constructing"),
    based_on = "neither",
    activity_level = 1,
    refuel_fires = true,
    auto_needs = true,
})

content.add(content.ActivityType {
    id = "ACT_VEHICLE",
    verb = ccb.content.text("interacting with the vehicle"),
    based_on = "speed",
    activity_level = 4,
})

content.add(content.ActivityType {
    id = "ACT_TRAIN",
    verb = ccb.content.text("training"),
    based_on = "speed",
    activity_level = 6,
})

content.add(content.ActivityType {
    id = "ACT_SOCIALIZE",
    verb = ccb.content.text("socializing"),
    based_on = "time",
    activity_level = 1,
    rooted = true,
})

content.add(content.ActivityType {
    id = "ACT_WAIT_WEATHER",
    verb = ccb.content.text("waiting"),
    based_on = "time",
    activity_level = 1,
    rooted = true,
    can_resume = false,
    auto_needs = true,
})

content.add(content.ActivityType {
    id = "ACT_FIRSTAID",
    verb = ccb.content.text("using first aid"),
    based_on = "speed",
    activity_level = 2,
    can_resume = false,
})

content.add(content.ActivityType {
    id = "ACT_FISH",
    verb = ccb.content.text("fishing"),
    based_on = "speed",
    activity_level = 1,
    rooted = true,
    can_resume = false,
})

content.add(content.ActivityType {
    id = "ACT_PICKAXE",
    verb = ccb.content.text("mining"),
    based_on = "speed",
    activity_level = 10,
})

content.add(content.ActivityType {
    id = "ACT_PULP",
    verb = ccb.content.text("smashing"),
    based_on = "speed",
    activity_level = 10,
    can_resume = false,
})

content.add(content.ActivityType {
    id = "ACT_HAND_CRANK",
    verb = ccb.content.text("cranking"),
    based_on = "time",
    activity_level = 4,
    rooted = true,
})

content.add(content.ActivityType {
    id = "ACT_HEATING",
    verb = ccb.content.text("heating"),
    based_on = "time",
    activity_level = 1,
    rooted = true,
})

content.add(content.ActivityType {
    id = "ACT_VIBE",
    verb = ccb.content.text("de-stressing"),
    based_on = "time",
    activity_level = 2,
})

content.add(content.ActivityType {
    id = "ACT_DROP",
    verb = ccb.content.text("dropping"),
    based_on = "neither",
    activity_level = 2,
    can_resume = false,
})

content.add(content.ActivityType {
    id = "ACT_STASH",
    verb = ccb.content.text("stashing"),
    based_on = "neither",
    activity_level = 2,
    can_resume = false,
})

content.add(content.ActivityType {
    id = "ACT_PICKUP",
    verb = ccb.content.text("picking up"),
    based_on = "neither",
    activity_level = 2,
    can_resume = false,
})

content.add(content.ActivityType {
    id = "ACT_MOVE_ITEMS",
    verb = ccb.content.text("moving items"),
    based_on = "neither",
    activity_level = 4,
    can_resume = false,
})

content.add(content.ActivityType {
    id = "ACT_INSERT_ITEM",
    verb = ccb.content.text("inserting"),
    based_on = "speed",
    activity_level = 2,
    can_resume = false,
})

content.add(content.ActivityType {
    id = "ACT_AUTODRIVE",
    verb = ccb.content.text("driving"),
    based_on = "neither",
    activity_level = 1,
    can_resume = false,
})

content.add(content.ActivityType {
    id = "ACT_TRAVELLING",
    verb = ccb.content.text("traveling"),
    based_on = "neither",
    activity_level = 1,
    can_resume = false,
})

content.add(content.ActivityType {
    id = "ACT_MOVE_LOOT",
    verb = ccb.content.text("sorting out the loot"),
    based_on = "neither",
    activity_level = 4,
})

content.add(content.ActivityType {
    id = "ACT_UNLOAD_LOOT",
    verb = ccb.content.text("unloading loot"),
    based_on = "neither",
    activity_level = 4,
    multi_activity = true,
})

content.add(content.ActivityType {
    id = "ACT_FETCH_REQUIRED",
    verb = ccb.content.text("fetching components"),
    based_on = "neither",
    activity_level = 4,
})

content.add(content.ActivityType {
    id = "ACT_MULTIPLE_FARM",
    verb = ccb.content.text("farming"),
    based_on = "neither",
    activity_level = 6,
    multi_activity = true,
    auto_needs = true,
})

content.add(content.ActivityType {
    id = "ACT_START_FIRE",
    verb = ccb.content.text("lighting the fire"),
    based_on = "neither",
    activity_level = 1,
    rooted = true,
    can_resume = false,
})

content.add(content.ActivityType {
    id = "ACT_OPEN_GATE",
    verb = ccb.content.text("working the winch"),
    based_on = "speed",
    activity_level = 4,
})

content.add(content.ActivityType {
    id = "ACT_OPEN_TILE",
    verb = ccb.content.text("opening"),
    based_on = "time",
    activity_level = 1,
    mute_npc_completion = true,
})

content.add(content.ActivityType {
    id = "ACT_CLOSE_TILE",
    verb = ccb.content.text("closing"),
    based_on = "time",
    activity_level = 1,
    mute_npc_completion = true,
})

content.add(content.ActivityType {
    id = "ACT_FILL_LIQUID",
    verb = ccb.content.text("filling the container"),
    based_on = "neither",
    activity_level = 1,
    rooted = true,
    can_resume = false,
})

content.add(content.ActivityType {
    id = "ACT_MILK",
    verb = ccb.content.text("milking an animal"),
    based_on = "time",
    activity_level = 2,
    rooted = true,
    can_resume = false,
})

content.add(content.ActivityType {
    id = "ACT_SHEARING",
    verb = ccb.content.text("shearing an animal"),
    based_on = "speed",
    activity_level = 4,
    rooted = true,
    can_resume = false,
})

content.add(content.ActivityType {
    id = "ACT_HOTWIRE_CAR",
    verb = ccb.content.text("hotwiring the vehicle"),
    based_on = "speed",
    activity_level = 1,
})

content.add(content.ActivityType {
    id = "ACT_AIM",
    verb = ccb.content.text("aiming"),
    based_on = "neither",
    activity_level = 2,
    can_resume = false,
}:ignore("hunger"):ignore("thirst"):ignore("hostile_spotted_near"):ignore("hostile_spotted_far"))

content.add(content.ActivityType {
    id = "ACT_PULL_CREATURE",
    verb = ccb.content.text("pulling a creature"),
    based_on = "time",
    activity_level = 4,
    can_resume = false,
})

content.add(content.ActivityType {
    id = "ACT_ATM",
    verb = ccb.content.text("using the ATM"),
    based_on = "time",
    activity_level = 1,
    can_resume = false,
})

content.add(content.ActivityType {
    id = "ACT_START_ENGINES",
    verb = ccb.content.text("trying to start the vehicle"),
    based_on = "time",
    activity_level = 1,
    can_resume = false,
})

content.add(content.ActivityType {
    id = "ACT_OXYTORCH",
    verb = ccb.content.text("welding"),
    based_on = "time",
    activity_level = 1,
})

content.add(content.ActivityType {
    id = "ACT_CRACKING",
    verb = ccb.content.text("cracking"),
    based_on = "speed",
    activity_level = 1,
    rooted = true,
})

content.add(content.ActivityType {
    id = "ACT_LOCKPICK",
    verb = ccb.content.text("picking lock"),
    based_on = "speed",
    activity_level = 1,
    rooted = true,
    can_resume = false,
})

content.add(content.ActivityType {
    id = "ACT_REPAIR_ITEM",
    verb = ccb.content.text("repairing"),
    based_on = "neither",
    activity_level = 1,
    rooted = true,
    refuel_fires = true,
    auto_needs = true,
})

content.add(content.ActivityType {
    id = "ACT_MEND_ITEM",
    verb = ccb.content.text("mending"),
    based_on = "speed",
    activity_level = 1,
    rooted = true,
    refuel_fires = true,
    auto_needs = true,
})

content.add(content.ActivityType {
    id = "ACT_TREAT_WOUND",
    verb = ccb.content.text("treating wounds"),
    based_on = "speed",
    activity_level = 1,
    rooted = true,
    refuel_fires = true,
    auto_needs = true,
})

content.add(content.ActivityType {
    id = "ACT_GUNMOD_ADD",
    verb = ccb.content.text("modifying gun"),
    based_on = "speed",
    activity_level = 1,
    can_resume = false,
})

content.add(content.ActivityType {
    id = "ACT_GUNMOD_REMOVE",
    verb = ccb.content.text("modifying gun"),
    based_on = "speed",
    activity_level = 1,
    can_resume = false,
})

content.add(content.ActivityType {
    id = "ACT_TOOLMOD_ADD",
    verb = ccb.content.text("modifying tool"),
    based_on = "speed",
    activity_level = 1,
    can_resume = false,
})

content.add(content.ActivityType {
    id = "ACT_WAIT_FOLLOWERS",
    verb = ccb.content.text("waiting for followers to catch up"),
    based_on = "time",
    activity_level = 1,
    rooted = true,
    can_resume = false,
})

content.add(content.ActivityType {
    id = "ACT_WAIT_NPC",
    verb = ccb.content.text("interacting with the NPC"),
    based_on = "time",
    activity_level = 1,
    rooted = true,
    can_resume = false,
})

content.add(content.ActivityType {
    id = "ACT_WAIT_STAMINA",
    verb = ccb.content.text("catching breath"),
    based_on = "time",
    activity_level = 1,
    rooted = true,
    can_resume = false,
})

content.add(content.ActivityType {
    id = "ACT_CLEAR_RUBBLE",
    verb = ccb.content.text("clearing that rubble"),
    based_on = "speed",
    activity_level = 10,
})

content.add(content.ActivityType {
    id = "ACT_MEDITATE",
    verb = ccb.content.text("meditating"),
    based_on = "speed",
    activity_level = 1,
    rooted = true,
})

content.add(content.ActivityType {
    id = "ACT_OUTFIT_SWAP",
    verb = ccb.content.text("changing clothes"),
    based_on = "speed",
    activity_level = 2,
    rooted = true,
})

content.add(content.ActivityType {
    id = "ACT_WASH",
    verb = ccb.content.text("washing"),
    based_on = "speed",
    activity_level = 4,
    rooted = true,
})

content.add(content.ActivityType {
    id = "ACT_HACKSAW",
    verb = ccb.content.text("cutting the metal"),
    based_on = "speed",
    activity_level = 4,
})

content.add(content.ActivityType {
    id = "ACT_BOLTCUTTING",
    verb = ccb.content.text("cutting the wire"),
    based_on = "speed",
    activity_level = 4,
})

content.add(content.ActivityType {
    id = "ACT_PRYING",
    verb = ccb.content.text("prying open"),
    based_on = "speed",
    activity_level = 4,
})

content.add(content.ActivityType {
    id = "ACT_CHOP_TREE",
    verb = ccb.content.text("chopping down a tree"),
    based_on = "speed",
    activity_level = 8,
})

content.add(content.ActivityType {
    id = "ACT_CHOP_LOGS",
    verb = ccb.content.text("chopping a log"),
    based_on = "speed",
    activity_level = 8,
})

content.add(content.ActivityType {
    id = "ACT_CHOP_PLANKS",
    verb = ccb.content.text("cutting planks"),
    based_on = "speed",
    activity_level = 8,
    can_resume = false,
})

content.add(content.ActivityType {
    id = "ACT_JACKHAMMER",
    verb = ccb.content.text("drilling"),
    based_on = "speed",
    activity_level = 8,
})

content.add(content.ActivityType {
    id = "ACT_CHURN",
    verb = ccb.content.text("churning earth"),
    based_on = "time",
    activity_level = 10,
})

content.add(content.ActivityType {
    id = "ACT_PLANT_SEED",
    verb = ccb.content.text("planting seeds"),
    based_on = "time",
    activity_level = 4,
})

content.add(content.ActivityType {
    id = "ACT_FERTILIZE_PLANT",
    verb = ccb.content.text("fertilizing plants"),
    based_on = "time",
    activity_level = 4,
})

content.add(content.ActivityType {
    id = "ACT_SHAVE",
    verb = ccb.content.text("shaving"),
    based_on = "speed",
    activity_level = 1,
    rooted = true,
})

content.add(content.ActivityType {
    id = "ACT_HAIRCUT",
    verb = ccb.content.text("cutting your hair"),
    based_on = "speed",
    activity_level = 1,
    rooted = true,
})

content.add(content.ActivityType {
    id = "ACT_PLAY_WITH_PET",
    verb = ccb.content.text("playing with your pet"),
    based_on = "speed",
    activity_level = 2,
})

content.add(content.ActivityType {
    id = "ACT_TRY_SLEEP",
    verb = ccb.content.text("trying to fall asleep"),
    based_on = "speed",
    activity_level = 1,
    rooted = true,
    can_resume = false,
})

content.add(content.ActivityType {
    id = "ACT_OPERATION",
    verb = ccb.content.text("being operated on"),
    based_on = "time",
    activity_level = 1,
    interruptable = false,
    can_resume = false,
})

-- For characters getting crafting done
content.add(content.ActivityType {
    id = "ACT_MEASURE",
    verb = ccb.content.text("getting measurements taken"),
    based_on = "time",
    activity_level = 1,
    rooted = true,
    interruptable = false,
    can_resume = false,
    refuel_fires = true,
    auto_needs = true,
})

content.add(content.ActivityType {
    id = "ACT_UNLOAD",
    verb = ccb.content.text("unloading"),
    based_on = "speed",
    activity_level = 1,
    can_resume = false,
})

content.add(content.ActivityType {
    id = "ACT_ROBOT_CONTROL",
    verb = ccb.content.text("programming override"),
    based_on = "time",
    activity_level = 1,
    can_resume = false,
})

content.add(content.ActivityType {
    id = "ACT_WEAR",
    verb = ccb.content.text("putting on items"),
    based_on = "neither",
    activity_level = 1,
    can_resume = false,
})

content.add(content.ActivityType {
    id = "ACT_WIELD",
    verb = ccb.content.text("wielding item"),
    based_on = "neither",
    activity_level = 1,
    can_resume = false,
})

content.add(content.ActivityType {
    id = "ACT_BIONIC_WATER",
    verb = ccb.content.text("extracting water"),
    based_on = "neither",
    activity_level = 1,
    rooted = true,
    can_resume = false,
})

content.add(content.ActivityType {
    id = "ACT_REMOTE_VEHICLE",
    verb = ccb.content.text("accessing vehicle controls"),
    based_on = "neither",
    activity_level = 1,
    rooted = true,
    can_resume = false,
})

content.add(content.ActivityType {
    id = "ACT_INVOKE_ITEM",
    verb = ccb.content.text("using item"),
    based_on = "neither",
    activity_level = 1,
    rooted = true,
    can_resume = false,
})

content.add(content.ActivityType {
    id = "ACT_TREE_COMMUNION",
    verb = ccb.content.text("communing with the trees"),
    based_on = "time",
    activity_level = 1,
    rooted = true,
    can_resume = false,
})

content.add(content.ActivityType {
    id = "ACT_SPELLCASTING",
    verb = ccb.content.text("casting"),
    based_on = "speed",
    activity_level = 2,
    can_resume = false,
})

content.add(content.ActivityType {
    id = "ACT_STUDY_SPELL",
    verb = ccb.content.text("studying"),
    based_on = "time",
    activity_level = 1,
    rooted = true,
    can_resume = false,
    refuel_fires = true,
    auto_needs = true,
})

content.add(content.ActivityType {
    id = "ACT_HACKING",
    verb = ccb.content.text("hacking"),
    based_on = "time",
    activity_level = 1,
    can_resume = false,
})

content.add(content.ActivityType {
    id = "ACT_BINDER_COPY_RECIPE",
    verb = ccb.content.text("writing"),
    based_on = "speed",
    activity_level = 1,
    rooted = true,
})

content.add(content.ActivityType {
    id = "ACT_DATA_HANDLING",
    verb = ccb.content.text("downloading data"),
    based_on = "time",
    activity_level = 1,
    can_resume = false,
    auto_needs = true,
})

content.add(content.ActivityType {
    id = "ACT_MIGRATION_CANCEL",
    verb = ccb.content.text("canceling activity serialized with legacy code"),
    based_on = "neither",
    activity_level = 1,
    can_resume = false,
})

content.add(content.ActivityType {
    id = "ACT_CONSUME",
    verb = ccb.content.text("consuming"),
    based_on = "time",
    activity_level = 1,
}:ignore("hunger"):ignore("thirst"))

content.add(content.ActivityType {
    id = "ACT_WORKOUT_HARD",
    verb = ccb.content.text("working out", "training"),
    based_on = "time",
    activity_level = 10,
})

content.add(content.ActivityType {
    id = "ACT_WORKOUT_ACTIVE",
    verb = ccb.content.text("working out", "training"),
    based_on = "time",
    activity_level = 8,
})

content.add(content.ActivityType {
    id = "ACT_WORKOUT_MODERATE",
    verb = ccb.content.text("working out", "training"),
    based_on = "time",
    activity_level = 4,
})

content.add(content.ActivityType {
    id = "ACT_WORKOUT_LIGHT",
    verb = ccb.content.text("working out", "training"),
    based_on = "time",
    activity_level = 2,
})

content.add(content.ActivityType {
    id = "ACT_DISABLE",
    verb = ccb.content.text("disabling"),
    based_on = "speed",
    activity_level = 1,
    can_resume = false,
})

content.add(content.ActivityType {
    id = "ACT_FURNITURE_MOVE",
    verb = ccb.content.text("moving"),
    based_on = "time",
    activity_level = 8,
    can_resume = false,
})

content.add(content.ActivityType {
    id = "ACT_TARGET_PRACTICE",
    verb = ccb.content.text("practicing marksmanship"),
    based_on = "neither",
    activity_level = 2,
    interruptable = true,
    interruptable_with_keyboard = true,
    can_resume = false,
    refuel_fires = true,
    auto_needs = true,
})

content.add(content.ActivityType {
    id = "ACT_TENT_PLACE",
    verb = ccb.content.text("pitching a tent"),
    based_on = "time",
    activity_level = 2,
    rooted = true,
    can_resume = false,
    refuel_fires = false,
    auto_needs = false,
})

content.add(content.ActivityType {
    id = "ACT_TENT_DECONSTRUCT",
    verb = ccb.content.text("packing up a tent"),
    based_on = "time",
    activity_level = 2,
    rooted = true,
    can_resume = false,
    refuel_fires = false,
    auto_needs = false,
})

content.add(content.ActivityType {
    id = "ACT_REEL_CABLE",
    verb = ccb.content.text("reeling cable"),
    based_on = "speed",
    activity_level = 1,
})

content.add(content.ActivityType {
    id = "ACT_GENERIC_EOC",
    verb = ccb.content.text("preparing"),
    based_on = "time",
    activity_level = 1,
    interruptable = false,
    interruptable_with_keyboard = false,
    can_resume = false,
})

content.add(content.ActivityType {
    id = "ACT_CBM_SURGERY",
    verb = ccb.content.text("being operated on"),
    based_on = "time",
    activity_level = 1,
    interruptable = false,
    interruptable_with_keyboard = false,
    can_resume = false,
})

content.add(content.ActivityType {
    id = "ACT_GLIDE",
    verb = ccb.content.text("gliding"),
    based_on = "neither",
    activity_level = 1,
    interruptable = false,
    interruptable_with_keyboard = false,
    can_resume = false,
    refuel_fires = false,
    auto_needs = false,
})

content.add(content.ActivityType {
    id = "ACT_MORTAR_AIMING",
    verb = ccb.content.text("aiming the artillery"),
    based_on = "speed",
    activity_level = 1,
})

content.add(content.ActivityType {
    id = "ACT_EAT_MENU",
    verb = ccb.content.text("eating"),
    based_on = "time",
    activity_level = 1,
    rooted = true,
    can_resume = false,
}:ignore("hunger"):ignore("thirst"))

content.add(content.ActivityType {
    id = "ACT_CONSUME_FOOD_MENU",
    verb = ccb.content.text("consuming"),
    based_on = "time",
    activity_level = 1,
    rooted = true,
    can_resume = false,
}:ignore("hunger"):ignore("thirst"))

content.add(content.ActivityType {
    id = "ACT_CONSUME_DRINK_MENU",
    verb = ccb.content.text("drinking"),
    based_on = "time",
    activity_level = 1,
    can_resume = false,
}:ignore("hunger"):ignore("thirst"))

content.add(content.ActivityType {
    id = "ACT_CONSUME_MEDS_MENU",
    verb = ccb.content.text("using drugs"),
    based_on = "time",
    activity_level = 1,
    can_resume = false,
}:ignore("hunger"):ignore("thirst"))

content.add(content.ActivityType {
    id = "ACT_ARMOR_LAYERS",
    verb = ccb.content.text("fiddling with your clothes"),
    based_on = "time",
    activity_level = 1,
    can_resume = false,
})

content.add(content.ActivityType {
    id = "ACT_TRAIN_TEACHER",
    verb = ccb.content.text("teaching"),
    based_on = "speed",
    activity_level = 6,
    can_resume = false,
})

content.add(content.ActivityType {
    id = "ACT_TIDY_UP",
    verb = ccb.content.text("tidying up"),
    based_on = "time",
    activity_level = 4,
})

content.add(content.ActivityType {
    id = "ACT_FERTILIZE_PLOT",
    verb = ccb.content.text("fertilizing plots"),
    based_on = "time",
    activity_level = 4,
    can_resume = false,
    auto_needs = true,
})

ccb.runtime.handler("saline_infusion_turn", function(activity)
    local character = activity.character
    local infusion = services.variables.get_number(character, "amount_of_saline_infused")
    if not infusion.ok then
        error(infusion.error.message)
    end
    local blood_id = services.types.id("vitamin", "blood")
    local blood = services.needs.get_vitamin(character, blood_id)
    if not blood.ok then
        error(blood.error.message)
    end
    -- Native vitamin assignment truncates the resulting level toward zero on every turn.
    local amount = math.modf(blood.value + (infusion.value.value or 0) * (10 / 4) / 3600)
    local updated = services.needs.set_vitamin(character, blood_id, amount)
    if not updated.ok then
        error(updated.error.message)
    end
end, 1)

content.add(content.ActivityType {
    id = "ACT_SALINE_INFUSE",
    verb = ccb.content.text("infusing saline"),
    based_on = "time",
    activity_level = 1,
}:on_turn("saline_infusion_turn"))
