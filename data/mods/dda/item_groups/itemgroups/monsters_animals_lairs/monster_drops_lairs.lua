local content = require("ccb").content

do
    local group = content.ItemGroup { id = "monparts", kind = "distribution" }
    group:item("meat", 50)
    group:item("veggy", 30)
    group:item("meat_tainted", 60)
    group:item("veggy_tainted", 35)
    group:item("royal_jelly", 8)
    group:item("ant_egg", 5)
    group:item("bee_sting", 5)
    group:item("fighter_sting", 5)
    group:item("chitin_piece", 10)
    content.add(group)
end

do
    local group = content.ItemGroup { id = "kraken_food", kind = "distribution" }
    group:item("meat", 50)
    group:item("fish", 80)
    group:item("meat_tainted", 60)
    group:item("arm", 4)
    group:item("leg", 4)
    group:item("rock", 40)
    group:item("razorclaw_roe", 5)
    group:item("stick", 95)
    group:item("survivormap", 1)
    group:entry { item = "wetsuit", damage = { 2, 4 }, probability = 10 }
    group:entry { item = "wetsuit_thick", damage = { 2, 4 }, probability = 10 }
    group:item("homemade_bomb_act", 1)
    content.add(group)
end

do
    local group = content.ItemGroup { id = "razorclaw_nest", kind = "distribution" }
    group:entry { item = "razorclaw_roe", count = { 1, 6 } }
    content.add(group)
end

do
    local group = content.ItemGroup { id = "biollante", kind = "distribution" }
    group:item("biollante_bud", 1)
    content.add(group)
end

do
    local group = content.ItemGroup { id = "fungal_sting", kind = "distribution" }
    group:item("fighter_sting", 5)
    content.add(group)
end

do
    local group = content.ItemGroup { id = "cow", kind = "distribution" }
    group:item("cow_bell", 1)
    content.add(group)
end

do
    local group = content.ItemGroup { id = "dog_cop", kind = "distribution" }
    group:item("kevlar_harness", 1)
    content.add(group)
end

do
    local group = content.ItemGroup { id = "dog_clothes", kind = "distribution" }
    group:item("rubber_harness_dog", 50)
    group:item("leather_harness_dog", 25)
    group:item("kevlar_harness", 1)
    content.add(group)
end

do
    -- Bug butchery remains
    local group = content.ItemGroup { id = "bug_parts", kind = "distribution" }
    group:item("chitin_piece", 70)
    group:item("acidchitin_piece", 30)
    group:item("endochitin", 70)
    group:item("mutant_bug_hydrogen_sacs", 30)
    group:entry { item = "mutant_bug_lungs", count = { 4, 4 }, probability = 10 }
    group:item("mutant_bug_organs", 10)
    group:item("sinew", 10)
    group:item("bee_sting", 10)
    content.add(group)
end

do
    -- Normal/mutated animal remains
    local group = content.ItemGroup { id = "vertebrate_parts", kind = "distribution" }
    group:item("skull_canis", 10)
    group:item("skull_canis_medium", 15)
    group:item("skull_feline_small", 15)
    group:item("skull_rodent", 25)
    group:item("skull_pig", 10)
    group:item("skull_bovine", 5)
    group:item("skull_cervine", 10)
    group:item("skull_moose", 3)
    group:item("bone", 80)
    group:item("feather", 80)
    group:item("raw_leather", 30)
    group:item("raw_fur", 30)
    group:item("wool_staple", 30)
    group:item("sinew", 5)
    group:entry { item = "brain", count = { 4, 4 }, probability = 5 }
    group:entry { item = "lung", count = { 4, 4 }, probability = 5 }
    group:entry { item = "liver", count = { 4, 4 }, probability = 5 }
    group:entry { item = "sweetbread", count = { 4, 4 }, probability = 5 }
    group:item("stomach", 5)
    group:item("stomach_large", 5)
    group:entry { item = "kidney", count = { 4, 4 }, probability = 5 }
    group:item("jabberwock_heart", 1)
    content.add(group)
end

do
    -- (demi)human remains
    local group = content.ItemGroup { id = "human_parts", kind = "distribution" }
    group:item("skull_human", 20)
    group:item("bone_human", 80)
    group:item("raw_hleather", 30)
    group:item("raw_demihumanleather", 5)
    group:item("raw_hfur", 1)
    group:item("sinew", 5)
    group:item("hstomach", 5)
    group:item("demihuman_stomach", 1)
    group:item("hstomach_large", 5)
    group:item("demihuman_stomach_large", 1)
    content.add(group)
end
