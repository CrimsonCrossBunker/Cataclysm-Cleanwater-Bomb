local content = require("ccb").content

-- enchantments.json
content.add(content.Enchantment { id = "fcl_melee_counteraction", condition = "ACTIVE" }
    :hit_me({ id = "fcl_generic_free_turn", self = true, trigger_message = content.text("You react with machine-like precision."), npc_trigger_message = content.text("%1$s's reacts with robotic precision.") }))

content.add(content.Enchantment { id = "fcl_melee_optimization", condition = "ACTIVE" }
    :hit_you({ id = "fcl_generic_speed_bonus", self = true }))
