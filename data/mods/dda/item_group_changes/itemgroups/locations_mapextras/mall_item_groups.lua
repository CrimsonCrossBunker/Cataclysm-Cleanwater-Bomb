local content = require("ccb").content

do
    local group = content.ItemGroup { id = "music_shop", kind = "distribution", with_ammo = 75, with_magazine = 100 }
    group:group("box_of_batteries_unopened", 50)
    group:entry { item = "radio", charges = { 100, 100 }, probability = 30 }
    group:entry { item = "mp3", charges = { 100, 100 }, probability = 25 }
    group:item("national_flag", 1)
    content.add(group)
end

do
    local group = content.ItemGroup { id = "vitamin_shop", kind = "distribution" }
    group:group("adhesive_bandages_box_full", 25)
    group:group("full_1st_aid", 15)
    group:group("full_ifak", 15)
    group:group("vitamins_bottle_plastic_pill_supplement_20", 75)
    group:group("calcium_tablet_bottle_full", 75)
    group:group("vitc_tablet_bottle_full", 75)
    group:group("aspirin_bottle_full", 45)
    group:group("ibuprofen_bottle_full", 45)
    group:group("naproxen_bottle_full", 45)
    group:group("acetaminophen_bottle_full", 45)
    group:group("caffeine_bottle_full", 50)
    group:group("pills_sleep_bottle_full", 45)
    group:group("melatonin_bottle_full", 30)
    group:item("disinfectant", 15)
    group:group("protein_bottle_full", 40)
    group:group("chewing_gum_full_caff", 30)
    group:group("chewing_gum_full_nic", 25)
    group:item("bathroom_scale", 20)
    group:group("pillbox_any_empty", 20)
    content.add(group)
end
