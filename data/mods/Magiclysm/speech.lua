local ccb = require("ccb")
local content = ccb.content
local pools = {}
local ordered = {}

local function line(speakers, sound, volume)
    for _, speaker in ipairs(speakers) do
        local pool = pools[speaker]
        if pool == nil then
            pool = content.SpeechPool { id = speaker }
            pools[speaker] = pool
            ordered[#ordered + 1] = pool
        end
        pool:line(sound, volume)
    end
end

-- This and below represent the mi-go parroting incantations they've heard from captured human (and elven, dwarven, etc) wizards, not them casting spells using them.
line({ "mon_mi_go_fleshwarper", "mon_mi_go_nethermancer" }, ccb.content.text("\"Abra-cadabra!\""), 20)
-- TRANSLATORS: The mi-go is parroting a Latin incantation here that should not be translated.
line({ "mon_mi_go_fleshwarper", "mon_mi_go_nethermancer" }, ccb.content.text("\"Per Adonai Elohim, Adonai Jehova, Adonai Sabaoth…\""), 20)
-- TRANSLATORS: The mi-go is parroting a Latin incantation here that should not be translated.
line({ "mon_mi_go_fleshwarper", "mon_mi_go_nethermancer" }, ccb.content.text("\"Metraton on agla mathon, verbum pythonicum, mysterium salamandrae…\""), 20)
-- TRANSLATORS: The mi-go is parroting a Latin incantation here that should not be translated.
line({ "mon_mi_go_fleshwarper", "mon_mi_go_nethermancer" }, ccb.content.text("\"Conventus sylvorum, antra gnomorum, daemonia coeli gad…\""), 20)
-- TRANSLATORS: The mi-go is parroting a Latin incantation here that should not be translated.
line({ "mon_mi_go_fleshwarper", "mon_mi_go_nethermancer" }, ccb.content.text("\"Almousin, gibor, jehosua, evam, zariatnatmik, veni, veni, veni…\""), 20)
-- TRANSLATORS: The mi-go is parroting an incantation here that should not be translated.
line({ "mon_mi_go_fleshwarper", "mon_mi_go_nethermancer" }, ccb.content.text("\"Y'ai 'nh'ngah h'ee-l'geb f'ai throdog uaaah!\""), 20)
-- TRANSLATORS: The mi-go is parroting an incantation here that should not be translated.
line({ "mon_mi_go_fleshwarper", "mon_mi_go_nethermancer" }, ccb.content.text("\"Ogthrod ai'f geb'l-ee'h 'ngah'ng ai'y zhro!\""), 20)
line({ "mon_zombie_dwarf", "mon_zombie_elf", "mon_zombie_goblin", "mon_zombie_ravenfolk", "mon_zombie_lizardfolk" }, ccb.content.text("wheezing."), 10)
line({ "mon_zombie_dwarf", "mon_zombie_elf", "mon_zombie_goblin", "mon_zombie_lizardfolk" }, ccb.content.text("moaning."), 20)
line({ "mon_zombie_ravenfolk" }, ccb.content.text("screeching."), 20)

for _, pool in ipairs(ordered) do
    content.append_speech_pool(pool)
end
