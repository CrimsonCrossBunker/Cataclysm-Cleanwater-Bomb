local ccb = require("ccb")
local content = ccb.content

local function upgrade_item(id, name, description, material)
    content.add(content.Item {
        id = id,
        name = name,
        description = description,
        category = "spare_parts",
        symbol = "V",
        color = "white",
        mass_grams = 15000,
        volume_ml = 25000,
        longest_side_mm = 900,
    }:material(material or "stone", 1))
end

upgrade_item(
    "buildkey_base1",
    ccb.content.plural_text("Mouth of the Island", "Mouth of the Island"),
    ccb.content.text("This strange metaphysical artifact is used to build a structure on the island.  Will be used automatically upon crafting, and can only be used once.\n\nASSOCIATED BUILD: Bunker Entrance")
)

upgrade_item(
    "buildkey_bigroom1",
    ccb.content.text("Miner's Cameo"),
    ccb.content.text("This strange metaphysical artifact is used to build a structure on the island.  Will be used automatically upon crafting, and can only be used once.\n\nASSOCIATED BUILD: Main Room 1")
)

upgrade_item(
    "buildkey_bigroom2",
    ccb.content.text("Hollow Carver"),
    ccb.content.text("This strange metaphysical artifact is used to build a structure on the island.  Will be used automatically upon crafting, and can only be used once.\n\nASSOCIATED BUILD: Main Room 2")
)

upgrade_item(
    "buildkey_bigroom3",
    ccb.content.text("Warped Reinforcement"),
    ccb.content.text("This strange metaphysical artifact is used to build a structure on the island.  Will be used automatically upon crafting, and can only be used once.\n\nASSOCIATED BUILD: Main Room 3")
)

upgrade_item(
    "buildkey_bigroom4",
    ccb.content.text("Cavernous Soul"),
    ccb.content.text("This strange metaphysical artifact is used to build a structure on the island.  Will be used automatically upon crafting, and can only be used once.\n\nASSOCIATED BUILD: Main Room 4")
)

upgrade_item(
    "buildkey_centralskylight2",
    ccb.content.text("Glass Figurine"),
    ccb.content.text("This strange metaphysical artifact is used to build a structure on the island.  Will be used automatically upon crafting, and can only be used once.\n\nASSOCIATED BUILD: Central Skylight 2")
)

upgrade_item(
    "buildkey_centralskylight3",
    ccb.content.text("Crystalline Mirror"),
    ccb.content.text("This strange metaphysical artifact is used to build a structure on the island.  Will be used automatically upon crafting, and can only be used once.\n\nASSOCIATED BUILD: Central Skylight 3")
)

upgrade_item(
    "buildkey_centralskylight4",
    ccb.content.text("Transparent Cube"),
    ccb.content.text("This strange metaphysical artifact is used to build a structure on the island.  Will be used automatically upon crafting, and can only be used once.\n\nASSOCIATED BUILD: Central Skylight 4")
)

upgrade_item(
    "buildkey_eastroom1",
    ccb.content.plural_text("Miner's Cameo (East)", "Miner's Cameo (East)"),
    ccb.content.text("This strange metaphysical artifact is used to build a structure on the island.  Will be used automatically upon crafting, and can only be used once.\n\nASSOCIATED BUILD: East Room 1")
)

upgrade_item(
    "buildkey_eastroom2",
    ccb.content.plural_text("Hollow Carver (East)", "Hollow Carver (East)"),
    ccb.content.text("This strange metaphysical artifact is used to build a structure on the island.  Will be used automatically upon crafting, and can only be used once.\n\nASSOCIATED BUILD: East Room 2")
)

upgrade_item(
    "buildkey_eastroom3",
    ccb.content.plural_text("Warped Reinforcement (East)", "Warped Reinforcement (East)"),
    ccb.content.text("This strange metaphysical artifact is used to build a structure on the island.  Will be used automatically upon crafting, and can only be used once.\n\nASSOCIATED BUILD: East Room 3")
)

upgrade_item(
    "buildkey_eastroom4",
    ccb.content.plural_text("Crystalline Glass (East)", "Crystalline Glass (East)"),
    ccb.content.text("This strange metaphysical artifact is used to build a structure on the island.  Will be used automatically upon crafting, and can only be used once.\n\nASSOCIATED BUILD: East Room Gallery")
)

upgrade_item(
    "buildkey_east_side_rooms",
    ccb.content.plural_text("Inverted Cube (East)", "Inverted Cube (East)"),
    ccb.content.text("This strange metaphysical artifact is used to build a structure on the island.  Will be used automatically upon crafting, and can only be used once.\n\nASSOCIATED BUILD: East Side Rooms")
)

upgrade_item(
    "buildkey_south_greenhouse_1",
    ccb.content.plural_text("Miner's Cameo (South)", "Miner's Cameo (South)"),
    ccb.content.text("This strange metaphysical artifact is used to build a structure on the island.  Will be used automatically upon crafting, and can only be used once.\n\nASSOCIATED BUILD: South Greenhouse 1")
)

upgrade_item(
    "buildkey_south_greenhouse_2",
    ccb.content.plural_text("Hollow Carver (South)", "Hollow Carver (South)"),
    ccb.content.text("This strange metaphysical artifact is used to build a structure on the island.  Will be used automatically upon crafting, and can only be used once.\n\nASSOCIATED BUILD: South Greenhouse 2")
)

upgrade_item(
    "buildkey_south_greenhouse_3",
    ccb.content.plural_text("Warped Reinforcement (South)", "Warped Reinforcement (South)"),
    ccb.content.text("This strange metaphysical artifact is used to build a structure on the island.  Will be used automatically upon crafting, and can only be used once.\n\nASSOCIATED BUILD: South Greenhouse 3")
)

upgrade_item(
    "buildkey_south_greenhouse_4",
    ccb.content.plural_text("Cavernous Soul (South)", "Cavernous Soul (South)"),
    ccb.content.text("This strange metaphysical artifact is used to build a structure on the island.  Will be used automatically upon crafting, and can only be used once.\n\nASSOCIATED BUILD: South Greenhouse 4")
)

upgrade_item(
    "buildkey_south_greenhouse_skylight_1",
    ccb.content.plural_text("Glass Figurine (South)", "Glass Figurine (South)"),
    ccb.content.text("This strange metaphysical artifact is used to build a structure on the island.  Will be used automatically upon crafting, and can only be used once.\n\nASSOCIATED BUILD: South Greenhouse Skylight 1")
)

upgrade_item(
    "buildkey_south_greenhouse_skylight_2",
    ccb.content.plural_text("Crystalline Mirror (South)", "Crystalline Mirror (South)"),
    ccb.content.text("This strange metaphysical artifact is used to build a structure on the island.  Will be used automatically upon crafting, and can only be used once.\n\nASSOCIATED BUILD: South Greenhouse Skylight 2")
)

upgrade_item(
    "buildkey_merchant_stall",
    ccb.content.plural_text("Jangling Pouch", "Jangling Pouch"),
    ccb.content.text("This strange metaphysical artifact is used to build a structure on the island.  Will be used automatically upon crafting, and can only be used once.\n\nASSOCIATED BUILD: Merchant Stall."),
    "gold"
)

upgrade_item(
    "buildkey_climatecontrol",
    ccb.content.text("Lukewarm Sphere"),
    ccb.content.text("This strange metaphysical artifact is used to build infrastructure on the island.  Will be used automatically upon crafting, and can only be used once.\n\nASSOCIATED BUILD: Climate Control")
)

upgrade_item(
    "upgradekey_sunblock",
    ccb.content.text("Solar Refractor"),
    ccb.content.text("This strange metaphysical artifact will make the island protect your skin from the sun while you are not earthside.  If your skin doesn't burn as the sun shines on it, this artifact will not do much to help but still won't hinder.  Will be used automatically upon crafting, and can only be used once.\n\nASSOCIATED UPGRADE: personal sunblock.")
)

upgrade_item(
    "upgradekey_radblock",
    ccb.content.text("Focused Scrubber"),
    ccb.content.text("This strange metaphysical artifact will make the island protect you from radiation while you are on it.  There might never be a single source of radiation on the island, but better prepared than sorry.  Will be used automatically upon crafting, and can only be used once.\n\nASSOCIATED UPGRADE: personal radiation shield.")
)

upgrade_item(
    "upgradekey_windblock",
    ccb.content.text("Wind Redirector"),
    ccb.content.text("This strange metaphysical artifact will make the island protect you from the winds while you are not earthside.  Will be used automatically upon crafting, and can only be used once.\n\nASSOCIATED UPGRADE: personal windblock.")
)

upgrade_item(
    "upgradekey_island_steady",
    ccb.content.text("Unyielding Sinew"),
    ccb.content.text("This strange metaphysical artifact will make the island maintain your speed while you are not earthside.  Will be used automatically upon crafting, and can only be used once.\n\nASSOCIATED UPGRADE: island-side resilience.")
)

upgrade_item(
    "upgradekey_temperature_control",
    ccb.content.text("Climate Self-Injector"),
    ccb.content.text("This strange metaphysical artifact will make the island protect you from temperature while you are not earthside.  Will be used automatically upon crafting, and can only be used once.\n\nASSOCIATED UPGRADE: personal temperature adaptation.")
)

upgrade_item(
    "buildkey_northroom1",
    ccb.content.plural_text("Miner's Cameo (North)", "Miner's Cameo (North)"),
    ccb.content.text("This strange metaphysical artifact is used to build a structure on the island.  Will be used automatically upon crafting, and can only be used once.\n\nASSOCIATED BUILD: North Room 1")
)

upgrade_item(
    "buildkey_northroom2",
    ccb.content.plural_text("Hollow Carver (North)", "Hollow Carver (North)"),
    ccb.content.text("This strange metaphysical artifact is used to build a structure on the island.  Will be used automatically upon crafting, and can only be used once.\n\nASSOCIATED BUILD: North Room 2")
)

upgrade_item(
    "buildkey_northroom3",
    ccb.content.plural_text("Warped Reinforcement (north)", "Warped Reinforcement (north)"),
    ccb.content.text("This strange metaphysical artifact is used to build a structure on the island.  Will be used automatically upon crafting, and can only be used once.\n\nASSOCIATED BUILD: North Room 3")
)

upgrade_item(
    "buildkey_northroom4",
    ccb.content.plural_text("Cavernous Soul (North)", "Cavernous Soul (North)"),
    ccb.content.text("This strange metaphysical artifact is used to build a structure on the island.  Will be used automatically upon crafting, and can only be used once.\n\nASSOCIATED BUILD: North Room 4")
)

upgrade_item(
    "buildkey_north_side_rooms",
    ccb.content.plural_text("Inverted Cube (North)", "Inverted Cube (North)"),
    ccb.content.text("This strange metaphysical artifact is used to build a structure on the island.  Will be used automatically upon crafting, and can only be used once.\n\nASSOCIATED BUILD: North Side Rooms")
)

upgrade_item(
    "upgradekey_rankup1",
    ccb.content.plural_text("Proof of Determination", "Proofs of Determination"),
    ccb.content.text("This strange metaphysical artifact will empower the island and unlock a permanent upgrade for all future runs.  Will be used automatically upon crafting, and can only be used once.\n\nASSOCIATED UPGRADE: Island Rank Up 1")
)

upgrade_item(
    "upgradekey_rankup2",
    ccb.content.plural_text("Proof of Mastery", "Proofs of Mastery"),
    ccb.content.text("This strange metaphysical artifact will empower the island and unlock a permanent upgrade for all future runs.  Will be used automatically upon crafting, and can only be used once.\n\nASSOCIATED UPGRADE: Island Rank Up 2")
)

upgrade_item(
    "buildkey_westroom1",
    ccb.content.plural_text("Miner's Cameo (West)", "Miner's Cameo (West)"),
    ccb.content.text("This strange metaphysical artifact is used to build a structure on the island.  Will be used automatically upon crafting, and can only be used once.\n\nASSOCIATED BUILD: West Room 1")
)

upgrade_item(
    "buildkey_westroom2",
    ccb.content.plural_text("Hollow Carver (West)", "Hollow Carver (West)"),
    ccb.content.text("This strange metaphysical artifact is used to build a structure on the island.  Will be used automatically upon crafting, and can only be used once.\n\nASSOCIATED BUILD: West Room 2")
)

upgrade_item(
    "buildkey_westroom3",
    ccb.content.plural_text("Warped Reinforcement (West)", "Warped Reinforcement (West)"),
    ccb.content.text("This strange metaphysical artifact is used to build a structure on the island.  Will be used automatically upon crafting, and can only be used once.\n\nASSOCIATED BUILD: West Room 3")
)

upgrade_item(
    "buildkey_westroom4",
    ccb.content.plural_text("Crystalline Glass (West)", "Crystalline Glass (West)"),
    ccb.content.text("This strange metaphysical artifact is used to build a structure on the island.  Will be used automatically upon crafting, and can only be used once.\n\nASSOCIATED BUILD: West Room Gallery")
)

upgrade_item(
    "buildkey_west_side_rooms",
    ccb.content.plural_text("Inverted Cube (West)", "Inverted Cube (West)"),
    ccb.content.text("This strange metaphysical artifact is used to build a structure on the island.  Will be used automatically upon crafting, and can only be used once.\n\nASSOCIATED BUILD: West Side Rooms")
)

upgrade_item(
    "upgradekey_challenge_mode",
    ccb.content.text("Eternal Obelisk"),
    ccb.content.text("This strange metaphysical artifact will empower the island and unlock a permanent upgrade for all future runs.  Will be used automatically upon crafting, and can only be used once.\n\nASSOCIATED UPGRADE: Challenge Mode")
)

upgrade_item(
    "upgradekey_exit1",
    ccb.content.text("Escape Charm"),
    ccb.content.text("This strange metaphysical artifact will empower the island and unlock a permanent upgrade for all future runs.  Will be used automatically upon crafting, and can only be used once.\n\nASSOCIATED UPGRADE: Two Exits per Expedition")
)

upgrade_item(
    "upgradekey_exit2",
    ccb.content.plural_text("Blindfold of Egress", "Blindfolds of Egress"),
    ccb.content.text("This strange metaphysical artifact will empower the island and unlock a permanent upgrade for all future runs.  Will be used automatically upon crafting, and can only be used once.\n\nASSOCIATED UPGRADE: Three Exits per Expedition")
)

upgrade_item(
    "upgradekey_exit3",
    ccb.content.text("Thrice-Sided Door"),
    ccb.content.text("This strange metaphysical artifact will empower the island and unlock a permanent upgrade for all future runs.  Will be used automatically upon crafting, and can only be used once.\n\nASSOCIATED UPGRADE: Four Exits per Expedition")
)

upgrade_item(
    "upgradekey_exit4",
    ccb.content.text("Intangible Door Stopper"),
    ccb.content.text("This strange metaphysical artifact will empower the island and unlock a permanent upgrade for all future runs.  Will be used automatically upon crafting, and can only be used once.\n\nASSOCIATED UPGRADE: Five Exits per Expedition")
)

upgrade_item(
    "upgradekey_landing1",
    ccb.content.text("Landing Pad"),
    ccb.content.text("This strange metaphysical artifact will empower the island and unlock a permanent upgrade for all future runs.  Will be used automatically upon crafting, and can only be used once.\n\nASSOCIATED UPGRADE: Landing 1")
)

upgrade_item(
    "upgradekey_landing2",
    ccb.content.text("Safety Net"),
    ccb.content.text("This strange metaphysical artifact will empower the island and unlock a permanent upgrade for all future runs.  Will be used automatically upon crafting, and can only be used once.\n\nASSOCIATED UPGRADE: Landing 2")
)

upgrade_item(
    "upgradekey_landing3",
    ccb.content.text("Warped Parachute"),
    ccb.content.text("This strange metaphysical artifact will empower the island and unlock a permanent upgrade for all future runs.  Will be used automatically upon crafting, and can only be used once.\n\nASSOCIATED UPGRADE: Landing 3")
)

upgrade_item(
    "upgradekey_landing4",
    ccb.content.text("Ethereal Cushion"),
    ccb.content.text("This strange metaphysical artifact will empower the island and unlock a permanent upgrade for all future runs.  Will be used automatically upon crafting, and can only be used once.\n\nASSOCIATED UPGRADE: Landing 4")
)

upgrade_item(
    "upgradekey_landing5",
    ccb.content.plural_text("Grace of the Island", "Grace of the Island"),
    ccb.content.text("This strange metaphysical artifact will empower the island and unlock a permanent upgrade for all future runs.  Will be used automatically upon crafting, and can only be used once.\n\nASSOCIATED UPGRADE: Landing 5")
)

upgrade_item(
    "upgradekey_landing6",
    ccb.content.text("Familiarity Gemstone"),
    ccb.content.text("This strange metaphysical artifact will empower the island and unlock a permanent upgrade for all future runs.  Will be used automatically upon crafting, and can only be used once.\n\nASSOCIATED UPGRADE: Landing 6")
)

upgrade_item(
    "upgradekey_landing7",
    ccb.content.text("Warm Welcome"),
    ccb.content.text("This strange metaphysical artifact will empower the island and unlock a permanent upgrade for all future runs.  Will be used automatically upon crafting, and can only be used once.\n\nASSOCIATED UPGRADE: Landing 7")
)

upgrade_item(
    "upgradekey_landing8",
    ccb.content.text("Emissary's Herald"),
    ccb.content.text("This strange metaphysical artifact will empower the island and unlock a permanent upgrade for all future runs.  Will be used automatically upon crafting, and can only be used once.\n\nASSOCIATED UPGRADE: Landing 8")
)

upgrade_item(
    "upgradekey_landing_waterwalking",
    ccb.content.plural_text("Cloaking Buoyancy", "Cloaking Buoyancy"),
    ccb.content.text("This strange metaphysical artifact will empower the island and unlock a permanent upgrade for all future runs.  Will be used automatically upon crafting, and can only be used once.\n\nASSOCIATED UPGRADE: Landing Boost: Waterwalking.")
)

upgrade_item(
    "upgradekey_landing_flight",
    ccb.content.text("Inverted Gravity Bubble"),
    ccb.content.text("This strange metaphysical artifact will empower the island and unlock a permanent upgrade for all future runs.  Will be used automatically upon crafting, and can only be used once.\n\nASSOCIATED UPGRADE: Landing Boost: Flight.")
)

upgrade_item(
    "upgradekey_landing_phase",
    ccb.content.plural_text("Universal Access Pass", "Universal Access Pass"),
    ccb.content.text("This strange metaphysical artifact will empower the island and unlock a permanent upgrade for all future runs.  Will be used automatically upon crafting, and can only be used once.\n\nASSOCIATED UPGRADE: Landing Boost: Phasing.")
)

upgrade_item(
    "upgradekey_raidlength1",
    ccb.content.plural_text("Warped Hourglass", "Warped Hourglasses"),
    ccb.content.text("This strange metaphysical artifact will empower the island and unlock a permanent upgrade for all future runs.  Will be used automatically upon crafting, and can only be used once.\n\nASSOCIATED UPGRADE: Large Expeditions")
)

upgrade_item(
    "upgradekey_raidlength2",
    ccb.content.text("Watch of Flowing Time"),
    ccb.content.text("This strange metaphysical artifact will empower the island and unlock a permanent upgrade for all future runs.  Will be used automatically upon crafting, and can only be used once.\n\nASSOCIATED UPGRADE: Extended Expeditions")
)

upgrade_item(
    "upgradekey_slaughter",
    ccb.content.plural_text("Vengeance of the Island", "Vengeance of the Island"),
    ccb.content.text("This strange metaphysical artifact will empower the island and unlock a permanent upgrade for all future runs.  Will be used automatically upon crafting, and can only be used once.\n\nASSOCIATED UPGRADE: Slaughter Missions")
)

upgrade_item(
    "upgradekey_bonusmissions1",
    ccb.content.text("Warped Decree"),
    ccb.content.text("This strange metaphysical artifact will empower the island and unlock a permanent upgrade for all future runs.  Will be used automatically upon crafting, and can only be used once.\n\nASSOCIATED UPGRADE: Expedition Missions")
)

upgrade_item(
    "upgradekey_bonusmissions2",
    ccb.content.text("Order's Blade"),
    ccb.content.text("This strange metaphysical artifact will empower the island and unlock a permanent upgrade for all future runs.  Will be used automatically upon crafting, and can only be used once.\n\nASSOCIATED UPGRADE: Two Missions per Expedition")
)

upgrade_item(
    "upgradekey_bonusmissions3",
    ccb.content.plural_text("Hand of the Island", "Hand of the Island"),
    ccb.content.text("This strange metaphysical artifact will empower the island and unlock a permanent upgrade for all future runs.  Will be used automatically upon crafting, and can only be used once.\n\nASSOCIATED UPGRADE: Three Missions per Expedition")
)

upgrade_item(
    "upgradekey_bonusmissions4",
    ccb.content.text("Petrified Duty's Call"),
    ccb.content.text("This strange metaphysical artifact will empower the island and unlock a permanent upgrade for all future runs.  Will be used automatically upon crafting, and can only be used once.\n\nASSOCIATED UPGRADE: Four Missions per Expedition")
)

upgrade_item(
    "upgradekey_bonusmissions5",
    ccb.content.text("Oath of the Island's Enforcer"),
    ccb.content.text("This strange metaphysical artifact will empower the island and unlock a permanent upgrade for all future runs.  Will be used automatically upon crafting, and can only be used once.\n\nASSOCIATED UPGRADE: Five Missions per Expedition")
)

upgrade_item(
    "upgradekey_hardmissions1",
    ccb.content.text("Ordinator's Sigil"),
    ccb.content.text("This strange metaphysical artifact will empower the island and unlock a permanent upgrade for all future runs.  Will be used automatically upon crafting, and can only be used once.\n\nASSOCIATED UPGRADE: Harder Missions")
)

upgrade_item(
    "upgradekey_hardmissions2",
    ccb.content.plural_text("Will of the Island", "Will of the Island"),
    ccb.content.text("This strange metaphysical artifact will empower the island and unlock a permanent upgrade for all future runs.  Will be used automatically upon crafting, and can only be used once.\n\nASSOCIATED UPGRADE: Hardest Missions")
)

upgrade_item(
    "upgradekey_scouting1",
    ccb.content.plural_text("Scouting Lens", "Scouting Lenses"),
    ccb.content.text("This strange metaphysical artifact will empower the island and unlock a permanent upgrade for all future runs.  Will be used automatically upon crafting, and can only be used once.\n\nASSOCIATED UPGRADE: Scouting 1")
)

upgrade_item(
    "upgradekey_scouting2",
    ccb.content.text("Scouting Scope"),
    ccb.content.text("This strange metaphysical artifact will empower the island and unlock a permanent upgrade for all future runs.  Will be used automatically upon crafting, and can only be used once.\n\nASSOCIATED UPGRADE: Scouting 2")
)

upgrade_item(
    "upgradekey_scouting3",
    ccb.content.text("Vision Amplifier"),
    ccb.content.text("This strange metaphysical artifact will empower the island and unlock a permanent upgrade for all future runs.  Will be used automatically upon crafting, and can only be used once.\n\nASSOCIATED UPGRADE: Scouting 3")
)

upgrade_item(
    "upgradekey_scouting4",
    ccb.content.text("Third Eye Charm"),
    ccb.content.text("This strange metaphysical artifact will empower the island and unlock a permanent upgrade for all future runs.  Will be used automatically upon crafting, and can only be used once.\n\nASSOCIATED UPGRADE: Scouting 4")
)

upgrade_item(
    "upgradekey_scouting5",
    ccb.content.plural_text("Eye of the Island", "Eye of the Island"),
    ccb.content.text("This strange metaphysical artifact will empower the island and unlock a permanent upgrade for all future runs.  Will be used automatically upon crafting, and can only be used once.\n\nASSOCIATED UPGRADE: Scouting 5")
)

upgrade_item(
    "upgradekey_scouting6",
    ccb.content.plural_text("Warpforged Telescope", "Warpforged Telescope"),
    ccb.content.text("This strange metaphysical artifact will empower the island and unlock a permanent upgrade for all future runs.  Will be used automatically upon crafting, and can only be used once.\n\nASSOCIATED UPGRADE: Scouting 6")
)

upgrade_item(
    "upgradekey_scouting7",
    ccb.content.plural_text("Agglomerated Oculus", "Agglomerated Oculus"),
    ccb.content.text("This strange metaphysical artifact will empower the island and unlock a permanent upgrade for all future runs.  Will be used automatically upon crafting, and can only be used once.\n\nASSOCIATED UPGRADE: Scouting 7")
)

upgrade_item(
    "upgradekey_scouting8",
    ccb.content.plural_text("Other Eye of the Island", "Other Eye of the Island"),
    ccb.content.text("This strange metaphysical artifact will empower the island and unlock a permanent upgrade for all future runs.  Will be used automatically upon crafting, and can only be used once.\n\nASSOCIATED UPGRADE: Scouting 8")
)

upgrade_item(
    "upgradekey_scoutingclairvoyance1",
    ccb.content.text("Higher Viewpoint"),
    ccb.content.text("This strange metaphysical artifact will empower the island and unlock a permanent upgrade for all future runs.  Will be used automatically upon crafting, and can only be used once.\n\nASSOCIATED UPGRADE: Scouting Clairvoyance 1")
)

upgrade_item(
    "upgradekey_scoutingclairvoyance2",
    ccb.content.plural_text("All-Seeing Effigy", "All-Seeing Effigy"),
    ccb.content.text("This strange metaphysical artifact will empower the island and unlock a permanent upgrade for all future runs.  Will be used automatically upon crafting, and can only be used once.\n\nASSOCIATED UPGRADE: Scouting Clairvoyance 2")
)

upgrade_item(
    "upgradekey_stability1",
    ccb.content.text("Warped Tincture"),
    ccb.content.text("This strange metaphysical artifact will empower the island and unlock a permanent upgrade for all future runs.  Will be used automatically upon crafting, and can only be used once.\n\nASSOCIATED UPGRADE: Stability 1")
)

upgrade_item(
    "upgradekey_stability2",
    ccb.content.text("Surreal Shield"),
    ccb.content.text("This strange metaphysical artifact will empower the island and unlock a permanent upgrade for all future runs.  Will be used automatically upon crafting, and can only be used once.\n\nASSOCIATED UPGRADE: Stability 2")
)

upgrade_item(
    "upgradekey_stability3",
    ccb.content.text("Warpstream Plating"),
    ccb.content.text("This strange metaphysical artifact will empower the island and unlock a permanent upgrade for all future runs.  Will be used automatically upon crafting, and can only be used once.\n\nASSOCIATED UPGRADE: Stability 3")
)

upgrade_item(
    "upgradekey_stability4",
    ccb.content.plural_text("Fortitude of the Island", "Fortitude of the Island"),
    ccb.content.text("This strange metaphysical artifact will empower the island and unlock a permanent upgrade for all future runs.  Will be used automatically upon crafting, and can only be used once.\n\nASSOCIATED UPGRADE: Stability 4")
)

upgrade_item(
    "upgradekey_stability5",
    ccb.content.text("Explorer's Ward"),
    ccb.content.text("This strange metaphysical artifact will empower the island and unlock a permanent upgrade for all future runs.  Will be used automatically upon crafting, and can only be used once.\n\nASSOCIATED UPGRADE: Stability 5")
)

upgrade_item(
    "upgradekey_stability6",
    ccb.content.text("Island-Bound Armor"),
    ccb.content.text("This strange metaphysical artifact will empower the island and unlock a permanent upgrade for all future runs.  Will be used automatically upon crafting, and can only be used once.\n\nASSOCIATED UPGRADE: Stability 6")
)

upgrade_item(
    "upgradekey_stability7",
    ccb.content.text("Triune Anchor"),
    ccb.content.text("This strange metaphysical artifact will empower the island and unlock a permanent upgrade for all future runs.  Will be used automatically upon crafting, and can only be used once.\n\nASSOCIATED UPGRADE: Stability 7")
)

upgrade_item(
    "upgradekey_basementsunlock",
    ccb.content.text("Basement Locator"),
    ccb.content.text("This strange metaphysical artifact will empower the island and unlock a permanent upgrade for all future runs.  Will be used automatically upon crafting, and can only be used once.\n\nASSOCIATED UPGRADE: Unlock Start Location: Basements")
)

upgrade_item(
    "upgradekey_roofsunlock",
    ccb.content.text("Rooftop Locator"),
    ccb.content.text("This strange metaphysical artifact will empower the island and unlock a permanent upgrade for all future runs.  Will be used automatically upon crafting, and can only be used once.\n\nASSOCIATED UPGRADE: Unlock Start Location: Roofs")
)

upgrade_item(
    "upgradekey_labsunlock",
    ccb.content.text("Laboratory Locator"),
    ccb.content.text("This strange metaphysical artifact will empower the island and unlock a permanent upgrade for all future runs.  Will be used automatically upon crafting, and can only be used once.\n\nASSOCIATED UPGRADE: Unlock Start Location: Labs")
)

upgrade_item(
    "upgradekey_warped_harness1",
    ccb.content.plural_text("Ideal of Exercise", "Ideals of Exercise"),
    ccb.content.text("This strange metaphysical artifact will empower you and unlock a new crafting recipe.  Will be used automatically upon crafting, and can only be used once.\n\nASSOCIATED UPGRADE: Warped Hauler's Harness Mk II")
)

upgrade_item(
    "upgradekey_warped_harness2",
    ccb.content.plural_text("Testament of Hoisting", "Testaments of Hoisting"),
    ccb.content.text("This strange metaphysical artifact will empower you and unlock a new crafting recipe.  Will be used automatically upon crafting, and can only be used once.\n\nASSOCIATED UPGRADE: Warped Hauler's Harness Mk III")
)
