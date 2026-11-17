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

-- The Anathema is both vampire and vampire hunter.  This contradiction result in them speaking about both as they cannot doubt that they did the right thing.
line({ "mon_vampire_anathema" }, ccb.content.text("\"One more to kill.\""), 20)
line({ "mon_vampire_anathema" }, ccb.content.text("\"Your blood will contribute to a great cause, the end of all vampires.\""), 20)
line({ "mon_vampire_anathema" }, ccb.content.text("\"I've slain thousands, each stronger than you.  Do not believe that you can kill me.\""), 20)
line({ "mon_vampire_anathema" }, ccb.content.text("\"It is all necessary, yet they all failed to understand.\""), 20)
line({ "mon_vampire_anathema" }, ccb.content.text("\"They tried to stop me, so I killed them all.\""), 20)
line({ "mon_vampire_anathema" }, ccb.content.text("\"Most hunters are siding with the vampires.  I know as they tried to kill me, calling me a vampire.\""), 20)
line({ "mon_vampire_anathema" }, ccb.content.text("\"Standing against me is standing against humanity.\""), 20)
line({ "mon_vampire_anathema" }, ccb.content.text("\"So thirsty… Need to drink…\""), 10)
line({ "mon_vampire_anathema" }, ccb.content.text("\"I'll send you where you belong!\""), 35)
line({ "mon_vampire_anathema" }, ccb.content.text("\"The mentors still elude me.  You however, do not.\""), 20)
line({ "mon_vampire_anathema" }, ccb.content.text("\"Vampires cannot truly be bargained with.  They must all die.\""), 20)
line({ "mon_vampire_anathema" }, ccb.content.text("\"Never trust a vampire.  It will leave you open to their mind control.\""), 20)
line({ "mon_vampire_anathema" }, ccb.content.text("\"Why did they hated me?  I only wanted to help them!\""), 35)
line({ "mon_vampire_anathema" }, ccb.content.text("\"Their blood was so delicious.\""), 20)
line({ "mon_vampire_anathema" }, ccb.content.text("\"I need your blood!\""), 35)
line({ "mon_vampire_anathema" }, ccb.content.text("\"They aren't uniting against me aren't they?\""), 20)
line({ "mon_vampire_anathema" }, ccb.content.text("\"I'm just trying to kill all the vampires, and everyone trying to oppose me in this goal.\""), 20)
line({ "mon_vampire_anathema" }, ccb.content.text("\"I can't understand why vampire hunters could want me dead.  I'm one of them!\""), 20)
line({ "mon_vampire_anathema" }, ccb.content.text("\"They have started to attack me with the vampires' help!  Traitors, all of them!\""), 35)
line({ "mon_vampire_anathema" }, ccb.content.text("\"Every other vampire will die, then I'll get rid of the last one.\""), 20)
line({ "mon_fetch_child" }, ccb.content.text("\"*giggles* Would you like to play tag?\""), 10)
line({ "mon_fetch_child" }, ccb.content.text("\"*whispers* I want to tell you a secret.\""), 5)
line({ "mon_fetch_child" }, ccb.content.text("\"My last friend went all red and stopped moving.\""), 8)
line({ "mon_fetch_child" }, ccb.content.text("\"You're it, I'm gonna catch you!\""), 15)
line({ "mon_fetch_child" }, ccb.content.text("\"Won't you take me home with you?\""), 10)
line({ "mon_sevenoclock_active" }, ccb.content.text("\"You should be sleeping by now!\""), 25)
line({ "mon_sevenoclock_active" }, ccb.content.text("\"You should be sleeping by now.\""), 20)
line({ "mon_sevenoclock_active" }, ccb.content.text("\"I'm going to eat you!\""), 25)
line({ "mon_sevenoclock_active" }, ccb.content.text("\"SLEEP!\""), 32)
line({ "mon_sevenoclock_active" }, ccb.content.text("\"Jump in my bag, it will be less painful that way.\""), 20)
line({ "mon_sevenoclock_active" }, ccb.content.text("\"Another one awake past its bedtime.\""), 20)
line({ "mon_sevenoclock_active" }, ccb.content.text("\"Those who do not sleep won't ever wake up.\""), 20)
line({ "mon_sevenoclock_active" }, ccb.content.text("\"I'm going to beat you until you sleep, one way or another.\""), 20)
line({ "mon_sevenoclock_active" }, ccb.content.text("\"This time is for the sleeping, not for the wakeful.\""), 20)
line({ "mon_sevenoclock_active" }, ccb.content.text("\"There is no excuse.  You sleep, or you die.\""), 20)
line({ "mon_sevenoclock_active" }, ccb.content.text("\"I am here to guard the sleepers.\""), 20)
line({ "mon_sevenoclock_active" }, ccb.content.text("\"I am here to kill the awake.\""), 20)
line({ "mon_sevenoclock_active" }, ccb.content.text("\"I won't let you wake them up.\""), 20)
line({ "mon_sevenoclock_active" }, ccb.content.text("\"They say being dead is akin to being asleep.  Sleep now, or you'll know what is it to be dead.\""), 20)
line({ "mon_sevenoclock_active" }, ccb.content.text("\"So hungry.\""), 20)
line({ "mon_sevenoclock_active" }, ccb.content.text("\"Need to eat.\""), 20)
line({ "mon_sevenoclock_active" }, ccb.content.text("\"Their flesh and dreams are rotten.\""), 20)
line({ "mon_sevenoclock_active" }, ccb.content.text("\"You will be fine food.\""), 20)
line({ "mon_sevenoclock_active" }, ccb.content.text("\"The wakeful threaten the sleepers.  I cannot let that be.\""), 20)
line({ "mon_sevenoclock_active" }, ccb.content.text("\"It is currently the sleepers' time.\""), 20)
line({ "mon_sevenoclock_active" }, ccb.content.text("\"All who are awake during the sleepers' time are mine.\""), 20)
line({ "mon_sevenoclock_active" }, ccb.content.text("\"I wish for all to sleep well in this time.\""), 20)
line({ "mon_sevenoclock_active" }, ccb.content.text("\"You are still able to sleep.  Why do you squander this gift?\""), 20)
line({ "mon_sevenoclock_active" }, ccb.content.text("\"I will ensure that all who sleep won't be disturbed.\""), 20)
line({ "mon_sevenoclock_active" }, ccb.content.text("\"I will ensure that all who cannot sleep will die.\""), 20)
line({ "mon_sevenoclock_active" }, ccb.content.text("\"For the last time: SLEEP!\""), 32)
line({ "mon_civilian_wendi" }, ccb.content.text("\"Help!  I'm lost and alone!\""), 25)
line({ "mon_civilian_wendi" }, ccb.content.text("\"This hunger is neverending.\""), 20)
line({ "mon_cryptid_wendi" }, ccb.content.text("\"I'm going to eat you!\""), 25)
line({ "mon_mi_go", "mon_mi_go_slaver", "mon_mi_go_myrmidon", "mon_mi_go_humanoid" }, ccb.content.text("\"We negotiated salvage rights to any biological matter remaining in the event of civilizational collapse.\""), 20)
line({ "mon_mi_go", "mon_mi_go_slaver", "mon_mi_go_myrmidon", "mon_mi_go_humanoid" }, ccb.content.text("\"Come with us if you want to live!\""), 20)
line({ "mon_mi_go", "mon_mi_go_slaver", "mon_mi_go_myrmidon", "mon_mi_go_humanoid" }, ccb.content.text("\"Cease opposition.  Our rights here are guaranteed by treaty M-A-J-I-K-1-2.\""), 20)
line({ "mon_mi_go", "mon_mi_go_slaver", "mon_mi_go_myrmidon", "mon_mi_go_humanoid" }, ccb.content.text("\"Your government no longer exists, we will adopt you.\""), 20)
line({ "mon_mi_go", "mon_mi_go_slaver", "mon_mi_go_myrmidon", "mon_mi_go_humanoid" }, ccb.content.text("\"Welcome to the Mi-go family, children of Earth!  Soon our biologies will mingle unto the death of the stars!\""), 20)
-- Mi-go xys/zys words should be pronounced as one single combined word.
line({ "mon_mi_go", "mon_mi_go_slaver", "mon_mi_go_myrmidon", "mon_mi_go_humanoid" }, ccb.content.text("\"We were so pleased/honored to be chosen as the inheritors of your species, so close to it's death that you must have felt it coming and sought us out.\""), 20)
line({ "mon_mi_go", "mon_mi_go_slaver", "mon_mi_go_myrmidon", "mon_mi_go_humanoid" }, ccb.content.text("\"Let us commingle humans!  We can make use of your genetics and your species will live on as part of us!\""), 20)
line({ "mon_mi_go", "mon_mi_go_slaver", "mon_mi_go_myrmidon", "mon_mi_go_humanoid" }, ccb.content.text("\"In one of it's last acts your government gave us responsibility for the remainder of you.  That number shrinks by the hour.\""), 20)
-- Mi-go xys/zys words should be pronounced as one single combined word.
line({ "mon_mi_go", "mon_mi_go_slaver", "mon_mi_go_myrmidon", "mon_mi_go_humanoid" }, ccb.content.text("\"Good night Human/Earthlings!\""), 20)
-- Mi-go is not their name for themselves and Yuggoth is not their name for their planet.  But the humans they knew liked to pretend so the mi-go continue pretending for their racial memory.
line({ "mon_mi_go", "mon_mi_go_slaver", "mon_mi_go_myrmidon", "mon_mi_go_humanoid" }, ccb.content.text("\"We're off to see the Wizard, the wonderful wizard of Yuggoth.  Come humans we have watched your legends, we know your culture.\""), 20)
line({ "mon_mi_go", "mon_mi_go_slaver", "mon_mi_go_myrmidon", "mon_mi_go_humanoid" }, ccb.content.text("\"Have you considered ceasing to break the laws granting us rights and responsibility over the remains of human civilization and it's peoples?\""), 20)
-- The theme for thses snippets is that the automaton's inerts remains are possessed by an unknown entity with electrical powers.  Said entity is very protective of the remains, need them to exist and is perpetually exhausted by all the effort required to keep the remains in one piece and defend them.  Due to that, it considers everything it perceives as a threat to eliminate.
line({ "mon_dreamforged_automaton" }, ccb.content.text("\"Do not…\""), 10)
line({ "mon_dreamforged_automaton" }, ccb.content.text("\"Destroy…\""), 10)
line({ "mon_dreamforged_automaton" }, ccb.content.text("\"My home…\""), 10)
line({ "mon_dreamforged_automaton" }, ccb.content.text("\"Stop…\""), 10)
line({ "mon_dreamforged_automaton" }, ccb.content.text("\"Why are you…  doing that…\""), 10)
line({ "mon_dreamforged_automaton" }, ccb.content.text("\"Nothing…  but threats…\""), 10)
line({ "mon_dreamforged_automaton" }, ccb.content.text("\"It is already broken…\""), 10)
line({ "mon_dreamforged_automaton" }, ccb.content.text("\"Do not break it further…\""), 10)
line({ "mon_dreamforged_automaton" }, ccb.content.text("\"Must hold the home…  in one piece…\""), 10)
line({ "mon_dreamforged_automaton" }, ccb.content.text("\"My house's breaking down…  like this world…\""), 10)
line({ "mon_dreamforged_automaton" }, ccb.content.text("\"This home…  is all I have…\""), 10)
line({ "mon_dreamforged_automaton" }, ccb.content.text("\"I need it…  as you need your bones…\""), 10)
line({ "mon_dreamforged_automaton" }, ccb.content.text("\"There has to…  be another way…\""), 10)
line({ "mon_renfield", "mon_renfield_9mm", "mon_renfield_shotgun", "mon_renfield_flamethrower", "mon_renfield_bionic_monster", "mon_renfield_abomination" }, ccb.content.text("\"The masters have come, and they have promised to make me immortal!\""), 20)
line({ "mon_renfield", "mon_renfield_9mm", "mon_renfield_shotgun", "mon_renfield_flamethrower", "mon_renfield_bionic_monster", "mon_renfield_abomination" }, ccb.content.text("\"I am here to do the masters' bidding!\""), 32)
line({ "mon_renfield", "mon_renfield_9mm", "mon_renfield_shotgun", "mon_renfield_flamethrower", "mon_renfield_bionic_monster", "mon_renfield_abomination" }, ccb.content.text("\"Who's there?  Is that blood for the masters?\""), 20)
line({ "mon_renfield", "mon_renfield_9mm", "mon_renfield_shotgun", "mon_renfield_flamethrower", "mon_renfield_bionic_monster", "mon_renfield_abomination" }, ccb.content.text("\"Can you help me?  The masters are so very hungry.\""), 20)
line({ "mon_renfield", "mon_renfield_9mm", "mon_renfield_shotgun", "mon_renfield_flamethrower", "mon_renfield_bionic_monster", "mon_renfield_abomination" }, ccb.content.text("\"Why won't you just surrender to the masters' needs!\""), 32)

for _, pool in ipairs(ordered) do
    content.append_speech_pool(pool)
end
