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

line({ "mon_zombie_scientist_phavian", "mon_zombie_blank", "mon_zombie_concentration_ender" }, ccb.content.text("wheezing."), 10)
line({ "mon_zombie_scientist_phavian", "mon_zombie_blank", "mon_zombie_concentration_ender" }, ccb.content.text("moaning."), 20)
line({ "mon_zombie_scientist_phavian", "mon_zombie_blank", "mon_zombie_concentration_ender" }, ccb.content.text("gargling."), 10)
line({ "mon_zombie_scientist_phavian", "mon_zombie_blank", "mon_zombie_concentration_ender" }, ccb.content.text("growling."), 15)
line({ "mon_zombie_scientist_phavian", "mon_zombie_blank", "mon_zombie_concentration_ender" }, ccb.content.text("grunting."), 10)
line({ "mon_zombie_scientist_phavian", "mon_zombie_blank", "mon_zombie_concentration_ender" }, ccb.content.text("gasping."), 5)
line({ "mon_feral_human_pyrokin3", "mon_feral_human_pyrokin2", "mon_civilian_pyrokinetic" }, ccb.content.text("the crackle of flames."), 10)
line({ "mon_feral_human_pyrokin3", "mon_feral_human_pyrokin2" }, ccb.content.text("\"Must… burn…\""), 10)
line({ "mon_feral_human_teep2", "mon_zombie_concentration_ender", "mon_zombie_nullpsi", "mon_zombie_psi_void" }, ccb.content.text("a low droning hum inside your head."), 10)
line({ "mon_feral_human_teep2" }, ccb.content.text("a tuneless whistling inside your head."), 10)
line({ "mon_feral_human_teep2", "mon_civilian_telepath" }, ccb.content.text("an inarticulate cry inside your head."), 10)
line({ "mon_feral_human_teep2" }, ccb.content.text("quiet laughter inside your head."), 10)
line({ "mon_feral_human_bio3", "mon_feral_security_captain_psychic" }, ccb.content.text("\"Kill…\""), 10)
line({ "mon_feral_human_clair2", "mon_feral_human_clair3" }, ccb.content.text("\"I… see…\""), 10)
line({ "mon_feral_human_clair3" }, ccb.content.text("\"You… see…\""), 10)
line({ "mon_feral_human_clair3" }, ccb.content.text("\"Can you see?\""), 10)
line({ "mon_civilian_clairsentient" }, ccb.content.text("\"I told you they were coming.\""), 10)
line({ "mon_civilian_clairsentient" }, ccb.content.text("\"You didn't listen!\""), 10)
line({ "mon_civilian_clairsentient" }, ccb.content.text("\"Just like the dreams.\""), 10)
line({ "mon_civilian_clairsentient" }, ccb.content.text("\"This is the end.\""), 10)
line({ "mon_civilian_clairsentient" }, ccb.content.text("\"I knew it.  I knew it.  I knew it.\""), 10)
line({ "mon_civilian_clairsentient" }, ccb.content.text("\"Doom.  DOOM!\""), 10)
line({ "mon_civilian_clairsentient" }, ccb.content.text("\"You didn't listen!\""), 10)
line({ "mon_civilian_pyrokinetic" }, ccb.content.text("\"Burn them all!  Burn them to ash!\""), 15)
line({ "mon_civilian_telepath" }, ccb.content.text("a voice inside your head mutter, \"No no no no.\"."), 10)
line({ "mon_civilian_telepath" }, ccb.content.text("a voice inside your head whisper, \"No escape…\"."), 10)
line({ "mon_civilian_telepath" }, ccb.content.text("a voice inside your head say, \"Why?  Why?  Why?\"."), 10)
line({ "mon_feral_human_porter3" }, ccb.content.text("\"Lost between…\""), 10)
line({ "mon_feral_human_porter3", "mon_civilian_teleporter" }, ccb.content.text("\"So… cold…\""), 10)
line({ "mon_feral_human_porter3", "mon_civilian_teleporter" }, ccb.content.text("\"So… dark…\""), 10)
line({ "mon_civilian_vitakinetic" }, ccb.content.text("\"I have to live!\""), 15)
line({ "mon_civilian_vitakinetic" }, ccb.content.text("\"Have to escape.\""), 10)
line({ "mon_civilian_vitakinetic" }, ccb.content.text("\"Must survive.\""), 10)
line({ "mon_civilian_vitakinetic" }, ccb.content.text("\"I need a way out!\""), 15)
line({ "mon_feral_scientist_psychic" }, ccb.content.text("quiet laughter."), 10)
line({ "mon_feral_scientist_psychic" }, ccb.content.text("\"Yes…\""), 10)
line({ "mon_feral_scientist_psychic" }, ccb.content.text("\"A test subject…\""), 10)
line({ "mon_feral_scientist_psychic" }, ccb.content.text("\"Ah, yes…\""), 10)
line({ "mon_feral_security_captain_psychic", "mon_feral_security_psychic" }, ccb.content.text("\"Stop!\""), 15)
line({ "mon_feral_security_captain_psychic", "mon_feral_security_psychic" }, ccb.content.text("\"This is a restricted area!\""), 15)
line({ "mon_feral_security_captain_psychic", "mon_feral_security_psychic" }, ccb.content.text("\"Authorized personnel only!\""), 15)
line({ "mon_feral_security_captain_psychic", "mon_feral_security_psychic" }, ccb.content.text("\"Leave!\""), 15)

for _, pool in ipairs(ordered) do
    content.append_speech_pool(pool)
end
