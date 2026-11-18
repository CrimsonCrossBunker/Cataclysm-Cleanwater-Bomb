local content = require("ccb").content

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
    content.plural_text("Mouth of the Island", "Mouth of the Island"),
    content.text("This strange metaphysical artifact is used to build a structure on the island.  Will be used automatically upon crafting, and can only be used once.\n\nASSOCIATED BUILD: Bunker Entrance")
)

upgrade_item(
    "buildkey_bigroom1",
    content.text("Miner's Cameo"),
    content.text("This strange metaphysical artifact is used to build a structure on the island.  Will be used automatically upon crafting, and can only be used once.\n\nASSOCIATED BUILD: Main Room 1")
)

upgrade_item(
    "buildkey_bigroom2",
    content.text("Hollow Carver"),
    content.text("This strange metaphysical artifact is used to build a structure on the island.  Will be used automatically upon crafting, and can only be used once.\n\nASSOCIATED BUILD: Main Room 2")
)

upgrade_item(
    "buildkey_bigroom3",
    content.text("Warped Reinforcement"),
    content.text("This strange metaphysical artifact is used to build a structure on the island.  Will be used automatically upon crafting, and can only be used once.\n\nASSOCIATED BUILD: Main Room 3")
)

upgrade_item(
    "buildkey_bigroom4",
    content.text("Cavernous Soul"),
    content.text("This strange metaphysical artifact is used to build a structure on the island.  Will be used automatically upon crafting, and can only be used once.\n\nASSOCIATED BUILD: Main Room 4")
)

upgrade_item(
    "buildkey_centralskylight2",
    content.text("Glass Figurine"),
    content.text("This strange metaphysical artifact is used to build a structure on the island.  Will be used automatically upon crafting, and can only be used once.\n\nASSOCIATED BUILD: Central Skylight 2")
)

upgrade_item(
    "buildkey_centralskylight3",
    content.text("Crystalline Mirror"),
    content.text("This strange metaphysical artifact is used to build a structure on the island.  Will be used automatically upon crafting, and can only be used once.\n\nASSOCIATED BUILD: Central Skylight 3")
)

upgrade_item(
    "buildkey_centralskylight4",
    content.text("Transparent Cube"),
    content.text("This strange metaphysical artifact is used to build a structure on the island.  Will be used automatically upon crafting, and can only be used once.\n\nASSOCIATED BUILD: Central Skylight 4")
)

upgrade_item(
    "buildkey_eastroom1",
    content.plural_text("Miner's Cameo (East)", "Miner's Cameo (East)"),
    content.text("This strange metaphysical artifact is used to build a structure on the island.  Will be used automatically upon crafting, and can only be used once.\n\nASSOCIATED BUILD: East Room 1")
)

upgrade_item(
    "buildkey_eastroom2",
    content.plural_text("Hollow Carver (East)", "Hollow Carver (East)"),
    content.text("This strange metaphysical artifact is used to build a structure on the island.  Will be used automatically upon crafting, and can only be used once.\n\nASSOCIATED BUILD: East Room 2")
)

upgrade_item(
    "buildkey_eastroom3",
    content.plural_text("Warped Reinforcement (East)", "Warped Reinforcement (East)"),
    content.text("This strange metaphysical artifact is used to build a structure on the island.  Will be used automatically upon crafting, and can only be used once.\n\nASSOCIATED BUILD: East Room 3")
)

upgrade_item(
    "buildkey_eastroom4",
    content.plural_text("Crystalline Glass (East)", "Crystalline Glass (East)"),
    content.text("This strange metaphysical artifact is used to build a structure on the island.  Will be used automatically upon crafting, and can only be used once.\n\nASSOCIATED BUILD: East Room Gallery")
)

upgrade_item(
    "buildkey_east_side_rooms",
    content.plural_text("Inverted Cube (East)", "Inverted Cube (East)"),
    content.text("This strange metaphysical artifact is used to build a structure on the island.  Will be used automatically upon crafting, and can only be used once.\n\nASSOCIATED BUILD: East Side Rooms")
)

upgrade_item(
    "buildkey_south_greenhouse_1",
    content.plural_text("Miner's Cameo (South)", "Miner's Cameo (South)"),
    content.text("This strange metaphysical artifact is used to build a structure on the island.  Will be used automatically upon crafting, and can only be used once.\n\nASSOCIATED BUILD: South Greenhouse 1")
)

upgrade_item(
    "buildkey_south_greenhouse_2",
    content.plural_text("Hollow Carver (South)", "Hollow Carver (South)"),
    content.text("This strange metaphysical artifact is used to build a structure on the island.  Will be used automatically upon crafting, and can only be used once.\n\nASSOCIATED BUILD: South Greenhouse 2")
)

upgrade_item(
    "buildkey_south_greenhouse_3",
    content.plural_text("Warped Reinforcement (South)", "Warped Reinforcement (South)"),
    content.text("This strange metaphysical artifact is used to build a structure on the island.  Will be used automatically upon crafting, and can only be used once.\n\nASSOCIATED BUILD: South Greenhouse 3")
)

upgrade_item(
    "buildkey_south_greenhouse_4",
    content.plural_text("Cavernous Soul (South)", "Cavernous Soul (South)"),
    content.text("This strange metaphysical artifact is used to build a structure on the island.  Will be used automatically upon crafting, and can only be used once.\n\nASSOCIATED BUILD: South Greenhouse 4")
)

upgrade_item(
    "buildkey_south_greenhouse_skylight_1",
    content.plural_text("Glass Figurine (South)", "Glass Figurine (South)"),
    content.text("This strange metaphysical artifact is used to build a structure on the island.  Will be used automatically upon crafting, and can only be used once.\n\nASSOCIATED BUILD: South Greenhouse Skylight 1")
)

upgrade_item(
    "buildkey_south_greenhouse_skylight_2",
    content.plural_text("Crystalline Mirror (South)", "Crystalline Mirror (South)"),
    content.text("This strange metaphysical artifact is used to build a structure on the island.  Will be used automatically upon crafting, and can only be used once.\n\nASSOCIATED BUILD: South Greenhouse Skylight 2")
)

upgrade_item(
    "buildkey_merchant_stall",
    content.plural_text("Jangling Pouch", "Jangling Pouch"),
    content.text("This strange metaphysical artifact is used to build a structure on the island.  Will be used automatically upon crafting, and can only be used once.\n\nASSOCIATED BUILD: Merchant Stall."),
    "gold"
)

upgrade_item(
    "buildkey_climatecontrol",
    content.text("Lukewarm Sphere"),
    content.text("This strange metaphysical artifact is used to build infrastructure on the island.  Will be used automatically upon crafting, and can only be used once.\n\nASSOCIATED BUILD: Climate Control")
)

upgrade_item(
    "upgradekey_sunblock",
    content.text("Solar Refractor"),
    content.text("This strange metaphysical artifact will make the island protect your skin from the sun while you are not earthside.  If your skin doesn't burn as the sun shines on it, this artifact will not do much to help but still won't hinder.  Will be used automatically upon crafting, and can only be used once.\n\nASSOCIATED UPGRADE: personal sunblock.")
)

upgrade_item(
    "upgradekey_radblock",
    content.text("Focused Scrubber"),
    content.text("This strange metaphysical artifact will make the island protect you from radiation while you are on it.  There might never be a single source of radiation on the island, but better prepared than sorry.  Will be used automatically upon crafting, and can only be used once.\n\nASSOCIATED UPGRADE: personal radiation shield.")
)

upgrade_item(
    "upgradekey_windblock",
    content.text("Wind Redirector"),
    content.text("This strange metaphysical artifact will make the island protect you from the winds while you are not earthside.  Will be used automatically upon crafting, and can only be used once.\n\nASSOCIATED UPGRADE: personal windblock.")
)

upgrade_item(
    "upgradekey_island_steady",
    content.text("Unyielding Sinew"),
    content.text("This strange metaphysical artifact will make the island maintain your speed while you are not earthside.  Will be used automatically upon crafting, and can only be used once.\n\nASSOCIATED UPGRADE: island-side resilience.")
)

upgrade_item(
    "upgradekey_temperature_control",
    content.text("Climate Self-Injector"),
    content.text("This strange metaphysical artifact will make the island protect you from temperature while you are not earthside.  Will be used automatically upon crafting, and can only be used once.\n\nASSOCIATED UPGRADE: personal temperature adaptation.")
)

upgrade_item(
    "buildkey_northroom1",
    content.plural_text("Miner's Cameo (North)", "Miner's Cameo (North)"),
    content.text("This strange metaphysical artifact is used to build a structure on the island.  Will be used automatically upon crafting, and can only be used once.\n\nASSOCIATED BUILD: North Room 1")
)

upgrade_item(
    "buildkey_northroom2",
    content.plural_text("Hollow Carver (North)", "Hollow Carver (North)"),
    content.text("This strange metaphysical artifact is used to build a structure on the island.  Will be used automatically upon crafting, and can only be used once.\n\nASSOCIATED BUILD: North Room 2")
)

upgrade_item(
    "buildkey_northroom3",
    content.plural_text("Warped Reinforcement (north)", "Warped Reinforcement (north)"),
    content.text("This strange metaphysical artifact is used to build a structure on the island.  Will be used automatically upon crafting, and can only be used once.\n\nASSOCIATED BUILD: North Room 3")
)

upgrade_item(
    "buildkey_northroom4",
    content.plural_text("Cavernous Soul (North)", "Cavernous Soul (North)"),
    content.text("This strange metaphysical artifact is used to build a structure on the island.  Will be used automatically upon crafting, and can only be used once.\n\nASSOCIATED BUILD: North Room 4")
)

upgrade_item(
    "buildkey_north_side_rooms",
    content.plural_text("Inverted Cube (North)", "Inverted Cube (North)"),
    content.text("This strange metaphysical artifact is used to build a structure on the island.  Will be used automatically upon crafting, and can only be used once.\n\nASSOCIATED BUILD: North Side Rooms")
)

upgrade_item(
    "upgradekey_rankup1",
    content.plural_text("Proof of Determination", "Proofs of Determination"),
    content.text("This strange metaphysical artifact will empower the island and unlock a permanent upgrade for all future runs.  Will be used automatically upon crafting, and can only be used once.\n\nASSOCIATED UPGRADE: Island Rank Up 1")
)

upgrade_item(
    "upgradekey_rankup2",
    content.plural_text("Proof of Mastery", "Proofs of Mastery"),
    content.text("This strange metaphysical artifact will empower the island and unlock a permanent upgrade for all future runs.  Will be used automatically upon crafting, and can only be used once.\n\nASSOCIATED UPGRADE: Island Rank Up 2")
)

upgrade_item(
    "buildkey_westroom1",
    content.plural_text("Miner's Cameo (West)", "Miner's Cameo (West)"),
    content.text("This strange metaphysical artifact is used to build a structure on the island.  Will be used automatically upon crafting, and can only be used once.\n\nASSOCIATED BUILD: West Room 1")
)

upgrade_item(
    "buildkey_westroom2",
    content.plural_text("Hollow Carver (West)", "Hollow Carver (West)"),
    content.text("This strange metaphysical artifact is used to build a structure on the island.  Will be used automatically upon crafting, and can only be used once.\n\nASSOCIATED BUILD: West Room 2")
)

upgrade_item(
    "buildkey_westroom3",
    content.plural_text("Warped Reinforcement (West)", "Warped Reinforcement (West)"),
    content.text("This strange metaphysical artifact is used to build a structure on the island.  Will be used automatically upon crafting, and can only be used once.\n\nASSOCIATED BUILD: West Room 3")
)

upgrade_item(
    "buildkey_westroom4",
    content.plural_text("Crystalline Glass (West)", "Crystalline Glass (West)"),
    content.text("This strange metaphysical artifact is used to build a structure on the island.  Will be used automatically upon crafting, and can only be used once.\n\nASSOCIATED BUILD: West Room Gallery")
)

upgrade_item(
    "buildkey_west_side_rooms",
    content.plural_text("Inverted Cube (West)", "Inverted Cube (West)"),
    content.text("This strange metaphysical artifact is used to build a structure on the island.  Will be used automatically upon crafting, and can only be used once.\n\nASSOCIATED BUILD: West Side Rooms")
)

upgrade_item(
    "upgradekey_challenge_mode",
    content.text("Eternal Obelisk"),
    content.text("This strange metaphysical artifact will empower the island and unlock a permanent upgrade for all future runs.  Will be used automatically upon crafting, and can only be used once.\n\nASSOCIATED UPGRADE: Challenge Mode")
)

upgrade_item(
    "upgradekey_exit1",
    content.text("Escape Charm"),
    content.text("This strange metaphysical artifact will empower the island and unlock a permanent upgrade for all future runs.  Will be used automatically upon crafting, and can only be used once.\n\nASSOCIATED UPGRADE: Two Exits per Expedition")
)

upgrade_item(
    "upgradekey_exit2",
    content.plural_text("Blindfold of Egress", "Blindfolds of Egress"),
    content.text("This strange metaphysical artifact will empower the island and unlock a permanent upgrade for all future runs.  Will be used automatically upon crafting, and can only be used once.\n\nASSOCIATED UPGRADE: Three Exits per Expedition")
)

upgrade_item(
    "upgradekey_exit3",
    content.text("Thrice-Sided Door"),
    content.text("This strange metaphysical artifact will empower the island and unlock a permanent upgrade for all future runs.  Will be used automatically upon crafting, and can only be used once.\n\nASSOCIATED UPGRADE: Four Exits per Expedition")
)

upgrade_item(
    "upgradekey_exit4",
    content.text("Intangible Door Stopper"),
    content.text("This strange metaphysical artifact will empower the island and unlock a permanent upgrade for all future runs.  Will be used automatically upon crafting, and can only be used once.\n\nASSOCIATED UPGRADE: Five Exits per Expedition")
)

upgrade_item(
    "upgradekey_landing1",
    content.text("Landing Pad"),
    content.text("This strange metaphysical artifact will empower the island and unlock a permanent upgrade for all future runs.  Will be used automatically upon crafting, and can only be used once.\n\nASSOCIATED UPGRADE: Landing 1")
)

upgrade_item(
    "upgradekey_landing2",
    content.text("Safety Net"),
    content.text("This strange metaphysical artifact will empower the island and unlock a permanent upgrade for all future runs.  Will be used automatically upon crafting, and can only be used once.\n\nASSOCIATED UPGRADE: Landing 2")
)

upgrade_item(
    "upgradekey_landing3",
    content.text("Warped Parachute"),
    content.text("This strange metaphysical artifact will empower the island and unlock a permanent upgrade for all future runs.  Will be used automatically upon crafting, and can only be used once.\n\nASSOCIATED UPGRADE: Landing 3")
)

upgrade_item(
    "upgradekey_landing4",
    content.text("Ethereal Cushion"),
    content.text("This strange metaphysical artifact will empower the island and unlock a permanent upgrade for all future runs.  Will be used automatically upon crafting, and can only be used once.\n\nASSOCIATED UPGRADE: Landing 4")
)

upgrade_item(
    "upgradekey_landing5",
    content.plural_text("Grace of the Island", "Grace of the Island"),
    content.text("This strange metaphysical artifact will empower the island and unlock a permanent upgrade for all future runs.  Will be used automatically upon crafting, and can only be used once.\n\nASSOCIATED UPGRADE: Landing 5")
)

upgrade_item(
    "upgradekey_landing6",
    content.text("Familiarity Gemstone"),
    content.text("This strange metaphysical artifact will empower the island and unlock a permanent upgrade for all future runs.  Will be used automatically upon crafting, and can only be used once.\n\nASSOCIATED UPGRADE: Landing 6")
)

upgrade_item(
    "upgradekey_landing7",
    content.text("Warm Welcome"),
    content.text("This strange metaphysical artifact will empower the island and unlock a permanent upgrade for all future runs.  Will be used automatically upon crafting, and can only be used once.\n\nASSOCIATED UPGRADE: Landing 7")
)

upgrade_item(
    "upgradekey_landing8",
    content.text("Emissary's Herald"),
    content.text("This strange metaphysical artifact will empower the island and unlock a permanent upgrade for all future runs.  Will be used automatically upon crafting, and can only be used once.\n\nASSOCIATED UPGRADE: Landing 8")
)

upgrade_item(
    "upgradekey_landing_waterwalking",
    content.plural_text("Cloaking Buoyancy", "Cloaking Buoyancy"),
    content.text("This strange metaphysical artifact will empower the island and unlock a permanent upgrade for all future runs.  Will be used automatically upon crafting, and can only be used once.\n\nASSOCIATED UPGRADE: Landing Boost: Waterwalking.")
)

upgrade_item(
    "upgradekey_landing_flight",
    content.text("Inverted Gravity Bubble"),
    content.text("This strange metaphysical artifact will empower the island and unlock a permanent upgrade for all future runs.  Will be used automatically upon crafting, and can only be used once.\n\nASSOCIATED UPGRADE: Landing Boost: Flight.")
)

upgrade_item(
    "upgradekey_landing_phase",
    content.plural_text("Universal Access Pass", "Universal Access Pass"),
    content.text("This strange metaphysical artifact will empower the island and unlock a permanent upgrade for all future runs.  Will be used automatically upon crafting, and can only be used once.\n\nASSOCIATED UPGRADE: Landing Boost: Phasing.")
)

upgrade_item(
    "upgradekey_raidlength1",
    content.plural_text("Warped Hourglass", "Warped Hourglasses"),
    content.text("This strange metaphysical artifact will empower the island and unlock a permanent upgrade for all future runs.  Will be used automatically upon crafting, and can only be used once.\n\nASSOCIATED UPGRADE: Large Expeditions")
)

upgrade_item(
    "upgradekey_raidlength2",
    content.text("Watch of Flowing Time"),
    content.text("This strange metaphysical artifact will empower the island and unlock a permanent upgrade for all future runs.  Will be used automatically upon crafting, and can only be used once.\n\nASSOCIATED UPGRADE: Extended Expeditions")
)

upgrade_item(
    "upgradekey_slaughter",
    content.plural_text("Vengeance of the Island", "Vengeance of the Island"),
    content.text("This strange metaphysical artifact will empower the island and unlock a permanent upgrade for all future runs.  Will be used automatically upon crafting, and can only be used once.\n\nASSOCIATED UPGRADE: Slaughter Missions")
)

upgrade_item(
    "upgradekey_bonusmissions1",
    content.text("Warped Decree"),
    content.text("This strange metaphysical artifact will empower the island and unlock a permanent upgrade for all future runs.  Will be used automatically upon crafting, and can only be used once.\n\nASSOCIATED UPGRADE: Expedition Missions")
)

upgrade_item(
    "upgradekey_bonusmissions2",
    content.text("Order's Blade"),
    content.text("This strange metaphysical artifact will empower the island and unlock a permanent upgrade for all future runs.  Will be used automatically upon crafting, and can only be used once.\n\nASSOCIATED UPGRADE: Two Missions per Expedition")
)

upgrade_item(
    "upgradekey_bonusmissions3",
    content.plural_text("Hand of the Island", "Hand of the Island"),
    content.text("This strange metaphysical artifact will empower the island and unlock a permanent upgrade for all future runs.  Will be used automatically upon crafting, and can only be used once.\n\nASSOCIATED UPGRADE: Three Missions per Expedition")
)

upgrade_item(
    "upgradekey_bonusmissions4",
    content.text("Petrified Duty's Call"),
    content.text("This strange metaphysical artifact will empower the island and unlock a permanent upgrade for all future runs.  Will be used automatically upon crafting, and can only be used once.\n\nASSOCIATED UPGRADE: Four Missions per Expedition")
)

upgrade_item(
    "upgradekey_bonusmissions5",
    content.text("Oath of the Island's Enforcer"),
    content.text("This strange metaphysical artifact will empower the island and unlock a permanent upgrade for all future runs.  Will be used automatically upon crafting, and can only be used once.\n\nASSOCIATED UPGRADE: Five Missions per Expedition")
)

upgrade_item(
    "upgradekey_hardmissions1",
    content.text("Ordinator's Sigil"),
    content.text("This strange metaphysical artifact will empower the island and unlock a permanent upgrade for all future runs.  Will be used automatically upon crafting, and can only be used once.\n\nASSOCIATED UPGRADE: Harder Missions")
)

upgrade_item(
    "upgradekey_hardmissions2",
    content.plural_text("Will of the Island", "Will of the Island"),
    content.text("This strange metaphysical artifact will empower the island and unlock a permanent upgrade for all future runs.  Will be used automatically upon crafting, and can only be used once.\n\nASSOCIATED UPGRADE: Hardest Missions")
)

upgrade_item(
    "upgradekey_scouting1",
    content.plural_text("Scouting Lens", "Scouting Lenses"),
    content.text("This strange metaphysical artifact will empower the island and unlock a permanent upgrade for all future runs.  Will be used automatically upon crafting, and can only be used once.\n\nASSOCIATED UPGRADE: Scouting 1")
)

upgrade_item(
    "upgradekey_scouting2",
    content.text("Scouting Scope"),
    content.text("This strange metaphysical artifact will empower the island and unlock a permanent upgrade for all future runs.  Will be used automatically upon crafting, and can only be used once.\n\nASSOCIATED UPGRADE: Scouting 2")
)

upgrade_item(
    "upgradekey_scouting3",
    content.text("Vision Amplifier"),
    content.text("This strange metaphysical artifact will empower the island and unlock a permanent upgrade for all future runs.  Will be used automatically upon crafting, and can only be used once.\n\nASSOCIATED UPGRADE: Scouting 3")
)

upgrade_item(
    "upgradekey_scouting4",
    content.text("Third Eye Charm"),
    content.text("This strange metaphysical artifact will empower the island and unlock a permanent upgrade for all future runs.  Will be used automatically upon crafting, and can only be used once.\n\nASSOCIATED UPGRADE: Scouting 4")
)

upgrade_item(
    "upgradekey_scouting5",
    content.plural_text("Eye of the Island", "Eye of the Island"),
    content.text("This strange metaphysical artifact will empower the island and unlock a permanent upgrade for all future runs.  Will be used automatically upon crafting, and can only be used once.\n\nASSOCIATED UPGRADE: Scouting 5")
)

upgrade_item(
    "upgradekey_scouting6",
    content.plural_text("Warpforged Telescope", "Warpforged Telescope"),
    content.text("This strange metaphysical artifact will empower the island and unlock a permanent upgrade for all future runs.  Will be used automatically upon crafting, and can only be used once.\n\nASSOCIATED UPGRADE: Scouting 6")
)

upgrade_item(
    "upgradekey_scouting7",
    content.plural_text("Agglomerated Oculus", "Agglomerated Oculus"),
    content.text("This strange metaphysical artifact will empower the island and unlock a permanent upgrade for all future runs.  Will be used automatically upon crafting, and can only be used once.\n\nASSOCIATED UPGRADE: Scouting 7")
)

upgrade_item(
    "upgradekey_scouting8",
    content.plural_text("Other Eye of the Island", "Other Eye of the Island"),
    content.text("This strange metaphysical artifact will empower the island and unlock a permanent upgrade for all future runs.  Will be used automatically upon crafting, and can only be used once.\n\nASSOCIATED UPGRADE: Scouting 8")
)

upgrade_item(
    "upgradekey_scoutingclairvoyance1",
    content.text("Higher Viewpoint"),
    content.text("This strange metaphysical artifact will empower the island and unlock a permanent upgrade for all future runs.  Will be used automatically upon crafting, and can only be used once.\n\nASSOCIATED UPGRADE: Scouting Clairvoyance 1")
)

upgrade_item(
    "upgradekey_scoutingclairvoyance2",
    content.plural_text("All-Seeing Effigy", "All-Seeing Effigy"),
    content.text("This strange metaphysical artifact will empower the island and unlock a permanent upgrade for all future runs.  Will be used automatically upon crafting, and can only be used once.\n\nASSOCIATED UPGRADE: Scouting Clairvoyance 2")
)

upgrade_item(
    "upgradekey_stability1",
    content.text("Warped Tincture"),
    content.text("This strange metaphysical artifact will empower the island and unlock a permanent upgrade for all future runs.  Will be used automatically upon crafting, and can only be used once.\n\nASSOCIATED UPGRADE: Stability 1")
)

upgrade_item(
    "upgradekey_stability2",
    content.text("Surreal Shield"),
    content.text("This strange metaphysical artifact will empower the island and unlock a permanent upgrade for all future runs.  Will be used automatically upon crafting, and can only be used once.\n\nASSOCIATED UPGRADE: Stability 2")
)

upgrade_item(
    "upgradekey_stability3",
    content.text("Warpstream Plating"),
    content.text("This strange metaphysical artifact will empower the island and unlock a permanent upgrade for all future runs.  Will be used automatically upon crafting, and can only be used once.\n\nASSOCIATED UPGRADE: Stability 3")
)

upgrade_item(
    "upgradekey_stability4",
    content.plural_text("Fortitude of the Island", "Fortitude of the Island"),
    content.text("This strange metaphysical artifact will empower the island and unlock a permanent upgrade for all future runs.  Will be used automatically upon crafting, and can only be used once.\n\nASSOCIATED UPGRADE: Stability 4")
)

upgrade_item(
    "upgradekey_stability5",
    content.text("Explorer's Ward"),
    content.text("This strange metaphysical artifact will empower the island and unlock a permanent upgrade for all future runs.  Will be used automatically upon crafting, and can only be used once.\n\nASSOCIATED UPGRADE: Stability 5")
)

upgrade_item(
    "upgradekey_stability6",
    content.text("Island-Bound Armor"),
    content.text("This strange metaphysical artifact will empower the island and unlock a permanent upgrade for all future runs.  Will be used automatically upon crafting, and can only be used once.\n\nASSOCIATED UPGRADE: Stability 6")
)

upgrade_item(
    "upgradekey_stability7",
    content.text("Triune Anchor"),
    content.text("This strange metaphysical artifact will empower the island and unlock a permanent upgrade for all future runs.  Will be used automatically upon crafting, and can only be used once.\n\nASSOCIATED UPGRADE: Stability 7")
)

upgrade_item(
    "upgradekey_basementsunlock",
    content.text("Basement Locator"),
    content.text("This strange metaphysical artifact will empower the island and unlock a permanent upgrade for all future runs.  Will be used automatically upon crafting, and can only be used once.\n\nASSOCIATED UPGRADE: Unlock Start Location: Basements")
)

upgrade_item(
    "upgradekey_roofsunlock",
    content.text("Rooftop Locator"),
    content.text("This strange metaphysical artifact will empower the island and unlock a permanent upgrade for all future runs.  Will be used automatically upon crafting, and can only be used once.\n\nASSOCIATED UPGRADE: Unlock Start Location: Roofs")
)

upgrade_item(
    "upgradekey_labsunlock",
    content.text("Laboratory Locator"),
    content.text("This strange metaphysical artifact will empower the island and unlock a permanent upgrade for all future runs.  Will be used automatically upon crafting, and can only be used once.\n\nASSOCIATED UPGRADE: Unlock Start Location: Labs")
)

upgrade_item(
    "upgradekey_warped_harness1",
    content.plural_text("Ideal of Exercise", "Ideals of Exercise"),
    content.text("This strange metaphysical artifact will empower you and unlock a new crafting recipe.  Will be used automatically upon crafting, and can only be used once.\n\nASSOCIATED UPGRADE: Warped Hauler's Harness Mk II")
)

upgrade_item(
    "upgradekey_warped_harness2",
    content.plural_text("Testament of Hoisting", "Testaments of Hoisting"),
    content.text("This strange metaphysical artifact will empower you and unlock a new crafting recipe.  Will be used automatically upon crafting, and can only be used once.\n\nASSOCIATED UPGRADE: Warped Hauler's Harness Mk III")
)
