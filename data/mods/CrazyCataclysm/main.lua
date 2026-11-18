local ccb = require("ccb")
local content = ccb.content

local definition = content.Blacklist {
    kind = "monster",
    whitelist = true,
}
definition:entry("mon_zombie_dancer")
definition:entry("mon_zombie_jackson")
definition:entry("mon_shia")
definition:entry("mon_bear_smoky")
definition:entry("mon_zombie_skeltal")
definition:entry("mon_zombie_skeltal_minion")
content.add(definition)

require("speech")

require("ammo_effects")

require("snippets")

require("disassembly")

require("food_recipes")

require("weapon_recipes")

require("craft_recipes")

require("item_groups")

require("item_group_changes")

require("generic_items")

require("inherited_items")
