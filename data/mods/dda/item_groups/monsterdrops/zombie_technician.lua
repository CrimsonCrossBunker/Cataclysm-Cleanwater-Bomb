local content = require("ccb").content

do
    local group = content.ItemGroup { id = "mon_zombie_technician_death_drops", kind = "collection" }
    group:entry { group = "clothing_work_set", damage = { 1, 4 } }
    group:entry { group = "underwear", damage = { 1, 4 } }
    group:entry { group = "default_zombie_items_pockets", damage = { 0, 2 }, probability = 80 }
    group:entry {
        distribution = {
            { group = "tools_workshop", probability = 30 },
            { group = "tools_toolbox", probability = 70 },
        },
        probability = 50,
    }
    group:entry { group = "supplies_electronics", count = { 1, 3 }, probability = 70 }
    group:entry { group = "wallets", damage = { 1, 4 }, probability = 60 }
    group:item("id_industrial", 20)
    content.add(group)
end

do
    local group = content.ItemGroup { id = "worker_kitted_hard_hat", kind = "collection" }
    group:entry { item = "attachable_ear_muffs", damage = { 1, 3 }, probability = 50 }
    group:entry {
        distribution = {
            { item = "nape_protector", damage = { 1, 3 } },
            { item = "mesh_nape_protector", damage = { 1, 3 } },
        },
        probability = 60,
    }
    group:entry {
        distribution = {
            { item = "shield_visor", damage = { 1, 3 } },
            { item = "face_shield", damage = { 1, 3 } },
            { item = "face_shield_plastic", damage = { 1, 3 } },
        },
        probability = 60,
    }
    content.add(group)
end

do
    local group = content.ItemGroup { id = "mon_zombie_miner_death_drops", kind = "collection" }
    group:entry { group = "clothing_work_boots", damage = { 1, 4 }, probability = 60 }
    group:entry { group = "clothing_work_glasses", damage = { 1, 4 }, probability = 60 }
    group:entry { group = "clothing_work_gloves", damage = { 1, 4 }, probability = 50 }
    group:entry { group = "clothing_work_mask", damage = { 1, 4 }, probability = 40 }
    group:entry { group = "default_zombie_items_pockets", damage = { 0, 2 }, probability = 80 }
    group:entry { group = "wallets", damage = { 1, 4 }, probability = 40 }
    group:entry { item = "tool_belt", damage = { 1, 4 }, probability = 25 }
    group:entry {
        distribution = {
            { item = "pickaxe", damage = { 1, 3 }, probability = 10 },
            { item = "shovel", damage = { 1, 3 }, probability = 50 },
        },
        probability = 40,
    }
    group:entry {
        distribution = {
            {
                collection = {
                    {
                        distribution = {
                            {
                                item = "hat_hard",
                                damage = { 1, 3 },
                                variant = "yellow_hat_hard",
                                contents = {
                                    { group = "worker_kitted_hard_hat" },
                                },
                            },
                            {
                                item = "hat_hard",
                                damage = { 1, 3 },
                                variant = "green_hat_hard",
                                contents = {
                                    { group = "worker_kitted_hard_hat" },
                                },
                                probability = 10,
                            },
                            {
                                collection = {
                                    {
                                        item = "hat_hard",
                                        damage = { 1, 3 },
                                        variant = "white_hat_hard",
                                        contents = {
                                            { group = "worker_kitted_hard_hat" },
                                        },
                                    },
                                    {
                                        distribution = {
                                            { group = "used_1st_aid", probability = 70 },
                                            { group = "full_1st_aid", probability = 30 },
                                        },
                                    },
                                },
                                probability = 5,
                            },
                        },
                    },
                    {
                        distribution = {
                            { item = "ear_plugs", damage = { 1, 4 }, probability = 15 },
                            { group = "tools_lighting_industrial", damage = { 1, 3 } },
                            { item = "electric_lantern", charges = { 0, 100 }, damage = { 1, 3 } },
                        },
                    },
                },
            },
            {
                group = "hat_hard_flashlight",
                damage = { 1, 4 },
                contents = {
                    { group = "worker_kitted_hard_hat" },
                },
                probability = 40,
            },
        },
    }
    group:entry { item = "glowstick", count = { 1, 3 }, charges = { 1400, 1400 }, probability = 30 }
    group:item("multitool", 10)
    group:entry {
        distribution = {
            {
                collection = {
                    { group = "clothing_work_pants", damage = { 1, 4 } },
                    { group = "clothing_work_torso", damage = { 1, 4 } },
                },
                probability = 70,
            },
            { item = "technician_coveralls", damage = { 1, 4 }, probability = 20 },
            { item = "technician_coveralls_h", damage = { 1, 4 }, probability = 10 },
        },
    }
    group:entry { group = "underwear", damage = { 1, 4 } }
    content.add(group)
end
