local ccb = require("ccb")
local content = ccb.content

-- It can see you (and will run/follow)
content.add(content.MonsterFlag { id = "SEES" })

-- It can hear you
content.add(content.MonsterFlag { id = "HEARS" })

-- Pursues sounds more than most monsters
content.add(content.MonsterFlag { id = "GOODHEARING" })

-- It can smell you
content.add(content.MonsterFlag { id = "SMELLS" })

-- Keen sense of smell
content.add(content.MonsterFlag { id = "KEENNOSE" })

-- Stumbles in its movement
content.add(content.MonsterFlag { id = "STUMBLES" })

-- Has a chance to fall when attacking
content.add(content.MonsterFlag { id = "CLUMSY_ATTACKS" })

-- Warm blooded
content.add(content.MonsterFlag { id = "WARM" })

-- Is a nemesis monster
content.add(content.MonsterFlag { id = "NEMESIS" })

-- It's sapient and capable of reason (no matter how limited--ferals count)
content.add(content.MonsterFlag { id = "HAS_MIND" })

-- Headshots not allowed!
content.add(content.MonsterFlag { id = "NOHEAD" })

-- It's one size smaller for ranged attacks, no less than creature_size::tiny
content.add(content.MonsterFlag { id = "HARDTOSHOOT" })

-- Its attacks may grab us!
content.add(content.MonsterFlag { id = "GRABS" })

-- Bashes down doors
content.add(content.MonsterFlag { id = "BASHES" })

-- Bashes down walls and more
content.add(content.MonsterFlag { id = "DESTROYS" })

-- Tunnels through just about anything
content.add(content.MonsterFlag { id = "BORES" })

-- Poisonous to eat
content.add(content.MonsterFlag { id = "POISON" })

-- Attack may poison the player
content.add(content.MonsterFlag { id = "VENOM" })

-- Attack may SEVERELY poison the player
content.add(content.MonsterFlag { id = "BADVENOM" })

-- Attack may paralyze the player with venom
content.add(content.MonsterFlag { id = "PARALYZEVENOM" })

-- Doesn't destroy webs
content.add(content.MonsterFlag { id = "WEBWALK" })

-- Digs through the ground
content.add(content.MonsterFlag { id = "DIGS" })

-- Can dig and walk
content.add(content.MonsterFlag { id = "CAN_DIG" })

-- Can fly (over water, etc)
content.add(content.MonsterFlag { id = "FLIES" })

-- Confined to water
content.add(content.MonsterFlag { id = "AQUATIC" })

-- Treats water as 50 movement point terrain
content.add(content.MonsterFlag { id = "SWIMS" })

-- Attacks other monsters
content.add(content.MonsterFlag { id = "ATTACKMON" })

-- Is an "animal" for purposes of the Animal Empath trait
content.add(content.MonsterFlag { id = "ANIMAL" })

-- Absorbs physical damage to a great degree
content.add(content.MonsterFlag { id = "PLASTIC" })

-- Dies in full sunlight
content.add(content.MonsterFlag { id = "SUNDEATH" })

-- Severely weakened in sufficient light (applies photophobia effect)
content.add(content.MonsterFlag { id = "PHOTOPHOBIC" })

-- Monster can see creatures even when they're invisible
content.add(content.MonsterFlag { id = "TRUESIGHT" })

-- Monster bleeds sap
content.add(content.MonsterFlag { id = "PLANT_BLOOD" })

-- The monster is PERMANENTLY invisible.  Be careful about using this one
content.add(content.MonsterFlag { id = "PERMANENT_INVISIBILITY" })

-- Shocks unarmed attackers
content.add(content.MonsterFlag { id = "ELECTRIC" })

-- Immune to acid
content.add(content.MonsterFlag { id = "ACIDPROOF" })

-- Leaves a trail of acid
content.add(content.MonsterFlag { id = "ACIDTRAIL" })

-- Leaves an intermittent trail of acid
content.add(content.MonsterFlag { id = "SHORTACIDTRAIL" })

-- Immune to fire
content.add(content.MonsterFlag { id = "FIREPROOF" })

-- Immune to cold iron and does cold iron damage instead of any cutting damage
content.add(content.MonsterFlag { id = "IRONWROUGHT" })

-- Ignores the effect of sludge trails
content.add(content.MonsterFlag { id = "SLUDGEPROOF" })

-- Is a faerie creature
content.add(content.MonsterFlag { id = "FAE_CREATURE" })

-- Causes monster to leave a sludge trap trail when moving
content.add(content.MonsterFlag { id = "SLUDGETRAIL" })

-- Causes monster to leave a low intensity, 1 tile sludge pool approximately every other tile when moving
content.add(content.MonsterFlag { id = "SMALLSLUDGETRAIL" })

-- Immune to ballistic damage
content.add(content.MonsterFlag { id = "BULLETPROOF" })

-- Immune to cold damage
content.add(content.MonsterFlag { id = "COLDPROOF" })

-- Immune to biological damage
content.add(content.MonsterFlag { id = "BIOLOGICALPROOF" })

-- Mount has better chance to ignore hostile monster fear
content.add(content.MonsterFlag { id = "COMBAT_MOUNT" })

-- Burns stuff and is immune to fire
content.add(content.MonsterFlag { id = "FIREY" })

-- Cannot be flashbanged
content.add(content.MonsterFlag { id = "FLASHBANGPROOF" })

-- When it dies, local populations start to die off too
content.add(content.MonsterFlag { id = "QUEEN" })

-- e.g.  a robot; affected by EMP blasts, and other stuff
content.add(content.MonsterFlag { id = "ELECTRONIC" })

-- Despawns when a nearby console is properly hacked
content.add(content.MonsterFlag { id = "CONSOLE_DESPAWN" })

-- Doesn't move (e.g.  turrets)
content.add(content.MonsterFlag { id = "IMMOBILE" })

-- Despawns when a science ID card is used on a nearby console
content.add(content.MonsterFlag { id = "ID_CARD_DESPAWN" })

-- A rideable mech that is immobile until ridden
content.add(content.MonsterFlag { id = "RIDEABLE_MECH" })

-- A rideable mech that was designed for military work
content.add(content.MonsterFlag { id = "MILITARY_MECH" })

-- This mech gives you IR night-vision
content.add(content.MonsterFlag { id = "MECH_RECON_VISION" })

-- This mech gives you thorough protection
content.add(content.MonsterFlag { id = "MECH_DEFENSIVE" })

-- Flee for several turns after a melee attack
content.add(content.MonsterFlag { id = "HIT_AND_RUN" })

-- You can pay this bot to be your friend for a time
content.add(content.MonsterFlag { id = "PAY_BOT" })

-- It's a live human, as long as it's alive
content.add(content.MonsterFlag { id = "HUMAN" })

-- Creature can't drown and is unharmed by gas, smoke, or poison
content.add(content.MonsterFlag { id = "NO_BREATHE" })

-- Monster catches fire, burns, and spreads fire to nearby objects
content.add(content.MonsterFlag { id = "FLAMMABLE" })

-- Monster corpse will revive after a short period of time
content.add(content.MonsterFlag { id = "REVIVES" })

-- Monster corpse can be revived by dormant corpse traps. Do NOT set manually, will be autogenerated.
content.add(content.MonsterFlag { id = "DORMANT" })

-- Monster also defines a dormant pseudo monster during JSON load. Only makes sense when combined with `REVIVES`.
content.add(content.MonsterFlag { id = "GEN_DORMANT" })

-- Monster dies quietly and doesn't display a message.
content.add(content.MonsterFlag { id = "QUIETDEATH" })

-- Creature won't leave gibs / meat chunks when killed with huge damage
content.add(content.MonsterFlag { id = "NOGIB" })

-- Forces monster to bleed hemolymph
content.add(content.MonsterFlag { id = "ARTHROPOD_BLOOD" })

-- Makes monster bleed acid.  Fun stuff!  Does not automatically dissolve in a pool of acid on death.
content.add(content.MonsterFlag { id = "ACID_BLOOD" })

-- Makes monster bleed bile
content.add(content.MonsterFlag { id = "BILE_BLOOD" })

-- Any clothing it drops will be filthy
content.add(content.MonsterFlag { id = "FILTHY" })

-- It is fishable
content.add(content.MonsterFlag { id = "FISHABLE" })

-- Monsters that can pile up against obstacles and add their strength together to break them
content.add(content.MonsterFlag { id = "GROUP_BASH" })

-- Monsters that like to group together and form loose packs
content.add(content.MonsterFlag { id = "SWARMS" })

-- Monsters that are more courageous when near friends
content.add(content.MonsterFlag { id = "GROUP_MORALE" })

-- Monster contain's its ammo inside itself, no need to load on launch.  Prevents ammo from being dropped on disable.
content.add(content.MonsterFlag { id = "INTERIOR_AMMO" })

-- Monsters that can climb certain terrain and furniture
content.add(content.MonsterFlag { id = "CLIMBS" })

-- Monsters that will never use melee attack, useful for having them use grab without attacking the player
content.add(content.MonsterFlag { id = "PACIFIST" })

-- Attempts to keep a short distance (tracking_distance) from its current target.  The default tracking distance is 8 tiles
content.add(content.MonsterFlag { id = "KEEP_DISTANCE" })

-- Monsters that can push creatures out of their way
content.add(content.MonsterFlag { id = "PUSH_MON" })

-- Monsters that can push vehicles out of their way
content.add(content.MonsterFlag { id = "PUSH_VEH" })

-- Monsters that will never run not matter how much damage they suffer
content.add(content.MonsterFlag { id = "UNBREAKABLE_MORALE" })

-- Monsters that are invisible in poor light conditions
content.add(content.MonsterFlag { id = "NIGHT_INVISIBILITY" })

-- When revived, this monster has full hitpoints and speed
content.add(content.MonsterFlag { id = "REVIVES_HEALTHY" })

-- This monster can't be revived by necros.  It will still rise on its own.
content.add(content.MonsterFlag { id = "NO_NECRO" })

-- This monster will path around some dangers instead of through them
content.add(content.MonsterFlag { id = "PATH_AVOID_DANGER" })

-- This monster will path around heat-related dangers instead of through them
content.add(content.MonsterFlag { id = "PATH_AVOID_FIRE" })

-- This monster will path around cliffs instead of off of them
content.add(content.MonsterFlag { id = "PATH_AVOID_FALL" })

-- This monster will prioritize targets depending on their danger levels
content.add(content.MonsterFlag { id = "PRIORITIZE_TARGETS" })

-- Monsters that will NOT appear when player's producing hallucinations
content.add(content.MonsterFlag { id = "NOT_HALLUCINATION" })

-- This monster can be played with if it's a pet
content.add(content.MonsterFlag { id = "CANPLAY" })

-- This monster can be culled if it's a pet
content.add(content.MonsterFlag { id = "CAN_BE_CULLED" })

-- This monster can be mounted and ridden when tamed
content.add(content.MonsterFlag { id = "PET_MOUNTABLE" })

-- This monster can be harnessed when tamed
content.add(content.MonsterFlag { id = "PET_HARNESSABLE" })

-- This monster will respond to the dog whistle
content.add(content.MonsterFlag { id = "DOGFOOD" })

-- This monster is milkable
content.add(content.MonsterFlag { id = "MILKABLE" })

-- This monster is shearable
content.add(content.MonsterFlag { id = "SHEARABLE" })

-- This monster doesn't breed, even though it has breed data
content.add(content.MonsterFlag { id = "NO_BREED" })

-- This monster can't be damaged by fungal spores and can't be fungalized either
content.add(content.MonsterFlag { id = "NO_FUNG_DMG" })

-- This monster won't follow the player automatically when tamed
content.add(content.MonsterFlag { id = "PET_WONT_FOLLOW" })

-- This monster occasionally drips napalm on move
content.add(content.MonsterFlag { id = "DRIPS_NAPALM" })

-- This monster occasionally drips gasoline on move
content.add(content.MonsterFlag { id = "DRIPS_GASOLINE" })

-- This monster is surrounded by an electrical field that ignites flammable liquids near it
content.add(content.MonsterFlag { id = "ELECTRIC_FIELD" })

-- This monster makes move noises as if ~2 sizes louder, even if flying
content.add(content.MonsterFlag { id = "LOUDMOVES" })

-- This monster makes move noises as if ~2 sizes quieter
content.add(content.MonsterFlag { id = "QUIETMOVES" })

-- This monster makes no move noise at all
content.add(content.MonsterFlag { id = "SILENTMOVES" })

-- This monster can open doors
content.add(content.MonsterFlag { id = "CAN_OPEN_DOORS" })

-- This monster is immune to the stun effect
content.add(content.MonsterFlag { id = "STUN_IMMUNE" })

-- This monster drops ammo.  Should not be set for monsters that use pseudo ammo.
content.add(content.MonsterFlag { id = "DROPS_AMMO" })

-- This monster wields a weapon.  Used for disarming techniques to trigger with this enemy.
content.add(content.MonsterFlag { id = "WIELDED_WEAPON" })

-- This monster is immune to insecticide, even though it's made of bug flesh
content.add(content.MonsterFlag { id = "INSECTICIDEPROOF" })

-- This monster has any sort of ranged attack
content.add(content.MonsterFlag { id = "RANGED_ATTACKER" })

-- This monster is hard to spot, even in broad daylight
content.add(content.MonsterFlag { id = "CAMOUFLAGE" })

-- This monster is hard to spot if it is underwater, especially if you aren't
content.add(content.MonsterFlag { id = "WATER_CAMOUFLAGE" })

-- This monster is capable of hitting upper limbs
content.add(content.MonsterFlag { id = "ATTACK_UPPER" })

-- This monster is incapable of hitting upper limbs regardless of other factors
content.add(content.MonsterFlag { id = "ATTACK_LOWER" })

-- This monster can inflict the zombie_virus effect
content.add(content.MonsterFlag { id = "DEADLY_VIRUS" })

-- This monster can inflict the vampire_virus effect
content.add(content.MonsterFlag { id = "VAMP_VIRUS" })

-- If was summoned by someone, copies the texture of it's summoner.
content.add(content.MonsterFlag { id = "COPY_SUMMONER_LOOK" })

-- Always looks like an avatar (character you play right now).
content.add(content.MonsterFlag { id = "COPY_AVATAR_LOOK" })

-- This monster can always be seen regardless of los or light or anything
content.add(content.MonsterFlag { id = "ALWAYS_VISIBLE" })

-- This monster appears neutral but AI behaves as if not. (The effect is hardcoded)
content.add(content.MonsterFlag { id = "APPEARS_NEUTRAL" })

-- This monster always knows where the avatar is
content.add(content.MonsterFlag { id = "ALWAYS_SEES_YOU" })

-- Once this monster establishes initial line-of-sight to the avatar, it gains a temporary effect where it always knows the avatar's location for its duration
content.add(content.MonsterFlag { id = "LOCKS_ON" })

-- This monster can see everything within its vision range regardless of light or obstacles
content.add(content.MonsterFlag { id = "ALL_SEEING" })

-- This monster can see everything within 5 squares + its vision bonuses regardless of light or obstacles, unless that thing is undetectable to telepathy
content.add(content.MonsterFlag { id = "MIND_SEEING" })

-- This monster can see in the infrared spectrum
content.add(content.MonsterFlag { id = "INFRARED_VISION" })

-- This monster will never join wandering hordes
content.add(content.MonsterFlag { id = "NEVER_WANDER" })

-- This monster can engage in conversation.  Will need to have chat_topics as well.
content.add(content.MonsterFlag { id = "CONVERSATION" })

-- This monster will disappear without printing any message
content.add(content.MonsterFlag { id = "SILENT_DISAPPEAR" })

content.add(content.MonsterFlag { id = "EATS" })

-- This monster will stop fleeing and fight back if pursued into spear range or closer.
content.add(content.MonsterFlag { id = "CORNERED_FIGHTER" })

-- This small monster can hide under or behind furniture such as beds, refrigerators, and underbrush
content.add(content.MonsterFlag { id = "SMALL_HIDER" })

-- Warning: Do not use without death_guilt function. This helps count the amount of animals (e.g hatchlings, kittens) before player goes numb.
content.add(content.MonsterFlag { id = "GUILT_ANIMAL" })

-- Boss, you killed a child! Warning: Do not use without a death_guilt function. This helps count the children kills before player goes numb.
content.add(content.MonsterFlag { id = "GUILT_CHILD" })

-- Warning: Do not use without death_guilt function. This helps count the non-npc human (e.g civilian/futile fighter) kills before player goes numb.
content.add(content.MonsterFlag { id = "GUILT_HUMAN" })

-- Warning: Do not use without death_guilt function. This helps count the all the other kills that do not fit the other three (e.g blood sacrifice) before player goes numb.
content.add(content.MonsterFlag { id = "GUILT_OTHERS" })

-- Immune to Chiropteran saliva. Use for any creature with nonstandard blood (ie mi-go, insects, but probably not zombies or fungalized animals, unless they have acid blood or something).
content.add(content.MonsterFlag { id = "DRACULIN_IMMUNE" })

-- Immune to attacks from the POISONOUS and POISONOUS2 mutations
content.add(content.MonsterFlag { id = "VENOM_IMMUNE" })

-- Immune to telepathic damage/detection
content.add(content.MonsterFlag { id = "TEEP_IMMUNE" })

-- This monster has significant armor, and it is much harder to pulp it without a proper tool
-- Rule of thumb: if monster has something like a spine character wants to break, and it is covered by any armor, use this flag
content.add(content.MonsterFlag { id = "PULP_PRYING" })

-- Monsters that exist in the x dimension, for creatures that exist in fewer than 3
content.add(content.MonsterFlag { id = "ONE_DIMENSIONAL_X" })

-- Monsters that exist in the y dimension, for creatures that exist in fewer than 3
content.add(content.MonsterFlag { id = "ONE_DIMENSIONAL_Y" })

-- Monsters that exist in the z dimension, for creatures that exist in fewer than 3
content.add(content.MonsterFlag { id = "ONE_DIMENSIONAL_Z" })
