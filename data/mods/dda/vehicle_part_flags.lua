local ccb = require("ccb")
local content = ccb.content

content.add(content.JsonFlag {
    id = "DECK_STAIRS",
    info = ccb.content.text("This part connects this vehicle deck to the deck immediately above it."),
})

content.add(content.JsonFlag {
    id = "ALTERNATOR",
    -- TRANSLATORS: Leave the tags in angle brackets unchanged.
    info = ccb.content.text("When mounted on an engine and the engine is on it will provide up to <color_green>%dW</color> of electrical power to the vehicle."),
    requires_flag = "E_ALTERNATOR",
})

content.add(content.JsonFlag {
    id = "AISLE",
    info = ccb.content.text("You can move through this vehicle frame without being slowed down."),
})

content.add(content.JsonFlag {
    id = "AISLE_LIGHT",
    info = ccb.content.text("A bright light that illuminates several squares inside the vehicle."),
})

content.add(content.JsonFlag {
    id = "ARMOR",
    info = ccb.content.text("Armor plate.  Will partially protect other components on the same frame from damage from direct attacks but not from the shock damage of a distant collision."),
})

content.add(content.JsonFlag {
    id = "BED",
    info = ccb.content.text("You can sleep here comfortably."),
})

content.add(content.JsonFlag {
    id = "BELTABLE",
    info = ccb.content.text("You can install a seat belt or five part harness here to help keep you in your seat during a collision."),
})

content.add(content.JsonFlag { id = "BOARD_INTERNAL" })

content.add(content.JsonFlag {
    id = "CABLE_PORTS",
    info = ccb.content.text("You can connect electrical cables to this part."),
})

content.add(content.JsonFlag {
    id = "CARGO",
    info = ccb.content.text("You can store items here."),
})

content.add(content.JsonFlag {
    id = "CTRL_ELECTRONIC",
    info = ccb.content.text("You can 'e'xamine the tile to access the electronic controls.  If there are vehicle controls installed in the same spot, you can also use the vehicle control key (default '^')."),
})

content.add(content.JsonFlag {
    id = "CONTROLS",
    info = ccb.content.text("With a seat or saddle, you drive from here.  You can 'e'xamine the tile to access the controls, or use the vehicle control key (default '^')."),
})

content.add(content.JsonFlag {
    id = "EOC_ACTIVATION",
    info = ccb.content.text("Enables an associated EOC to be triggered from the vehicle control menu."),
})

content.add(content.JsonFlag {
    id = "SMART_ENGINE_CONTROLLER",
    info = ccb.content.text("When active, turns engines on and off automatically."),
})

content.add(content.JsonFlag {
    id = "COVERED",
    info = ccb.content.text("Illuminated items in this space will not illuminate nearby squares."),
})

content.add(content.JsonFlag {
    id = "CURTAIN",
    info = ccb.content.text("Closed, it prevents people from seeing through the curtain.  A door motor allows you to remotely open or close it from the vehicle controls."),
})

content.add(content.JsonFlag {
    id = "NEEDS_WINDOW",
    requires_flag = "WINDOW",
})

content.add(content.JsonFlag {
    id = "WINDOW_MOUNT",
    requires_flag = "WINDOW_MOUNTABLE",
})

content.add(content.JsonFlag { id = "WINDOW_MOUNTABLE" })

content.add(content.JsonFlag {
    id = "DOOR",
    info = ccb.content.text("When open, this part lets you move from inside the vehicle to outside or vice versa.  When closed, it prevents people from entering or leaving the vehicle."),
})

content.add(content.JsonFlag {
    id = "ENABLED_DRAINS_EPOWER",
    -- TRANSLATORS: Leave the tags in angle brackets unchanged.
    info = ccb.content.text("When turned on, this device drains <color_red>%dW</color> from the vehicle's batteries."),
})

content.add(content.JsonFlag {
    id = "SOLAR_PANEL",
    -- TRANSLATORS: Leave the tags in angle brackets unchanged.
    info = ccb.content.text("Provides up to <color_green>%dW</color> of electrical power to the vehicle when exposed to the sun.  Weather and clouds will affect power generation."),
})

content.add(content.JsonFlag {
    id = "ENGINE",
    info = ccb.content.text("Provides motive power to move the vehicle if the vehicle has sufficient wheels.  Requires controls to turn on.  If it drains power, also requires a charged battery to start."),
})

-- The engine can mount and power an alternator
content.add(content.JsonFlag {
    id = "E_ALTERNATOR",
    info = ccb.content.text("An alternator can be attached, and it will generate electrical power while the engine is on at the cost of some motive power."),
})

content.add(content.JsonFlag {
    id = "EXTRA_DRAG",
    info = ccb.content.text("When turned on, it will stop the vehicle unless it has a strong engine."),
})

content.add(content.JsonFlag {
    id = "FLOATS",
    info = ccb.content.text("Each boat hull will reduce the draft of your vehicle and increase the height sealed against water.  If the draft is less than the sealed height, your vehicle will float if placed in water."),
})

content.add(content.JsonFlag {
    id = "FRAGILE_COMPONENTS",
    -- TRANSLATORS: Leave the tags in angle brackets unchanged.
    info = ccb.content.text("Some components of this part are <color_red>fragile</color> and might be damaged even if the part itself isn't."),
})

content.add(content.JsonFlag {
    id = "FURNITURE_TIEDOWN",
    info = ccb.content.text("You can tie down a furniture here."),
})

content.add(content.JsonFlag {
    id = "FURNITURE_LIFT_ASSIST",
    info = ccb.content.text("It's much easier to tie down a furniture here."),
})

content.add(content.JsonFlag {
    id = "NO_LEAK",
    info = ccb.content.text("Causes a boat hull to float even when damaged."),
})

content.add(content.JsonFlag {
    id = "NONBELTABLE",
    info = ccb.content.text("There's no place to attach a seat belt, so you get thrown from the vehicle in a crash."),
})

content.add(content.JsonFlag {
    id = "ROOF",
    info = ccb.content.text("Keeps the rain out of the interior of the vehicle."),
})

content.add(content.JsonFlag { id = "RESIST_RUNOVER_DAMAGE" })

content.add(content.JsonFlag {
    id = "SEAT",
    info = ccb.content.text("You need to be in a seat or saddle to operate vehicle controls."),
})

content.add(content.JsonFlag {
    id = "ENHANCED_VISION",
    -- TRANSLATORS: Leave the tags in angle brackets unchanged.
    info = ccb.content.text("Can be used to <color_cyan>scout things far away</color> when seated."),
    requires_flag = "SEAT",
})

content.add(content.JsonFlag {
    id = "SEATBELT",
    info = ccb.content.text("This part will help prevent you from being thrown from the vehicle in a collision.  You will automatically enable this part when you move into a tile with it."),
    requires_flag = "BELTABLE",
})

content.add(content.JsonFlag {
    id = "SHOCK_ABSORBER",
    info = ccb.content.text("Armor plate.  Will partially protect other components on the same frame from the shock damage of a distant collision but not from direct attacks."),
})

content.add(content.JsonFlag {
    id = "STABLE",
    info = ccb.content.text("If your vehicle consists of a single tile, this wheel is enough to allow it to move."),
})

content.add(content.JsonFlag {
    id = "UNSTABLE_WHEEL",
    info = ccb.content.text("This wheel requires another wheel to be installed to be functional."),
})

content.add(content.JsonFlag {
    id = "STEERABLE",
    info = ccb.content.text("Your vehicle needs at least one set of steerable wheels to turn."),
})

content.add(content.JsonFlag { id = "TRACKED" })

content.add(content.JsonFlag {
    id = "TRAP_PROOF",
    info = ccb.content.text("This wheel hovers and will not set off traps such as deep pits or landmines."),
})

content.add(content.JsonFlag {
    id = "TURRET",
    info = ccb.content.text("This weapon is mounted in a turret.  It can be fired from the vehicle controls."),
    requires_flag = "TURRET_MOUNT",
})

content.add(content.JsonFlag {
    id = "TURRET_CONTROLS",
    requires_flag = "TURRET_MOUNT",
})

content.add(content.JsonFlag {
    id = "WHEEL",
    info = ccb.content.text("If the center of balance of your vehicle is between all the wheels, the vehicle will be able to move, provided it has an active engine or motor with enough power to move the vehicle."),
})

content.add(content.JsonFlag {
    id = "WIND_TURBINE",
    -- TRANSLATORS: Leave the tags in angle brackets unchanged.
    info = ccb.content.text("Provides <color_green>%dW</color> of electrical power to the vehicle for every 1 m/s of wind the vehicle is exposed to."),
})

content.add(content.JsonFlag {
    id = "WATER_WHEEL",
    -- TRANSLATORS: Leave the tags in angle brackets unchanged.
    info = ccb.content.text("Provides up to <color_green>%dW</color> of electrical power to the vehicle when built over shallow moving water."),
})

content.add(content.JsonFlag {
    id = "FLAT_SURF",
    info = ccb.content.text("This has a flat surface.  It would be a nice place to eat."),
})

content.add(content.JsonFlag {
    id = "WORKBENCH",
    info = ccb.content.text("You can craft here."),
})

content.add(content.JsonFlag {
    id = "NEEDS_WHEEL_MOUNT_LIGHT",
    requires_flag = "WHEEL_MOUNT_LIGHT",
})

content.add(content.JsonFlag {
    id = "NEEDS_WHEEL_MOUNT_MEDIUM",
    requires_flag = "WHEEL_MOUNT_MEDIUM",
})

content.add(content.JsonFlag {
    id = "NEEDS_WHEEL_MOUNT_HEAVY",
    requires_flag = "WHEEL_MOUNT_HEAVY",
})

content.add(content.JsonFlag {
    id = "NEEDS_BATTERY_MOUNT",
    requires_flag = "BATTERY_MOUNT",
})

content.add(content.JsonFlag {
    id = "NEEDS_HANDHELD_BATTERY_MOUNT",
    requires_flag = "HANDHELD_BATTERY_MOUNT",
})

content.add(content.JsonFlag {
    id = "ON_CONTROLS",
    requires_flag = "CONTROLS",
})

-- Can be mounted inside other parts
content.add(content.JsonFlag {
    id = "INTERNAL",
    requires_flag = "CARGO",
})

content.add(content.JsonFlag {
    id = "CARGO_LOCKING",
    requires_flag = "LOCKABLE_CARGO",
    info = ccb.content.text("Attached to a suitable cargo space, it will prevent other people from accessing the cargo and taking your stuff."),
})

content.add(content.JsonFlag {
    id = "DOOR_LOCKING",
    requires_flag = "LOCKABLE_DOOR",
    info = ccb.content.text("Attached to a door or a hatch, it can be used to lock it."),
})

content.add(content.JsonFlag {
    id = "DOOR_MOTOR",
    requires_flag = "OPENABLE",
})

content.add(content.JsonFlag {
    id = "ON_ROOF",
    requires_flag = "ROOF",
})

content.add(content.JsonFlag { id = "ADVANCED_PLANTER" })
content.add(content.JsonFlag { id = "AIRCRAFT_REPAIRABLE_NOPROF" })
content.add(content.JsonFlag { id = "ANIMAL_CTRL" })
content.add(content.JsonFlag { id = "ATOMIC_LIGHT" })
content.add(content.JsonFlag { id = "AUTOCLAVE" })
content.add(content.JsonFlag { id = "AUTO_COOKER" })
content.add(content.JsonFlag { id = "AUTOPILOT" })
content.add(content.JsonFlag { id = "BATTERY" })
content.add(content.JsonFlag { id = "BATTERY_MOUNT" })
content.add(content.JsonFlag { id = "HANDHELD_BATTERY_MOUNT" })
content.add(content.JsonFlag { id = "ARCADE" })
content.add(content.JsonFlag { id = "BEEPER" })
content.add(content.JsonFlag { id = "BIKE_RACK_VEH" })
content.add(content.JsonFlag { id = "BOARDABLE" })
content.add(content.JsonFlag { id = "CAMERA" })
content.add(content.JsonFlag { id = "CAMERA_CONTROL" })

content.add(content.JsonFlag {
    id = "CAPTURE_MONSTER_VEH",
    info = ccb.content.text("You can 'e'xamine it to capture an animal next to you, or to release the animal currently contained.  When selecting an animal to capture, choose its tile relative to you, not the part."),
})

content.add(content.JsonFlag { id = "CHIMES" })

content.add(content.JsonFlag {
    id = "CIRCLE_LIGHT",
    -- TRANSLATORS: Leave the tags in angle brackets unchanged.
    info = ccb.content.text("A bright light that <color_yellow>illuminates a circular area</color> outside the vehicle when turned on."),
})

content.add(content.JsonFlag {
    id = "CONE_LIGHT",
    -- TRANSLATORS: Leave the tags in angle brackets unchanged.
    info = ccb.content.text("A bright, directed light that <color_yellow>illuminates a narrow cone</color> outside the vehicle when turned on.  During installation, you can choose what direction to point the light."),
})

content.add(content.JsonFlag { id = "CONTROL_ANIMAL" })
content.add(content.JsonFlag { id = "COOLER" })
content.add(content.JsonFlag { id = "DISHWASHER" })
content.add(content.JsonFlag { id = "DOME_LIGHT" })

-- Cold weather makes the engine take longer to start
content.add(content.JsonFlag { id = "E_COLD_START" })

content.add(content.JsonFlag {
    id = "E_DIESEL_FUEL",
    info = ccb.content.text("Burns diesel or JP8 fuel from a tank in the vehicle.  Can also burn biodiesel or kerosene, though somewhat less efficiently."),
})

content.add(content.JsonFlag { id = "E_HEATER" })

-- Multiple engines with this flag are harder to install
content.add(content.JsonFlag { id = "E_HIGHER_SKILL" })

-- The engine takes no time to start, like foot pedals
content.add(content.JsonFlag { id = "E_STARTS_INSTANTLY" })

content.add(content.JsonFlag { id = "EVENTURN" })

content.add(content.JsonFlag {
    id = "FLUIDTANK",
    -- TRANSLATORS: Leave the tags in angle brackets unchanged.
    info = ccb.content.text("If filled with the <color_light_red>appropriate fuel</color> for the vehicle's engine, the engine will automatically draw fuel from the tank when the engine is on.  If filled with <color_light_blue>water</color>, you can access the water from a water faucet, if one is installed in the vehicle.  You can also use a rubber hose to siphon liquids out of a tank."),
})

content.add(content.JsonFlag { id = "GASTANK" })
content.add(content.JsonFlag { id = "FREEZER" })
content.add(content.JsonFlag { id = "FRIDGE" })
content.add(content.JsonFlag { id = "FULL_BOARD" })

-- When set on vehicle part the, bonus field defines the funnel radius in mm^2 and part collects rain
content.add(content.JsonFlag { id = "FUNNEL" })

content.add(content.JsonFlag { id = "HALF_BOARD" })

content.add(content.JsonFlag {
    id = "HALF_CIRCLE_LIGHT",
    -- TRANSLATORS: Leave the tags in angle brackets unchanged.
    info = ccb.content.text("A bright, directed light that <color_yellow>illuminates a half-circular area</color> outside the vehicle when turned on.  During installation, you can choose what direction to point the light."),
})

content.add(content.JsonFlag { id = "HARNESS_any" })
content.add(content.JsonFlag { id = "HARNESS_human" })

content.add(content.JsonFlag {
    id = "HEATED_TANK",
    -- TRANSLATORS: Leave the tags in angle brackets unchanged.
    info = ccb.content.text("When turned on, it will <color_light_cyan>prevent the content from freezing</color>."),
})

content.add(content.JsonFlag {
    id = "HORN",
    info = ccb.content.text("Use the vehicle controls and select the honk option to make noise."),
})

content.add(content.JsonFlag { id = "LOCKABLE_CARGO" })

content.add(content.JsonFlag {
    id = "LOCKABLE_DOOR",
    info = ccb.content.text("This can be locked if equipped with a locking mechanism, preventing access from outside the vehicle."),
})

content.add(content.JsonFlag { id = "LOW_FINAL_AIR_DRAG" })

-- Usable as a point to fire a mountable weapon from
content.add(content.JsonFlag { id = "MOUNTABLE" })

content.add(content.JsonFlag { id = "MUFFLER" })
content.add(content.JsonFlag { id = "MULTISQUARE" })
content.add(content.JsonFlag { id = "MUSCLE_ARMS" })
content.add(content.JsonFlag { id = "MUSCLE_LEGS" })

content.add(content.JsonFlag {
    id = "MWS",
    info = ccb.content.text("This part functions as a mobile weather station."),
})

content.add(content.JsonFlag {
    id = "ADVANCED_MWS",
    info = ccb.content.text("This part functions as an advanced mobile weather station."),
})

content.add(content.JsonFlag { id = "NEEDS_JACKING" })

-- Part can't be installed by player but visible in install menu (e.g. helicopter rotors).
content.add(content.JsonFlag { id = "NO_INSTALL_PLAYER" })

-- Part can't be installed by player and hidden in install menu (e.g. power cords, inflatable boat parts, summoned vehicle parts).
content.add(content.JsonFlag { id = "NO_INSTALL_HIDDEN" })

content.add(content.JsonFlag { id = "NO_ROOF_NEEDED" })
content.add(content.JsonFlag { id = "NO_UNINSTALL" })
content.add(content.JsonFlag { id = "OBSTACLE" })
content.add(content.JsonFlag { id = "ODDTURN" })
content.add(content.JsonFlag { id = "OPAQUE" })
content.add(content.JsonFlag { id = "OPENABLE" })
content.add(content.JsonFlag { id = "OPENCLOSE_INSIDE" })
content.add(content.JsonFlag { id = "PLANTER" })
content.add(content.JsonFlag { id = "PLOW" })
content.add(content.JsonFlag { id = "POWER_TRANSFER" })
content.add(content.JsonFlag { id = "PROTRUSION" })
content.add(content.JsonFlag { id = "RAIL" })
content.add(content.JsonFlag { id = "REACTOR" })
content.add(content.JsonFlag { id = "REAPER" })
content.add(content.JsonFlag { id = "REMOTE_CONTROLS" })
content.add(content.JsonFlag { id = "ROCKWHEEL" })
content.add(content.JsonFlag { id = "ROTOR" })
content.add(content.JsonFlag { id = "SCOOP" })
content.add(content.JsonFlag { id = "SECURITY" })
content.add(content.JsonFlag { id = "SELF_JACK" })
content.add(content.JsonFlag { id = "SHARP" })
content.add(content.JsonFlag { id = "SIMPLE_PART" })
content.add(content.JsonFlag { id = "SMASH_REMOVE" })
content.add(content.JsonFlag { id = "SPACE_HEATER" })
content.add(content.JsonFlag { id = "STEREO" })
content.add(content.JsonFlag { id = "TRACK" })
content.add(content.JsonFlag { id = "TRANSFORM_TERRAIN" })
content.add(content.JsonFlag { id = "TURRET_MOUNT" })
content.add(content.JsonFlag { id = "UNMOUNT_ON_DAMAGE" })
content.add(content.JsonFlag { id = "UNMOUNT_ON_MOVE" })

-- This is assigned automatically in vpart_info::finalize, means the gun uses magazine-like batteries for example afs_cartridge and turret should drain vehicle batteries
content.add(content.JsonFlag { id = "USE_BATTERIES" })

-- Turrets draw liquid ammunition from vehicle tanks. Reactors may use compatible liquid from tanks on the same vehicle after their internal fuel runs out.
content.add(content.JsonFlag { id = "USE_TANKS" })

content.add(content.JsonFlag { id = "VARIABLE_SIZE" })

-- Modular tool station allowing to 'hook' tools to vehicle batteries/tanks.
content.add(content.JsonFlag {
    id = "VEH_TOOLS",
    -- TRANSLATORS: Leave the tags in angle brackets unchanged.
    info = ccb.content.text("You can 'e'xamine the tile to <color_cyan>connect tools</color> to the vehicle's batteries and tanks."),
})

content.add(content.JsonFlag { id = "VISION" })
content.add(content.JsonFlag { id = "WALL_MOUNTED" })
content.add(content.JsonFlag { id = "WASHING_MACHINE" })
content.add(content.JsonFlag { id = "WHEEL_MOUNT_HEAVY" })
content.add(content.JsonFlag { id = "WHEEL_MOUNT_LIGHT" })
content.add(content.JsonFlag { id = "WHEEL_MOUNT_MEDIUM" })

content.add(content.JsonFlag {
    id = "WIDE_CONE_LIGHT",
    -- TRANSLATORS: Leave the tags in angle brackets unchanged.
    info = ccb.content.text("A bright, directed light that <color_yellow>illuminates a wide cone</color> outside the vehicle when turned on.  During installation, you can choose what direction to point the light."),
})

content.add(content.JsonFlag { id = "WIND_POWERED" })
content.add(content.JsonFlag { id = "WINDOW" })
content.add(content.JsonFlag { id = "WINDSHIELD" })
content.add(content.JsonFlag { id = "WIRING" })
content.add(content.JsonFlag { id = "SEAT_REQUIRES_BALANCE" })
content.add(content.JsonFlag { id = "WHEEL_MOUNT_SKATEBOARD" })

content.add(content.JsonFlag {
    id = "NEEDS_WHEEL_MOUNT_SKATEBOARD",
    requires_flag = "WHEEL_MOUNT_SKATEBOARD",
})

content.add(content.JsonFlag {
    id = "CARGO_PASSABLE",
    info = ccb.content.text("Items stored here won't get in the way of any passengers."),
})

content.add(content.JsonFlag {
    id = "CARGO_PASSABLE_BY_STORED",
    info = ccb.content.text("Items stored here can obstruct passage if there are too many of them."),
})

content.add(content.JsonFlag {
    id = "HUGE_OK",
    info = ccb.content.text("Even when roofed, this part is roomy enough to comfortably admit very large creatures, like cows and horses."),
})

content.add(content.JsonFlag { id = "IGNORE_LEG_REQUIREMENT" })

content.add(content.JsonFlag {
    id = "NEED_LEG",
    info = ccb.content.text("Operating this part will require at least one working leg."),
})

content.add(content.JsonFlag {
    id = "INOPERABLE_SMALL",
    info = ccb.content.text("People who are very short may be unable to make use of this part."),
})

content.add(content.JsonFlag { id = "IGNORE_HEIGHT_REQUIREMENT" })
content.add(content.JsonFlag { id = "WHEEL_MOUNT_CONCRETE_MIX" })

content.add(content.JsonFlag {
    id = "NEEDS_WHEEL_MOUNT_CONCRETE_MIX",
    requires_flag = "WHEEL_MOUNT_CONCRETE_MIX",
})

content.add(content.JsonFlag {
    id = "NL_BOILER",
    info = ccb.content.text("This part functions as a boiler from the nether."),
})

content.add(content.JsonFlag {
    id = "BALLOON",
    info = ccb.content.text("This part is a gas balloon that provides lift to keep an airship aloft."),
})

content.add(content.JsonFlag {
    id = "PROPELLER",
    info = ccb.content.text("This part is a propeller that provides thrust to move an airship."),
})

content.add(content.JsonFlag {
    id = "EXTENDABLE",
    info = ccb.content.text("This part can be extended into adjacent tiles of the same part."),
})

content.add(content.JsonFlag {
    id = "SHOCK_IMMUNE",
    info = ccb.content.text("This part is immune to shock damage from collisions."),
})

content.add(content.JsonFlag {
    id = "SHOCK_RESISTANT",
    info = ccb.content.text("This part is resistant to shock damage from collisions."),
})

content.add(content.JsonFlag {
    id = "NOCOLLIDE",
    info = ccb.content.text("This part does not collide with anything."),
})

content.add(content.JsonFlag {
    id = "NOCOLLIDEBELOW",
    info = ccb.content.text("This part does not collide with terrain on the z-level below it."),
})

content.add(content.JsonFlag {
    id = "FOLDABLE",
    info = ccb.content.text("This part can be folded up for storage and transport."),
})

content.add(content.JsonFlag {
    id = "MANUAL",
    info = ccb.content.text("This part lacks the electronics for remote operation and must be operated by hand."),
})

content.add(content.JsonFlag {
    id = "LADDER",
    info = ccb.content.text("This part is a ladder, letting you climb down from the vehicle."),
})
