local content = {}

function content.register(ccb)
    local fac = ccb.content.MonsterFaction {
        id = "fac_lua_first_drone",
    }
    fac:attitude("friendly", "fac_lua_first_drone")
    fac:attitude("friendly", "bot")
    fac:attitude("neutral", "human")
    ccb.content.add(fac)

    local species = ccb.content.Species {
        id = "SPECIES_LUA_TUTORIAL",
    }
    species:flag("ELECTRONIC")
    species:anger("HURT")
    species:fear("FIRE")
    ccb.content.add(species)

    local attack = ccb.content.MonsterAttack {
        id = "atk_lua_first_purifying_pulse",
        cooldown = 4,
    }
    attack:policy("lua_first_monster_attack_pulse")
    ccb.content.add(attack)

    local item_group = ccb.content.ItemGroup {
        id = "ig_lua_first_drone_death_drops",
        kind = "collection",
    }
    item_group:item("scrap", 50)
    item_group:item("battery", 30)
    ccb.content.add(item_group)

    local harvest = ccb.content.Harvest {
        id = "harvest_lua_first_synthetic_drone",
        message = "You carefully salvage the synthetic components.",
        leftovers = "ruined_chunks",
        butchery_requirements = "default",
    }
    harvest:drop {
        output = "scrap",
        category = "flesh",
        base_minimum = 1,
        base_maximum = 3,
        mass_ratio = 0.3,
    }
    harvest:drop {
        output = "battery",
        category = "flesh",
        base_minimum = 1,
        base_maximum = 1,
        mass_ratio = 0.1,
    }
    ccb.content.add(harvest)

    local patrol = ccb.content.Behavior {
        id = "lua_first_ai_goal_patrol",
        goal = "patrol",
    }
    patrol:when("lua_first_ai_should_patrol", "nearby", false)
    ccb.content.add(patrol)

    local combat = ccb.content.Behavior {
        id = "lua_first_ai_goal_combat",
        goal = "combat",
    }
    combat:score("lua_first_ai_combat_utility", "standard")
    ccb.content.add(combat)

    local root = ccb.content.Behavior {
        id = "lua_first_ai_root",
        strategy = "utility",
    }
    root:child("lua_first_ai_goal_combat")
    root:child("lua_first_ai_goal_patrol")
    ccb.content.add(root)

    local drone = ccb.content.Monster {
        id = "mon_lua_first_tutorial_drone",
        name = "tutorial training drone",
        description = "A hovering robotic sphere demonstrating custom Lua monster properties, dynamic attacks, harvest tables, and behavior tree AI.",
        symbol = "d",
        color = "c_cyan",
        default_faction = "fac_lua_first_drone",
        death_drops = "ig_lua_first_drone_death_drops",
        hp = 40,
        speed = 100,
        aggression = 0,
        morale = 100,
        tracking_distance = 5,
        attack_cost = 100,
        melee_skill = 2,
        melee_dice = 1,
        melee_sides = 4,
        dodge = 2,
        vision_day = 30,
        vision_night = 20,
        harvest = "harvest_lua_first_synthetic_drone",
    }
    drone:material("steel", 2)
    drone:species("SPECIES_LUA_TUTORIAL")
    drone:flag("SEES")
    drone:flag("HEARS")
    drone:flag("ELECTRONIC")
    drone:flag("NOHEAD")
    drone:attack("atk_lua_first_purifying_pulse", 4)
    drone:goal("lua_first_ai_root")
    ccb.content.add(drone)
end

return content
