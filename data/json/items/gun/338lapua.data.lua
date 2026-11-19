local ccb = require("ccb")

ccb.content.define_item {
    id = "tac338",
    copy_from = "gun_base_rifle_manual",
    looks_like = "modular_ar15",
    name = ccb.content.text("AI bolt-action sniper rifle"),
    description = ccb.content.text("A high-precision bolt-action sniper rifle, in service with special operations members of the US Navy prior to the Cataclysm.  Firing the powerful .338 Lapua cartridge, the weapon feeds from detachable five round Accuracy International magazines."),
    variant_kind = "gun",
    variants = {
        {
            id = "tac338",
            name = ccb.content.text("McMillan Tac-338 rifle"),
            description = ccb.content.text("Chambering the .338 Lapua cartridge, the Tac-338 is a high-precision, bolt-action sniper rifle that, before the Cataclysm, complemented the arsenal of the US Navy Special Warfare unit.  Providing Navy SEAL marksmen with the capability to land effective shots on targets at a typical range of 1600 meters, a valuable capability for the long-distance engagements prevalent during the US army's war on terror, the rifle comes kitted with an adjustable cheek pad, butt hook, and muzzle break."),
        },
    },
    mass = "5897 g",
    volume = "4000 ml",
    length = "1295 mm",
    price = "6 kUSD 428 USD",
    survival_price = "40 USD",
    materials = { "steel", "plastic" },
    pockets = { { kind = "MAGAZINE_WELL", allowed_items = { "ai_338mag", "ai_338mag_10" } } },
    inheritance = { add = { flags = { "BOLT_ACTION" } } },
    gun = {
        barrel_length = "686 mm",
        ammunition = { "338lapua" },
        dispersion = 50,
        mod_locations = {
            { id = "barrel", count = 1 },
            { id = "mechanism", count = 2 },
            { id = "muzzle", count = 1 },
            { id = "rail mount", count = 1 },
            { id = "sights", count = 1 },
            { id = "sling", count = 1 },
            { id = "stock accessory", count = 2 },
            { id = "stock mount", count = 1 },
            { id = "underbarrel mount", count = 1 },
        },
        default_mods = { "cheek_pad", "butt_hook", "bipod", "rifle_scope", "muzzle_brake" },
    },
}

-- Giant amount of sight-dispersion in order to simulate that the rifle doesn't come with factory installed sights.
ccb.content.define_item {
    id = "savage112",
    copy_from = "gun_base_rifle_manual",
    looks_like = "modular_ar15",
    name = ccb.content.text("single-shot target rifle"),
    description = ccb.content.text("A bolt-action precision rifle with the potential for impressive accuracy, this particular weapon makes use of the powerful .338 Lapua cartridge and is decked in a handsome set of wooden furniture, providing the rifle with a classical mystique.  Unfortunately, the weapon's single-round magazine and a lack of factory iron sights, which makes target acquisition an exercise in futility unless a gunsight is installed, make the rifle limited in its post-Cataclysm utility."),
    variant_kind = "gun",
    variants = {
        {
            id = "savage112",
            name = ccb.content.text("Savage 112 Magnum Target rifle"),
            description = ccb.content.text("A highly-accurate precision rifle chambered for the powerful .338 Lapua cartridge, the Savage 112 Magnum Target is a classically designed bolt-action rifle in both its fit and finish, with a heavy barrel, a hardwood stock, and an attached muzzle brake.  Unfortunately for the weapon and its users, a traditional veneer, no matter how admittedly swanky, isn't conducive to tactical effectiveness, as demonstrated by the 112 Magnum Target's mighty magazine size of one entire cartridge and lack of any factory-attached sights."),
        },
    },
    mass = "5470 g",
    volume = "3000 ml",
    length = "1222 mm",
    price = "1 kUSD 109 USD",
    survival_price = "8 USD",
    materials = { "steel", "wood" },
    flags = { "RELOAD_ONE", "RELOAD_EJECT", "EASY_CLEAN", "NO_TURRET" },
    pockets = { { kind = "MAGAZINE", rigid = true, ammunition = { ["338lapua"] = 1 } } },
    gun = {
        barrel_length = "660 mm",
        ammunition = { "338lapua" },
        dispersion = 50,
        sight_dispersion = 1000,
        clip_size = 1,
        default_mods = { "match_trigger", "muzzle_brake" },
        mod_locations = {
            { id = "barrel", count = 1 },
            { id = "mechanism", count = 2 },
            { id = "rail mount", count = 1 },
            { id = "sights", count = 1 },
            { id = "sling", count = 1 },
            { id = "stock accessory", count = 1 },
            { id = "stock mount", count = 1 },
            { id = "underbarrel mount", count = 1 },
        },
        barrel_volume = "820 ml",
    },
}

-- Cheek pad required for holding the buttstock in place and keep it from folding.
ccb.content.define_item {
    id = "mrad_smr",
    copy_from = "gun_base_rifle_manual",
    looks_like = "modular_ar15",
    name = ccb.content.text("Barrett precision rifle"),
    description = ccb.content.text("A box magazine-fed bolt-action precision rifle developed by the Barrett Arms Company, firing the .338 Lapua cartridge.  A civilian copy of more versatile military weapons, this rifle is a remarkably well-crafted piece of anti-personnel engineering despite lacking the sheer modularity of its Marshal sister, and is still capable of engaging targets at extreme distances."),
    variant_kind = "gun",
    variants = {
        {
            id = "mrad_smr",
            name = ccb.content.text("Barrett MRAD SMR rifle"),
            description = ccb.content.text("Chambered for the .338 Lapua cartridge, the Barrett MRAD SMR is a civilian variant of the MK22 MRAD sniper rifle, which was in service with elements of the US army and is often regarded as one of the finest bolt-action sniper rifles ever developed.  The primary differences that set this weapon apart from its Marshal sibling are the removal of the MRAD's caliber conversion capabilities and the installation of a fixed buttstock.  These changes have resulted in a lighter and slimmer rifle that, most importantly for the discerning pre-Cataclysmic precision shooter, didn't require a second mortgage to purchase."),
        },
    },
    mass = "6305 g",
    volume = "5500 ml",
    length = "1204 mm",
    price = "4 kUSD 60 USD 98 cent",
    survival_price = "40 USD",
    materials = { "aluminum", "steel", "plastic" },
    pockets = { { kind = "MAGAZINE_WELL", allowed_items = { "mrad_338lapua_mag" } } },
    inheritance = { add = { flags = { "EASY_CLEAN", "NO_TURRET", "BOLT_ACTION" } } },
    gun = {
        barrel_length = "660 mm",
        ammunition = { "338lapua" },
        dispersion = 50,
        durability = 10,
        built_in_mods = { "cheek_pad" },
        default_mods = { "match_trigger", "muzzle_brake" },
        mod_locations = {
            { id = "barrel", count = 1 },
            { id = "brass catcher", count = 1 },
            { id = "mechanism", count = 2 },
            { id = "rail", count = 1 },
            { id = "sights", count = 1 },
            { id = "sling", count = 1 },
            { id = "stock accessory", count = 1 },
            { id = "underbarrel", count = 1 },
        },
    },
}

-- Weight of gun plus muzzle break and empty 10-round magazine is 6.8 kg. Weights of these latter two have been deducted, as has the weight of a standard barrel.
-- Length and volume calculations have been adjusted to represent just the base chassis, without an installed barrel.
-- This should be removed once vehicle turrets are capable of mounting guns with mods attached. As it stands, trying to mount this style of weapon would require the player to remove the conversion kit, thus rendering it unusable anyhow.
ccb.content.define_item {
    id = "axmc",
    copy_from = "gun_base_rifle_manual",
    looks_like = "modular_ar15",
    name = ccb.content.text("modular sniper rifle"),
    description = ccb.content.text("A weapon platform that prides itself on modularity and customizability, this highly accurate precision rifle may be configured with various caliber conversion kits that can allow it to fire either the .338 Lapua, .300 Win Mag, or .308 Winchester cartridges.  The rifle's size prevents it from being a particularly mobile piece of equipment, but the weapon's folding buttstock aids in portability."),
    variant_kind = "gun",
    variants = {
        {
            id = "axmc",
            name = ccb.content.text("Accuracy International AXMC rifle"),
            description = ccb.content.text("Produced by the British precision rifle company Accuracy International, the AX Modular Caliber Weapon System is a highly-accurate combat sniper rifle offered to military, law enforcement, and civilian precision marksmen.  The rifle is compatible with a wide range of aftermarket components, including caliber conversion kits, and is built upon a base aluminum chassis, into which the weapon's parts may be installed or removed at the user's discretion."),
        },
    },
    mass = "5420 g",
    volume = "6050 ml",
    length = "564 mm",
    price = "6 kUSD 750 USD",
    survival_price = "40 USD",
    materials = { "aluminum", "steel", "plastic" },
    color = "dark_gray",
    inheritance = { add = { flags = { "NO_TURRET", "EASY_CLEAN", "NO_TURRET", "BOLT_ACTION" } } },
    gun = {
        ammunition = { "NULL" },
        dispersion = 50,
        durability = 10,
        default_mods = { "match_trigger", "high_end_folding_stock" },
        mod_locations = {
            { id = "bore", count = 1 },
            { id = "mechanism", count = 2 },
            { id = "rail", count = 1 },
            { id = "sights", count = 1 },
            { id = "sling", count = 1 },
            { id = "stock accessory", count = 2 },
            { id = "underbarrel", count = 1 },
            { id = "stock", count = 1 },
        },
    },
}
