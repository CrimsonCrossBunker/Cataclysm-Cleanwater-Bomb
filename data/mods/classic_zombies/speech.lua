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

line({ "mon_zombie_cunning" }, ccb.content.text("wheezing."), 10)
line({ "mon_zombie_cunning" }, ccb.content.text("moaning."), 20)
line({ "mon_zombie_cunning" }, ccb.content.text("gargling."), 10)
line({ "mon_zombie_cunning" }, ccb.content.text("growling."), 15)
line({ "mon_zombie_cunning" }, ccb.content.text("grunting."), 10)
line({ "mon_zombie_cunning" }, ccb.content.text("gasping."), 5)

for _, pool in ipairs(ordered) do
    content.append_speech_pool(pool)
end
