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

line({ "afs_mon_migoturret" }, ccb.content.text("\"Hello?\""), 40)
line({ "afs_mon_migoturret" }, ccb.content.text("\"Can you help me?\""), 40)
line({ "afs_mon_migoturret" }, ccb.content.text("\"I have no mouth and yet I scream!\""), 60)
line({ "afs_mon_migoturret" }, ccb.content.text("\"¿Por qué?\""), 40)
line({ "afs_mon_migoturret" }, ccb.content.text("\"Come closer little one.\""), 40)
line({ "afs_mon_migoturret" }, ccb.content.text("\"The better to eat you!  I don't actually think I eat anymore.\""), 40)
line({ "afs_mon_migoturret" }, ccb.content.text("\"Cyrus said if I was patient, he could get me a new body.\""), 40)
line({ "afs_mon_migoturret" }, ccb.content.text("\"Quem é Você?\""), 40)
line({ "afs_mon_migoturret" }, ccb.content.text("\"Eu vou te matar!\""), 60)
line({ "afs_mon_migoturret" }, ccb.content.text("\"I can't keep myself from killing you, please run!\""), 60)
line({ "mon_utilibot_beehive" }, ccb.content.text("\"bzzzzzz.\""), 3)
line({ "mon_human_biomachine" }, ccb.content.text("\"west, west, west, west, west\""), 60)
line({ "mon_human_biomachine" }, ccb.content.text("\"east, east, east, east, east\""), 60)
line({ "mon_human_biomachine" }, ccb.content.text("\"south, south, south, south, south\""), 60)
line({ "mon_human_biomachine" }, ccb.content.text("\"north, north, north, north, north\""), 60)
line({ "mon_human_biomachine" }, ccb.content.text("\"Where am I?  Where am I?  Where am I?\""), 60)
line({ "mon_human_biomachine" }, ccb.content.text("\"It's very cold, It's very cold, It's very cold\""), 60)
line({ "mon_human_biomachine" }, ccb.content.text("\"dark, dark, where is everything\""), 60)

for _, pool in ipairs(ordered) do
    content.append_speech_pool(pool)
end
