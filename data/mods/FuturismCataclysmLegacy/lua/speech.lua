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

line({ "mon_eyebot" }, ccb.content.text("\"Stop where you are!\""), 15)
line({ "mon_eyebot" }, ccb.content.text("\"You are under arrest!\""), 15)
line({ "mon_eyebot" }, ccb.content.text("\"Criminal activity detected!\""), 10)
line({ "mon_eyebot" }, ccb.content.text("\"Criminal activity registered!\""), 15)
line({ "mon_eyebot" }, ccb.content.text("\"Violation of law detected!\""), 15)
line({ "mon_eyebot" }, ccb.content.text("\"Suspect on the move!\""), 15)
line({ "mon_eyebot" }, ccb.content.text("\"Suspect in sight!\""), 15)
line({ "mon_eyebot" }, ccb.content.text("\"You are being detained!\""), 15)
line({ "mon_eyebot" }, ccb.content.text("\"You have right to remain silent!\""), 15)
line({ "mon_eyebot" }, ccb.content.text("\"Requesting assistance!\""), 15)
line({ "mon_eyebot" }, ccb.content.text("\"Requesting supervisor!\""), 15)
line({ "mon_eyebot" }, ccb.content.text("\"Requesting human officer!\""), 15)
line({ "mon_eyebot" }, ccb.content.text("\"No officer on scene.  Requesting backup!\""), 15)
line({ "mon_eyebot" }, ccb.content.text("\"Let me see your hands!\""), 15)
line({ "mon_eyebot" }, ccb.content.text("\"Stop resisting!\""), 15)
line({ "mon_eyebot" }, ccb.content.text("\"Code 10-66.  Copy 10-4.  Possible 10-55.\""), 10)
line({ "mon_eyebot" }, ccb.content.text("\"Probable 10-70.\""), 15)
line({ "mon_eyebot" }, ccb.content.text("\"Get on the ground!  Now!\""), 15)
line({ "mon_eyebot" }, ccb.content.text("\"Suspected felony!\""), 15)
line({ "mon_eyebot" }, ccb.content.text("\"Suspected misdemeanor!\""), 15)
line({ "mon_eyebot" }, ccb.content.text("\"Do not reach for your pockets!\""), 15)
line({ "mon_eyebot" }, ccb.content.text("\"Keep your hands up!\""), 15)
line({ "mon_eyebot" }, ccb.content.text("\"Get on your knees!\""), 15)
line({ "mon_eyebot" }, ccb.content.text("\"Hands in the air!\""), 15)
line({ "mon_eyebot" }, ccb.content.text("\"Wait for law enforcement officer!\""), 15)
line({ "mon_eyebot" }, ccb.content.text("\"Remain where you are!\""), 15)
line({ "mon_eyebot" }, ccb.content.text("\"Police inbound.  Stay where you are!\""), 15)
line({ "fcl_mon_migoturret" }, ccb.content.text("\"Hello?\""), 40)
line({ "fcl_mon_migoturret" }, ccb.content.text("\"Can you help me?\""), 40)
line({ "fcl_mon_migoturret" }, ccb.content.text("\"I have no mouth and yet I scream!\""), 60)
line({ "fcl_mon_migoturret" }, ccb.content.text("\"¿Por qué?\""), 40)
line({ "fcl_mon_migoturret" }, ccb.content.text("\"Come closer little one.\""), 40)
line({ "fcl_mon_migoturret" }, ccb.content.text("\"The better to eat you!  I don't actually think I eat anymore.\""), 40)
line({ "fcl_mon_migoturret" }, ccb.content.text("\"Cyrus said if I was patient, he could get me a new body.\""), 40)
line({ "fcl_mon_migoturret" }, ccb.content.text("\"Quem é Você?\""), 40)
line({ "fcl_mon_migoturret" }, ccb.content.text("\"Eu vou te matar!\""), 60)
line({ "fcl_mon_migoturret" }, ccb.content.text("\"I can't keep myself from killing you, please run!\""), 60)

for _, pool in ipairs(ordered) do
    content.append_speech_pool(pool)
end
