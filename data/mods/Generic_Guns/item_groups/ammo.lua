local content = require("ccb").content

do
    local group = content.ItemGroup { id = "boxed_pistol", kind = "distribution" }
    group:group("boxed_pistol_20")
    group:group("boxed_pistol_100", 10)
    content.add(group)
end

do
    local group = content.ItemGroup { id = "boxed_pistol_20", kind = "distribution", container = "pistol_ammo_box_20" }
    group:entry { item = "pistol_ball", charges = { 20, 20 }, probability = 1 }
    group:entry { item = "pistol_jhp", charges = { 20, 20 }, probability = 10 }
    content.add(group)
end

do
    local group = content.ItemGroup { id = "boxed_pistol_100", kind = "distribution", container = "pistol_ammo_box_100" }
    group:entry { item = "pistol_ball", charges = { 100, 100 }, probability = 10 }
    group:entry { item = "pistol_jhp", charges = { 100, 100 }, probability = 1 }
    content.add(group)
end

do
    local group = content.ItemGroup { id = "boxed_pistol_tiny", kind = "distribution" }
    group:group("boxed_pistol_tiny_50")
    group:group("boxed_pistol_tiny_250", 10)
    content.add(group)
end

do
    local group = content.ItemGroup { id = "boxed_pistol_tiny_50", kind = "distribution", container = "pistol_tiny_ammo_box_50" }
    group:entry { item = "tiny_pistol_ball", charges = { 50, 50 }, probability = 1 }
    group:entry { item = "tiny_pistol_jhp", charges = { 50, 50 }, probability = 10 }
    content.add(group)
end

do
    local group = content.ItemGroup {
        id = "boxed_pistol_tiny_250",
        kind = "distribution",
        container = "pistol_tiny_ammo_box_250",
    }
    group:entry { item = "tiny_pistol_ball", charges = { 250, 250 }, probability = 10 }
    group:entry { item = "tiny_pistol_jhp", charges = { 250, 250 }, probability = 1 }
    content.add(group)
end

do
    local group = content.ItemGroup { id = "boxed_magnum", kind = "distribution", container = "magnum_ammo_box_20" }
    group:entry { item = "pistol_magnum_ball", charges = { 20, 20 } }
    group:entry { item = "pistol_magnum_jhp", charges = { 20, 20 } }
    content.add(group)
end

do
    local group = content.ItemGroup { id = "boxed_rifle", kind = "distribution" }
    group:group("boxed_rifle_20")
    group:group("boxed_rifle_50", 10)
    content.add(group)
end

do
    local group = content.ItemGroup { id = "boxed_rifle_20", kind = "distribution", container = "rifle_ammo_box_20" }
    group:entry { item = "rifle_ball", charges = { 20, 20 } }
    group:entry { item = "rifle_AP", charges = { 20, 20 } }
    content.add(group)
end

do
    local group = content.ItemGroup { id = "boxed_rifle_50", kind = "distribution", container = "rifle_ammo_box_50" }
    group:entry { item = "rifle_ball", charges = { 50, 50 }, probability = 10 }
    group:entry { item = "rifle_AP", charges = { 50, 50 }, probability = 1 }
    content.add(group)
end

do
    local group = content.ItemGroup { id = "boxed_shot", kind = "distribution", container = "shot_ammo_box_10" }
    group:entry { item = "shot_buck", charges = { 10, 10 } }
    group:entry { item = "shot_fowl", charges = { 10, 10 } }
    group:entry { item = "shot_foster", charges = { 10, 10 } }
    content.add(group)
end

do
    local group = content.ItemGroup { id = "boxed_pistol_used", kind = "distribution" }
    group:group("boxed_pistol_20_used")
    group:group("boxed_pistol_100_used", 10)
    content.add(group)
end

do
    local group = content.ItemGroup {
        id = "boxed_pistol_20_used",
        kind = "distribution",
        container = "pistol_ammo_box_20",
        overflow = "spill",
    }
    group:entry { item = "pistol_ball", count = { 10, 30 }, charges = { 1, 1 }, probability = 1 }
    group:entry { item = "pistol_jhp", count = { 10, 30 }, charges = { 1, 1 }, probability = 10 }
    content.add(group)
end

do
    local group = content.ItemGroup {
        id = "boxed_pistol_100_used",
        kind = "distribution",
        container = "pistol_ammo_box_100",
        overflow = "spill",
    }
    group:entry { item = "pistol_ball", count = { 50, 150 }, charges = { 1, 1 }, probability = 10 }
    group:entry { item = "pistol_jhp", count = { 50, 150 }, charges = { 1, 1 }, probability = 1 }
    content.add(group)
end

do
    local group = content.ItemGroup { id = "boxed_pistol_tiny_used", kind = "distribution" }
    group:group("boxed_pistol_tiny_50_used")
    group:group("boxed_pistol_tiny_250_used", 10)
    content.add(group)
end

do
    local group = content.ItemGroup {
        id = "boxed_pistol_tiny_50_used",
        kind = "distribution",
        container = "pistol_tiny_ammo_box_50",
        overflow = "spill",
    }
    group:entry { item = "tiny_pistol_ball", count = { 25, 75 }, charges = { 1, 1 }, probability = 1 }
    group:entry { item = "tiny_pistol_jhp", count = { 25, 75 }, charges = { 1, 1 }, probability = 10 }
    content.add(group)
end

do
    local group = content.ItemGroup {
        id = "boxed_pistol_tiny_250_used",
        kind = "distribution",
        container = "pistol_tiny_ammo_box_250",
        overflow = "spill",
    }
    group:entry { item = "tiny_pistol_ball", count = { 200, 300 }, charges = { 1, 1 }, probability = 10 }
    group:entry { item = "tiny_pistol_jhp", count = { 200, 300 }, charges = { 1, 1 }, probability = 1 }
    content.add(group)
end

do
    local group = content.ItemGroup {
        id = "boxed_magnum_used",
        kind = "distribution",
        container = "magnum_ammo_box_20",
        overflow = "spill",
    }
    group:entry { item = "pistol_magnum_ball", count = { 10, 30 }, charges = { 1, 1 } }
    group:entry { item = "pistol_magnum_jhp", count = { 10, 30 }, charges = { 1, 1 } }
    content.add(group)
end

do
    local group = content.ItemGroup { id = "boxed_rifle_used", kind = "distribution" }
    group:group("boxed_rifle_20_used")
    group:group("boxed_rifle_50_used", 10)
    content.add(group)
end

do
    local group = content.ItemGroup {
        id = "boxed_rifle_20_used",
        kind = "distribution",
        container = "rifle_ammo_box_20",
        overflow = "spill",
    }
    group:entry { item = "rifle_ball", count = { 10, 30 }, charges = { 1, 1 } }
    group:entry { item = "rifle_AP", count = { 10, 30 }, charges = { 1, 1 } }
    content.add(group)
end

do
    local group = content.ItemGroup {
        id = "boxed_rifle_50_used",
        kind = "distribution",
        container = "rifle_ammo_box_50",
        overflow = "spill",
    }
    group:entry { item = "rifle_ball", count = { 25, 75 }, charges = { 1, 1 }, probability = 10 }
    group:entry { item = "rifle_AP", count = { 25, 75 }, charges = { 1, 1 }, probability = 1 }
    content.add(group)
end

do
    local group = content.ItemGroup {
        id = "boxed_shot_used",
        kind = "distribution",
        container = "shot_ammo_box_10",
        overflow = "spill",
    }
    group:entry { item = "shot_buck", count = { 5, 15 }, charges = { 1, 1 } }
    group:entry { item = "shot_fowl", count = { 5, 15 }, charges = { 1, 1 } }
    group:entry { item = "shot_foster", count = { 5, 15 }, charges = { 1, 1 } }
    content.add(group)
end

do
    local group = content.ItemGroup { id = "boxed_pistol_looted", kind = "distribution" }
    group:group("boxed_pistol_20_looted")
    group:group("boxed_pistol_100_looted", 10)
    content.add(group)
end

do
    local group = content.ItemGroup { id = "boxed_pistol_20_looted", kind = "distribution", container = "pistol_ammo_box_20" }
    group:entry { item = "pistol_ball", charges = { 0, 5 }, probability = 1 }
    group:entry { item = "pistol_jhp", charges = { 0, 5 }, probability = 10 }
    content.add(group)
end

do
    local group = content.ItemGroup { id = "boxed_pistol_100_looted", kind = "distribution", container = "pistol_ammo_box_100" }
    group:entry { item = "pistol_ball", charges = { 0, 20 }, probability = 10 }
    group:entry { item = "pistol_jhp", charges = { 0, 20 }, probability = 1 }
    content.add(group)
end

do
    local group = content.ItemGroup { id = "boxed_pistol_tiny_looted", kind = "distribution" }
    group:group("boxed_pistol_tiny_50_looted")
    group:group("boxed_pistol_tiny_250_looted", 10)
    content.add(group)
end

do
    local group = content.ItemGroup {
        id = "boxed_pistol_tiny_50_looted",
        kind = "distribution",
        container = "pistol_tiny_ammo_box_50",
    }
    group:entry { item = "tiny_pistol_ball", charges = { 0, 15 }, probability = 1 }
    group:entry { item = "tiny_pistol_jhp", charges = { 0, 15 }, probability = 10 }
    content.add(group)
end

do
    local group = content.ItemGroup {
        id = "boxed_pistol_tiny_250_looted",
        kind = "distribution",
        container = "pistol_tiny_ammo_box_250",
    }
    group:entry { item = "tiny_pistol_ball", charges = { 0, 40 }, probability = 10 }
    group:entry { item = "tiny_pistol_jhp", charges = { 0, 40 }, probability = 1 }
    content.add(group)
end

do
    local group = content.ItemGroup { id = "boxed_magnum_looted", kind = "distribution", container = "magnum_ammo_box_20" }
    group:entry { item = "pistol_magnum_ball", charges = { 0, 5 } }
    group:entry { item = "pistol_magnum_jhp", charges = { 0, 5 } }
    content.add(group)
end

do
    local group = content.ItemGroup { id = "boxed_rifle_looted", kind = "distribution" }
    group:group("boxed_rifle_20_looted")
    group:group("boxed_rifle_50_looted", 10)
    content.add(group)
end

do
    local group = content.ItemGroup { id = "boxed_rifle_20_looted", kind = "distribution", container = "rifle_ammo_box_20" }
    group:entry { item = "rifle_ball", charges = { 0, 5 } }
    group:entry { item = "rifle_AP", charges = { 0, 5 } }
    content.add(group)
end

do
    local group = content.ItemGroup { id = "boxed_rifle_50_looted", kind = "distribution", container = "rifle_ammo_box_50" }
    group:entry { item = "rifle_ball", charges = { 0, 10 }, probability = 10 }
    group:entry { item = "rifle_AP", charges = { 0, 10 }, probability = 1 }
    content.add(group)
end

do
    local group = content.ItemGroup { id = "boxed_shot_looted", kind = "distribution", container = "shot_ammo_box_10" }
    group:entry { item = "shot_buck", charges = { 0, 2 } }
    group:entry { item = "shot_fowl", charges = { 0, 2 } }
    group:entry { item = "shot_foster", charges = { 0, 2 } }
    content.add(group)
end
