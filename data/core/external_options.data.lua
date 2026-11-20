local content = require("ccb").content

-- Multiplicatively mitigates weary maluses. Bigger is faster. 2 is twice as fast, to a max of your non-weary speed.
content.define_external_option { id = "COMBAT_SPEED_MODIFIER", kind = "float", value = 1 }

-- Value that adds to weapon dispersion per weapon damage value.
content.define_external_option { id = "DISPERSION_PER_GUN_DAMAGE", kind = "int", value = 20 }

-- Value that divides total weapon dispersion.  15 means that weapons became 15 times more accurate than default.
content.define_external_option { id = "GUN_DISPERSION_DIVIDER", kind = "float", value = 24 }

-- Sets the base max stamina value of the player, before cardio modifiers.
content.define_external_option { id = "PLAYER_MAX_STAMINA_BASE", kind = "int", value = 3500 }

-- Sets a cap on maximum effective strength for characters.
content.define_external_option { id = "PLAYER_MAX_STR_VALUE", kind = "int", value = 30 }

-- Sets a cap on maximum effective dexterity for characters.
content.define_external_option { id = "PLAYER_MAX_DEX_VALUE", kind = "int", value = 30 }

-- Sets a cap on maximum effective perception for characters.
content.define_external_option { id = "PLAYER_MAX_PER_VALUE", kind = "int", value = 30 }

-- Sets a cap on maximum effective intelligence for characters.
content.define_external_option { id = "PLAYER_MAX_INT_VALUE", kind = "int", value = 30 }

-- Sets the effect of cardio on maximum stamina.
content.define_external_option { id = "PLAYER_CARDIOFIT_STAMINA_SCALING", kind = "int", value = 5 }

-- Sets base stamina regeneration per turn of the player, before cardio modifiers.  May be used as an offset in stamina draining effects.
content.define_external_option { id = "PLAYER_BASE_STAMINA_REGEN_RATE", kind = "float", value = 20 }

-- Sets base stamina burn per 100 moves of the walking player.
content.define_external_option { id = "PLAYER_BASE_STAMINA_BURN_RATE", kind = "int", value = 15 }

-- Set base hunger rate per 5 minutes.  Default: 1.0
content.define_external_option { id = "PLAYER_HUNGER_RATE", kind = "float", value = 1.0 }

-- Set base thirst rate per 5 minutes.  Default: 1.0
content.define_external_option { id = "PLAYER_THIRST_RATE", kind = "float", value = 1.0 }

-- Set base sleepiness rate per 5 minutes.  Default: 1.0
content.define_external_option { id = "PLAYER_SLEEPINESS_RATE", kind = "float", value = 1.0 }

-- Set base player healing rate per turn.  Default: 0.0001
content.define_external_option { id = "PLAYER_HEALING_RATE", kind = "float", value = 0.0001 }

-- Set base NPC healing rate per turn.  Default: 0.0001
content.define_external_option { id = "NPC_HEALING_RATE", kind = "float", value = 0.0001 }

-- Disables vehicle part faults.  If true, disables vehicle part faults, vehicle parts will be totally reliable unless destroyed, and can only be repaired via replacement.
content.define_external_option { id = "NO_FAULTS", kind = "bool", value = false }

-- Disables tracking food, thirst and fatigue/sleep for NPCs.  If true, NPCs won't need to eat, drink, or sleep and will stay perpetually rested.
content.define_external_option { id = "NO_NPC_FOOD", kind = "bool", value = false }

-- Disables tracking vitamins in food items.  If true, disables vitamin tracking and vitamin disorders.
content.define_external_option { id = "NO_VITAMINS", kind = "bool", value = false }

-- Enables CBM slots mechanics.  If true CBM slots are enabled.
content.define_external_option { id = "CBM_SLOTS_ENABLED", kind = "bool", value = false }

-- Probability to get a wound from taking damage.  0.25 means 25% to get a wound.
content.define_external_option { id = "WOUND_CHANCE", kind = "float", value = 1.0 }

-- Scales how much pain decrease your stat.  0.005 means 0.5% of stat loss per one unit of pain.
content.define_external_option { id = "PAIN_PENALTY_MOD_STR", kind = "float", value = 0.005 }

-- Scales how much pain decrease your stat.  0.0075 means 0.75% of stat loss per one unit of pain.
content.define_external_option { id = "PAIN_PENALTY_MOD_DEX", kind = "float", value = 0.0075 }

-- Scales how much pain decrease your stat.  0.01 means 1% of stat loss per one unit of pain.
content.define_external_option { id = "PAIN_PENALTY_MOD_INT", kind = "float", value = 0.01 }

-- Scales how much pain decrease your stat.  0.01 means 1% of stat loss per one unit of pain.
content.define_external_option { id = "PAIN_PENALTY_MOD_PER", kind = "float", value = 0.01 }

-- Minimum city size to guarantee extra zombies are spawned in cities.  0 means all cities spawn extra zombies.  Negative values disable extra city zombies.
content.define_external_option { id = "SPAWN_CITY_HORDE_THRESHOLD", kind = "int", value = 4 }

-- Probability of a city smaller than SPAWN_HORDE_THRESHOLD having city zombies spawned, express in 'one in x' fashion .
content.define_external_option { id = "SPAWN_CITY_HORDE_SMALL_CITY_CHANCE", kind = "int", value = 16 }

-- A scaling factor that determines how far from the center of cities extra zombies spawn, multiplied by city size, when city hordes are indicated.
content.define_external_option { id = "SPAWN_CITY_HORDE_SPREAD", kind = "float", value = 1.5 }

-- A scaling factor that determines how many zombies are spawned in cites, multiplied by city size, when city hordes are indicated.
content.define_external_option { id = "SPAWN_CITY_HORDE_SCALAR", kind = "float", value = 80.0 }

-- A scaling factor that determines density of wild, formerly domesticated and mutated animal spawns.
content.define_external_option { id = "SPAWN_ANIMAL_DENSITY", kind = "float", value = 1.0 }

-- Disable additional spawn of large groups of monsters fighting each other on swamps.
content.define_external_option { id = "DISABLE_ANIMAL_CLASH", kind = "bool", value = false }

-- Disables robot spawning from alerts and from being wanted.
content.define_external_option { id = "DISABLE_ROBOT_RESPONSE", kind = "bool", value = false }

-- Portal storm enemies will ignore NPCs no matter what.
content.define_external_option { id = "PORTAL_STORM_IGNORE_NPC", kind = "bool", value = false }

-- A boolean specifically for Crazy Cataclysm.
content.define_external_option { id = "CRAZY", kind = "bool", value = false }

-- What portion of BMR is used as the base for determining weariness threshold.
content.define_external_option { id = "WEARY_BMR_MULT", kind = "float", value = 0.54 }

-- What the weariness threshold is multiplied by to gain each successive level.
content.define_external_option { id = "WEARY_THRESH_SCALING", kind = "float", value = 0.75 }

-- What the weariness threshold is multiplied by for the first level of weariness.
content.define_external_option { id = "WEARY_INITIAL_STEP", kind = "float", value = 1.0 }

-- What percentage of calorie intake and expenditure is reduced during each reduction tick.
content.define_external_option { id = "WEARY_RECOVERY_MULT", kind = "float", value = 0.05 }

-- The amount of INT which is used as base point for focus adjustments
content.define_external_option { id = "INT_BASED_LEARNING_BASE_VALUE", kind = "int", value = 8 }

-- The amount of focus gained per each INT point above INT_BASED_LEARNING_BASE_VALUE
content.define_external_option { id = "INT_BASED_LEARNING_FOCUS_ADJUSTMENT", kind = "int", value = 5 }

-- The profession selected by default in the character creator menu.
content.define_external_option { id = "GENERIC_PROFESSION_ID", kind = "string_input", value = "unemployed" }

-- The scenario selected by default in the character creator menu.
content.define_external_option { id = "GENERIC_SCENARIO_ID", kind = "string_input", value = "evacuee" }

-- If false, examining workbench-type furniture will auto-execute pickup and undeploy (where applicable) actions, no crafting-related options will be listed.
content.define_external_option { id = "WORKBENCH_ALL_OPTIONS", kind = "bool", value = true }

-- Allows to select starting city in new character menu.
content.define_external_option { id = "SELECT_STARTING_CITY", kind = "bool", value = false }

-- Path to pregenerated overmap files.  Should include mod folder name and folder where omap files are stored.
content.define_external_option { id = "OVERMAP_PREGENERATED_PATH", kind = "string_input", value = "" }

-- If true, initial status and amount of fuel for all spawned vehicles will be overridden by values of VEHICLE_STATUS_AT_SPAWN and VEHICLE_FUEL_AT_SPAWN options.
content.define_external_option { id = "OVERRIDE_VEHICLE_INIT_STATE", kind = "bool", value = false }

-- All vehicles spawn in this status.  -1 is lightly damaged (default), 0 is undamaged, 1 is disabled (destroyed tires or engine).  Values are read only if OVERRIDE_VEHICLE_INIT_STATE is set to true.
content.define_external_option { id = "VEHICLE_STATUS_AT_SPAWN", kind = "int", value = -1 }

-- All vehicles spawn with this percentage of fuel.  0 is empty, 100 is fully loaded, -1 is random amount from 7% to 35% (default).  Values are read only if OVERRIDE_VEHICLE_INIT_STATE is set to true.
content.define_external_option { id = "VEHICLE_FUEL_AT_SPAWN", kind = "int", value = -1 }

-- If true, it will able the reduction in the maximum repairable damage capacity of vehicle parts when they are damaged.
content.define_external_option { id = "VEHICLE_DEGRADATION_WHEN_DAMAGE", kind = "bool", value = true }

-- If .omap s are being used this is the overmap terrain used outside of the defined overmaps.
content.define_external_option { id = "OUTSIDE_DEFINED_OMAP_OMT", kind = "string_input", value = "lake_surface" }

-- EMP will disable electonics for a short period of ~60 seconds, instead of permanently.  Theres a 5% chance of items shorting out permanently.
content.define_external_option { id = "GAME_EMP", kind = "bool", value = false }

-- NPCs will accept your bank balance as payment in trades.
content.define_external_option { id = "CAPITALISM", kind = "bool", value = false }

-- Enables the functionality of the "zombify_into" JSON field in monster definitions.
content.define_external_option { id = "ZOMBIFY_INTO_ENABLED", kind = "bool", value = true }

-- Determines frequency (in minutes) of displaying music description in sidebar when listening to MP3-players and the like.
content.define_external_option { id = "DESCRIBE_MUSIC_FREQUENCY", kind = "int", value = 5 }

-- NPCs generated post-cataclysm will, when initially generated, receive this amount of exp to a random skill for each day that has passed since the Cataclysm.
content.define_external_option { id = "MIN_CATCHUP_EXP_PER_POST_CATA_DAY", kind = "int", value = 50 }

-- Same as above.  This is the second value of rng(min, max) to determine base exp (before other character modifiers).
content.define_external_option { id = "MAX_CATCHUP_EXP_PER_POST_CATA_DAY", kind = "int", value = 150 }

-- The maximum skill level randomly generated NPCs can achieve via MIN_CATCHUP_EXP_PER_POST_CATA_DAY and MAX_CATCHUP_EXP_PER_POST_CATA_DAY.
content.define_external_option { id = "EXTRA_NPC_SKILL_LEVEL_CAP", kind = "int", value = 7 }

-- Sets eternal weather.  Possible values are 'normal', 'clear', 'cloudy', 'light_drizzle', 'drizzle', 'rain', 'rainstorm', 'thunder', 'lightning', 'flurries', 'snowing', 'snowstorm', 'early_portal_storm', 'portal_storm'.  'normal' clears all eternal weather overrides and sets normal weather pattern.  Requires restart of the game after changing value to take effect.
content.define_external_option { id = "ETERNAL_WEATHER", kind = "string_input", value = "normal" }

-- When mutating, displays a menu which allows players to pick from a list of possible mutations.
content.define_external_option { id = "SHOW_MUTATION_SELECTOR", kind = "bool", value = false }

-- Sets the latitude used for sunrise/sunset times.  Defaults to Boston.
content.define_external_option { id = "LATITUDE", kind = "float", value = 42.36 }

-- Sets the longitude used for sunrise/sunset times.  Defaults to Boston.
content.define_external_option { id = "LONGITUDE", kind = "float", value = -71.06 }

-- If true, radiation causes the player to mutate.
-- RAD_MUTATION keeps its existing world setting (default false).

-- Initial points available to spend on stats on character generation.
content.define_external_option { id = "INITIAL_STAT_POINTS", kind = "int", value = 6 }

-- Initial points available to spend on traits on character generation.
content.define_external_option { id = "INITIAL_TRAIT_POINTS", kind = "int", value = 0 }

-- Initial points available to spend on skills on character generation.
content.define_external_option { id = "INITIAL_SKILL_POINTS", kind = "int", value = 2 }

-- Maximum trait points available for character generation.
content.define_external_option { id = "MAX_TRAIT_POINTS", kind = "int", value = 12 }

-- Scales experience gained from practicing proficiencies.  0.5 is half as fast as default, 2.0 is twice as fast, 0.0 disables proficiency training except for NPC training.
content.define_external_option { id = "PROFICIENCY_TRAINING_SPEED", kind = "float", value = 1.0 }

-- Season length, in days.  Warning: Very little other than the duration of seasons scales with this value, so adjusting it may cause nonsensical results.
-- SEASON_LENGTH keeps its existing world setting (default 91).

-- Sets the time of construction in percents.  '50' is two times faster than default, '200' is two times longer.  '0' automatically scales construction time to match the world's season length.
-- CONSTRUCTION_SCALING keeps its existing world setting (default 100).

-- If true, keep the initial season forever.
-- ETERNAL_SEASON keeps its existing world setting (default false).

-- If true, custom characters must be Average or weaker in all rating categories.
content.define_external_option { id = "CHARACTER_CREATION_HARD_LIMIT", kind = "bool", value = false }

-- Day/night cycle settings.  'normal' sets a normal cycle.  'day' sets eternal day.  'night' sets eternal night.
-- ETERNAL_TIME_OF_DAY keeps its existing world setting (default "normal").

-- The distance between east-west highways in overmaps, with the whole overmap gap being `grid_row_separation` - 1.
content.define_external_option { id = "HIGHWAY_GRID_ROW_SEPARATION", kind = "int", value = 8 }

-- The distance between north-south highways in overmaps, with the whole overmap gap being `grid_column_separation` - 1.
content.define_external_option { id = "HIGHWAY_GRID_COLUMN_SEPARATION", kind = "int", value = 10 }

-- The maximum number of overmaps that an intersection can deviate from its gridded position. Cannot be greater than or equal to row / 2 or column / 2, may cause bugs for > row / 4, column / 4.
content.define_external_option { id = "HIGHWAY_GRID_VARIANCE", kind = "int", value = 2 }

-- The default value is true; when this option is false, it prevents players from switching genders in the player_display menu. Some special character json flag can bypass this configuration option.
content.define_external_option { id = "PLAYER_ARBITRARY_CHANGE_GENDER", kind = "bool", value = true }
