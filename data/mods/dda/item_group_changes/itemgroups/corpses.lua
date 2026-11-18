local content = require("ccb").content

do
    -- Damage based off descriptions
    local group = content.ItemGroup { id = "corpses", kind = "distribution" }
    group:entry { group = "corpse_generic_male", damage = { 0, 1 }, probability = 80 }
    group:entry { group = "corpse_generic_female", damage = { 0, 1 }, probability = 80 }
    group:entry { group = "corpse_generic_boy", damage = { 0, 1 }, probability = 15 }
    group:entry { group = "corpse_generic_girl", damage = { 0, 1 }, probability = 15 }
    group:entry { group = "corpse_generic_human", damage = { 0, 1 }, probability = 10 }
    group:entry { group = "corpse_generic_gunned", damage = { 1, 3 }, probability = 40 }
    group:group("corpse_generic_infected", 40)
    group:entry { group = "corpse_bloody", damage = { 1, 3 }, probability = 10 }
    group:entry { group = "corpse_painful", damage = { 0, 2 }, probability = 10 }
    group:entry { group = "corpse_scorched", damage = { 3, 4 }, probability = 10 }
    group:entry { group = "corpse_stabbed", damage = { 1, 3 }, probability = 10 }
    group:entry { group = "corpse_gunned", damage = { 1, 3 }, probability = 10 }
    group:entry { group = "corpse_halved_upper", damage = { 4, 4 }, probability = 10 }
    group:entry { group = "corpse_half_beheaded", damage = { 4, 4 }, probability = 10 }
    group:group("corpse_child_calm", 10)
    group:entry { group = "corpse_child_gunned", damage = { 2, 4 }, probability = 10 }
    group:entry { group = "corpse_oldwoman_jewelry", damage = { 1, 3 }, probability = 10 }
    content.add(group)
end

do
    local group = content.ItemGroup { id = "corpse_painful", kind = "distribution", container = "corpse_painful" }
    group:group("default_zombie_death_drops")
    content.add(group)
end
