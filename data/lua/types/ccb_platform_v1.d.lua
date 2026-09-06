---@meta

-- LuaLS declarations for the CCB Lua-first Platform v1 bootstrap surface.
-- This is editor metadata. Do not require or copy it into runtime code.

---@class CcbPlatformResultError
---@field code string Stable fail-closed error code.
---@field message string Human-readable diagnostic.

---@class CcbResult
---@field ok boolean True only when `value` is present.
---@field value? any Detached value returned by the Platform operation.
---@field error? CcbPlatformResultError Present when the exact handle or value was rejected.

---@class GameId
---@field kind string Native typed-id kind.
---@field value string Stable string id.
---@field is_null fun(self: GameId): boolean
---@field is_valid fun(self: GameId): boolean
---@operator eq(GameId): boolean

---@class GameEnum
---@field kind string Native enum kind.
---@field name string Stable enum name.
---@field ordinal integer Native enum ordinal.
---@operator eq(GameEnum): boolean

---@class PointCoord
---@field origin string Coordinate origin tag.
---@field scale string Coordinate scale tag.
---@field type string Native coordinate type.
---@field x integer
---@field y integer
---@field xy fun(self: PointCoord): PointCoord
---@field add fun(self: PointCoord, other: PointCoord): PointCoord
---@field subtract fun(self: PointCoord, other: PointCoord): PointCoord
---@field scale_by fun(self: PointCoord, factor: integer): PointCoord
---@field compare fun(self: PointCoord, other: PointCoord): integer
---@field square_distance fun(self: PointCoord, other: PointCoord): integer
---@field manhattan_distance fun(self: PointCoord, other: PointCoord): integer
---@field euclidean_distance fun(self: PointCoord, other: PointCoord): number
---@field project_to fun(self: PointCoord, scale: string): PointCoord
---@field project_remain fun(self: PointCoord, scale: string): PointCoord
---@field project_combine fun(self: PointCoord, remainder: PointCoord): PointCoord
---@field to fun(self: PointCoord, origin: string, scale: string): PointCoord
---@operator add(PointCoord): PointCoord
---@operator sub(PointCoord): PointCoord
---@operator mul(integer): PointCoord
---@operator unm: PointCoord
---@operator eq(PointCoord): boolean

---@class TripointCoord: PointCoord
---@field z integer
---@field xy fun(self: TripointCoord): PointCoord
---@field add fun(self: TripointCoord, other: TripointCoord): TripointCoord
---@field subtract fun(self: TripointCoord, other: TripointCoord): TripointCoord
---@field scale_by fun(self: TripointCoord, factor: integer): TripointCoord
---@field project_to fun(self: TripointCoord, scale: string): TripointCoord
---@field project_remain fun(self: TripointCoord, scale: string): TripointCoord
---@field project_combine fun(self: TripointCoord, remainder: TripointCoord): TripointCoord
---@field to fun(self: TripointCoord, origin: string, scale: string): TripointCoord

---@class TimeDuration
---@field turns integer
---@field value integer
---@field display fun(self: TimeDuration): string
---@field compare fun(self: TimeDuration, other: TimeDuration): integer
---@field scale fun(self: TimeDuration, factor: number): TimeDuration
---@field divide fun(self: TimeDuration, divisor: number): TimeDuration
---@operator add(TimeDuration): TimeDuration
---@operator sub(TimeDuration): TimeDuration
---@operator mul(number): TimeDuration
---@operator div(number): TimeDuration
---@operator unm: TimeDuration
---@operator eq(TimeDuration): boolean

---@class TimePoint
---@field turn integer
---@field display fun(self: TimePoint): string
---@field compare fun(self: TimePoint, other: TimePoint): integer
---@field hour_of_day fun(self: TimePoint): integer
---@field minute_of_hour fun(self: TimePoint): integer
---@field second_of_minute fun(self: TimePoint): integer
---@field season fun(self: TimePoint): string
---@field moon_phase fun(self: TimePoint): string
---@field sunrise fun(self: TimePoint): TimePoint
---@field sunset fun(self: TimePoint): TimePoint
---@field is_dawn fun(self: TimePoint): boolean
---@field is_day fun(self: TimePoint): boolean
---@field is_dusk fun(self: TimePoint): boolean
---@field is_night fun(self: TimePoint): boolean
---@operator add(TimeDuration): TimePoint
---@operator sub(TimePoint|TimeDuration): TimeDuration|TimePoint
---@operator eq(TimePoint): boolean

---@class UnitValue
---@field kind string Native unit kind.
---@field value number
---@field canonical_unit string
---@field is_integral boolean
---@field add fun(self: UnitValue, other: UnitValue): UnitValue
---@field subtract fun(self: UnitValue, other: UnitValue): UnitValue
---@field scale fun(self: UnitValue, factor: number): UnitValue
---@field compare fun(self: UnitValue, other: UnitValue): integer
---@operator add(UnitValue): UnitValue
---@operator sub(UnitValue): UnitValue
---@operator eq(UnitValue): boolean

---@class CcbCharacterNearbyOptions
---@field offset? integer
---@field limit? integer
---@field radius? integer

---@class CcbVehicleDefinitionQueryOptions
---@field offset? integer
---@field limit? integer
---@field query? string

---@class CcbVehiclePartPageOptions
---@field offset? integer
---@field limit? integer

---@class CcbVehicleStopOptions
---@field disable_cruise? boolean

---@class CcbVehicleValueOptions
---@field post_cataclysm? boolean

---@class CcbMissionQueryOptions
---@field offset? integer
---@field limit? integer
---@field status? string

---@class CcbFactionQueryOptions
---@field offset? integer
---@field limit? integer
---@field query? string

---@class CcbFactionPolicyOptions
---@field consumes_food? boolean
---@field stealing? boolean

---@class CcbFactionRelationshipOptions
---@field kill_on_sight? boolean
---@field watch_your_back? boolean
---@field share_my_stuff? boolean
---@field guard_your_stuff? boolean
---@field lets_you_in? boolean

---@class CcbInventoryChoiceOptions
---@field title? string
---@field allow_cancel? boolean

---@class CcbInventoryGiveOptions
---@field birthday? TimePoint
---@field charges? integer

---@class CcbNpcQueryOptions
---@field offset? integer
---@field limit? integer
---@field query? string

---@class CcbCreatureNearbyOptions
---@field offset? integer
---@field limit? integer
---@field radius? integer

---@class GameHandle
---@field kind 'creature'|'item'|'vehicle'|'vehicle_part'|'camp'|'none' Broad native storage kind.
---@field subtype 'avatar'|'character'|'npc'|'monster'|'creature'|'item'|'vehicle'|'vehicle_part'|'camp' Diagnostic subtype hint; exact domain APIs validate the live subtype again.
---@field locator table<string, any> Bounded locator copied from native identity data.
---@field identity_generation integer Native identity generation; changes when the referenced object is replaced, relocated, unloaded, or retired.
---@field is_valid fun(self: GameHandle): boolean False after owner/runtime/world/entity invalidation.
---@field status fun(self: GameHandle): CcbResult Typed status with a fail-closed error when stale, dead, or destroyed.

---@class MapTileToken
---@field position TripointCoord Explicit absolute map-square position captured by this token.
---@field runtime_generation integer Lua Platform runtime generation bound at issuance.
---@field world_generation integer World generation bound at issuance.
---@field owner_generation integer Active map-token owner generation; changes on runtime/world/map reset.
---@field is_valid fun(self: MapTileToken): boolean False when the owner/runtime/world, z-level, bounds, or loaded bubble no longer match.

---@class OvermapTileToken
---@field position TripointCoord Explicit absolute overmap-terrain (`abs_omt`) position captured by this token.
---@field runtime_generation integer Lua Platform runtime generation bound at issuance.
---@field world_generation integer World generation bound at issuance.
---@field owner_generation integer Active overmap-token owner generation; changes when overmap token ownership is reset.
---@field is_valid fun(self: OvermapTileToken): boolean False after the owner/runtime/world or absolute OMT identity is invalidated.
---@field __tostring fun(self: OvermapTileToken): string Stable `OvermapTileToken<position:runtime:world:owner>` identity string.
---@operator eq(OvermapTileToken): boolean Equality compares the absolute OMT position and runtime/world/owner identity generations.

---@class CcbMapTileSnapshot
---@field position TripointCoord Explicit absolute map-square position.
---@field terrain GameId GameId<terrain> at the tile.
---@field terrain_name string Detached terrain name.
---@field furniture? GameId GameId<furniture>, absent when the tile has no furniture.
---@field furniture_name? string Detached furniture name.
---@field trap? GameId GameId<trap>, absent when the tile has no trap.
---@field trap_name? string Detached trap name.
---@field trap_benign? boolean Whether the detached trap is benign.
---@field fields table<string, any> Bounded detached field page.
---@field signage string Bounded detached signage text.
---@field signage_truncated boolean True when signage exceeded the requested bound.
---@field vehicle_part table<string, any> Detached vehicle-part snapshot; `present` is false when absent.
---@field item_count integer Number of items currently on the tile.
---@field revision integer Platform map mutation revision for compare-and-swap edits.

---@class CcbMapTileFieldChange
---@field id GameId GameId<field>.
---@field intensity? integer Bounded native field intensity.
---@field age? TimeDuration Bounded field age.
---@field hit_player? boolean Unsupported by services.map.edit; retained only for explicit rejection diagnostics.
---@field remove? boolean Remove this field instead of adding/updating it.

---@class CcbMapTileChanges
---@field terrain? GameId GameId<terrain> replacement.
---@field furniture? GameId|table<string, boolean|GameId> Replacement or `{ clear = true }`.
---@field furniture_clear? boolean Clear furniture when true.
---@field trap? GameId|table<string, boolean|GameId> Replacement or `{ clear = true }`.
---@field trap_clear? boolean Clear trap when true.
---@field field? CcbMapTileFieldChange|CcbMapTileFieldChange[] One field change or a dense array.
---@field fields? CcbMapTileFieldChange|CcbMapTileFieldChange[] Dense field changes.
---@field remove_field? GameId|GameId[] One field id or a dense array of field ids.

---@class CcbMapSnapshotOptions
---@field field_limit? integer Maximum detached fields returned, from 0 through 128.
---@field signage_limit? integer Maximum signage bytes returned, from 0 through 4096.

---@class CcbMapApi
local CcbMapApi = {}

---@param position TripointCoord Explicit absolute map-square coordinate; local/OMT/raw tables are rejected.
---@return CcbResult result `value` is a generation-bound MapTileToken.
function CcbMapApi.tile(position) end

---@param tile MapTileToken Exact token for a currently loaded map tile.
---@param options? CcbMapSnapshotOptions Bounded detached snapshot limits.
---@return CcbResult result `value` is a CcbMapTileSnapshot.
function CcbMapApi.snapshot(tile, options) end

---@param tile MapTileToken Exact token for a currently loaded map tile.
---@param expected_revision integer Platform map revision captured by a prior snapshot.
---@param changes CcbMapTileChanges Bounded tile-state changes; emit/event state is not accepted.
---@return CcbResult result `value` is the committed CcbMapTileSnapshot.
function CcbMapApi.edit(tile, expected_revision, changes) end

---@class CcbOvermapTileSnapshot
---@field position TripointCoord Explicit absolute overmap-terrain (`abs_omt`) position.
---@field exists boolean Whether the overmap tile currently exists in the loaded buffer.
---@field epoch integer Current overmap mutation epoch.
---@field revision integer Compare-and-swap revision for this overmap tile.
---@field terrain? GameId GameId<overmap_terrain> at the tile; present when exists is true.
---@field terrain_type? string Native overmap-terrain type id; present when exists is true.
---@field name? string Full native terrain name; present when exists is true.
---@field visible_name? string Terrain name at the tile's current vision level; present when exists is true.
---@field mapgen_id? string Native mapgen id; present when exists is true.
---@field rotation? integer Native terrain rotation; present when exists is true.
---@field linear? boolean Whether the terrain is linear; present when exists is true.
---@field rotatable? boolean Whether the terrain is rotatable; present when exists is true.
---@field vision? GameEnum GameEnum<OmVisionLevel>; present when exists is true.
---@field seen? boolean Whether the tile has been seen; present when exists is true.
---@field explored? boolean Whether the tile has been explored; present when exists is true.
---@field note? string Bounded note text, or nil when no note exists.
---@field note_truncated? boolean Whether the returned note exceeded the native bound.
---@field note_dangerous? boolean Whether the tile note is marked dangerous.
---@field note_danger_radius? integer Native note-danger radius, or -1 when not dangerous.
---@field generated? boolean Whether the OMT has been map-generated; present when exists is true.
---@field has_extra? boolean Whether the tile has an overmap extra; present when exists is true.
---@field extra? string Overmap extra id, or nil when no extra exists.
---@field has_camp? boolean Whether a camp exists at this position; present when exists is true.
---@field has_vehicle? boolean Whether a vehicle exists at this position; present when exists is true.

---@class CcbOvermapNoteValueChange
---@field value string Note value; this shape is mutually exclusive with `clear`.

---@class CcbOvermapNoteClearChange
---@field clear true Clear the note; `clear` must be exactly true and is mutually exclusive with `value`.

---@alias CcbOvermapNoteChange CcbOvermapNoteValueChange|CcbOvermapNoteClearChange

---@class CcbOvermapNoteDangerChange
---@field dangerous boolean Whether the note is dangerous.
---@field radius integer Note-danger radius in the native 0..100 range.

---@class CcbOvermapTileChanges
---@field set_terrain? GameId GameId<overmap_terrain> replacement.
---@field set_seen? GameEnum GameEnum<OmVisionLevel> replacement.
---@field set_explored? boolean Replacement explored state.
---@field set_note? CcbOvermapNoteChange Exactly `{ value = string }` or `{ clear = true }`.
---@field set_note_danger? CcbOvermapNoteDangerChange Exactly `{ dangerous = boolean, radius = integer }`.

---@class CcbOvermapEditResult
---@field accepted boolean True when the edit was accepted.
---@field changed boolean Whether the edit changed native overmap state.
---@field position TripointCoord Explicit absolute overmap-terrain (`abs_omt`) position.
---@field epoch integer Current overmap mutation epoch after the edit.
---@field previous_revision integer Tile revision before the edit.
---@field revision integer Tile revision after the edit.
---@field snapshot CcbOvermapTileSnapshot Committed detached tile snapshot.

---@class CcbOvermapApi
local CcbOvermapApi = {}

---@param position TripointCoord Explicit absolute overmap-terrain (`abs_omt`) coordinate; local/map-square/raw tables are rejected.
---@return CcbResult result `value` is a generation-bound OvermapTileToken.
function CcbOvermapApi.tile_token(position) end

---@param token OvermapTileToken Exact token for the requested overmap tile.
---@return CcbResult result `value` is a CcbOvermapTileSnapshot.
function CcbOvermapApi.snapshot(token) end

---@param token OvermapTileToken Exact token for the requested overmap tile.
---@param expected_revision integer Tile revision captured by a prior snapshot.
---@param changes CcbOvermapTileChanges Bounded overmap-tile changes.
---@return CcbResult result `value` is a CcbOvermapEditResult.
function CcbOvermapApi.edit(token, expected_revision, changes) end

---@class CcbHandlesApi
local CcbHandlesApi = {}

---@return GameHandle
function CcbHandlesApi.avatar() end

---@class ModDefinitionOptions
---@field id? string Stable 1-256-byte Mod id without `#`; defaults to the root directory name when omitted.
---@field name? string 1-512-byte display name; defaults to the resolved Mod id.
---@field version? string 1-128-byte author-defined Mod version.
---@field entry? string Root-relative entry path of at most 4096 bytes; defaults to main.lua.
---@field dependencies? string[] Dense one-based array of at most 256 unique stable Mod ids loaded before this Mod.
---@field authors? string[] Dense one-based array of unique author names.
---@field description? string Player-facing Mod description of at most 4096 bytes.
---@field category? string Existing Mod-list category id.
---@field core? boolean Whether this is a core Mod.

---@class ModDefinition
---@field id string
---@field name string
---@field version string
---@field entry string
---@field dependencies string[]
---@field authors string[]
---@field description string
---@field category string
---@field core boolean
local ModDefinition = {}

---@class CcbPlatformBubbleMapSquarePayload
---@field coordinate_space 'bub_ms' Literal native space tag.
---@field x integer Bubble map-square x coordinate.
---@field y integer Bubble map-square y coordinate.
---@field z integer Bubble map-square z coordinate.

---@class CcbPlatformAbsoluteMapSquarePayload
---@field coordinate_space 'abs_ms' Literal native space tag.
---@field x integer Absolute map-square x coordinate.
---@field y integer Absolute map-square y coordinate.
---@field z integer Absolute map-square z coordinate.

---@class ItemDefinitionOptions
---@field id string Stable item type id.
---@field copy_from? string Existing item id used as the patch base.
---@field name? string Display name; defaults to id.
---@field description? string Player-facing description.
---@field symbol? string Map symbol; defaults to `?`.
---@field color? string Native color id.
---@field category? string Native item-category id.
---@field looks_like? string Existing item id used for presentation.
---@field mass_grams? integer Non-negative mass in grams.
---@field volume_ml? integer Non-negative volume in milliliters.
---@field price_cents? integer Non-negative pre-Cataclysm price in cents.
---@field price_postapoc_cents? integer Non-negative post-Cataclysm price in cents.
---@field magazine_capacity? integer Positive legacy magazine capacity, independent of per-ammo pocket restrictions.

---@class ItemDefinition
---@field id string
local ItemDefinition = {}

---@param grams integer
---@return ItemDefinition self
function ItemDefinition:mass_grams(grams) end

---@param milliliters integer
---@return ItemDefinition self
function ItemDefinition:volume_ml(milliliters) end

---@param cents integer
---@return ItemDefinition self
function ItemDefinition:price_cents(cents) end

---@param cents integer
---@return ItemDefinition self
function ItemDefinition:price_postapoc_cents(cents) end

---@param damage_type string
---@param amount number
---@return ItemDefinition self
function ItemDefinition:melee_damage(damage_type, amount) end

---@param ammo_type string
---@param capacity integer
---@return ItemDefinition self
function ItemDefinition:magazine_ammo(ammo_type, capacity) end

---@param capacity integer Positive legacy magazine capacity, independent of per-ammo pocket restrictions.
---@return ItemDefinition self
function ItemDefinition:magazine_capacity(capacity) end

---@param id string
---@param portions integer
---@return ItemDefinition self
function ItemDefinition:material(id, portions) end

---@param id string
---@param level integer
---@return ItemDefinition self
function ItemDefinition:quality(id, level) end

---@param id string
---@return ItemDefinition self
function ItemDefinition:flag(id) end

---@class ComestibleDefinitionOptions
---@field type "FOOD"|"DRINK"
---@field calories integer Fixed kilocalories per serving.
---@field fun integer Base enjoyment.
---@field healthy? integer Health modifier; defaults to zero.
---@field quench? integer Thirst modifier; defaults to zero.
---@field spoils_in_turns? integer Non-negative shelf life; zero never spoils.
---@field charges? integer Positive default serving count; defaults to one.
---@field stack_size? integer Positive servings represented by the volume; defaults to charges.

---@param options ComestibleDefinitionOptions
---@return ItemDefinition self
function ItemDefinition:comestible(options) end

---@param vitamin_id string Existing or same-transaction vitamin id.
---@param amount integer Vitamin units per serving.
---@return ItemDefinition self
function ItemDefinition:vitamin(vitamin_id, amount) end

---@class BookDefinitionOptions
---@field skill string Existing or same-transaction skill id.
---@field required_level integer Minimum skill needed to understand the book.
---@field maximum_level integer Maximum skill level trained by the book.
---@field intelligence integer Minimum intelligence needed to read it.
---@field read_time_turns integer Positive time per chapter.
---@field fun integer Reading enjoyment.

---@param options BookDefinitionOptions
---@return ItemDefinition self
function ItemDefinition:book(options) end

---@param handler_id string
---@param label? string
---@return ItemDefinition self
function ItemDefinition:on_use(handler_id, label) end

---@param handler_id string
---@param label? string
---@return ItemDefinition self
function ItemDefinition:on_consume(handler_id, label) end

---@class RecipeDefinitionOptions
---@field id string Stable recipe id.
---@field result string Stable result item id.
---@field category? string Native crafting category id.
---@field subcategory? string Native crafting subcategory id.
---@field skill? string Primary skill id.
---@field difficulty? integer Difficulty from zero through the native maximum skill level.
---@field duration_moves? integer Positive base duration in moves.
---@field autolearn? boolean Whether the recipe is automatically learnable.
---@field reversible? boolean Whether the recipe supplies disassembly data.
---@field practice? boolean Whether this is a practice recipe; native practice
---progression data stays author-owned Lua behaviour.
---@field uncraft? boolean Whether this is a disassembly recipe staged into the
---native uncraft dictionary.
---@field activity_level? number Positive native exertion multiplier.

---@class RecipeComponentAlternative
---@field id string Item type id.
---@field count? integer Positive count; defaults to one.
---@field requirement? boolean Treat `id` as a native Requirement id (`LIST` semantics).

---@class RecipeDefinition
---@field id string
local RecipeDefinition = {}

---@param moves integer
---@return RecipeDefinition self
function RecipeDefinition:duration_moves(moves) end

---@param charges integer Positive number of result charges/servings.
---@return RecipeDefinition self
function RecipeDefinition:result_charges(charges) end

---@param id string
---@param count integer
---@param requirement? boolean Treat `id` as a native Requirement id.
---@return RecipeDefinition self
function RecipeDefinition:component(id, count, requirement) end

---@param choices RecipeComponentAlternative[] Dense one-based array with at most 128 entries.
---@return RecipeDefinition self
function RecipeDefinition:component_any(choices) end

---@param id string
---@param count integer Positive number of tool instances; tools are not consumed.
---@param requirement? boolean Treat `id` as a native Requirement id.
---@return RecipeDefinition self
function RecipeDefinition:tool(id, count, requirement) end

---@param id string
---@param charges integer Positive charges consumed by crafting.
---@param requirement? boolean Treat `id` as a native Requirement id.
---@return RecipeDefinition self
function RecipeDefinition:tool_charges(id, charges, requirement) end

---@class RecipeToolAlternative
---@field id string Item type id.
---@field count? integer Positive non-consuming instance count; defaults to one.
---@field charges? integer Positive charge count consumed instead of `count`.
---@field requirement? boolean Treat `id` as a native Requirement id (`LIST` semantics).

---@param choices RecipeToolAlternative[] Dense one-based array with at most 128 entries.
---@return RecipeDefinition self
function RecipeDefinition:tool_any(choices) end

---@param id string
---@param level integer
---@return RecipeDefinition self
function RecipeDefinition:requires_skill(id, level) end

---@param requirement_id string Native Requirement id.
---@param multiplier integer Positive multiplier.
---@return RecipeDefinition self
function RecipeDefinition:requirement(requirement_id, multiplier) end

---@class RecipeProficiencyOptions
---@field required? boolean Whether crafting is forbidden without this proficiency.
---@field time_multiplier? number Native time multiplier when missing.
---@field skill_penalty? number Native skill penalty when missing.

---@param proficiency_id string Existing proficiency id.
---@param options? RecipeProficiencyOptions
---@return RecipeDefinition self
function RecipeDefinition:proficiency(proficiency_id, options) end

---@param item_id string Existing book item id.
---@param skill_level integer Required primary skill level.
---@return RecipeDefinition self
function RecipeDefinition:book(item_id, skill_level) end

---@param handler_id string
---@return RecipeDefinition self
function RecipeDefinition:on_complete(handler_id) end

---@class NestedRecipeCategoryDefinitionOptions
---@field id string Stable nested-category recipe id.
---@field name string Player-facing nested category name.
---@field description? string Player-facing category description.
---@field category string Native crafting category id.
---@field subcategory string Native crafting subcategory id.
---@field activity_level? number Positive exertion multiplier; defaults to no exercise.

---@class NestedRecipeCategoryDefinition
---@field id string
local NestedRecipeCategoryDefinition = {}

---@param recipe_id string Native, same-transaction recipe, or nested-category id.
---@return NestedRecipeCategoryDefinition self
function NestedRecipeCategoryDefinition:recipe(recipe_id) end

---@class RequirementDefinitionOptions
---@field id string Stable reusable requirement id.
---@field name? string Optional player-facing name.

---@class RequirementAlternative
---@field id string Item type id.
---@field count? integer Positive count; defaults to one.
---@field requirement? boolean Treat `id` as another native Requirement id (`LIST` semantics).

---@class RequirementQualityAlternative
---@field id string ToolQuality id.
---@field level? integer Positive quality level; defaults to one.
---@field count? integer Positive tool count; defaults to one.

---@class RequirementDefinition
---@field id string
local RequirementDefinition = {}

---@param item_id string
---@param count integer
---@param requirement? boolean Treat `item_id` as another native Requirement id.
---@return RequirementDefinition self
function RequirementDefinition:component(item_id, count, requirement) end

---@param choices RequirementAlternative[] Dense one-based array with at most 128 entries.
---@return RequirementDefinition self
function RequirementDefinition:component_any(choices) end

---@param item_id string
---@param count integer Positive non-consuming instance count.
---@param requirement? boolean Treat `item_id` as another native Requirement id.
---@return RequirementDefinition self
function RequirementDefinition:tool(item_id, count, requirement) end

---@param item_id string
---@param charges integer Positive charge count consumed.
---@param requirement? boolean Treat `item_id` as another native Requirement id.
---@return RequirementDefinition self
function RequirementDefinition:tool_charges(item_id, charges, requirement) end

---@param choices RecipeToolAlternative[] Dense one-based array with at most 128 entries.
---@return RequirementDefinition self
function RequirementDefinition:tool_any(choices) end

---@param quality_id string
---@param level integer
---@param count integer
---@return RequirementDefinition self
function RequirementDefinition:quality(quality_id, level, count) end

---@param choices RequirementQualityAlternative[] Dense one-based array with at most 128 entries.
---@return RequirementDefinition self
function RequirementDefinition:quality_any(choices) end

---@class RecipeGroupDefinitionOptions
---@field id string Stable recipe-group id.
---@field building_type? string Native camp/building group; defaults to `NONE`.

---@class RecipeGroupDefinition
---@field id string
local RecipeGroupDefinition = {}

---@param recipe_id string
---@param description string Player-facing action description.
---@return RecipeGroupDefinition self
function RecipeGroupDefinition:recipe(recipe_id, description) end

---@param recipe_id string Recipe entry added earlier to this group.
---@param overmap_terrain string Overmap terrain matcher or `ANY`.
---@param match_type 'EXACT'|'TYPE'|'SUBTYPE'|'PREFIX'|'CONTAINS'
---@return RecipeGroupDefinition self
function RecipeGroupDefinition:terrain(recipe_id, overmap_terrain, match_type) end

---@param recipe_id string Recipe whose most recently added terrain receives the parameter.
---@param parameter string Mapgen parameter name.
---@param values string[] Dense accepted-value list.
---@return RecipeGroupDefinition self
function RecipeGroupDefinition:terrain_parameter(recipe_id, parameter, values) end

---@class ScentTypeDefinitionOptions
---@field id string Stable scent-type id.

---@class ScentTypeDefinition
---@field id string
local ScentTypeDefinition = {}

---@param species_id string Native monster-species id that can perceive this scent.
---@return ScentTypeDefinition self
function ScentTypeDefinition:receptive_species(species_id) end

---@class ButcheryRequirementDefinitionOptions
---@field id string Stable butchery-requirement id.

---@class ButcheryRequirementDefinition
---@field id string
local ButcheryRequirementDefinition = {}

---@param speed number Finite non-negative speed bonus for this row.
---@param size string Creature-size name: TINY, SMALL, MEDIUM, LARGE, or HUGE.
---@param butcher string Butcher-type name: BLEED, QUICK, FULL, FIELD_DRESS, SKIN, QUARTER, DISMEMBER, or DISSECT.
---@param requirement_id string Native requirement id the row resolves to.
---@return ButcheryRequirementDefinition self
function ButcheryRequirementDefinition:requirement(speed, size, butcher, requirement_id) end

---@class ItemActionDefinitionOptions
---@field id string Stable item-action id.
---@field name? string Display name; defaults to the id.

---@class ItemActionDefinition
---@field id string
local ItemActionDefinition = {}

---@class ScenarioDefinitionOptions
---Calendar defaults match native JSON scenarios without explicit dates, using SEASON_LENGTH.
---Game start is at 08:00; the cataclysm begins five calendar days earlier at 00:00.
---@field id string Stable scenario id.
---@field name string Scenario display name.
---@field description string Scenario description.
---@field start_name string Start-location display name.
---@field points? integer Character-creation point cost; defaults to 0.
---@field blacklist? boolean Professions are a blacklist instead of a whitelist.
---@field extra_professions? boolean Professions add to the default set.
---@field reveal_locale? boolean Whether the start locale is revealed; defaults to true.
---@field hard_requirement? boolean Whether the unlock requirement applies with metaprogression disabled.
---@field distance_initial_visibility? integer Initial overmap visibility distance.
---@field map_extra? string Native map-extra id applied at game start; omission means none.

---@class ScenarioDefinition
---@field id string
local ScenarioDefinition = {}

---@param location_id string Native start-location id.
---@return ScenarioDefinition self
function ScenarioDefinition:location(location_id) end

---@param profession_id string Native profession id.
---@return ScenarioDefinition self
function ScenarioDefinition:profession(profession_id) end

---@param trait_id string Native trait id allowed for this scenario.
---@return ScenarioDefinition self
function ScenarioDefinition:allowed_trait(trait_id) end

---@param trait_id string Native trait id forced by this scenario.
---@return ScenarioDefinition self
function ScenarioDefinition:forced_trait(trait_id) end

---@param trait_id string Native trait id forbidden by this scenario.
---@return ScenarioDefinition self
function ScenarioDefinition:forbidden_trait(trait_id) end

---@param name string Scenario flag name.
---@return ScenarioDefinition self
function ScenarioDefinition:flag(name) end

---@param achievement_id string Native achievement id required to unlock the scenario.
---@return ScenarioDefinition self
function ScenarioDefinition:requirement(achievement_id) end

---@param handler_id string
---@return ScenarioDefinition self
function ScenarioDefinition:on_start(handler_id) end

---@class VehicleColorPaletteDefinitionOptions
---@field id string Stable vehicle color palette id.

---@class VehicleColorPaletteDefinition
---@field id string
local VehicleColorPaletteDefinition = {}

---@param fuzzy_ids string[] Dense array of fuzzy part-id prefixes mapped to this color group.
---@param colors table[] Dense array of { color_name, positive_weight } pairs for this group.
---@return VehicleColorPaletteDefinition self
function VehicleColorPaletteDefinition:group(fuzzy_ids, colors) end

---@class MonsterGroupDefinitionOptions
---@field id string Stable monster-group id.
---@field default_monster? string Native monster id used when no entry rolls.
---@field is_animal? boolean Marks the group as animal-only for missions.

---@class MonsterGroupDefinition
---@field id string
local MonsterGroupDefinition = {}

---@param monster_id string Native monster id for this entry.
---@param weight integer Positive spawn weight.
---@param cost_multiplier integer Non-negative spawn cost multiplier.
---@param pack_minimum integer Minimum pack size (1..pack_maximum).
---@param pack_maximum integer Maximum pack size.
---@return MonsterGroupDefinition self
function MonsterGroupDefinition:monster(monster_id, weight, cost_multiplier, pack_minimum, pack_maximum) end

---@param group_id string Native monster-group id referenced by this entry.
---@param weight integer Positive spawn weight.
---@param cost_multiplier integer Non-negative spawn cost multiplier.
---@param pack_minimum integer Minimum pack size (1..pack_maximum).
---@param pack_maximum integer Maximum pack size.
---@return MonsterGroupDefinition self
function MonsterGroupDefinition:group(group_id, weight, cost_multiplier, pack_minimum, pack_maximum) end

---@class OvermapConnectionDefinitionOptions
---@field id string Stable overmap-connection id.

---@class OvermapConnectionDefinition
---@field id string
local OvermapConnectionDefinition = {}

---@param terrain string Native oter-type terrain id for this subtype.
---@param basic_cost integer Non-negative base pathing cost.
---@param locations string[] Dense array of overmap-location ids allowed for this subtype.
---@param orthogonal boolean Whether the subtype only connects orthogonally.
---@param perpendicular_crossing boolean Whether the subtype supports perpendicular crossings.
---@return OvermapConnectionDefinition self
function OvermapConnectionDefinition:subtype(terrain, basic_cost, locations, orthogonal, perpendicular_crossing) end

---@class SpeedDescriptionDefinitionOptions
---@field id string Stable speed-description id.

---@class SpeedDescriptionDefinition
---@field id string
local SpeedDescriptionDefinition = {}

---@param threshold number Finite non-negative relative-speed threshold.
---@param descriptions string[] Dense non-empty list of alternative player-facing descriptions.
---@return SpeedDescriptionDefinition self
function SpeedDescriptionDefinition:value(threshold, descriptions) end

---@class HarvestDropTypeDefinitionOptions
---@field id string Stable harvest-drop type id.
---@field field_dress_success? string Snippet category for successful field dressing.
---@field field_dress_failure? string Snippet category for failed field dressing.
---@field butcher_success? string Snippet category for successful butchery.
---@field butcher_failure? string Snippet category for failed butchery.
---@field dissect_success? string Snippet category for successful dissection.
---@field dissect_failure? string Snippet category for failed dissection.
---@field item_group? boolean Whether the harvested drop is an item-group id.
---@field dissect_only? boolean Whether the drop is available only through dissection.

---@class HarvestDropTypeDefinition
---@field id string
local HarvestDropTypeDefinition = {}

---@param skill_id string Native skill used by harvest rolls; the implicit default is `survival` when none are added.
---@return HarvestDropTypeDefinition self
function HarvestDropTypeDefinition:skill(skill_id) end

---@class HarvestDefinitionOptions
---@field id string Stable harvest-list id referenced by monsters or other native content.
---@field message? string Player-facing message used when this harvest is available.
---@field leftovers? string Native item id left after butchery; defaults to `ruined_chunks`.
---@field butchery_requirements? string Native butchery-requirements id; defaults to `default`.

---@class HarvestDropOptions
---@field output string Unique native item id, or native item-group id when `category` names an item-group harvest-drop type.
---@field category? string Harvest-drop type id; omission means a normal item drop.
---@field base_minimum? number Finite base minimum quantity; defaults to 1.
---@field base_maximum? number Finite base maximum quantity no lower than the minimum.
---@field skill_minimum? number Finite minimum quantity gained per harvest-skill level; defaults to 0.
---@field skill_maximum? number Finite maximum quantity gained per harvest-skill level no lower than the minimum.
---@field maximum? integer Positive native maximum quantity; defaults to 1000.
---@field mass_ratio? number Finite share of corpse mass from 0 through 1; defaults to 0.

---@class HarvestDefinition
---@field id string
local HarvestDefinition = {}

---@param options HarvestDropOptions
---@return HarvestDefinition self
function HarvestDefinition:drop(options) end

---@param output string Output id staged earlier on this harvest definition.
---@param flag_id string Existing or same-transaction native item flag id.
---@return HarvestDefinition self
function HarvestDefinition:item_flag(output, flag_id) end

---@param output string Output id staged earlier on this harvest definition.
---@param fault_id string Existing native item-fault id.
---@return HarvestDefinition self
function HarvestDefinition:item_fault(output, fault_id) end

---@class BehaviorDefinitionOptions
---@field id string Stable native behavior-node id.
---@field strategy? string Native traversal strategy for a branch node, such as `sequential`, `fallback`, or `utility`.
---@field goal? string Goal selected by a leaf node; a definition must provide either this field or one or more child() calls, never both.

---@class BehaviorPolicyPayload
---@field behavior_id string Behavior node currently being evaluated.
---@field argument string Author-supplied policy argument.
---@field subject_kind 'avatar'|'npc'|'monster'|'creature'|'none'
---@field subject GameHandle|nil Generation-safe handle for the native AI subject.

---@class BehaviorDefinition
---@field id string
local BehaviorDefinition = {}

---@param behavior_id string Existing or same-transaction child behavior id.
---@return BehaviorDefinition self
function BehaviorDefinition:child(behavior_id) end

---@param handler_id string Named callback receiving BehaviorPolicyPayload and returning one boolean.
---@param argument? string Bounded opaque argument passed to the callback.
---@param inverted? boolean Invert the callback result before traversal.
---@return BehaviorDefinition self
function BehaviorDefinition:when(handler_id, argument, inverted) end

---@param predicate_id string Registered native behavior predicate.
---@param argument? string Bounded native predicate argument.
---@param inverted? boolean Invert the predicate result before traversal.
---@return BehaviorDefinition self
function BehaviorDefinition:when_native(predicate_id, argument, inverted) end

---@param handler_id string Named callback receiving BehaviorPolicyPayload and returning one finite native-range number.
---@param argument? string Bounded opaque argument passed to the callback.
---@return BehaviorDefinition self
function BehaviorDefinition:score(handler_id, argument) end

---@param predicate_id string Registered native behavior score predicate.
---@param argument? string Bounded native predicate argument.
---@return BehaviorDefinition self
function BehaviorDefinition:score_native(predicate_id, argument) end

---@class MonsterAttackDefinitionOptions
---@field id string Stable native monster-attack id.
---@field cooldown? number Finite non-negative default cooldown; defaults to one turn.
---@field policy? string Named Lua handler returning one boolean.

---@class MonsterAttackPolicyPayload
---@field attack_id string Native attack id being invoked.
---@field attacker GameHandle Generation-safe attacking monster handle.
---@field target GameHandle|nil Generation-safe current target when one exists.

---@class MonsterAttackDefinition
---@field id string
local MonsterAttackDefinition = {}

---@param handler_id string Named handler receiving MonsterAttackPolicyPayload and returning one boolean.
---@return MonsterAttackDefinition self
function MonsterAttackDefinition:policy(handler_id) end

---@class EffectTypeDefinitionOptions
---@field id string Stable native effect-type id.
---@field name? string First intensity name; additional intensities use name().
---@field description? string First intensity description; additional intensities use description().
---@field remove_message? string Player-facing removal message.
---@field apply_memorial_log? string Memorial text recorded when applied.
---@field remove_memorial_log? string Memorial text recorded when removed.
---@field blood_analysis_description? string Player-facing blood-analysis description.
---@field maximum_intensity? integer Positive native maximum intensity; defaults to one.
---@field maximum_duration_turns? integer Non-negative maximum duration.
---@field intensity_duration_turns? integer Non-negative duration represented by one intensity.
---@field duration_add_percent? integer Duration stacking percentage; defaults to 100.
---@field intensity_add_value? integer Intensity added when stacking.
---@field intensity_decay_step? integer Decay step, where -1 is the native default.
---@field intensity_decay_tick? integer Non-negative turns per intensity-decay tick.
---@field intensity_decay_removes? boolean Whether decay removes the effect.
---@field main_parts_only? boolean Whether body-part application targets only main parts.
---@field show_in_info? boolean Whether the effect appears in item/character information.
---@field show_intensity? boolean Whether UI displays intensity; defaults to true.
---@field part_descriptions? boolean Whether descriptions vary by body part.

---@class EffectTypeDefinition
---@field id string
local EffectTypeDefinition = {}

---@param text string
---@return EffectTypeDefinition self
function EffectTypeDefinition:name(text) end
---@param text string
---@return EffectTypeDefinition self
function EffectTypeDefinition:description(text) end
---@param text string
---@return EffectTypeDefinition self
function EffectTypeDefinition:reduced_description(text) end
---@param id string
---@return EffectTypeDefinition self
function EffectTypeDefinition:flag(id) end
---@param id string
---@return EffectTypeDefinition self
function EffectTypeDefinition:immune_character_flag(id) end
---@param id string
---@return EffectTypeDefinition self
function EffectTypeDefinition:immune_bodypart_flag(id) end
---@param id string
---@return EffectTypeDefinition self
function EffectTypeDefinition:resist_trait(id) end
---@param id string Existing or same-transaction EffectType id.
---@return EffectTypeDefinition self
function EffectTypeDefinition:resist_effect(id) end
---@param id string Existing or same-transaction EffectType id.
---@return EffectTypeDefinition self
function EffectTypeDefinition:removes_effect(id) end
---@param id string Existing or same-transaction EffectType id.
---@return EffectTypeDefinition self
function EffectTypeDefinition:blocks_effect(id) end

---@param id string Existing or same-transaction Enchantment id.
---@return EffectTypeDefinition self
function EffectTypeDefinition:enchantment(id) end

---@class WeakpointDefinitionOptions
---@field id string Unique weakpoint id within its set.
---@field name? string Player-facing weakpoint name.
---@field coverage? number Finite non-negative selection weight; defaults to 100.
---@field good? boolean Whether hitting the point is beneficial to the attacker.
---@field head? boolean Whether this is a head weakpoint.

---@class WeakpointEffectOptions
---@field effect string Existing or same-transaction EffectType id.
---@field chance? number Chance from zero through 100.
---@field permanent? boolean Whether the applied effect is permanent.
---@field duration_min_turns? integer Non-negative minimum duration.
---@field duration_max_turns? integer Maximum duration no lower than the minimum.
---@field intensity_min? integer Positive minimum intensity.
---@field intensity_max? integer Maximum intensity no lower than the minimum.
---@field damage_required_min? number Minimum damage percentage from zero through 100.
---@field damage_required_max? number Maximum damage percentage no lower than the minimum.
---@field message? string Player-facing application message.

---@class WeakpointSetDefinitionOptions
---@field id string Stable native weakpoint-set id.

---@class WeakpointSetDefinition
---@field id string
local WeakpointSetDefinition = {}

---@param options WeakpointDefinitionOptions
---@return WeakpointSetDefinition self
function WeakpointSetDefinition:weakpoint(options) end
---@param weakpoint_id string
---@param damage_type string
---@param value number
---@return WeakpointSetDefinition self
function WeakpointSetDefinition:armor_multiplier(weakpoint_id, damage_type, value) end
---@param weakpoint_id string
---@param damage_type string
---@param value number
---@return WeakpointSetDefinition self
function WeakpointSetDefinition:armor_penalty(weakpoint_id, damage_type, value) end
---@param weakpoint_id string
---@param damage_type string
---@param value number
---@return WeakpointSetDefinition self
function WeakpointSetDefinition:damage_multiplier(weakpoint_id, damage_type, value) end
---@param weakpoint_id string
---@param damage_type string
---@param value number
---@return WeakpointSetDefinition self
function WeakpointSetDefinition:critical_multiplier(weakpoint_id, damage_type, value) end
---@param weakpoint_id string
---@param options WeakpointEffectOptions
---@return WeakpointSetDefinition self
function WeakpointSetDefinition:effect(weakpoint_id, options) end

---@class FieldIntensityOptions
---@field name string Player-facing intensity name.
---@field symbol? string Exactly one display-cell glyph.
---@field color? string Native color name.
---@field dangerous? boolean
---@field transparent? boolean
---@field move_cost? integer
---@field upgrade_chance? integer Chance from zero through 100.
---@field upgrade_duration_turns? integer Non-negative upgrade duration.
---@field light_emitted? number Finite non-negative light.
---@field local_light_override? number Finite local override.
---@field translucency? number Finite non-negative translucency.
---@field concentration? integer Non-negative concentration.
---@field convection_temperature_modifier? integer
---@field scent_neutralization? integer

---@class FieldEffectOptions
---@field effect string Existing or same-transaction EffectType id.
---@field duration_min_turns? integer Non-negative minimum duration.
---@field duration_max_turns? integer Maximum duration no lower than the minimum.
---@field intensity? integer Positive effect intensity.
---@field body_part? string Existing or same-transaction BodyPart id.
---@field environmental? boolean
---@field message? string
---@field npc_message? string

---@class FieldTypeDefinitionOptions
---@field id string Stable native field-type id.
---@field underwater_age_speedup_turns? integer
---@field outdoor_age_speedup_turns? integer
---@field decay_amount_factor? integer
---@field percent_spread? integer Chance from zero through 100.
---@field gas_absorption_turns? integer Non-negative absorption duration.
---@field priority? integer
---@field half_life_turns? integer Non-negative half life.
---@field phase? 'null'|'solid'|'liquid'|'gas'|'plasma'
---@field description_affix? 'in'|'covered_in'|'on'|'under'|'illuminated_by'
---@field wandering_field? string Existing or same-transaction FieldType id.
---@field looks_like? string Tileset fallback id.
---@field splattering? boolean
---@field has_fire? boolean
---@field has_acid? boolean
---@field has_electricity? boolean
---@field has_fume? boolean
---@field moppable? boolean
---@field accelerated_decay? boolean
---@field display_items? boolean
---@field display_field? boolean
---@field linear_half_life? boolean
---@field indestructible? boolean
---@field mopsafe? boolean
---@field decrease_intensity_on_contact? boolean

---@class FieldTypeDefinition
---@field id string
local FieldTypeDefinition = {}
---@param options FieldIntensityOptions
---@return FieldTypeDefinition self
function FieldTypeDefinition:intensity(options) end
---@param one_based_intensity integer
---@param options FieldEffectOptions
---@return FieldTypeDefinition self
function FieldTypeDefinition:effect(one_based_intensity, options) end
---@param monster_id string Existing or same-transaction Monster id.
---@return FieldTypeDefinition self
function FieldTypeDefinition:immune_monster(monster_id) end
---@param monster_id string Existing or same-transaction Monster id.
---@return FieldTypeDefinition self
function FieldTypeDefinition:block_monster(monster_id) end

---@class ItemGroupDefinitionOptions
---@field id string Stable native item-group id.
---@field kind? 'distribution'|'collection'
---@field with_ammo? integer Chance from zero through 100.
---@field with_magazine? integer Chance from zero through 100.

---@class ItemGroupDefinition
---@field id string
local ItemGroupDefinition = {}
---@param item_id string Existing or same-transaction Item id.
---@param probability? integer Positive distribution weight or collection percentage.
---@param variant? string Native item variant id.
---@return ItemGroupDefinition self
function ItemGroupDefinition:item(item_id, probability, variant) end
---@param group_id string Existing or same-transaction ItemGroup id.
---@param probability? integer Positive distribution weight or collection percentage.
---@return ItemGroupDefinition self
function ItemGroupDefinition:group(group_id, probability) end

---@class ItemGroupEntryOptions
---@field item? string Exactly one of item or group is required.
---@field group? string Exactly one of item or group is required.
---@field probability? integer Positive distribution weight or collection percentage.
---@field count? integer[] Two-element inclusive count interval.
---@field charges? integer[] Two-element inclusive item charge interval; group entries may not set it.
---@field variant? string Native item variant id.

---@param options ItemGroupEntryOptions
---@return ItemGroupDefinition self
function ItemGroupDefinition:entry(options) end

---@class SubBodyPartDefinitionOptions
---@field id string Stable native sub-body-part id.
---@field name string Player-facing singular name.
---@field plural_name? string Pair/plural name; defaults to name.
---@field parent string Existing or same-transaction BodyPart id.
---@field opposite? string Existing or same-transaction SubBodyPart id; defaults to self.
---@field side? 'left'|'right'|'both'
---@field secondary? boolean
---@field maximum_coverage? integer Positive percentage no greater than 100.
---@field similar_body_part? string Existing or same-transaction SubBodyPart id used for armor coverage.

---@class SubBodyPartDefinition
---@field id string
local SubBodyPartDefinition = {}
---@param sub_body_part_id string Existing or same-transaction lower location.
---@return SubBodyPartDefinition self
function SubBodyPartDefinition:location_under(sub_body_part_id) end
---@param damage_type string
---@param amount number
---@return SubBodyPartDefinition self
function SubBodyPartDefinition:unarmed_damage(damage_type, amount) end

---@class WoundDefinitionOptions
---@field id string Stable native wound-type id.
---@field name? string Player-facing singular name; defaults to id.
---@field plural_name? string Player-facing plural name; defaults to name.
---@field description string Non-empty player-facing description.
---@field pain_min? integer Minimum pain rolled when the wound is created; defaults to zero.
---@field pain_max? integer Maximum pain no lower than pain_min; defaults to zero.
---@field healing_min_turns? integer Positive minimum healing duration in turns; defaults to one.
---@field healing_max_turns? integer Maximum healing duration no shorter than healing_min_turns; defaults to one.
---@field damage_min? integer Non-negative minimum incoming damage used by natural wound candidate selection.
---@field damage_max? integer Maximum incoming damage no lower than damage_min, used by natural candidate selection.
---@field weight? integer Positive relative natural-selection weight; defaults to one.
---@field per_part_limit? integer Non-negative per-body-part instance limit; zero is unlimited.
---@field required_body_part_flag? string Existing or same-transaction JsonFlag required when natural damage selection tests a body part.
---@field forbidden_body_part_flag? string Existing or same-transaction JsonFlag forbidden when natural damage selection tests a body part.

---@class WoundDefinition
---@field id string
local WoundDefinition = {}
---@param id string Existing or same-transaction DamageType id; each id may be added once and at least one is required.
---@return WoundDefinition self
function WoundDefinition:damage_type(id) end
---@param id string Existing or same-transaction LimbScore id.
---@param penalty number Finite penalty from zero through one.
---@return WoundDefinition self
function WoundDefinition:limb_score(id, penalty) end
---@param id string Existing or same-transaction non-self Wound id.
---@param chance integer Progression chance from zero through 100.
---@return WoundDefinition self
function WoundDefinition:progression(id, chance) end
---Require this body-part type during natural damage-selection candidate filtering.
---@param kind 'head'|'torso'|'sensor'|'mouth'|'arm'|'hand'|'leg'|'foot'|'wing'|'tail'|'other'
---@return WoundDefinition self
function WoundDefinition:require_body_part_type(kind) end
---Forbid this body-part type during natural damage-selection candidate filtering.
---@param kind 'head'|'torso'|'sensor'|'mouth'|'arm'|'hand'|'leg'|'foot'|'wing'|'tail'|'other'
---@return WoundDefinition self
function WoundDefinition:forbid_body_part_type(kind) end

---@class BodyPartDefinitionOptions
---@field id string Stable native body-part id.
---@field name string Player-facing singular name.
---@field plural_name? string Pair/plural name.
---@field accusative? string Accusative singular name.
---@field plural_accusative? string Accusative pair/plural name.
---@field heading? string UI heading.
---@field plural_heading? string UI pair/plural heading.
---@field encumbrance_text? string Encumbrance UI label.
---@field hp_bar_text? string HP-bar UI label.
---@field main_part? string Existing or same-transaction main BodyPart; defaults to self.
---@field connected_to? string Existing or same-transaction connected BodyPart.
---@field opposite? string Existing or same-transaction opposite BodyPart; defaults to self.
---@field side? 'left'|'right'|'both'
---@field hit_size? number Finite positive targeting size.
---@field hit_difficulty? number Finite non-negative targeting difficulty.
---@field base_health? integer Positive base HP.
---@field drench_capacity? integer Non-negative wetness capacity.
---@field limb? boolean
---@field vital? boolean

---@class BodyPartDefinition
---@field id string
local BodyPartDefinition = {}
---@param id string Existing or same-transaction SubBodyPart id.
---@return BodyPartDefinition self
function BodyPartDefinition:sub_part(id) end
---@param kind 'head'|'torso'|'sensor'|'mouth'|'arm'|'hand'|'leg'|'foot'|'wing'|'tail'|'other'
---@param weight? number Finite positive weight.
---@return BodyPartDefinition self
function BodyPartDefinition:limb_type(kind, weight) end
---@param damage_type string
---@param amount number
---@return BodyPartDefinition self
function BodyPartDefinition:armor(damage_type, amount) end
---@param damage_type string
---@param amount number
---@return BodyPartDefinition self
function BodyPartDefinition:unarmed_damage(damage_type, amount) end
---@param flag_id string Existing or same-transaction JsonFlag id.
---@return BodyPartDefinition self
function BodyPartDefinition:flag(flag_id) end
---@param limb_score_id string Existing or same-transaction LimbScore id.
---@param score number
---@param maximum? number
---@return BodyPartDefinition self
function BodyPartDefinition:limb_score(limb_score_id, score, maximum) end
---@param quality_id string Existing or same-transaction ToolQuality id.
---@param level integer
---@param disable_fraction? number Fraction from zero through one.
---@return BodyPartDefinition self
function BodyPartDefinition:quality(quality_id, level, disable_fraction) end

---@class WoundFixDefinitionOptions
---@field id string Stable native wound-fix id.
---@field name? string Player-facing action name; defaults to id.
---@field description string Non-empty player-facing treatment description.
---@field success_message? string Player-facing successful-treatment message.
---@field duration_turns? integer Non-negative base duration whose move cost fits the native integer range.
---@field health_delta? integer Signed body-part HP change applied by the treatment.

---@class WoundFixDefinition
---@field id string
local WoundFixDefinition = {}
---@param id string Existing or same-transaction Skill id.
---@param level integer Required level from zero through the native skill maximum.
---@return WoundFixDefinition self
function WoundFixDefinition:skill(id, level) end
---@param id string Existing or same-transaction Proficiency id.
---@param multiplier number Positive finite treatment-time multiplier that remains positive as a native float.
---@param mandatory boolean Whether the proficiency is required to perform the treatment.
---@return WoundFixDefinition self
function WoundFixDefinition:proficiency(id, multiplier, mandatory) end
---@param id string Existing or same-transaction Wound id removed by the treatment; at least one removal is required.
---@return WoundFixDefinition self
function WoundFixDefinition:removes(id) end
---@param id string Existing or same-transaction Wound id added by the treatment.
---@return WoundFixDefinition self
function WoundFixDefinition:adds(id) end
---@param id string Existing or same-transaction Requirement id.
---@param count integer Positive native requirement multiplier; multiplied and subsequently consolidated component/tool counts must fit signed native integers.
---@return WoundFixDefinition self
function WoundFixDefinition:requires(id, count) end

---@class AnatomyDefinitionOptions
---@field id string Stable native anatomy id.
---@class AnatomyDefinition
---@field id string
local AnatomyDefinition = {}
---@param body_part_id string Existing or same-transaction BodyPart id.
---@return AnatomyDefinition self
function AnatomyDefinition:part(body_part_id) end

---@class BodyGraphPartOptions
---@field body_parts? string[] Dense list of existing or same-transaction BodyPart ids.
---@field sub_body_parts? string[] Dense list of existing or same-transaction SubBodyPart ids.
---@field nested_graph? string Existing or same-transaction BodyGraph id.
---@field selected_color? string Native color name.
---@field display_symbol? string Exactly one display-cell glyph.
---@class BodyGraphDefinitionOptions
---@field id string Stable native body-graph id.
---@field parent_body_part? string Existing or same-transaction BodyPart id.
---@field mirror? string Existing or same-transaction BodyGraph id; mirrored graphs omit rows.
---@field label_fill? string
---@field fill_symbol? string Exactly one display-cell glyph.
---@field fill_color? string Native color name.
---@class BodyGraphDefinition
---@field id string
local BodyGraphDefinition = {}
---@param row string One through 40 display cells; all rows use one width.
---@param fill_row? string Optional fill row of the same width; supply it for every row or none.
---@return BodyGraphDefinition self
function BodyGraphDefinition:row(row, fill_row) end
---@param symbol string Unique one-cell graph symbol.
---@param options BodyGraphPartOptions
---@return BodyGraphDefinition self
function BodyGraphDefinition:part(symbol, options) end

---@class MonsterDefinitionOptions
---@field id string Stable native monster id.
---@field name string Player-facing singular name.
---@field plural_name? string Player-facing plural name.
---@field description? string Player-facing description.
---@field symbol? string Exactly one display-cell glyph.
---@field color? string Native color name.
---@field looks_like? string Tileset fallback id.
---@field body_type? string Native visual body-type tag.
---@field default_faction string Existing or same-transaction MonsterFaction id.
---@field harvest? string Existing or same-transaction Harvest id; defaults to `human`.
---@field dissect? string Existing or same-transaction Harvest id.
---@field decay? string Existing or same-transaction Harvest id.
---@field speed_description? string Existing or same-transaction SpeedDescription id.
---@field death_drops? string Existing or same-transaction ItemGroup id.
---@field volume_ml? integer Positive native volume.
---@field weight_grams? integer Positive native mass.
---@field phase? 'null'|'solid'|'liquid'|'gas'|'plasma'
---@field difficulty_adjustment? integer
---@field hp? integer Positive base HP before world scaling.
---@field speed? integer Non-negative base speed before world scaling.
---@field aggression? integer Value from -100 through 100.
---@field morale? integer
---@field tracking_distance? integer At least three tiles.
---@field attack_cost? integer Non-negative move cost.
---@field melee_skill? integer Non-negative melee skill.
---@field melee_dice? integer Non-negative bonus bash dice.
---@field melee_sides? integer Non-negative sides per bonus die.
---@field melee_armor_penetration? integer
---@field dodge? integer Non-negative dodge skill.
---@field vision_day? integer Non-negative daylight vision.
---@field vision_night? integer Non-negative dark vision.
---@field regenerates? integer HP regenerated per turn.
---@field bleed_rate? integer Non-negative percentage.
---@field status_chance_multiplier? number Finite value from zero through five.
---@field luminance? number Finite non-negative light emission.
---@field regenerates_in_dark? boolean
---@field regenerates_morale? boolean
---@field aggressive_to_characters? boolean

---@class MonsterDefinition
---@field id string
local MonsterDefinition = {}
---@param material_id string Existing or same-transaction Material id.
---@param portions? integer Positive material portions.
---@return MonsterDefinition self
function MonsterDefinition:material(material_id, portions) end
---@param species_id string Existing or same-transaction Species id.
---@return MonsterDefinition self
function MonsterDefinition:species(species_id) end
---@param category string
---@return MonsterDefinition self
function MonsterDefinition:category(category) end
---@param flag_id string Existing or same-transaction MonsterFlag id; `GEN_DORMANT` is not transaction-safe.
---@return MonsterDefinition self
function MonsterDefinition:flag(flag_id) end
---@param damage_type string
---@param amount number
---@return MonsterDefinition self
function MonsterDefinition:armor(damage_type, amount) end
---@param damage_type string
---@param amount number
---@param armor_penetration? number
---@return MonsterDefinition self
function MonsterDefinition:melee_damage(damage_type, amount, armor_penetration) end
---@param attack_id string Existing or same-transaction MonsterAttack id.
---@param cooldown? number Optional finite non-negative cooldown override.
---@return MonsterDefinition self
function MonsterDefinition:attack(attack_id, cooldown) end
---@param handler_id string
---@return MonsterDefinition self
function MonsterDefinition:on_attack(handler_id) end
---@param set_id string Existing or same-transaction WeakpointSet id.
---@return MonsterDefinition self
function MonsterDefinition:weakpoint_set(set_id) end
---@param emission_id string Existing or same-transaction Emission id.
---@param interval_turns integer Positive interval.
---@return MonsterDefinition self
function MonsterDefinition:emission(emission_id, interval_turns) end
---@param item_id string Existing or same-transaction Item id.
---@param amount integer Positive starting quantity.
---@return MonsterDefinition self
function MonsterDefinition:starting_ammo(item_id, amount) end
---@param scent_id string Existing or same-transaction ScentType id.
---@return MonsterDefinition self
function MonsterDefinition:track_scent(scent_id) end
---@param scent_id string Existing or same-transaction ScentType id.
---@return MonsterDefinition self
function MonsterDefinition:ignore_scent(scent_id) end
---@param effect_id string Existing or same-transaction EffectType id.
---@param amount integer Native regeneration modifier.
---@return MonsterDefinition self
function MonsterDefinition:regeneration_modifier(effect_id, amount) end
---@param behavior_id string Existing or same-transaction Behavior id.
---@return MonsterDefinition self
function MonsterDefinition:goal(behavior_id) end
---@param trigger 'STALK'|'PLAYER_WEAK'|'PLAYER_CLOSE'|'HOSTILE_SEEN'|'HURT'|'FIRE'|'FRIEND_DIED'|'FRIEND_ATTACKED'|'SOUND'|'PLAYER_NEAR_BABY'|'MATING_SEASON'|'BRIGHT_LIGHT'
---@return MonsterDefinition self
function MonsterDefinition:anger_trigger(trigger) end
---@param trigger 'STALK'|'PLAYER_WEAK'|'PLAYER_CLOSE'|'HOSTILE_SEEN'|'HURT'|'FIRE'|'FRIEND_DIED'|'FRIEND_ATTACKED'|'SOUND'|'PLAYER_NEAR_BABY'|'MATING_SEASON'|'BRIGHT_LIGHT'
---@return MonsterDefinition self
function MonsterDefinition:fear_trigger(trigger) end
---@param trigger 'STALK'|'PLAYER_WEAK'|'PLAYER_CLOSE'|'HOSTILE_SEEN'|'HURT'|'FIRE'|'FRIEND_DIED'|'FRIEND_ATTACKED'|'SOUND'|'PLAYER_NEAR_BABY'|'MATING_SEASON'|'BRIGHT_LIGHT'
---@return MonsterDefinition self
function MonsterDefinition:placate_trigger(trigger) end
---@param handler_id string
---@return MonsterDefinition self
function MonsterDefinition:on_death(handler_id) end

---@class MoraleTypeDefinitionOptions
---@field id string Stable morale-type id.
---@field text string Player-facing description; may contain one `%s` item-name placeholder.
---@field permanent? boolean Whether morale instances of this type are permanent.

---@class MoraleTypeDefinition
---@field id string
local MoraleTypeDefinition = {}

---@class DiseaseTypeDefinitionOptions
---@field id string Stable disease-type id.
---@field symptoms string Native effect id applied as symptoms.
---@field minimum_duration_turns? integer Positive minimum duration in game turns.
---@field maximum_duration_turns? integer Positive maximum duration no shorter than the minimum.
---@field minimum_intensity? integer Positive minimum symptom intensity.
---@field maximum_intensity? integer Positive maximum symptom intensity no lower than the minimum.
---@field health_threshold? integer Health above which the character is immune.

---@class DiseaseTypeDefinition
---@field id string
local DiseaseTypeDefinition = {}

---@param body_part_id string Native body-part id affected by the disease.
---@return DiseaseTypeDefinition self
function DiseaseTypeDefinition:affected_body_part(body_part_id) end

---@class MonsterFlagDefinitionOptions
---@field id string Stable monster-flag id.

---@class MonsterFlagDefinition
---@field id string
local MonsterFlagDefinition = {}

---@class SpeciesDefinitionOptions
---@field id string Stable monster-species id.
---@field description? string Player-facing species description.
---@field footsteps? string Player-facing footstep description; defaults to `footsteps.`.
---@field bleeds? string Native field-type id produced by bleeding; defaults to `fd_null`.

---@class SpeciesDefinition
---@field id string
local SpeciesDefinition = {}

---@param flag_id string Native MonsterFlag id inherited by every monster in the species.
---@return SpeciesDefinition self
function SpeciesDefinition:flag(flag_id) end

---@param trigger 'STALK'|'PLAYER_WEAK'|'PLAYER_CLOSE'|'HOSTILE_SEEN'|'HURT'|'FIRE'|'FRIEND_DIED'|'FRIEND_ATTACKED'|'SOUND'|'PLAYER_NEAR_BABY'|'MATING_SEASON'|'BRIGHT_LIGHT'
---@return SpeciesDefinition self
function SpeciesDefinition:anger(trigger) end

---@param trigger 'STALK'|'PLAYER_WEAK'|'PLAYER_CLOSE'|'HOSTILE_SEEN'|'HURT'|'FIRE'|'FRIEND_DIED'|'FRIEND_ATTACKED'|'SOUND'|'PLAYER_NEAR_BABY'|'MATING_SEASON'|'BRIGHT_LIGHT'
---@return SpeciesDefinition self
function SpeciesDefinition:fear(trigger) end

---@param trigger 'STALK'|'PLAYER_WEAK'|'PLAYER_CLOSE'|'HOSTILE_SEEN'|'HURT'|'FIRE'|'FRIEND_DIED'|'FRIEND_ATTACKED'|'SOUND'|'PLAYER_NEAR_BABY'|'MATING_SEASON'|'BRIGHT_LIGHT'
---@return SpeciesDefinition self
function SpeciesDefinition:placate(trigger) end

---@class EmissionDefinitionOptions
---@field id string Stable field-emission id.
---@field field string Native field-type id used by the static fallback profile.
---@field intensity? integer Positive fallback intensity no greater than the field type's maximum; defaults to one.
---@field quantity? integer Positive fallback field quantity; defaults to one.
---@field chance? integer Fallback emission chance from one through 100; defaults to 100.

---@class EmissionProfile
---@field field string Native field-type id; `fd_null` is not accepted.
---@field intensity integer Positive intensity no greater than the selected field type's maximum.
---@field quantity integer Non-negative field quantity; zero suppresses propagation.
---@field chance integer Emission chance from zero through 100; zero suppresses this emission.

---@class EmissionProfilePayload
---@field emission_id string
---@field position CcbPlatformBubbleMapSquarePayload Detached bubble map-square position of this emission.
---@field fallback EmissionProfile Immutable static fallback authored on the definition.

---@class EmissionDefinition
---@field id string
local EmissionDefinition = {}

---@param handler_id string Named handler receiving EmissionProfilePayload and returning one complete EmissionProfile table or nil for the fallback.
---@return EmissionDefinition self
function EmissionDefinition:profile(handler_id) end

---@class MonsterFactionDefinitionOptions
---@field id string Stable monster-faction id.
---@field base? string Native MonsterFaction id inherited when no direct relation exists; defaults to the sentinel root.

---@class MonsterFactionDefinition
---@field id string
local MonsterFactionDefinition = {}

---@param kind 'by_mood'|'neutral'|'friendly'|'hate' Direct relation kind.
---@param target string Native MonsterFaction id receiving the relation.
---@return MonsterFactionDefinition self
function MonsterFactionDefinition:attitude(kind, target) end

---@class MutationTypeDefinitionOptions
---@field id string Stable mutation-type grouping id.

---@class MutationTypeDefinition
---@field id string
local MutationTypeDefinition = {}

---@class ConnectGroupDefinitionOptions
---@field id string Stable terrain/furniture connection-group id.

---@class ConnectGroupDefinition
---@field id string
local ConnectGroupDefinition = {}

---@class MutationCategoryDefinitionOptions
---@field id string Stable mutation-category id.
---@field name? string Player-facing category name; defaults to id.
---@field threshold_mutation? string Native Mutation id granted at the threshold.
---@field mutagen_message string Player-facing message after consuming category mutagen.
---@field memorial_message? string Memorial text after crossing the threshold.
---@field vitamin? string Native Vitamin id used as category mutagen; defaults to `null`.
---@field threshold_minimum? integer Non-negative vitamin amount required for a threshold attempt.
---@field base_removal_chance? integer Starting-trait removal chance from zero through 100.
---@field base_removal_cost_multiplier? number Finite non-negative vitamin-cost multiplier.
---@field work_in_progress? boolean Marks an intentionally unfinished content category.
---@field skip_consistency_test? boolean Skips category consistency review for dummy-only categories.

---@class MutationCategoryDefinition
---@field id string
local MutationCategoryDefinition = {}

---@class ConstructionCategoryDefinitionOptions
---@field id string Stable construction-category id.
---@field name? string Player-facing category name; defaults to id.

---@class ConstructionCategoryDefinition
---@field id string
local ConstructionCategoryDefinition = {}

---@class ConstructionGroupDefinitionOptions
---@field id string Stable construction-group id.
---@field name? string Player-facing group name; defaults to id.

---@class ConstructionGroupDefinition
---@field id string
local ConstructionGroupDefinition = {}

---@class VehiclePartLocationDefinitionOptions
---@field id string Stable vehicle-part location id.
---@field name? string Player-facing location name; defaults to id.
---@field description? string Player-facing location description.
---@field z_order? integer Rendering order; higher locations render above lower locations.
---@field list_order? integer Vehicle-interaction display order; lower locations appear first.

---@class VehiclePartLocationDefinition
---@field id string
local VehiclePartLocationDefinition = {}

---@class MoodFaceDefinitionOptions
---@field id string Stable mood-face table id.

---@class MoodFaceDefinition
---@field id string
local MoodFaceDefinition = {}

---@param score integer Morale threshold, within the native integer range.
---@param face string Player-facing face markup used at or above the threshold.
---@return MoodFaceDefinition self
function MoodFaceDefinition:value(score, face) end

---@class DamageInfoOrderDefinitionOptions
---@field id string DamageType id whose presentation this definition controls.
---@field display? 'none'|'basic'|'detailed' Overall item-info detail level.
---@field verb? string Player-facing damage verb; defaults to the damage-type name.

---@class DamageInfoOrderDefinition
---@field id string
local DamageInfoOrderDefinition = {}

---@param section 'bionic'|'protection'|'pet_protection'|'melee'|'ablative'
---@param order integer Sort order for this presentation section.
---@param show_type boolean Whether the damage type appears in this section.
---@return DamageInfoOrderDefinition self
function DamageInfoOrderDefinition:section(section, order, show_type) end

---@class VehiclePartCategoryDefinitionOptions
---@field id string Stable vehicle-part category id.
---@field name? string Player-facing category name; defaults to id.
---@field short_name? string Compact player-facing label; defaults to name.
---@field priority? integer UI tab order.

---@class VehiclePartCategoryDefinition
---@field id string
local VehiclePartCategoryDefinition = {}

---@class NamedColorDefinitionOptions
---@field name string Stable player-facing color name.
---@field red? integer Red channel from 0 through 255.
---@field green? integer Green channel from 0 through 255.
---@field blue? integer Blue channel from 0 through 255.
---@field alpha? integer Alpha channel from 0 through 255; defaults to 255.

---@class NamedColorDefinition
---@field name string
local NamedColorDefinition = {}

---@class RotatableSymbolDefinitionOptions
---@field symbols string[] Dense array of two or four distinct, single-codepoint glyphs in clockwise order.

---@class RotatableSymbolDefinition
---@field key string First glyph, used as the stable transaction identity.
local RotatableSymbolDefinition = {}

---@class AsciiArtDefinitionOptions
---@field id string Stable ASCII-art id.

---@class AsciiArtDefinition
---@field id string
local AsciiArtDefinition = {}

---@param text string One display line, at most 41 terminal cells after color tags are removed.
---@return AsciiArtDefinition self
function AsciiArtDefinition:line(text) end

---@class LimbScoreDefinitionOptions
---@field id string Stable limb-score id.
---@field name? string Player-facing score name; defaults to id.
---@field affected_by_wounds? boolean Whether wounds reduce this score.
---@field affected_by_encumbrance? boolean Whether encumbrance reduces this score.

---@class LimbScoreDefinition
---@field id string
local LimbScoreDefinition = {}

---@class HitRangeDefinitionOptions
---@field even_good integer[] Dense global dispersion table indexed by range.

---@class HitRangeDefinition
---@field id 'global' Singleton identity; use `content.replace`.
local HitRangeDefinition = {}

---@class BashDamageProfileDefinitionOptions
---@field id string Stable bash-damage profile id.

---@class BashDamageProfileDefinition
---@field id string
local BashDamageProfileDefinition = {}

---@param damage_type_id string Native DamageType id.
---@param multiplier number Finite non-negative susceptibility multiplier.
---@return BashDamageProfileDefinition self
function BashDamageProfileDefinition:factor(damage_type_id, multiplier) end

---@class ClothingModDefinitionOptions
---@field id string Stable clothing-modification id.
---@field flag string Item flag applied by the modification.
---@field material_item string Item consumed to apply the modification.
---@field apply_prompt string Player-facing action prompt.
---@field remove_prompt string Player-facing removal prompt.
---@field restricted? boolean Whether the modification is restricted to compatible armor.

---@class ClothingModifierOptions
---@field stat 'acid'|'fire'|'bash'|'cut'|'bullet'|'encumbrance'|'warmth'
---@field amount number Finite modifier amount.
---@field scale? ('thickness'|'coverage')[] Optional composable scaling dimensions.
---@field round_up? boolean Whether the scaled result rounds upward.

---@class ClothingModDefinition
---@field id string
local ClothingModDefinition = {}

---@param options ClothingModifierOptions
---@return ClothingModDefinition self
function ClothingModDefinition:modifier(options) end

---@class OvermapLandUseCodeDefinitionOptions
---@field id string Stable overmap land-use id.
---@field code? integer External numeric classification code; defaults to zero.
---@field name? string Player-facing name; defaults to id.
---@field description? string Detailed player-facing definition.
---@field symbol string Exactly one Unicode codepoint.
---@field color? string Native color name; defaults to black.

---@class OvermapLandUseCodeDefinition
---@field id string
local OvermapLandUseCodeDefinition = {}

---@class OvermapVisionDefinitionOptions
---@field id string Stable overmap-vision profile id.

---@class OvermapVisionAppearanceOptions
---@field name string Player-facing description at this detail level.
---@field symbol string Exactly one Unicode codepoint.
---@field color? string Native color name; defaults to black.
---@field looks_like? string Optional overmap-terrain tileset fallback id.

---@class OvermapVisionDefinition
---@field id string
local OvermapVisionDefinition = {}

---@param options OvermapVisionAppearanceOptions
---@return OvermapVisionDefinition self
function OvermapVisionDefinition:appearance(options) end

---@return OvermapVisionDefinition self
function OvermapVisionDefinition:blend_adjacent() end

---@class OvermapLocationDefinitionOptions
---@field id string Stable overmap-location predicate id.

---@class OvermapLocationDefinition
---@field id string
local OvermapLocationDefinition = {}

---@param terrain_type_id string Native overmap terrain-type id accepted by this location.
---@return OvermapLocationDefinition self
function OvermapLocationDefinition:terrain(terrain_type_id) end

---@param flag string Native overmap-terrain flag accepted by this location.
---@return OvermapLocationDefinition self
function OvermapLocationDefinition:terrain_flag(flag) end

---@class ProfessionGroupDefinitionOptions
---@field id string Stable profession-group id.

---@class ProfessionGroupDefinition
---@field id string
local ProfessionGroupDefinition = {}

---@param profession_id string Native profession id included once in this group.
---@return ProfessionGroupDefinition self
function ProfessionGroupDefinition:profession(profession_id) end

---@class MapExtraCollectionDefinitionOptions
---@field id string Stable map-extra collection id.
---@field chance? integer Non-negative collection selection chance; defaults to zero.

---@class MapExtraCollectionDefinition
---@field id string
local MapExtraCollectionDefinition = {}

---@param map_extra_id string Native map-extra id.
---@param weight integer Positive selection weight.
---@return MapExtraCollectionDefinition self
function MapExtraCollectionDefinition:extra(map_extra_id, weight) end

---@class VehicleGroupDefinitionOptions
---@field id string Stable vehicle-group id.

---@class VehicleGroupDefinition
---@field id string
local VehicleGroupDefinition = {}

---@param vehicle_id string Native vehicle prototype id.
---@param weight integer Positive selection weight.
---@return VehicleGroupDefinition self
function VehicleGroupDefinition:vehicle(vehicle_id, weight) end

---@class FaultGroupDefinitionOptions
---@field id string Stable fault-group id.

---@class FaultGroupDefinition
---@field id string
local FaultGroupDefinition = {}

---@param fault_id string Native fault id.
---@param weight integer Positive selection weight.
---@return FaultGroupDefinition self
function FaultGroupDefinition:fault(fault_id, weight) end

---@class ExplosionLightDefinitionOptions
---@field id string Stable explosion-light recipe id.

---@class ExplosionLightWaveOptions
---@field travel? number Non-negative normalized wave travel time.
---@field gap? number Non-negative normalized gap between color fronts.
---@field rise? number Non-negative alpha rise duration.
---@field fade? number Non-negative alpha fade duration.
---@field blend? number Non-negative color-blend duration.
---@field spread_jitter? number Non-negative wavefront position variation.
---@field color_jitter? number Non-negative per-tile color variation.
---@field flicker? number Non-negative per-frame brightness variation.
---@field easing? 'linear'|'ease_in'|'ease_out'|'smoothstep'

---@class ExplosionLightDurationOptions
---@field base_ms? number Non-negative base animation duration.
---@field per_tile_ms? number Non-negative duration added per blast-radius tile.
---@field minimum_ms? number Positive lower duration bound.
---@field maximum_ms? number Duration upper bound no smaller than minimum_ms.

---@class ExplosionLightShockwaveOptions
---@field enabled? boolean Defaults to true.
---@field strength? number Non-negative peak refraction strength.
---@field speed? number Positive expansion-speed multiplier.
---@field thickness? number Non-negative radial half-width.

---@class ExplosionLightDefinition
---@field id string
local ExplosionLightDefinition = {}

---@param red integer Color component from zero through 255.
---@param green integer Color component from zero through 255.
---@param blue integer Color component from zero through 255.
---@param alpha integer Translucent opacity from zero through 255.
---@return ExplosionLightDefinition self
function ExplosionLightDefinition:stop(red, green, blue, alpha) end

---@param options ExplosionLightWaveOptions
---@return ExplosionLightDefinition self
function ExplosionLightDefinition:waves(options) end

---@param options ExplosionLightDurationOptions
---@return ExplosionLightDefinition self
function ExplosionLightDefinition:duration(options) end

---@param magnitude number Non-negative peak screen displacement.
---@param duration_ms number Non-negative shake duration.
---@return ExplosionLightDefinition self
function ExplosionLightDefinition:screen_shake(magnitude, duration_ms) end

---@param options ExplosionLightShockwaveOptions
---@return ExplosionLightDefinition self
function ExplosionLightDefinition:shockwave(options) end

---@class AmmoEffectDefinitionOptions
---@field id string Stable ammunition-effect id.
---@field trigger_chance? integer Percentage chance, from zero through 100, that the recipe runs on impact.

---@class AmmoFieldBurstOptions
---@field field string Native field-type id.
---@field intensity_min? integer Non-negative minimum field intensity; defaults to one.
---@field intensity_max? integer Maximum field intensity no smaller than intensity_min.
---@field radius? integer Non-negative horizontal radius.
---@field height? integer Non-negative vertical radius.
---@field chance? integer Per-tile percentage chance from zero through 100.
---@field footprint? integer Non-negative AI area-size hint.
---@field passable_only? boolean Only place the field on passable tiles.

---@class AmmoTrailOptions
---@field field string Native field-type id.
---@field intensity_min? integer Non-negative minimum field intensity; defaults to one.
---@field intensity_max? integer Maximum field intensity no smaller than intensity_min.
---@field chance? integer Per-tile percentage chance from zero through 100.

---@class AmmoOnHitOptions
---@field effect string Native character-effect id.
---@field duration_turns? integer Positive duration in game turns.
---@field intensity? integer Positive effect intensity.
---@field touch_skin? boolean Require the projectile to touch skin.

---@class AmmoAreaEffectOptions
---@field effect string Native character-effect id.
---@field duration_turns? integer Positive duration in game turns.
---@field intensity_min? integer Positive minimum effect intensity.
---@field intensity_max? integer Maximum intensity no smaller than intensity_min.
---@field chance? integer Percentage chance from zero through 100.
---@field radius? integer Non-negative horizontal radius.
---@field hits_min? integer Positive minimum number of affected body parts.
---@field hits_max? integer Maximum number of affected body parts no smaller than hits_min.
---@field all_body_parts? boolean Apply to every body part instead of choosing hits.

---@class AmmoExplosionOptions
---@field power number Non-negative blast power.
---@field distance_factor? number Blast retention factor from zero through one.
---@field max_noise? integer Non-negative native sound cap.
---@field fire? boolean Whether the blast ignites its area.
---@field light? string Native ExplosionLight id.

---@class AmmoShrapnelOptions
---@field casing_mass? integer Non-negative casing mass.
---@field fragment_mass? number Positive mass of one fragment.
---@field recovery? integer Recoverable-fragment percentage from zero through 100.
---@field drop? string Native item id dropped by recovered fragments.

---@class AmmoSpellOptions
---@field level? integer Non-negative spell level.
---@field self? boolean Cast on the projectile source rather than the impact position.

---@class AmmoImpactPolicyPayload
---@field ammo_effect_id string
---@field dealt_damage integer
---@field source GameHandle|nil Generation-checked source creature when present.
---@field target GameHandle|nil Generation-checked target creature when present.
---@field position CcbPlatformBubbleMapSquarePayload Detached impact position.

---@class AmmoEffectDefinition
---@field id string
local AmmoEffectDefinition = {}

---@param options AmmoFieldBurstOptions
---@return AmmoEffectDefinition self
function AmmoEffectDefinition:field_burst(options) end

---@param options AmmoTrailOptions
---@return AmmoEffectDefinition self
function AmmoEffectDefinition:trail(options) end

---@param options AmmoOnHitOptions
---@return AmmoEffectDefinition self
function AmmoEffectDefinition:on_hit(options) end

---@param options AmmoAreaEffectOptions
---@return AmmoEffectDefinition self
function AmmoEffectDefinition:area_effect(options) end

---@param options AmmoExplosionOptions
---@return AmmoEffectDefinition self
function AmmoEffectDefinition:explosion(options) end

---@param options AmmoShrapnelOptions Must follow explosion().
---@return AmmoEffectDefinition self
function AmmoEffectDefinition:shrapnel(options) end

---@return AmmoEffectDefinition self
function AmmoEffectDefinition:flashbang() end

---@return AmmoEffectDefinition self
function AmmoEffectDefinition:emp() end

---@return AmmoEffectDefinition self
function AmmoEffectDefinition:foamcrete() end

---@param spell_id string Native spell id.
---@param options? AmmoSpellOptions
---@return AmmoEffectDefinition self
function AmmoEffectDefinition:spell(spell_id, options) end

---@param enabled? boolean Defaults to true.
---@return AmmoEffectDefinition self
function AmmoEffectDefinition:cast_spells_on_miss(enabled) end

---@param handler_id string Named callback registered with ccb.runtime.handler.
---@return AmmoEffectDefinition self
function AmmoEffectDefinition:impact_policy(handler_id) end

---@class AddictionTypeDefinitionOptions
---@field id string Stable addiction-type id.
---@field name string Player-facing withdrawal name.
---@field type_name string Noun phrase completing “became addicted to …”.
---@field description string Player-facing effects description.
---@field craving_morale? string Native morale-type id used for cravings.

---@class AddictionTickPolicyPayload
---@field addiction_type_id string
---@field intensity integer
---@field sated_turns integer
---@field character GameHandle Generation-checked addicted character.

---@class AddictionTypeDefinition
---@field id string
local AddictionTypeDefinition = {}

---@param handler_id string Named callback registered with ccb.runtime.handler; it must return whether the tick produced an observable effect.
---@return AddictionTypeDefinition self
function AddictionTypeDefinition:tick_policy(handler_id) end

---@class CharacterModifierDefinitionOptions
---@field id string Stable character-modifier id.
---@field description string Player-facing explanation of the modifier.
---@field operation? 'add'|'multiply'|'none' How consumers display and combine the returned value; defaults to multiply.

---@class CharacterModifierPayload
---@field modifier_id string
---@field skill_id string Empty when the consumer did not provide a skill.
---@field character GameHandle Generation-checked character being evaluated.

---@class CharacterModifierDefinition
---@field id string
local CharacterModifierDefinition = {}

---@param handler_id string Named callback registered with ccb.runtime.handler; it must return one finite native-range number.
---@return CharacterModifierDefinition self
function CharacterModifierDefinition:evaluate_with(handler_id) end

---@class StartLocationDefinitionOptions
---@field id string Stable start-location id.
---@field name string Player-facing location name.

---@class StartLocationTerrainOptions
---@field match? 'exact'|'type'|'subtype'|'prefix'|'contains' Native overmap-terrain matching mode; defaults to type.
---@field parameters? table<string, string> Mapgen parameter values applied after selection.

---@class StartLocationDefinition
---@field id string
local StartLocationDefinition = {}

---@param terrain_id string Native overmap terrain or type selector.
---@param options? StartLocationTerrainOptions
---@return StartLocationDefinition self
function StartLocationDefinition:terrain(terrain_id, options) end

---@param flag_id string Native start-placement flag.
---@return StartLocationDefinition self
function StartLocationDefinition:flag(flag_id) end

---@param minimum integer Non-negative minimum city size.
---@param maximum integer Maximum city size no smaller than minimum.
---@return StartLocationDefinition self
function StartLocationDefinition:city_size(minimum, maximum) end

---@param minimum integer Non-negative minimum distance from a city edge.
---@param maximum integer Maximum distance no smaller than minimum.
---@return StartLocationDefinition self
function StartLocationDefinition:city_distance(minimum, maximum) end

---@param minimum integer Minimum native overmap z level.
---@param maximum integer Maximum native overmap z level.
---@return StartLocationDefinition self
function StartLocationDefinition:z_levels(minimum, maximum) end

---@class ClimbingAidDefinitionOptions
---@field id string Stable climbing-aid id.
---@field slip_chance_modifier? integer Signed modifier applied to native slip chance.

---@class ClimbingAidAvailabilityOptions
---@field category 'special'|'terrain_or_furniture'|'vehicle'|'item'|'character'|'trait'
---@field flag string Native capability, item, trait, vehicle, terrain, or furniture selector.
---@field uses? integer Non-negative item charges consumed when category is item.
---@field range? integer Non-negative terrain/furniture detection radius.

---@class ClimbingAidDescentOptions
---@field max_height? integer Maximum supported descent height; -1 disables descent.
---@field easy_climb_back_up? integer Non-negative height that remains easy to climb back.
---@field allow_remaining_height? boolean Whether the aid may cover only part of a taller fall.
---@field menu_text string Player-facing menu entry.
---@field unavailable_text? string Required when deploy() is used.
---@field hotkey? string Zero or one byte; required when deploy() is used.
---@field confirm_text string Confirmation prompt.
---@field before_message? string Message shown before descent.
---@field after_message? string Message shown after descent.

---@class ClimbingAidCostOptions
---@field pain? integer Non-negative pain cost.
---@field damage? integer Non-negative damage cost.
---@field kilocalories? integer Non-negative energy cost.
---@field thirst? integer Non-negative thirst cost.

---@class ClimbingAidDefinition
---@field id string
local ClimbingAidDefinition = {}

---@param options ClimbingAidAvailabilityOptions
---@return ClimbingAidDefinition self
function ClimbingAidDefinition:available_when(options) end

---@param options ClimbingAidDescentOptions
---@return ClimbingAidDefinition self
function ClimbingAidDefinition:descent(options) end

---@param options ClimbingAidCostOptions
---@return ClimbingAidDefinition self
function ClimbingAidDefinition:cost(options) end

---@param furniture_id string Native furniture id deployed below the climber.
---@return ClimbingAidDefinition self
function ClimbingAidDefinition:deploy(furniture_id) end

---@class WeatherTypeDefinitionOptions
---@field id string Stable weather-type id.
---@field name string Player-facing weather name.
---@field color? string Native text color; defaults to white.
---@field map_color? string Native overmap color; defaults to white.
---@field symbol? string Exactly one Unicode codepoint used by text displays.
---@field sun_symbol? string Exactly one Unicode codepoint used for the sun display.
---@field ranged_penalty? integer Signed native ranged-attack penalty.
---@field sight_penalty? number Non-negative per-tile visibility penalty.
---@field light_modifier? integer Signed ambient-light modifier.
---@field temperature_delta_kelvin? number Signed temperature delta in kelvins.
---@field light_multiplier? number Non-negative ambient-light multiplier.
---@field sun_multiplier? number Non-negative solar-radiation multiplier.
---@field sound_attenuation? integer Signed native sound attenuation.
---@field dangerous? boolean Whether entering this weather may interrupt activities.
---@field precipitation? 'none'|'very_light'|'light'|'heavy'
---@field rains? boolean Whether precipitation falls as rain.
---@field tiles_animation? string Tiles animation id; an empty string disables it.
---@field sound_category? 'silent'|'drizzle'|'rainy'|'rainstorm'|'thunder'|'flurries'|'snowstorm'|'snow'|'portal_storm'|'clear'|'sunny'|'cloudy'
---@field priority? integer Higher matching priorities replace lower ones.

---@class WeatherAnimationOptions
---@field factor number Non-negative animation density factor.
---@field color string Native animation color.
---@field symbol string Exactly one Unicode codepoint.

---@class WeatherPassiveEffectOptions
---@field effect string Native character-effect id.
---@field minimum_duration_turns? integer Positive minimum duration in game turns.
---@field maximum_duration_turns? integer Maximum duration no shorter than the minimum.
---@field intensity? integer Positive effect intensity.
---@field body_part? string Native body-part id; empty applies the effect without a body part.
---@field environmental? boolean Whether environmental immunity applies; defaults to true.
---@field immune_in_vehicle? boolean Suppress the effect in any vehicle.
---@field immune_inside_vehicle? boolean Suppress the effect inside a vehicle.
---@field immune_outside_vehicle? boolean Suppress the effect on exposed vehicle occupants.
---@field chance_in_vehicle? integer Percentage chance from zero through 100.
---@field chance_inside_vehicle? integer Percentage chance from zero through 100.
---@field chance_outside_vehicle? integer Percentage chance from zero through 100.
---@field message? string Player-facing application message.
---@field npc_message? string NPC-facing application message.

---@class WeatherConditionPayload
---@field weather_type_id string
---@field temperature_kelvin number
---@field humidity number
---@field pressure number
---@field windpower number
---@field wind_description string
---@field wind_direction integer
---@field turn integer
---@field location CcbPlatformAbsoluteMapSquarePayload Detached absolute map-square sample location.

---@class WeatherTypeDefinition
---@field id string
local WeatherTypeDefinition = {}

---@param minimum_turns integer Positive minimum duration in game turns.
---@param maximum_turns integer Maximum duration no shorter than the minimum.
---@return WeatherTypeDefinition self
function WeatherTypeDefinition:duration(minimum_turns, maximum_turns) end

---@param options WeatherAnimationOptions
---@return WeatherTypeDefinition self
function WeatherTypeDefinition:animation(options) end

---@param weather_id string Native or same-transaction prerequisite weather id.
---@return WeatherTypeDefinition self
function WeatherTypeDefinition:requires(weather_id) end

---@param options WeatherPassiveEffectOptions
---@return WeatherTypeDefinition self
function WeatherTypeDefinition:passive_effect(options) end

---@param handler_id string Named callback registered with ccb.runtime.handler; it must return one boolean.
---@return WeatherTypeDefinition self
function WeatherTypeDefinition:condition(handler_id) end

---@class ScoreDefinitionOptions
---@field id string Stable score id.
---@field statistic string Native event-statistic id whose value is displayed.
---@field description? string Optional format string receiving the statistic value.

---@class ScoreDefinition
---@field id string
local ScoreDefinition = {}

---@class OverlayOrderDefinition
---@field id string Always `global`; overlay ordering is an engine-wide singleton.
local OverlayOrderDefinition = {}

---@param mutation_id string Stable mutation or overlay id.
---@param order integer Signed native display order; lower values render first.
---@return OverlayOrderDefinition self
function OverlayOrderDefinition:mutation(mutation_id, order) end

---@class ZoneTypeDefinitionOptions
---@field id string Stable native zone-type id.
---@field name string Player-facing zone name.
---@field description? string Player-facing explanation shown by zone UIs.
---@field display_field string Native field type used to display marked tiles.
---@field can_be_personal? boolean Whether a character may own a personal instance.
---@field hidden? boolean Whether ordinary zone-type selection hides this definition.

---@class ZoneTypeDefinition
---@field id string
local ZoneTypeDefinition = {}

---@class SpeechPoolDefinitionOptions
---@field id string Stable speaker or speech-pool label.

---@class SpeechPoolDefinition
---@field id string
local SpeechPoolDefinition = {}

---@param sound string Player-facing speech text or sound description.
---@param volume integer Signed native sound volume.
---@return SpeechPoolDefinition self
function SpeechPoolDefinition:line(sound, volume) end

---@class EndScreenDefinitionOptions
---@field id string Stable end-screen id.
---@field picture string Native ASCII-art id.
---@field priority? integer Higher priorities are considered first.
---@field last_words_label? string Optional label for the final text input.

---@class EndScreenConditionPayload
---@field end_screen_id string
---@field character GameHandle Generation-checked character handle.

---@class EndScreenDefinition
---@field id string
local EndScreenDefinition = {}

---@param column integer Text column in the ASCII-art layout.
---@param row integer Text row in the ASCII-art layout.
---@param text string Player-facing information template.
---@return EndScreenDefinition self
function EndScreenDefinition:info(column, row, text) end

---@param handler_id string Named callback registered with ccb.runtime.handler; it must return one boolean.
---@return EndScreenDefinition self
function EndScreenDefinition:condition(handler_id) end

---@class ActivityTypeDefinitionOptions
---@field id string Stable native activity id.
---@field verb string Player-facing progressive verb used by activity UI.
---@field rooted? boolean Whether the character is rooted while the activity runs.
---@field interruptable? boolean Whether gameplay may interrupt the activity; defaults to true.
---@field interruptable_with_keyboard? boolean Whether keyboard input may interrupt it; defaults to true.
---@field based_on? 'time'|'speed'|'neither' Progress model; defaults to `speed`.
---@field can_resume? boolean Whether compatible activities can resume this one; defaults to true.
---@field multi_activity? boolean Whether it participates in multi-activity workflows.
---@field fetch_items_to_zone? boolean Whether native fetching may supply the activity; defaults to true.
---@field refuel_fires? boolean Whether native fire-refuelling support is enabled.
---@field auto_needs? boolean Whether native auto-eat/drink support is enabled.
---@field activity_level? number Positive finite native exertion multiplier; defaults to 1.

---@class ActivityPolicyPayload
---@field activity_type_id string
---@field phase 'do_turn'|'completion'
---@field character GameHandle Generation-checked character handle.
---@field moves_total integer
---@field moves_left integer
---@field index integer Deprecated native activity state exposed only as a bounded snapshot.
---@field position integer Deprecated native activity state exposed only as a bounded snapshot.
---@field name string Deprecated native activity state exposed only as a bounded snapshot.

---@class ActivityPolicyResult
---@field cancel? boolean Cancel the current activity without entering native completion.
---@field moves_total? integer Replace the non-negative total move budget.
---@field moves_left? integer Replace the remaining move budget; a positive completion result extends the activity.
---@field index? integer Replace the bounded legacy activity index.
---@field position? integer Replace the bounded legacy activity position.
---@field name? string Replace the bounded legacy activity name.

---@class ActivityTypeDefinition
---@field id string
local ActivityTypeDefinition = {}

---@param distraction 'noise'|'pain'|'attacked'|'hostile_spotted_far'|'hostile_spotted_near'|'talked_to'|'asthma'|'motion_alarm'|'weather_change'|'portal_storm_popup'|'eoc'|'dangerous_field'|'hunger'|'thirst'|'temperature'|'mutation'|'oxygen'|'withdrawal'|'craft_step_complete'
---@return ActivityTypeDefinition self
function ActivityTypeDefinition:ignore(distraction) end

---@param handler_id string Named callback registered with ccb.runtime.handler; it may return nil or ActivityPolicyResult.
---@return ActivityTypeDefinition self
function ActivityTypeDefinition:on_turn(handler_id) end

---@param handler_id string Named callback registered with ccb.runtime.handler; it may return nil or ActivityPolicyResult.
---@return ActivityTypeDefinition self
function ActivityTypeDefinition:on_finish(handler_id) end

---@class HelpTopicDefinitionOptions
---@field id string Stable Lua-first help-topic id.
---@field title string Player-facing topic title.
---@field order? integer Optional global display order; omitted topics append in deterministic Mod load order.

---@class HelpTopicDefinition
---@field id string
local HelpTopicDefinition = {}

---@param text string Player-facing paragraph; native help tokens remain available in text.
---@return HelpTopicDefinition self
function HelpTopicDefinition:paragraph(text) end

---@class SnippetCategoryDefinitionOptions
---@field id string Stable category/tag, including angle brackets when used by recursive expansion.

---@class SnippetEntryOptions
---@field id string Stable snippet id.
---@field text string Player-facing snippet text.
---@field name? string Optional player-facing short name.
---@field weight? integer Positive selection weight; defaults to 1.
---@field on_examine? string Named callback registered with ccb.runtime.handler; no EOC is stored.

---@class SnippetExaminePayload
---@field snippet_id string
---@field category_id string
---@field item_type_id string Stable type id of the item whose description exposed the snippet.
---@field character GameHandle Generation-checked character handle.

---@class SnippetCategoryDefinition
---@field id string
local SnippetCategoryDefinition = {}

---@param text string Player-facing anonymous snippet text.
---@param weight? integer Positive selection weight; defaults to 1.
---@return SnippetCategoryDefinition self
function SnippetCategoryDefinition:text(text, weight) end

---@param options SnippetEntryOptions
---@return SnippetCategoryDefinition self
function SnippetCategoryDefinition:entry(options) end

---@class PlaylistDefinitionOptions
---@field id string Stable playlist id; standard native contexts include `title`, `mp3`, `instrument`, and `sound`.
---@field shuffle? boolean Randomize track order per playlist cycle.

---@class PlaylistDefinition
---@field id string
local PlaylistDefinition = {}

---@param relative_file string Track path relative to the active soundpack; absolute and parent-traversing paths are rejected.
---@param volume? integer Native volume from 0 through 128; defaults to 100.
---@return PlaylistDefinition self
function PlaylistDefinition:track(relative_file, volume) end

---@class SoundEffectDefinitionOptions
---@field id string Stable ambient sound id.
---@field variant? string Sound variant id; defaults to `default`.
---@field season? string Season filter id; empty means every season.
---@field is_indoors? boolean Indoor filter; omitted means both indoor and outdoor.
---@field is_night? boolean Night filter; omitted means both day and night.
---@field volume? integer Native volume from 0 through 128; defaults to 100.

---@class SoundEffectDefinition
---@field id string
local SoundEffectDefinition = {}

---@param relative_file string Sound file relative to the active soundpack; absolute and parent-traversing paths are rejected.
---@return SoundEffectDefinition self
function SoundEffectDefinition:file(relative_file) end

---@class SoundEffectPreloadDefinitionOptions
---@field id string Stable ambient sound id to preload.
---@field variant? string Sound variant id; defaults to `default`.
---@field season? string Season filter id; empty means every season.
---@field is_indoors? boolean Indoor filter; omitted means both indoor and outdoor.
---@field is_night? boolean Night filter; omitted means both day and night.

---@class AttackVectorDefinitionOptions
---@field id string Stable attack-vector id.
---@field weapon? boolean Whether this vector represents the wielded weapon.
---@field strict_limbs? boolean Disable automatic substitution of anatomically similar parts.
---@field armor_bonus? boolean Include worn unarmed-weapon damage; defaults to true.
---@field encumbrance_limit? integer Maximum eligible limb encumbrance; defaults to 100.
---@field health_percent_limit? integer Minimum eligible limb health percentage from zero through 100.

---@class AttackVectorDefinition
---@field id string
local AttackVectorDefinition = {}

---@param body_part_id string Native BodyPart id eligible to deliver the attack.
---@return AttackVectorDefinition self
function AttackVectorDefinition:limb(body_part_id) end

---@param sub_body_part_id string Native SubBodyPart id used as the contact surface.
---@return AttackVectorDefinition self
function AttackVectorDefinition:contact(sub_body_part_id) end

---@param kind 'head'|'torso'|'sensor'|'mouth'|'arm'|'hand'|'leg'|'foot'|'wing'|'tail'|'other'
---@param count integer Positive required number of healthy limbs of this anatomical kind.
---@return AttackVectorDefinition self
function AttackVectorDefinition:requires_limb(kind, count) end

---@param flag_id string Native character/body-part flag required on an eligible limb.
---@return AttackVectorDefinition self
function AttackVectorDefinition:requires_flag(flag_id) end

---@param flag_id string Native character/body-part flag forbidden on an eligible limb.
---@return AttackVectorDefinition self
function AttackVectorDefinition:forbids_flag(flag_id) end

---@class TechniqueDefinitionOptions
---@field id string Stable technique id.
---@field name string Player-facing technique name.
---@field description? string Technique description.
---@field avatar_message? string Message shown to the avatar on use.
---@field npc_message? string Message shown to NPC observers on use.
---@field crit_tec? boolean Critical-only technique.
---@field crit_ok? boolean Usable on critical hits.
---@field wall_adjacent? boolean Only works near a wall.
---@field reach_tec? boolean Only usable during reach attacks.
---@field reach_ok? boolean Usable during reach attacks.
---@field needs_ammo? boolean Only works while the weapon is loaded.
---@field defensive? boolean Defensive technique.
---@field disarms? boolean Disarms the target.
---@field take_weapon? boolean Disarms and equips the weapon when hands are free.
---@field side_switch? boolean Moves the target behind the user.
---@field dummy? boolean Placeholder technique.
---@field dodge_counter? boolean Counter activated on a dodge.
---@field block_counter? boolean Counter activated on a block.
---@field miss_recovery? boolean Halves the move cost of a miss.
---@field grab_break? boolean Allows grab breaks.
---@field weighting? integer Non-negative usage frequency weight; defaults to 1.
---@field repeat_min? integer Minimum repeats; defaults to 1.
---@field repeat_max? integer Maximum repeats; defaults to 1.
---@field down_dur? integer Non-negative knockdown duration.
---@field stun_dur? integer Non-negative stun duration.
---@field knockback_dist? integer Non-negative knockback distance.
---@field knockback_spread? number Non-negative knockback randomness.
---@field knockback_follow? boolean Follow a knocked-back target.
---@field aoe? string Native area-of-effect shape id; empty means single target.
---@field unarmed_allowed? boolean Whether unarmed characters may use it.
---@field melee_allowed? boolean Whether armed characters may use it.
---@field strictly_unarmed? boolean Ignore force-unarmed styles.

---@class TechniqueDefinition
---@field id string
local TechniqueDefinition = {}

---@param flag_id string Native technique flag id.
---@return TechniqueDefinition self
function TechniqueDefinition:flag(flag_id) end

---@param attack_vector_id string Native attack-vector id.
---@return TechniqueDefinition self
function TechniqueDefinition:attack_vector(attack_vector_id) end

---@param skill_id string Native skill id.
---@param level integer Non-negative minimum skill level.
---@return TechniqueDefinition self
function TechniqueDefinition:requires_skill(skill_id, level) end
---@param handler_id string
---@return TechniqueDefinition self
function TechniqueDefinition:on_apply(handler_id) end

---@class MartialArtDefinitionOptions
---@field id string Stable martial-art style id.
---@field name string Player-facing style name.
---@field description? string Style description.
---@field initiate_avatar? string Message shown when the avatar starts the style.
---@field initiate_npc? string Message shown when an NPC starts the style.
---@field priority? integer Style selection priority; defaults to 0.
---@field primary_skill? string Primary skill id; empty means unarmed.
---@field learn_difficulty? integer Non-negative learning difficulty.
---@field teachable? boolean Whether the style is teachable; defaults to true.
---@field arm_block? integer Arm-block effectiveness from zero through 100.
---@field leg_block? integer Leg-block effectiveness from zero through 100.
---@field arm_block_with_bio_armor_arms? boolean Arm blocking works with bionic arms.
---@field leg_block_with_bio_armor_legs? boolean Leg blocking works with bionic legs.
---@field strictly_unarmed? boolean Punch daggers and similar only.
---@field strictly_melee? boolean A melee weapon is required.
---@field allow_all_weapons? boolean Any weapon or unarmed works.
---@field force_unarmed? boolean Never use weapons with this style.
---@field prevent_weapon_blocking? boolean Weapon blocking is disabled.

---@class MartialArtDefinition
---@field id string
local MartialArtDefinition = {}

---@param skill_id string Native skill id.
---@param level integer Non-negative skill level at which the style is auto-learned.
---@return MartialArtDefinition self
function MartialArtDefinition:autolearn(skill_id, level) end

---@param technique_id string Native technique id available to the style.
---@return MartialArtDefinition self
function MartialArtDefinition:technique(technique_id) end

---@param item_id string Native item id usable as a style weapon.
---@return MartialArtDefinition self
function MartialArtDefinition:weapon(item_id) end

---@param category_id string Native weapon-category id usable with the style.
---@return MartialArtDefinition self
function MartialArtDefinition:weapon_category(category_id) end
---@param handler_id string
---@return MartialArtDefinition self
function MartialArtDefinition:on(handler_id) end

---@class TrapDefinitionOptions
---@field id string Stable trap id.
---@field name string Player-facing trap name.
---@field color string Native color name.
---@field symbol string Single map symbol character.
---@field visibility? integer Non-negative spotting difficulty; smaller is easier.
---@field avoidance? integer Non-negative dodge difficulty.
---@field difficulty? integer Disarm difficulty from zero through 99; zero means always disarmable.
---@field action string Native trap action id, such as `spike` or `none`.
---@field memorial_male? string Memorial message for male victims; must pair with memorial_female.
---@field memorial_female? string Memorial message for female victims; must pair with memorial_male.
---@field trigger_message_u? string Message shown when the avatar triggers the trap.
---@field trigger_message_npc? string Message shown when an NPC triggers the trap.
---@field trap_radius? integer Non-negative trigger radius.
---@field benign? boolean Non-dangerous trap without safety queries.
---@field always_invisible? boolean Never visible without special search.
---@field funnel_radius? integer Non-negative funnel collection radius.
---@field comfort? integer Non-negative sleeping comfort.
---@field trigger_weight_grams? integer Minimum thrown weight in grams that triggers the trap; defaults to 500.
---@field sound_threshold_min? integer Non-negative minimum triggering volume.
---@field sound_threshold_max? integer Non-negative maximum triggering volume.

---@class TrapDefinition
---@field id string
local TrapDefinition = {}

---@param flag_id string Native trap flag id.
---@return TrapDefinition self
function TrapDefinition:flag(flag_id) end

---@param item_id string Native item id dropped by disassembly.
---@param quantity? integer Positive quantity; defaults to 1.
---@param charges? integer Positive charges; defaults to 1.
---@return TrapDefinition self
function TrapDefinition:drop(item_id, quantity, charges) end
---@param handler_id string
---@return TrapDefinition self
function TrapDefinition:on_trigger(handler_id) end

---@class ConstructionDefinitionOptions
---@field id string Stable construction id.
---@field group string Native construction-group id.
---@field category? string Native construction-category id.
---@field pre_note? string Note shown alongside the requirements.
---@field post_terrain? string Terrain or furniture id created on success.
---@field duration_moves? integer Non-negative base duration in moves.
---@field activity_level? number Non-negative native exertion multiplier; defaults to 1.

---@class ConstructionDefinition
---@field id string
local ConstructionDefinition = {}

---@param skill_id string Native skill id.
---@param level integer Non-negative minimum skill level.
---@return ConstructionDefinition self
function ConstructionDefinition:requires_skill(skill_id, level) end

---@param requirement_id string Native requirement id consumed by the construction.
---@param multiplier integer Positive requirement multiplier.
---@return ConstructionDefinition self
function ConstructionDefinition:using_requirement(requirement_id, multiplier) end

---@param terrain_id string Terrain or furniture id required before the construction.
---@return ConstructionDefinition self
function ConstructionDefinition:pre_terrain(terrain_id) end

---@param flag_id string Native flag required before the construction.
---@param force_terrain? boolean Whether the flag forces the terrain check.
---@return ConstructionDefinition self
function ConstructionDefinition:pre_flag(flag_id, force_terrain) end

---@param flag_id string Native flag applied after the construction.
---@return ConstructionDefinition self
function ConstructionDefinition:post_flag(flag_id) end

---@class FurnitureDefinitionOptions
---@field id string Stable furniture id.
---@field name string Player-facing furniture name.
---@field description? string Furniture description.
---@field color string Native color name.
---@field symbol string Single map symbol character.
---@field move_cost_mod? integer Native signed-int move cost modifier; negative values make the furniture impassable.
---@field required_str? integer Non-negative strength required to move through.
---@field light_emitted? integer Non-negative light emitted.
---@field comfort? integer Non-negative sleeping comfort.
---@field max_volume_ml? integer Non-negative tile storage volume in milliliters.
---@field mass_grams? integer Non-negative furniture mass in grams.
---@field keg_capacity_ml? integer Non-negative keg storage volume in milliliters.
---@field transparent? boolean Whether sight passes through.
---@field open? string Furniture id to transform into when opened.
---@field close? string Furniture id to transform into when closed.
---@field lockpick_result? string Furniture id to transform into when lockpicked.
---@field crafting_pseudo_item? string Item id used for in-place crafting.
---@field deployed_item? string Item id that deploys this furniture.

---@class FurnitureDefinition
---@field id string
local FurnitureDefinition = {}

---@param flag_id string Native furniture flag id.
---@return FurnitureDefinition self
function FurnitureDefinition:flag(flag_id) end
---@param handler_id string
---@return FurnitureDefinition self
function FurnitureDefinition:on_examine(handler_id) end

---@class TerrainDefinitionOptions
---@field id string Stable terrain id.
---@field name string Player-facing terrain name.
---@field description? string Terrain description.
---@field color string Native color name.
---@field symbol string Single map symbol character.
---@field move_cost? integer Non-negative move cost modifier.
---@field light_emitted? integer Non-negative light emitted.
---@field comfort? integer Non-negative sleeping comfort.
---@field max_volume_ml? integer Non-negative tile storage volume in milliliters.
---@field heat_radiation? integer Non-negative heat radiated.
---@field transparent? boolean Whether sight passes through.
---@field open? string Terrain id to transform into when opened.
---@field close? string Terrain id to transform into when closed.
---@field transforms_into? string Terrain id to transform into.
---@field roof? string Terrain id acting as this terrain's roof.
---@field lockpick_result? string Terrain id to transform into when lockpicked.
---@field trap? string Native trap id embedded in this terrain.

---@class TerrainDefinition
---@field id string
local TerrainDefinition = {}

---@param flag_id string Native terrain flag id.
---@return TerrainDefinition self
function TerrainDefinition:flag(flag_id) end
---@param handler_id string
---@return TerrainDefinition self
function TerrainDefinition:on_examine(handler_id) end

---@class GateDefinitionOptions
---@field id string Stable gate id; the matching terrain acts as the winch.
---@field door string Terrain id acting as the gate door.
---@field floor string Terrain id acting as the gate floor.
---@field pull_message? string Message shown when the gate is pulled.
---@field open_message? string Message shown when the gate opens.
---@field close_message? string Message shown when the gate closes.
---@field fail_message? string Message shown when the gate fails.
---@field moves? integer Non-negative operation cost in moves.
---@field bashing_damage? integer Non-negative damage dealt by the closing gate.

---@class GateDefinition
---@field id string
local GateDefinition = {}

---@param terrain_id string Terrain id usable as a gate wall section.
---@return GateDefinition self
function GateDefinition:wall(terrain_id) end

---@class FaultDefinitionOptions
---@field id string Stable fault id.
---@field fault_type string Fault type id grouping faults by item prefix.
---@field name string Player-facing fault name.
---@field description? string Fault description.
---@field item_prefix? string Prefix added to the affected item name.
---@field item_suffix? string Suffix added to the affected item name.
---@field message? string Message shown when the fault is discovered.
---@field color? string Native color name.
---@field price_modifier? number Item price multiplier; defaults to 1.
---@field degradation_mod? integer Temporary degradation added by the fault.
---@field instant_damage? integer Damage applied when the fault appears.
---@field contact_area_mod? number Contact-area multiplier.
---@field rolling_resistance_mod? number Rolling-resistance multiplier.
---@field vehicle_move_penalty_mod? integer Vehicle move penalty.
---@field encumbrance_mod_flat? integer Flat encumbrance modifier.
---@field encumbrance_mod_mult? number Encumbrance multiplier.
---@field affected_by_degradation? boolean Whether degradation affects the fault.

---@class FaultDefinition
---@field id string
local FaultDefinition = {}

---@param flag_id string Native fault flag id.
---@return FaultDefinition self
function FaultDefinition:flag(flag_id) end

---@param fault_id string Fault id blocked by this fault.
---@return FaultDefinition self
function FaultDefinition:block_fault(fault_id) end

---@param fix_id string Fault-fix id usable on this fault.
---@return FaultDefinition self
function FaultDefinition:fix(fix_id) end

---@class FaultFixDefinitionOptions
---@field id string Stable fault-fix id.
---@field name string Player-facing fix name.
---@field success_msg? string Message shown on a successful fix.
---@field time_seconds? integer Non-negative fix duration in seconds.
---@field mod_damage? integer Damage modifier applied by the fix.
---@field mod_degradation? integer Degradation modifier applied by the fix.

---@class FaultFixDefinition
---@field id string
local FaultFixDefinition = {}

---@param skill_id string Native skill id.
---@param level integer Non-negative minimum skill level.
---@return FaultFixDefinition self
function FaultFixDefinition:requires_skill(skill_id, level) end

---@param fault_id string Fault id removed by the fix.
---@return FaultFixDefinition self
function FaultFixDefinition:removes_fault(fault_id) end

---@param fault_id string Fault id added by the fix.
---@return FaultFixDefinition self
function FaultFixDefinition:adds_fault(fault_id) end

---@class DreamDefinitionOptions
---@field category string Mutation category that triggers the dream.
---@field strength? integer Non-negative category strength required.

---@class DreamDefinition
local DreamDefinition = {}

---@param text string Dream message text.
---@return DreamDefinition self
function DreamDefinition:message(text) end

---@class AchievementDefinitionOptions
---@field id string Stable achievement id.
---@field name string Player-facing achievement name.
---@field description? string Achievement description.
---@field is_conduct? boolean Whether this is a conduct tracked by the legacy conduct UI.

---@class AchievementDefinition
---@field id string
local AchievementDefinition = {}

---@param achievement_id string Achievement id hidden while this one is visible.
---@return AchievementDefinition self
function AchievementDefinition:hidden_by(achievement_id) end

---@class ConductDefinitionOptions
---@field id string Stable conduct id.
---@field name string Player-facing conduct name.
---@field description? string Conduct description.

---@class BlacklistDefinitionOptions
---@field kind 'trait'|'monster' Native blacklist target kind.
---@field whitelist? boolean Whether entries are whitelisted instead.

---@class BlacklistDefinition
local BlacklistDefinition = {}

---@param entry_id string Native id added to the blacklist or whitelist.
---@return BlacklistDefinition self
function BlacklistDefinition:entry(entry_id) end

---@class MapExtraDefinitionOptions
---@field id string Stable map-extra id.
---@field name string Player-facing map-extra name.
---@field description? string Map-extra description.
---@field generator_id? string Native generator id; empty means no generator.
---@field symbol? string Single map symbol character.
---@field color? string Native color name.

---@class MapExtraDefinition
---@field id string
local MapExtraDefinition = {}

---@param flag_id string Native map-extra flag id.
---@return MapExtraDefinition self
function MapExtraDefinition:flag(flag_id) end

---@class WeatherGeneratorDefinitionOptions
---@field id string Stable weather-generator id.
---@field base_temperature? number Base temperature.
---@field base_humidity? number Base humidity.
---@field base_pressure? number Base pressure.
---@field base_wind? number Base wind speed.
---@field base_wind_distrib_peaks? integer Non-negative wind distribution peaks.
---@field summer_temp_manual_mod? integer Summer temperature modifier.
---@field spring_temp_manual_mod? integer Spring temperature modifier.
---@field autumn_temp_manual_mod? integer Autumn temperature modifier.
---@field winter_temp_manual_mod? integer Winter temperature modifier.
---@field spring_humidity_manual_mod? integer Spring humidity modifier.
---@field summer_humidity_manual_mod? integer Summer humidity modifier.
---@field autumn_humidity_manual_mod? integer Autumn humidity modifier.
---@field winter_humidity_manual_mod? integer Winter humidity modifier.

---@class WeatherGeneratorDefinition
---@field id string
local WeatherGeneratorDefinition = {}

---@param weather_id string Weather type id excluded from this generator.
---@return WeatherGeneratorDefinition self
function WeatherGeneratorDefinition:blacklisted_weather(weather_id) end

---@param weather_id string Weather type id forced into this generator.
---@return WeatherGeneratorDefinition self
function WeatherGeneratorDefinition:whitelisted_weather(weather_id) end

---@class MigrationDefinitionOptions
---@field kind 'bionic'|'effect'|'field_type'|'furniture'|'oter'|'overmap_special'|'proficiency'|'terrain'|'trap'|'var'|'vehicle_part' Native migration target kind.
---@field from string Legacy id being migrated.
---@field to? string New id; empty means removed.

---@class MigrationDefinition
local MigrationDefinition = {}

---@class TraitGroupDefinitionOptions
---@field id string Stable trait-group id.

---@class TraitGroupDefinition
---@field id string
local TraitGroupDefinition = {}

---@class MonsterAdjustmentDefinitionOptions
---@field species string Native species id adjusted by this entry.
---@field stat? string Stat name adjusted (speed, hp, armor...).
---@field stat_adjust? number Stat multiplier; defaults to 1.
---@field flag? string Monster flag toggled by this entry.
---@field flag_val? boolean Flag value; defaults to false.
---@field special? string Special attack adjusted by this entry.

---@class MonsterAdjustmentDefinition
local MonsterAdjustmentDefinition = {}

---@param trait_id string Native trait id weighted by this group.
---@param weight integer Positive weight.
---@param variant? string Native mutation variant id.
---@return TraitGroupDefinition self
function TraitGroupDefinition:trait(trait_id, weight, variant) end

---@param group_id string Existing trait-group id.
---@param weight integer Positive weight.
---@return TraitGroupDefinition self
function TraitGroupDefinition:group(group_id, weight) end

---@class ShopkeeperEntryOptions
---@field item? string Item id matched by this entry.
---@field category? string Item-category id matched by this entry.
---@field item_group? string Item-group id matched by this entry.
---@field message? string Message shown when the entry matches.

---@class ShopkeeperDefinitionOptions
---@field id string Stable shopkeeper rule id.
---@field message? string Override message shown when entries match.
---@field default_rate? integer Default consumption rate.
---@field predicate? string Named boolean handler for a dynamic whitelist; receives a detached ShopkeeperWhitelistPayload.

---@class ShopkeeperWhitelistPayload
---@field item table Detached item fields: id, category_id, comestible, food, medication, base_enjoyment, fresh, going_bad, and rotten.
---@field shopkeeper table Detached NPC fields: name, class_id, and faction_id.

---@class ShopkeeperDefinition
---@field id string
local ShopkeeperDefinition = {}

---@param item string Item id matched by this entry.
---@param category string Item-category id matched by this entry.
---@param item_group string Item-group id matched by this entry.
---@param message string Message shown when the entry matches.
---@return ShopkeeperDefinition self
function ShopkeeperDefinition:entry(item, category, item_group, message) end

---@class MagicTypeDefinitionOptions
---@field id string Stable magic-system id.
---@field energy? 'hp'|'mana'|'stamina'|'bionic'|'vitamin'|'none' Native resource consumed by spells; defaults to none.
---@field vitamin? string Required native Vitamin id when energy is vitamin.
---@field energy_color? string Native color name used for the resource display; defaults to cyan.
---@field cannot_cast_message? string Message shown when a casting restriction is active.
---@field max_book_level? integer Maximum level learnable from books; omitted means no type-level override.
---@field failure_cost_fraction? number Non-negative default fraction of the successful spell cost paid on failure.
---@field failure_experience_fraction? number Non-negative default fraction of casting experience awarded on failure.

---@class MagicTypeDefinition
---@field id string
local MagicTypeDefinition = {}

---@param flag_id string Character flag that prevents casting spells of this type.
---@return MagicTypeDefinition self
function MagicTypeDefinition:cannot_cast_when(flag_id) end

---@param level_for_experience_handler string Named handler receiving `{ magic_type_id, spell_id, phase, input, experience, caster }` and returning a non-negative level.
---@param experience_for_level_handler string Named handler receiving `{ magic_type_id, spell_id, phase, input, level, caster }` and returning non-negative required experience.
---@return MagicTypeDefinition self
function MagicTypeDefinition:progression(level_for_experience_handler, experience_for_level_handler) end

---@param handler_id string Named handler returning non-negative casting experience from `{ magic_type_id, spell_id, phase, caster }`.
---@return MagicTypeDefinition self
function MagicTypeDefinition:casting_experience(handler_id) end

---@param handler_id string Named handler returning a failure chance from zero through one.
---@return MagicTypeDefinition self
function MagicTypeDefinition:failure_chance(handler_id) end

---@param handler_id string Named handler returning a non-negative failed-cast cost fraction.
---@return MagicTypeDefinition self
function MagicTypeDefinition:failure_cost(handler_id) end

---@param handler_id string Named handler returning a non-negative failed-cast experience fraction.
---@return MagicTypeDefinition self
function MagicTypeDefinition:failure_experience(handler_id) end

---@param handler_id string Named side-effect handler receiving `{ magic_type_id, spell_id, caster }` after a cast fails.
---@return MagicTypeDefinition self
function MagicTypeDefinition:on_failure(handler_id) end

---@class MovementModeDefinitionOptions
---@field id string Stable movement-mode id.
---@field name? string Player-facing mode name; defaults to id.
---@field kind? 'prone'|'crouching'|'walking'|'running' Native posture/movement category.
---@field character_symbol string Exactly one Unicode codepoint used in character state.
---@field panel_symbol string Exactly one Unicode codepoint used by the movement panel.
---@field panel_color? string Native panel color; defaults to white.
---@field symbol_color? string Native character-symbol color; defaults to white.
---@field exertion? number Non-negative metabolic activity level; defaults to 1.
---@field riding_exertion? number Non-negative metabolic level while riding; defaults to zero.
---@field stamina_multiplier? number Non-negative stamina cost multiplier; defaults to one.
---@field sound_multiplier? number Non-negative movement sound multiplier; defaults to one.
---@field speed_multiplier? number Positive movement-speed multiplier; defaults to one.
---@field mech_power_kilojoules? integer Non-negative mech energy cost; defaults to two.
---@field swim_speed_modifier? integer Native swim-speed adjustment; defaults to zero.
---@field stop_hauling? boolean Whether entering the mode stops hauling.

---@class MovementModeMessageOptions
---@field prepare string Message shown while preparing to change mode.
---@field success string Message shown after a successful change.
---@field failure? string Message shown after a failed change.

---@class MovementModeDefinition
---@field id string
local MovementModeDefinition = {}

---@param steed 'none'|'animal'|'mech'
---@param options MovementModeMessageOptions
---@return MovementModeDefinition self
function MovementModeDefinition:messages(steed, options) end

---@class RegionSettingsRavineDefinitionOptions
---@field id string Stable region settings ravine id.
---@field num_ravines? integer Number of ravines; defaults to 0.
---@field ravine_range? integer Ravine range; defaults to 45.
---@field ravine_width? integer Ravine width; defaults to 1.
---@field ravine_depth? integer Ravine depth; defaults to -3.

---@class RegionSettingsRavineDefinition
---@field id string
local RegionSettingsRavineDefinition = {}

---@param count integer
---@return RegionSettingsRavineDefinition self
function RegionSettingsRavineDefinition:num_ravines(count) end

---@param range integer
---@return RegionSettingsRavineDefinition self
function RegionSettingsRavineDefinition:ravine_range(range) end

---@param width integer
---@return RegionSettingsRavineDefinition self
function RegionSettingsRavineDefinition:ravine_width(width) end

---@param depth integer
---@return RegionSettingsRavineDefinition self
function RegionSettingsRavineDefinition:ravine_depth(depth) end

---@class RegionSettingsLakeAliasOptions
---@field om_terrain string Overmap terrain id or prefix.
---@field alias string Alias overmap terrain id.
---@field om_terrain_match_type? 'exact'|'type'|'subtype'|'prefix'|'contains' Match type; defaults to exact. Legacy uppercase spellings are also accepted.

---@class RegionSettingsLakeDefinitionOptions
---@field id string Stable region settings lake id.
---@field noise_threshold_lake? number Lake noise threshold; defaults to 0.25.
---@field lake_size_min? integer Minimum lake size; defaults to 20.
---@field lake_depth? integer Lake depth; defaults to -5.
---@field invert_lakes? boolean Whether to invert lakes; defaults to false.
---@field surface? string Surface terrain id; defaults to "lake_surface".
---@field surface_ter? string Surface terrain id; alias for surface.
---@field shore? string Shore terrain id; defaults to "lake_shore".
---@field shore_ter? string Shore terrain id; alias for shore.
---@field interior? string Interior terrain id; defaults to "lake_water_cube".
---@field interior_ter? string Interior terrain id; alias for interior.
---@field bed? string Bed terrain id; defaults to "lake_bed".
---@field bed_ter? string Bed terrain id; alias for bed.
---@field shore_extendable_overmap_terrain? string[] Overmap terrains allowed for shore extension.
---@field shore_extendable_overmap_terrain_aliases? RegionSettingsLakeAliasOptions[] Overmap terrain aliases.

---@class RegionSettingsLakeDefinition
---@field id string
local RegionSettingsLakeDefinition = {}

---@param threshold number
---@return RegionSettingsLakeDefinition self
function RegionSettingsLakeDefinition:noise_threshold_lake(threshold) end

---@param size integer
---@return RegionSettingsLakeDefinition self
function RegionSettingsLakeDefinition:lake_size_min(size) end

---@param depth integer
---@return RegionSettingsLakeDefinition self
function RegionSettingsLakeDefinition:lake_depth(depth) end

---@param invert boolean
---@return RegionSettingsLakeDefinition self
function RegionSettingsLakeDefinition:invert_lakes(invert) end

---@param terrain string
---@return RegionSettingsLakeDefinition self
function RegionSettingsLakeDefinition:surface_ter(terrain) end

---@param terrain string
---@return RegionSettingsLakeDefinition self
function RegionSettingsLakeDefinition:shore_ter(terrain) end

---@param terrain string
---@return RegionSettingsLakeDefinition self
function RegionSettingsLakeDefinition:interior_ter(terrain) end

---@param terrain string
---@return RegionSettingsLakeDefinition self
function RegionSettingsLakeDefinition:bed_ter(terrain) end

---@param terrain string
---@return RegionSettingsLakeDefinition self
function RegionSettingsLakeDefinition:shore_extendable_terrain(terrain) end

---@param options_or_terrain RegionSettingsLakeAliasOptions|string Alias options, or the source overmap terrain for the positional form.
---@param alias? string Required alias terrain when using the positional form.
---@param match_type? 'exact'|'type'|'subtype'|'prefix'|'contains' Optional positional match type; legacy uppercase spellings are accepted.
---@return RegionSettingsLakeDefinition self
function RegionSettingsLakeDefinition:shore_extendable_alias(options_or_terrain, alias, match_type) end

---@class RegionSettingsOceanDefinitionOptions
---@field id string Stable region settings ocean id.
---@field noise_threshold_ocean? number Ocean noise threshold; defaults to 0.25.
---@field ocean_size_min? integer Minimum ocean size; defaults to 100.
---@field ocean_depth? integer Ocean depth; defaults to -9.
---@field ocean_start_north? integer Distance to north edge; optional.
---@field ocean_start_east? integer Distance to east edge; optional.
---@field ocean_start_west? integer Distance to west edge; optional.
---@field ocean_start_south? integer Distance to south edge; optional.
---@field sandy_beach_width? integer Sandy beach width; defaults to 2.

---@class RegionSettingsOceanDefinition
---@field id string
local RegionSettingsOceanDefinition = {}

---@param threshold number
---@return RegionSettingsOceanDefinition self
function RegionSettingsOceanDefinition:noise_threshold_ocean(threshold) end

---@param size integer
---@return RegionSettingsOceanDefinition self
function RegionSettingsOceanDefinition:ocean_size_min(size) end

---@param depth integer
---@return RegionSettingsOceanDefinition self
function RegionSettingsOceanDefinition:ocean_depth(depth) end

---@param distance integer|nil Pass nil to clear the optional distance.
---@return RegionSettingsOceanDefinition self
function RegionSettingsOceanDefinition:ocean_start_north(distance) end

---@param distance integer|nil Pass nil to clear the optional distance.
---@return RegionSettingsOceanDefinition self
function RegionSettingsOceanDefinition:ocean_start_east(distance) end

---@param distance integer|nil Pass nil to clear the optional distance.
---@return RegionSettingsOceanDefinition self
function RegionSettingsOceanDefinition:ocean_start_west(distance) end

---@param distance integer|nil Pass nil to clear the optional distance.
---@return RegionSettingsOceanDefinition self
function RegionSettingsOceanDefinition:ocean_start_south(distance) end

---@param width integer
---@return RegionSettingsOceanDefinition self
function RegionSettingsOceanDefinition:sandy_beach_width(width) end

---@class RegionSettingsForestDefinitionOptions
---@field id string Stable region settings forest id.
---@field noise_threshold_forest? number Forest noise threshold; defaults to 0.25.
---@field noise_threshold_forest_thick? number Thick forest noise threshold; defaults to 0.3.
---@field noise_threshold_swamp_adjacent_water? number Swamp adjacent water noise threshold; defaults to 0.3.
---@field noise_threshold_swamp_isolated? number Isolated swamp noise threshold; defaults to 0.6.
---@field river_floodplain_buffer_distance_min? integer Minimum floodplain buffer distance; defaults to 3.
---@field river_floodplain_buffer_distance_max? integer Maximum floodplain buffer distance; defaults to 15.
---@field forest_threshold_limit? number Forest threshold limit (max_forest); defaults to 0.395.
---@field max_forest? number Forest threshold limit; alias for forest_threshold_limit.
---@field forest_threshold_increase? number[] Forest threshold increase array of 4 floats; defaults to {0, 0, 0, 0}.

---@class RegionSettingsForestDefinition
---@field id string
local RegionSettingsForestDefinition = {}

---@param threshold number
---@return RegionSettingsForestDefinition self
function RegionSettingsForestDefinition:noise_threshold_forest(threshold) end

---@param threshold number
---@return RegionSettingsForestDefinition self
function RegionSettingsForestDefinition:noise_threshold_forest_thick(threshold) end

---@param threshold number
---@return RegionSettingsForestDefinition self
function RegionSettingsForestDefinition:noise_threshold_swamp_adjacent_water(threshold) end

---@param threshold number
---@return RegionSettingsForestDefinition self
function RegionSettingsForestDefinition:noise_threshold_swamp_isolated(threshold) end

---@param distance integer
---@return RegionSettingsForestDefinition self
function RegionSettingsForestDefinition:river_floodplain_buffer_distance_min(distance) end

---@param distance integer
---@return RegionSettingsForestDefinition self
function RegionSettingsForestDefinition:river_floodplain_buffer_distance_max(distance) end

---@param limit number
---@return RegionSettingsForestDefinition self
function RegionSettingsForestDefinition:forest_threshold_limit(limit) end

---@param increase number[]
---@return RegionSettingsForestDefinition self
function RegionSettingsForestDefinition:forest_threshold_increase(increase) end

---@class RegionSettingsRiverDefinitionOptions
---@field id string Stable region settings river id.
---@field river_scale? integer River scale; defaults to 1.
---@field river_frequency? number River frequency; defaults to 1.5.
---@field river_branch_chance? number River branch chance; defaults to 64.0.
---@field river_branch_remerge_chance? number River branch remerge chance; defaults to 4.0.
---@field river_branch_scale_decrease? number River branch scale decrease; defaults to 1.0.

---@class RegionSettingsRiverDefinition
---@field id string
local RegionSettingsRiverDefinition = {}

---@param scale integer
---@return RegionSettingsRiverDefinition self
function RegionSettingsRiverDefinition:river_scale(scale) end

---@param frequency number
---@return RegionSettingsRiverDefinition self
function RegionSettingsRiverDefinition:river_frequency(frequency) end

---@param chance number
---@return RegionSettingsRiverDefinition self
function RegionSettingsRiverDefinition:river_branch_chance(chance) end

---@param chance number
---@return RegionSettingsRiverDefinition self
function RegionSettingsRiverDefinition:river_branch_remerge_chance(chance) end

---@param decrease number
---@return RegionSettingsRiverDefinition self
function RegionSettingsRiverDefinition:river_branch_scale_decrease(decrease) end

---@class RegionSettingsForestMapgenDefinitionOptions
---@field id string Stable region settings forest mapgen id.
---@field biomes? string[] Forest biome mapgen ids; defaults to {}.

---@class RegionSettingsForestMapgenDefinition
---@field id string
local RegionSettingsForestMapgenDefinition = {}

---@param biome_id string
---@return RegionSettingsForestMapgenDefinition self
function RegionSettingsForestMapgenDefinition:biome(biome_id) end

---@param biomes string[]
---@return RegionSettingsForestMapgenDefinition self
function RegionSettingsForestMapgenDefinition:biomes(biomes) end

---@class RegionSettingsMapExtrasDefinitionOptions
---@field id string Stable region settings map extras id.
---@field extras? string[] Map extra collection ids; defaults to {}.

---@class RegionSettingsMapExtrasDefinition
---@field id string
local RegionSettingsMapExtrasDefinition = {}

---@param extra_id string
---@return RegionSettingsMapExtrasDefinition self
function RegionSettingsMapExtrasDefinition:extra(extra_id) end

---@param extras string[]
---@return RegionSettingsMapExtrasDefinition self
function RegionSettingsMapExtrasDefinition:extras(extras) end

---@class RegionSettingsTerrainFurnitureDefinitionOptions
---@field id string Stable region settings terrain furniture id.
---@field ter_furn? string[] Region terrain furniture ids; defaults to {}.

---@class RegionSettingsTerrainFurnitureDefinition
---@field id string
local RegionSettingsTerrainFurnitureDefinition = {}

---@param tf_id string
---@return RegionSettingsTerrainFurnitureDefinition self
function RegionSettingsTerrainFurnitureDefinition:terrain_furniture(tf_id) end

---@param ter_furn string[]
---@return RegionSettingsTerrainFurnitureDefinition self
function RegionSettingsTerrainFurnitureDefinition:ter_furn(ter_furn) end

---@alias PlatformWeightedEntry string|[string, integer]

---@class RegionSettingsForestTrailDefinitionOptions
---@field id string Stable region settings forest trail id.
---@field chance? integer Forest trail chance; defaults to 1.
---@field border_point_chance? integer Border point chance; defaults to 2.
---@field minimum_forest_size? integer Minimum forest size; defaults to 50.
---@field random_point_min? integer Random point min; defaults to 4.
---@field random_point_max? integer Random point max; defaults to 50.
---@field random_point_size_scalar? integer Random point size scalar; defaults to 100.
---@field trailhead_chance? integer Trailhead chance; defaults to 1.
---@field trailhead_road_distance? integer Trailhead road distance; defaults to 6.
---@field trailheads? PlatformWeightedEntry[] Trailheads; duplicate ids replace the prior weight.

---@class RegionSettingsForestTrailDefinition
---@field id string
local RegionSettingsForestTrailDefinition = {}

---@param value integer
---@return RegionSettingsForestTrailDefinition self
function RegionSettingsForestTrailDefinition:chance(value) end

---@param value integer
---@return RegionSettingsForestTrailDefinition self
function RegionSettingsForestTrailDefinition:border_point_chance(value) end

---@param value integer
---@return RegionSettingsForestTrailDefinition self
function RegionSettingsForestTrailDefinition:minimum_forest_size(value) end

---@param value integer
---@return RegionSettingsForestTrailDefinition self
function RegionSettingsForestTrailDefinition:random_point_min(value) end

---@param value integer
---@return RegionSettingsForestTrailDefinition self
function RegionSettingsForestTrailDefinition:random_point_max(value) end

---@param value integer
---@return RegionSettingsForestTrailDefinition self
function RegionSettingsForestTrailDefinition:random_point_size_scalar(value) end

---@param value integer
---@return RegionSettingsForestTrailDefinition self
function RegionSettingsForestTrailDefinition:trailhead_chance(value) end

---@param value integer
---@return RegionSettingsForestTrailDefinition self
function RegionSettingsForestTrailDefinition:trailhead_road_distance(value) end

---@param special_id string Overmap special id.
---@param weight integer Positive weight.
---@return RegionSettingsForestTrailDefinition self
function RegionSettingsForestTrailDefinition:trailhead(special_id, weight) end

---@param special_id string Overmap special id.
---@param weight integer Positive weight.
---@return RegionSettingsForestTrailDefinition self
function RegionSettingsForestTrailDefinition:add_trailhead(special_id, weight) end

---@class RegionSettingsHighwayDefinitionOptions
---@field id string Stable region settings highway id.
---@field width_of_segments? integer Width of segments; defaults to 2.
---@field straightness_chance? number Straightness chance; defaults to 0.6.
---@field reserved_terrain_id? string Reserved terrain id.
---@field reserved_terrain_water_id? string Reserved terrain water id.
---@field segment_flat_special? string Segment flat special.
---@field segment_ramp_special? string Segment ramp special.
---@field segment_road_bridge_special? string Segment road bridge special.
---@field segment_bridge_special? string Segment bridge special.
---@field segment_bridge_supports_special? string Segment bridge supports special.
---@field segment_overpass_special? string Segment overpass special.
---@field clockwise_slant_special? string Clockwise slant special.
---@field counterclockwise_slant_special? string Counterclockwise slant special.
---@field fallback_onramp_special? string Fallback onramp special.
---@field fallback_bend_special? string Fallback bend special.
---@field fallback_three_way_intersection_special? string Fallback three way intersection special.
---@field fallback_four_way_intersection_special? string Fallback four way intersection special.
---@field fallback_supports? string Fallback supports.
---@field four_way_intersections? PlatformWeightedEntry[] Four way intersections; duplicate ids replace weights.
---@field three_way_intersections? PlatformWeightedEntry[] Three way intersections; duplicate ids replace weights.
---@field bends? PlatformWeightedEntry[] Bends; duplicate ids replace weights.
---@field road_connections? PlatformWeightedEntry[] Road connections; duplicate ids replace weights.
---@field interchanges? PlatformWeightedEntry[] Interchanges; duplicate ids replace weights.

---@class RegionSettingsHighwayDefinition
---@field id string
local RegionSettingsHighwayDefinition = {}

---@param value integer
---@return RegionSettingsHighwayDefinition self
function RegionSettingsHighwayDefinition:width_of_segments(value) end

---@param value number
---@return RegionSettingsHighwayDefinition self
function RegionSettingsHighwayDefinition:straightness_chance(value) end

---@param value string
---@return RegionSettingsHighwayDefinition self
function RegionSettingsHighwayDefinition:reserved_terrain_id(value) end

---@param value string
---@return RegionSettingsHighwayDefinition self
function RegionSettingsHighwayDefinition:reserved_terrain_water_id(value) end

---@param value string
---@return RegionSettingsHighwayDefinition self
function RegionSettingsHighwayDefinition:segment_flat_special(value) end

---@param value string
---@return RegionSettingsHighwayDefinition self
function RegionSettingsHighwayDefinition:segment_ramp_special(value) end

---@param value string
---@return RegionSettingsHighwayDefinition self
function RegionSettingsHighwayDefinition:segment_road_bridge_special(value) end

---@param value string
---@return RegionSettingsHighwayDefinition self
function RegionSettingsHighwayDefinition:segment_bridge_special(value) end

---@param value string
---@return RegionSettingsHighwayDefinition self
function RegionSettingsHighwayDefinition:segment_bridge_supports_special(value) end

---@param value string
---@return RegionSettingsHighwayDefinition self
function RegionSettingsHighwayDefinition:segment_overpass_special(value) end

---@param value string
---@return RegionSettingsHighwayDefinition self
function RegionSettingsHighwayDefinition:clockwise_slant_special(value) end

---@param value string
---@return RegionSettingsHighwayDefinition self
function RegionSettingsHighwayDefinition:counterclockwise_slant_special(value) end

---@param value string
---@return RegionSettingsHighwayDefinition self
function RegionSettingsHighwayDefinition:fallback_onramp_special(value) end

---@param value string
---@return RegionSettingsHighwayDefinition self
function RegionSettingsHighwayDefinition:fallback_bend_special(value) end

---@param value string
---@return RegionSettingsHighwayDefinition self
function RegionSettingsHighwayDefinition:fallback_three_way_intersection_special(value) end

---@param value string
---@return RegionSettingsHighwayDefinition self
function RegionSettingsHighwayDefinition:fallback_four_way_intersection_special(value) end

---@param value string
---@return RegionSettingsHighwayDefinition self
function RegionSettingsHighwayDefinition:fallback_supports(value) end

---@param special_id string Overmap special id.
---@param weight integer Positive weight.
---@return RegionSettingsHighwayDefinition self
function RegionSettingsHighwayDefinition:four_way_intersection(special_id, weight) end

---@param special_id string Overmap special id.
---@param weight integer Positive weight.
---@return RegionSettingsHighwayDefinition self
function RegionSettingsHighwayDefinition:three_way_intersection(special_id, weight) end

---@param special_id string Overmap special id.
---@param weight integer Positive weight.
---@return RegionSettingsHighwayDefinition self
function RegionSettingsHighwayDefinition:bend(special_id, weight) end

---@param special_id string Overmap special id.
---@param weight integer Positive weight.
---@return RegionSettingsHighwayDefinition self
function RegionSettingsHighwayDefinition:road_connection(special_id, weight) end

---@param special_id string Overmap special id.
---@param weight integer Positive weight.
---@return RegionSettingsHighwayDefinition self
function RegionSettingsHighwayDefinition:interchange(special_id, weight) end

---@class RegionSettingsFeatureFlagOptions
---@field blacklist? string[] Overmap feature flags excluded in this region.
---@field whitelist? string[] Overmap feature flags allowed in this region.

---@class RegionSettingsConnectionOptions
---@field trail_connection? string Overmap connection id used for trails.
---@field sewer_connection? string Overmap connection id used for sewers.
---@field subway_connection? string Overmap connection id used for subways.
---@field rail_connection? string Overmap connection id used for rails.
---@field intra_city_road_connection? string Overmap connection id used within cities.
---@field inter_city_road_connection? string Overmap connection id used between cities.

---@class RegionSettingsDefinitionOptions
---@field id string Stable region settings id.
---@field default_oter? string[] Exactly 21 overmap terrain ids ordered from highest z-level to lowest.
---@field default_groundcover? PlatformWeightedEntry[] Weighted terrain ids.
---@field cities string Region settings city id.
---@field forest_composition? string Region settings forest mapgen id.
---@field forest_trails? string Region settings forest trail id.
---@field weather? string Weather generator id.
---@field forests? string Region settings forest id.
---@field rivers? string Region settings river id.
---@field lakes? string Region settings lake id.
---@field ocean? string Region settings ocean id.
---@field highways? string Region settings highway id.
---@field ravines? string Region settings ravine id.
---@field map_extras? string Region settings map extras id.
---@field terrain_furniture? string Region settings terrain furniture id.
---@field feature_flag_settings? RegionSettingsFeatureFlagOptions
---@field connections? RegionSettingsConnectionOptions
---@field place_swamps? boolean Whether swamp placement is enabled; defaults to true.
---@field place_roads? boolean Whether road placement is enabled; defaults to true.
---@field place_railroads? boolean Whether railroad placement is enabled; defaults to false.
---@field place_railroads_before_roads? boolean Whether railroads are placed before roads; defaults to false.
---@field place_specials? boolean Whether overmap special placement is enabled; defaults to true.
---@field neighbor_connections? boolean Whether connections may continue into neighboring overmaps; defaults to true.
---@field max_urbanity? number Maximum urbanity; defaults to 8.
---@field urbanity_increase? number[] Exactly four north/east/south/west increases.

---@class RegionSettingsDefinition
---@field id string
local RegionSettingsDefinition = {}

---@param values string[] Exactly 21 overmap terrain ids ordered from highest z-level to lowest.
---@return RegionSettingsDefinition self
function RegionSettingsDefinition:default_oter(values) end

---@param values PlatformWeightedEntry[]
---@return RegionSettingsDefinition self
function RegionSettingsDefinition:default_groundcover(values) end

---@param terrain_id string
---@param weight integer
---@return RegionSettingsDefinition self
function RegionSettingsDefinition:groundcover(terrain_id, weight) end

---@param flag string
---@return RegionSettingsDefinition self
function RegionSettingsDefinition:feature_blacklisted(flag) end

---@param flag string
---@return RegionSettingsDefinition self
function RegionSettingsDefinition:feature_whitelisted(flag) end

---@param value string
---@return RegionSettingsDefinition self
function RegionSettingsDefinition:cities(value) end

---@param value string
---@return RegionSettingsDefinition self
function RegionSettingsDefinition:forest_composition(value) end

---@param value string
---@return RegionSettingsDefinition self
function RegionSettingsDefinition:forest_trails(value) end

---@param value string
---@return RegionSettingsDefinition self
function RegionSettingsDefinition:weather(value) end

---@param value string
---@return RegionSettingsDefinition self
function RegionSettingsDefinition:forests(value) end

---@param value string
---@return RegionSettingsDefinition self
function RegionSettingsDefinition:rivers(value) end

---@param value string
---@return RegionSettingsDefinition self
function RegionSettingsDefinition:lakes(value) end

---@param value string
---@return RegionSettingsDefinition self
function RegionSettingsDefinition:ocean(value) end

---@param value string
---@return RegionSettingsDefinition self
function RegionSettingsDefinition:highways(value) end

---@param value string
---@return RegionSettingsDefinition self
function RegionSettingsDefinition:ravines(value) end

---@param value string
---@return RegionSettingsDefinition self
function RegionSettingsDefinition:map_extras(value) end

---@param value string
---@return RegionSettingsDefinition self
function RegionSettingsDefinition:terrain_furniture(value) end

---@param value string
---@return RegionSettingsDefinition self
function RegionSettingsDefinition:trail_connection(value) end

---@param value string
---@return RegionSettingsDefinition self
function RegionSettingsDefinition:sewer_connection(value) end

---@param value string
---@return RegionSettingsDefinition self
function RegionSettingsDefinition:subway_connection(value) end

---@param value string
---@return RegionSettingsDefinition self
function RegionSettingsDefinition:rail_connection(value) end

---@param value string
---@return RegionSettingsDefinition self
function RegionSettingsDefinition:intra_city_road_connection(value) end

---@param value string
---@return RegionSettingsDefinition self
function RegionSettingsDefinition:inter_city_road_connection(value) end

---@param value boolean
---@return RegionSettingsDefinition self
function RegionSettingsDefinition:place_swamps(value) end

---@param value boolean
---@return RegionSettingsDefinition self
function RegionSettingsDefinition:place_roads(value) end

---@param value boolean
---@return RegionSettingsDefinition self
function RegionSettingsDefinition:place_railroads(value) end

---@param value boolean
---@return RegionSettingsDefinition self
function RegionSettingsDefinition:place_railroads_before_roads(value) end

---@param value boolean
---@return RegionSettingsDefinition self
function RegionSettingsDefinition:place_specials(value) end

---@param value boolean
---@return RegionSettingsDefinition self
function RegionSettingsDefinition:neighbor_connections(value) end

---@param value number
---@return RegionSettingsDefinition self
function RegionSettingsDefinition:max_urbanity(value) end

---@param values number[] Exactly four north/east/south/west increases.
---@return RegionSettingsDefinition self
function RegionSettingsDefinition:urbanity_increase(values) end

---@alias OptionSliderValueType "int"|"float"|"bool"|"string"

---@class OptionSliderOption
---@field option string Engine option id.
---@field type OptionSliderValueType Native option value type.
---@field value integer|number|boolean|string Typed option value.

---@class OptionSliderLevel
---@field level integer Dense zero-based level number.
---@field name string Display name.
---@field description? string Optional display description.
---@field options? OptionSliderOption[] Options applied by this level.

---@class OptionSliderDefinitionOptions
---@field id string Stable option slider id.
---@field name string Display name.
---@field context? string Option-page context.
---@field default_level? integer Default level; defaults to zero.
---@field levels OptionSliderLevel[] One or more densely numbered levels.

---@class OptionSliderDefinition
---@field id string
local OptionSliderDefinition = {}

---@param value string
---@return OptionSliderDefinition self
function OptionSliderDefinition:name(value) end

---@param value string
---@return OptionSliderDefinition self
function OptionSliderDefinition:context(value) end

---@param value integer
---@return OptionSliderDefinition self
function OptionSliderDefinition:default_level(value) end

---@param values OptionSliderLevel[]
---@return OptionSliderDefinition self
function OptionSliderDefinition:levels(values) end

---@param value OptionSliderLevel Adds or replaces the matching numeric level.
---@return OptionSliderDefinition self
function OptionSliderDefinition:level(value) end

---@class DimensionRegionLayoutDefinitionOptions
---@field id string Stable dimension region-layout id.
---@field generation_mode? "UNIFORM" The currently supported native generation mode.
---@field uniform_region string Region-settings id used by every generated overmap.

---@class DimensionRegionLayoutDefinition
---@field id string
local DimensionRegionLayoutDefinition = {}

---@param value "UNIFORM"
---@return DimensionRegionLayoutDefinition self
function DimensionRegionLayoutDefinition:generation_mode(value) end

---@param value string Region-settings id.
---@return DimensionRegionLayoutDefinition self
function DimensionRegionLayoutDefinition:uniform_region(value) end

---@class DimensionDefinitionOptions
---@field id string Stable dimension id.
---@field region_layout string Dimension region-layout id.

---@class DimensionDefinition
---@field id string
local DimensionDefinition = {}

---@param value string Dimension region-layout id.
---@return DimensionDefinition self
function DimensionDefinition:region_layout(value) end

---@class OmtPlaceholderDefinitionOptions
---@field id string Stable overmap terrain placeholder id.
---@field grid string[] Exactly 24 strings of 24 binary cells (`0` or `1`).

---@class OmtPlaceholderDefinition
---@field id string
local OmtPlaceholderDefinition = {}

---@param values string[] Exactly 24 strings of 24 binary cells (`0` or `1`).
---@return OmtPlaceholderDefinition self
function OmtPlaceholderDefinition:grid(values) end

---@class RegionTerrainFurnitureDefinitionOptions
---@field id string Stable region terrain furniture id.
---@field ter_id? string Target terrain id.
---@field furn_id? string Target furniture id.
---@field replace_with_terrain? PlatformWeightedEntry[] Replacement terrains; duplicate ids replace weights.
---@field replace_with_furniture? PlatformWeightedEntry[] Replacement furniture; duplicate ids replace weights.

---@class RegionTerrainFurnitureDefinition
---@field id string
local RegionTerrainFurnitureDefinition = {}

---@param value string
---@return RegionTerrainFurnitureDefinition self
function RegionTerrainFurnitureDefinition:ter_id(value) end

---@param value string
---@return RegionTerrainFurnitureDefinition self
function RegionTerrainFurnitureDefinition:furn_id(value) end

---@param terrain_id string Terrain id.
---@param weight integer Positive weight.
---@return RegionTerrainFurnitureDefinition self
function RegionTerrainFurnitureDefinition:replace_terrain(terrain_id, weight) end

---@param terrain_id string Terrain id.
---@param weight integer Positive weight.
---@return RegionTerrainFurnitureDefinition self
function RegionTerrainFurnitureDefinition:replace_with_terrain(terrain_id, weight) end

---@param furniture_id string Furniture id.
---@param weight integer Positive weight.
---@return RegionTerrainFurnitureDefinition self
function RegionTerrainFurnitureDefinition:replace_furniture(furniture_id, weight) end

---@param furniture_id string Furniture id.
---@param weight integer Positive weight.
---@return RegionTerrainFurnitureDefinition self
function RegionTerrainFurnitureDefinition:replace_with_furniture(furniture_id, weight) end

---@class ForestBiomeComponentDefinitionOptions
---@field id string Stable forest biome component id.
---@field chance? integer Feature chance; defaults to 0.
---@field sequence? integer Feature sequence; defaults to 0.
---@field types? PlatformWeightedEntry[] Component types; duplicate ids replace weights.

---@class ForestBiomeComponentDefinition
---@field id string
local ForestBiomeComponentDefinition = {}

---@param value integer
---@return ForestBiomeComponentDefinition self
function ForestBiomeComponentDefinition:chance(value) end

---@param value integer
---@return ForestBiomeComponentDefinition self
function ForestBiomeComponentDefinition:sequence(value) end

---@param ter_furn_id string Terrain, furniture, or region terrain furniture id.
---@param weight integer Positive weight.
---@return ForestBiomeComponentDefinition self
function ForestBiomeComponentDefinition:type(ter_furn_id, weight) end

---@param ter_furn_id string Terrain, furniture, or region terrain furniture id.
---@param weight integer Positive weight.
---@return ForestBiomeComponentDefinition self
function ForestBiomeComponentDefinition:add_type(ter_furn_id, weight) end

---@class CityDefinitionOptions
---@field id string Stable city id.
---@field database_id integer Native city database id.
---@field name? string City name; defaults to empty.
---@field population? integer Population; defaults to 0.
---@field size? integer Size; defaults to -1.
---@field pos_om integer[]|{x: integer, y: integer} Overmap coordinate [x, y].
---@field pos integer[]|{x: integer, y: integer} Overmap-terrain coordinate [x, y].

---@class CityDefinition
---@field id string
local CityDefinition = {}

---@param value integer
---@return CityDefinition self
function CityDefinition:database_id(value) end

---@param value string
---@return CityDefinition self
function CityDefinition:name(value) end

---@param value integer Non-negative population.
---@return CityDefinition self
function CityDefinition:population(value) end

---@param value integer Size >= -1.
---@return CityDefinition self
function CityDefinition:size(value) end

---@param x integer|integer[]|{x: integer, y: integer}
---@param y? integer
---@return CityDefinition self
function CityDefinition:pos_om(x, y) end

---@param x integer|integer[]|{x: integer, y: integer}
---@param y? integer
---@return CityDefinition self
function CityDefinition:pos(x, y) end

---@class FactionMissionDefinitionOptions
---@field id string Stable faction mission id.
---@field name string Name.
---@field desc string Description.
---@field description? string Description alias.
---@field skill? string Required skill id.
---@field difficulty? string Difficulty enum name.
---@field risk? string Risk enum name.
---@field activity? string Activity level name.
---@field time? string Time estimate description.
---@field positions? integer Number of positions (0-65535).
---@field items_label? string Items label.
---@field items_possibilities? string[] Items possibilities.
---@field effects? string[] Mission effects descriptions.
---@field footer? string Footer text.

---@class FactionMissionDefinition
---@field id string
local FactionMissionDefinition = {}

---@param value string
---@return FactionMissionDefinition self
function FactionMissionDefinition:name(value) end

---@param value string
---@return FactionMissionDefinition self
function FactionMissionDefinition:desc(value) end

---@param value string
---@return FactionMissionDefinition self
function FactionMissionDefinition:description(value) end

---@param value string
---@return FactionMissionDefinition self
function FactionMissionDefinition:skill(value) end

---@param value string
---@return FactionMissionDefinition self
function FactionMissionDefinition:difficulty(value) end

---@param value string
---@return FactionMissionDefinition self
function FactionMissionDefinition:risk(value) end

---@param value string
---@return FactionMissionDefinition self
function FactionMissionDefinition:activity(value) end

---@param value string
---@return FactionMissionDefinition self
function FactionMissionDefinition:time(value) end

---@param value integer
---@return FactionMissionDefinition self
function FactionMissionDefinition:positions(value) end

---@param value string
---@return FactionMissionDefinition self
function FactionMissionDefinition:items_label(value) end

---@param value string
---@return FactionMissionDefinition self
function FactionMissionDefinition:items_possibility(value) end

---@param value string
---@return FactionMissionDefinition self
function FactionMissionDefinition:add_items_possibility(value) end

---@param table string[]
---@return FactionMissionDefinition self
function FactionMissionDefinition:items_possibilities(table) end

---@param value string
---@return FactionMissionDefinition self
function FactionMissionDefinition:effect(value) end

---@param value string
---@return FactionMissionDefinition self
function FactionMissionDefinition:add_effect(value) end

---@param table string[]
---@return FactionMissionDefinition self
function FactionMissionDefinition:effects(table) end

---@param value string
---@return FactionMissionDefinition self
function FactionMissionDefinition:footer(value) end

---@class RegionSettingsCityDefinitionOptions
---@field id string Stable region settings city id.
---@field is_megacity? boolean
---@field city_size integer Required native city-size bound.
---@field city_spacing? integer
---@field shop_radius? integer
---@field shop_sigma? integer
---@field park_radius? integer
---@field park_sigma? integer
---@field name_snippet? string
---@field houses? PlatformWeightedEntry[]
---@field shops? PlatformWeightedEntry[]
---@field parks? PlatformWeightedEntry[]

---@class RegionSettingsCityDefinition
---@field id string
local RegionSettingsCityDefinition = {}

---@param value boolean
---@return RegionSettingsCityDefinition self
function RegionSettingsCityDefinition:is_megacity(value) end

---@param value integer
---@return RegionSettingsCityDefinition self
function RegionSettingsCityDefinition:city_size(value) end

---@param value integer
---@return RegionSettingsCityDefinition self
function RegionSettingsCityDefinition:city_spacing(value) end

---@param value integer
---@return RegionSettingsCityDefinition self
function RegionSettingsCityDefinition:shop_radius(value) end

---@param value integer
---@return RegionSettingsCityDefinition self
function RegionSettingsCityDefinition:shop_sigma(value) end

---@param value integer
---@return RegionSettingsCityDefinition self
function RegionSettingsCityDefinition:park_radius(value) end

---@param value integer
---@return RegionSettingsCityDefinition self
function RegionSettingsCityDefinition:park_sigma(value) end

---@param value string
---@return RegionSettingsCityDefinition self
function RegionSettingsCityDefinition:name_snippet(value) end

---@param special_id string
---@param weight integer
---@return RegionSettingsCityDefinition self
function RegionSettingsCityDefinition:house(special_id, weight) end

---@param special_id string
---@param weight integer
---@return RegionSettingsCityDefinition self
function RegionSettingsCityDefinition:add_house(special_id, weight) end

---@param table PlatformWeightedEntry[]
---@return RegionSettingsCityDefinition self
function RegionSettingsCityDefinition:houses(table) end

---@param special_id string
---@param weight integer
---@return RegionSettingsCityDefinition self
function RegionSettingsCityDefinition:shop(special_id, weight) end

---@param special_id string
---@param weight integer
---@return RegionSettingsCityDefinition self
function RegionSettingsCityDefinition:add_shop(special_id, weight) end

---@param table PlatformWeightedEntry[]
---@return RegionSettingsCityDefinition self
function RegionSettingsCityDefinition:shops(table) end

---@param special_id string
---@param weight integer
---@return RegionSettingsCityDefinition self
function RegionSettingsCityDefinition:park(special_id, weight) end

---@param special_id string
---@param weight integer
---@return RegionSettingsCityDefinition self
function RegionSettingsCityDefinition:add_park(special_id, weight) end

---@param table PlatformWeightedEntry[]
---@return RegionSettingsCityDefinition self
function RegionSettingsCityDefinition:parks(table) end

---@class ForestBiomeMapgenDefinitionOptions
---@field id string Stable forest biome mapgen id.
---@field sparseness_adjacency_factor? integer
---@field item_group? string
---@field item_group_chance? integer
---@field item_spawn_iterations? integer
---@field terrains? string[]
---@field components? string[]
---@field groundcover? PlatformWeightedEntry[]
---@field terrain_furniture? table<string, {chance: integer, furniture: PlatformWeightedEntry[]}>

---@class ForestBiomeMapgenDefinition
---@field id string
local ForestBiomeMapgenDefinition = {}

---@param value integer
---@return ForestBiomeMapgenDefinition self
function ForestBiomeMapgenDefinition:sparseness_adjacency_factor(value) end

---@param value string
---@return ForestBiomeMapgenDefinition self
function ForestBiomeMapgenDefinition:item_group(value) end

---@param value integer
---@return ForestBiomeMapgenDefinition self
function ForestBiomeMapgenDefinition:item_group_chance(value) end

---@param value integer
---@return ForestBiomeMapgenDefinition self
function ForestBiomeMapgenDefinition:item_spawn_iterations(value) end

---@param value string
---@return ForestBiomeMapgenDefinition self
function ForestBiomeMapgenDefinition:terrain(value) end

---@param value string
---@return ForestBiomeMapgenDefinition self
function ForestBiomeMapgenDefinition:add_terrain(value) end

---@param table string[]
---@return ForestBiomeMapgenDefinition self
function ForestBiomeMapgenDefinition:terrains(table) end

---@param value string
---@return ForestBiomeMapgenDefinition self
function ForestBiomeMapgenDefinition:component(value) end

---@param value string
---@return ForestBiomeMapgenDefinition self
function ForestBiomeMapgenDefinition:add_component(value) end

---@param table string[]
---@return ForestBiomeMapgenDefinition self
function ForestBiomeMapgenDefinition:components(table) end

---@param ter_id string|PlatformWeightedEntry[]
---@param weight? integer
---@return ForestBiomeMapgenDefinition self
function ForestBiomeMapgenDefinition:groundcover(ter_id, weight) end

---@param ter_id string
---@param weight integer
---@return ForestBiomeMapgenDefinition self
function ForestBiomeMapgenDefinition:add_groundcover(ter_id, weight) end

---@param ter_id string|table<string, {chance: integer, furniture: PlatformWeightedEntry[]}>
---@param chance? integer
---@param furniture_table? PlatformWeightedEntry[]
---@return ForestBiomeMapgenDefinition self
function ForestBiomeMapgenDefinition:terrain_furniture(ter_id, chance, furniture_table) end

---@param ter_id string
---@param chance integer
---@param furniture_table PlatformWeightedEntry[]
---@return ForestBiomeMapgenDefinition self
function ForestBiomeMapgenDefinition:add_terrain_furniture(ter_id, chance, furniture_table) end

---@class ToolQualityDefinitionOptions
---@field id string Stable tool-quality id.
---@field name? string Display name; defaults to id.

---@class ToolQualityDefinition
---@field id string
local ToolQualityDefinition = {}

---@param level integer Non-negative quality level.
---@param text string Player-facing usage description.
---@return ToolQualityDefinition self
function ToolQualityDefinition:usage(level, text) end

---@class SkillDisplayDefinitionOptions
---@field id string Stable skill display-category id.
---@field label? string Player-facing category label; defaults to id.

---@class SkillDisplayDefinition
---@field id string
local SkillDisplayDefinition = {}

---@class SkillDefinitionOptions
---@field id string Stable skill id.
---@field name? string Display name; defaults to id.
---@field description string Player-facing description.
---@field display_category? string SkillDisplay id; defaults to `none`.
---@field sort_rank? integer Native display ordering rank.
---@field teachable? boolean Whether NPCs may teach the skill.
---@field obsolete? boolean Whether the skill is retained only for compatibility.
---@field consumes_focus? boolean Whether training consumes focus.

---@class SkillDefinition
---@field id string
local SkillDefinition = {}

---@param tag string Native skill tag such as `combat_skill` or `contextual_skill`.
---@return SkillDefinition self
function SkillDefinition:tag(tag) end

---@param practice_id string Companion-practice category.
---@param weight integer Native weighting value.
---@return SkillDefinition self
function SkillDefinition:companion_practice(practice_id, weight) end

---@param level integer Level from zero through the native skill maximum.
---@param theory string Theory-level description.
---@param practice? string Practical-level description; omitted means theory-only,
--- matching the legacy independent theory/practice maps.
---@return SkillDefinition self
function SkillDefinition:level_description(level, theory, practice) end

---@param level integer Level from zero through the native skill maximum.
---@param practice string Practical-level description for a practice-only level.
---@return SkillDefinition self
function SkillDefinition:level_description_practice(level, practice) end

---@param trait_id string Trait that must be present.
---@return SkillDefinition self
function SkillDefinition:requires_all_trait(trait_id) end

---@param trait_id string One alternative trait that permits use.
---@return SkillDefinition self
function SkillDefinition:requires_any_trait(trait_id) end

---@param minimum integer Non-negative absolute minimum attack time.
---@param base integer Base attack time, no lower than minimum.
---@param reduction_per_level integer Non-negative reduction per level.
---@return SkillDefinition self
function SkillDefinition:attack_time(minimum, base, reduction_per_level) end

---@param combat integer
---@param survival integer
---@param industry integer
---@return SkillDefinition self
function SkillDefinition:companion_rank_factors(combat, survival, industry) end

---@class VitaminDefinitionOptions
---@field id string Stable vitamin id.
---@field name? string Display name; defaults to id.
---@field kind? 'vitamin'|'toxin'|'drug'|'counter'
---@field deficiency? string Effect id used for deficiency.
---@field excess? string Effect id used for excess.
---@field minimum? integer Lower native accumulation bound.
---@field maximum? integer Upper native accumulation bound.
---@field rate_turns? integer Positive turns consumed per unit.

---@class VitaminDefinition
---@field id string
local VitaminDefinition = {}

---@param micrograms integer Positive mass per unit.
---@return VitaminDefinition self
function VitaminDefinition:weight_micrograms(micrograms) end

---@param start integer
---@param finish integer
---@return VitaminDefinition self
function VitaminDefinition:deficiency_range(start, finish) end

---@param start integer
---@param finish integer
---@return VitaminDefinition self
function VitaminDefinition:excess_range(start, finish) end

---@param vitamin_id string
---@param rate integer Positive decay proportion.
---@return VitaminDefinition self
function VitaminDefinition:decays_into(vitamin_id, rate) end

---@param flag string
---@return VitaminDefinition self
function VitaminDefinition:flag(flag) end

---@class JsonFlagDefinitionOptions
---@field id string Stable flag id.
---@field info? string Informative UI text.
---@field restriction? string Restriction phrase.
---@field name? string Player-facing name.
---@field item_prefix? string Item-name prefix.
---@field item_suffix? string Item-name suffix.
---@field requires_flag? string Required companion flag id.
---@field taste_modifier? integer Comestible fun modifier.
---@field inherit? boolean Whether attached items pass the flag to their base item.
---@field craft_inherit? boolean Whether components pass the flag to a crafted item.

---@class JsonFlagDefinition
---@field id string
local JsonFlagDefinition = {}

---@param flag_id string
---@return JsonFlagDefinition self
function JsonFlagDefinition:conflicts_with(flag_id) end

---@class DamageTypeDefinitionOptions
---@field id string Stable damage-type id.
---@field name? string Display name; defaults to id.
---@field skill? string Associated Skill id.
---@field magic_color? string Native color name.
---@field bash_conversion_factor? number Non-negative conversion factor.
---@field melee_only? boolean
---@field physical? boolean
---@field monster_difficulty? boolean
---@field no_resist? boolean
---@field edged? boolean
---@field environmental? boolean
---@field material_required? boolean

---@class DamageTypeDefinition
---@field id string
local DamageTypeDefinition = {}

---@param damage_type_id string
---@param factor number
---@return DamageTypeDefinition self
function DamageTypeDefinition:derived(damage_type_id, factor) end

---@param flag string
---@return DamageTypeDefinition self
function DamageTypeDefinition:immune_character_flag(flag) end

---@param flag string
---@return DamageTypeDefinition self
function DamageTypeDefinition:immune_monster_flag(flag) end

---@class PlatformDamageTypePayload
---@field damage_type_id string
---@field phase 'on_hit'|'on_damage'
---@field source GameHandle|nil Generation-safe source creature handle.
---@field target GameHandle|nil Generation-safe target creature handle.
---@field body_part string Empty for `on_hit`.
---@field total_damage number Premitigation damage for `on_damage`.
---@field damage_taken number Applied damage for `on_damage`.

---@param handler_id string Named handler receiving PlatformDamageTypePayload.
---@return DamageTypeDefinition self
function DamageTypeDefinition:on_hit(handler_id) end

---@param handler_id string Named handler receiving PlatformDamageTypePayload.
---@return DamageTypeDefinition self
function DamageTypeDefinition:on_damage(handler_id) end

---@class MaterialDefinitionOptions
---@field id string Stable material id.
---@field name? string Display name; defaults to id.
---@field salvaged_into? string Item id produced by salvage.
---@field repaired_with? string Repair item id.
---@field bash_damage_verb? string
---@field cut_damage_verb? string
---@field chip_resistance? integer Non-negative native resistance.
---@field breathability? integer Native breathability rank from zero through five.
---@field repair_difficulty? integer Native skill difficulty.
---@field wind_resistance? integer Percentage from zero through 100.
---@field density? number Positive relative density.
---@field sheet_thickness? number Non-negative sheet thickness.
---@field specific_heat_liquid? number
---@field specific_heat_solid? number
---@field latent_heat? number
---@field freezing_point? number Celsius.
---@field rotting? boolean
---@field soft? boolean
---@field uncomfortable? boolean
---@field conductive? boolean

---@class MaterialDefinition
---@field id string
local MaterialDefinition = {}

---@param damage_type_id string
---@param amount number
---@return MaterialDefinition self
function MaterialDefinition:resistance(damage_type_id, amount) end

---@param vitamin_id string
---@param amount number
---@return MaterialDefinition self
function MaterialDefinition:vitamin(vitamin_id, amount) end

---@param level integer One-based damage adjective level.
---@param text string
---@return MaterialDefinition self
function MaterialDefinition:damage_adjective(level, text) end

---@param intensity integer One-based fire intensity.
---@param immune boolean
---@param volume_ml_per_turn integer
---@param fuel number
---@param smoke number
---@param burned number
---@return MaterialDefinition self
function MaterialDefinition:burn(intensity, immune, volume_ml_per_turn, fuel, smoke, burned) end

---@param item_id string
---@param efficiency number
---@return MaterialDefinition self
function MaterialDefinition:burn_product(item_id, efficiency) end

---@param energy_kilojoules integer
---@param pump_terrain? string
---@param perpetual? boolean
---@return MaterialDefinition self
function MaterialDefinition:fuel(energy_kilojoules, pump_terrain, perpetual) end

---@param chance_hot integer
---@param chance_cold integer
---@param factor number
---@param fiery boolean
---@param size_factor number
---@return MaterialDefinition self
function MaterialDefinition:fuel_explosion(chance_hot, chance_cold, factor, fiery, size_factor) end

---@class AmmunitionTypeDefinitionOptions
---@field id string Stable ammunition-family id.
---@field name? string Display name; defaults to id.
---@field default_item? string Default ammunition item id.

---@class AmmunitionTypeDefinition
---@field id string
local AmmunitionTypeDefinition = {}

---@class ItemCategoryDefinitionOptions
---@field id string Stable inventory category id.
---@field header? string Inventory header; defaults to id.
---@field noun? string Noun used in descriptive text; defaults to header.
---@field sort_rank? integer Lower ranks sort first.
---@field spawn_rate? number Non-negative item spawn multiplier.
---@field zone? string Default zone id.

---@class ItemCategoryDefinition
---@field id string
local ItemCategoryDefinition = {}

---@param zone_id string
---@param flags string[] Dense list of item flags; may be empty when `filthy` is true.
---@param filthy? boolean Whether the rule matches filthy items.
---@return ItemCategoryDefinition self
function ItemCategoryDefinition:priority_zone(zone_id, flags, filthy) end

---@class RecipeCategoryDefinitionOptions
---@field id string Stable `CC_` crafting category id.
---@field hidden? boolean
---@field practice? boolean
---@field building? boolean
---@field wildcard? boolean

---@class RecipeCategoryDefinition
---@field id string
local RecipeCategoryDefinition = {}

---@param id string `CSC_ALL` or a subcategory id matching this category.
---@return RecipeCategoryDefinition self
function RecipeCategoryDefinition:subcategory(id) end

---@class ProficiencyCategoryDefinitionOptions
---@field id string Stable proficiency category id.
---@field name? string Display name; defaults to id.
---@field description string Player-facing description.

---@class ProficiencyCategoryDefinition
---@field id string
local ProficiencyCategoryDefinition = {}

---@class ProficiencyDefinitionOptions
---@field id string Stable proficiency id.
---@field name? string Display name; defaults to id.
---@field description string Player-facing description.
---@field category string ProficiencyCategory id.
---@field time_to_learn_turns? integer Positive training time in game turns.
---@field time_multiplier? number Non-negative default crafting time multiplier.
---@field skill_penalty? number Non-negative default crafting skill penalty.
---@field weakpoint_bonus? number
---@field weakpoint_penalty? number
---@field can_learn? boolean
---@field ignore_focus? boolean
---@field teachable? boolean

---@class ProficiencyDefinition
---@field id string
local ProficiencyDefinition = {}

---@param proficiency_id string
---@return ProficiencyDefinition self
function ProficiencyDefinition:requires(proficiency_id) end

---@param category string Native bonus category.
---@param attribute 'strength'|'dexterity'|'intelligence'|'perception'|'stamina'
---@param value number
---@return ProficiencyDefinition self
function ProficiencyDefinition:bonus(category, attribute, value) end

---@class WeaponCategoryDefinitionOptions
---@field id string Stable weapon category id.
---@field name? string Display name; defaults to id.

---@class WeaponCategoryDefinition
---@field id string
local WeaponCategoryDefinition = {}

---@param proficiency_id string
---@return WeaponCategoryDefinition self
function WeaponCategoryDefinition:proficiency(proficiency_id) end

---Non-copyable borrowed callback context. Every member becomes stale after the
---item-use handler returns or fails; saving the userdata does not extend its lease.
---@class ItemUseContext
---@field player_name string
---@field item_id string
---@field character GameHandle Runtime-owner- and generation-safe handle for the using character.
---@field item GameHandle Runtime-owner- and generation-safe handle for the used item instance.
---@field position TripointCoord Reality-bubble map-square (`bub`/`ms`) position of use.
---@field charges integer
local ItemUseContext = {}

---@param text string
function ItemUseContext:message(text) end

---@class FactionDefinitionOptions
---@field id string Stable faction id.
---@field name? string Player-facing name; defaults to id.
---@field description? string Player-facing description.
---@field likes? integer Initial player like score.
---@field respects? integer Initial player respect score.
---@field trusts? integer Initial player trust score.
---@field known? boolean Whether the player initially knows the faction.
---@field size? integer Initial member count.
---@field power? integer Initial power score.
---@field wealth? integer Initial wealth score.
---@field food_calories? integer Initial food energy in kilocalories.
---@field food_vitamins? table<string, integer> Initial native vitamin units keyed by vitamin id.
---@field consumes_food? boolean Whether faction members consume the shared supply.
---@field lone_wolf? boolean Whether the faction is a lone-wolf faction.
---@field limited_area? boolean Whether area claims are limited.
---@field currency? string Existing item id used as faction currency.
---@field monster_faction? string Existing monster-faction id; defaults to human.
---@field relations? table<string, string[]> Relation flags keyed by target faction id.

---@class FactionDefinition
---@field id string
local FactionDefinition = {}

---@class NpcDistribution
---@field constant? integer Constant value.
---@field rng? integer[] Two-element inclusive random interval.
---@field dice? integer[] Two-element dice count and sides.
---@field add? integer Constant added to the selected distribution.

---@class NpcShopGroupOptions
---@field id string Existing item-group id.
---@field trust? integer Minimum trust.
---@field strict? boolean Native strict matching flag.
---@field rigid? boolean Native rigid restock flag.
---@field condition_handler? string Optional Platform handler used to evaluate this group.

---@class NpcPriceRuleOptions
---@field item? string Item id matched by this rule.
---@field group? string Item-group id matched by this rule.
---@field category? string Item-category id matched by this rule.
---@field markup? number Sale markup; defaults to one.
---@field premium? number Purchase premium; defaults to one.
---@field fixed_adjustment? number Optional fixed adjustment.
---@field price? integer Optional fixed price in cents.
---@field condition_handler? string Optional Platform handler used to evaluate this rule.

---@class NpcClassDefinitionOptions
---@field id string Stable NPC-class id.
---@field name? string Player-facing class name; defaults to id.
---@field job_description? string Player-facing job description.
---@field common? boolean Whether random NPC generation may select the class.
---@field sells_belongings? boolean Whether the NPC sells personal belongings.
---@field worn? string Existing starting worn item-group id.
---@field carry? string Existing starting carried item-group id.
---@field weapon? string Existing starting weapon item-group id.
---@field traits? string Existing or same-transaction trait-group id.
---@field consumption_rates? string Existing shopkeeper-consumption-rates id.
---@field strength? NpcDistribution
---@field dexterity? NpcDistribution
---@field intelligence? NpcDistribution
---@field perception? NpcDistribution
---@field skills? table<string, NpcDistribution> Base skill distributions keyed by skill id.
---@field bonus_skills? table<string, NpcDistribution> Bonus skill distributions keyed by skill id.
---@field shop_groups? NpcShopGroupOptions[]
---@field price_rules? NpcPriceRuleOptions[]

---@class NpcClassDefinition
---@field id string
local NpcClassDefinition = {}

---@class NpcDefinitionOptions
---@field id string Stable NPC-template id.
---@field unique_name? string Fixed personal name.
---@field suffix? string Display-name suffix.
---@field temporary_suffix? string Temporary display-name suffix.
---@field gender? 'male'|'female'|'random'
---@field class string Existing or same-transaction NPC-class id.
---@field faction? string Existing or same-transaction faction id.
---@field attitude? integer Native NPC-attitude value.
---@field mission? string Native NPC-mission enum name.
---@field chat? string Initial dialogue topic id.
---@field stole_item_chat? string Stolen-item dialogue topic id.
---@field age? integer Fixed generated age.
---@field height? integer Fixed generated height in centimeters.
---@field on_death? string Platform handler invoked when the NPC dies.

---@class NpcDefinition
---@field id string
local NpcDefinition = {}

---@class OvermapTerrainDefinitionOptions
---@field id string Stable overmap-terrain type id.
---@field name? string Player-facing name; defaults to id.
---@field symbol? string Single display symbol.
---@field color? string Native color id.
---@field see_cost? string Native overmap see-cost enum name.
---@field travel_cost? string Native overmap travel-cost enum name.
---@field on_entry? string Platform handler invoked on entering this terrain.
---@field on_exit? string Platform handler invoked on leaving this terrain.
---@field default_map_data? string Native map-data-summary id; defaults to `full_omt`.
---@field vision_levels? string Native overmap-vision id; defaults to `default`.
---@field monster_density? integer Native monster density.
---@field flags? string[] Native overmap-terrain flags.

---@class OvermapTerrainDefinition
---@field id string
local OvermapTerrainDefinition = {}

---@class OvermapSpecialTerrainOptions
---@field point integer[] Three-element relative overmap-terrain coordinate.
---@field terrain? string Concrete overmap-terrain id; empty marks a location-only footprint tile.
---@field locations? string[] Allowed overmap-location ids for this tile.
---@field flags? string[] Native special-terrain flags.

---@class OvermapSpecialConnectionOptions
---@field point integer[] Three-element relative overmap-terrain coordinate.
---@field from? integer[] Optional three-element source coordinate.
---@field terrain? string Overmap-terrain type connected at this point.
---@field connection? string Existing overmap-connection id.
---@field existing? boolean Whether the connection must already exist.

---@class OvermapSpecialDefinitionOptions
---@field id string Stable overmap-special id.
---@field condition_handler? string Optional Platform placement-condition handler.
---@field on_place? string Platform handler invoked when the special is placed.
---@field terrains? OvermapSpecialTerrainOptions[]
---@field connections? OvermapSpecialConnectionOptions[]
---@field locations? string[] Default overmap-location ids.
---@field flags? string[] Native overmap-special flags.
---@field city_size? integer[] Two-element inclusive city-size interval.
---@field city_distance? integer[] Two-element inclusive city-distance interval.
---@field occurrences? integer[] Two-element inclusive occurrence interval.
---@field priority? integer Placement priority.
---@field rotate? boolean Whether the special may rotate.

---@class OvermapSpecialDefinition
---@field id string
local OvermapSpecialDefinition = {}

---@class VehiclePartVariantOptions
---@field id? string Native variant id; empty is the default variant.
---@field label? string Player-facing variant label.
---@field symbols? string Native eight-direction symbol sequence.
---@field broken_symbols? string Native eight-direction broken symbol sequence.

---@class VehiclePartRequirementReference
---@field id string Existing Requirement id.
---@field multiplier? integer Positive multiplier; defaults to one.

---@class VehiclePartRequirementOptions
---@field id? string Single existing Requirement id.
---@field multiplier? integer Positive multiplier for id.
---@field using? VehiclePartRequirementReference[] Ordered existing Requirement references.
---@field time_minutes? integer Native work time in minutes.
---@field skills? table<string, integer> Required levels keyed by skill id.

---@class VehiclePartControlOptions
---@field air_proficiencies? string[] Existing air-control proficiency ids.
---@field land_proficiencies? string[] Existing land-control proficiency ids.

---@class VehiclePartCollectionPatch
---@field extend_categories? string[] Add only categories absent from the inherited set.
---@field delete_categories? string[] Remove only categories present in the inherited set.
---@field extend_flags? string[] Add only flags absent from the inherited set.
---@field delete_flags? string[] Remove only flags present in the inherited set.
---@field extend_emissions? string[] Add only emissions absent from the inherited set.
---@field delete_emissions? string[] Remove only emissions present in the inherited set.
---@field extend_exhaust? string[] Add only exhaust emissions absent from the inherited set.
---@field delete_exhaust? string[] Remove only exhaust emissions present in the inherited set.

---@class VehiclePartDefinitionOptions
---@field id string Stable vehicle-part id.
---@field copy_from? string Existing vehicle-part id used as the patch base.
---@field name? string Player-facing name.
---@field description? string Player-facing description.
---@field item? string Existing or same-transaction base item id.
---@field location? string Existing vehicle-part-location id.
---@field looks_like? string Existing vehicle-part id used for presentation.
---@field color? string Native color id.
---@field broken_color? string Native broken color id.
---@field fuel_type? string Existing fuel item id.
---@field durability? integer Positive durability.
---@field size_ml? integer Cargo size in milliliters.
---@field damage_modifier? integer Native damage modifier.
---@field power_watts? integer Mechanical power in watts.
---@field epower_watts? integer Electrical power in watts.
---@field energy_consumption_watts? integer Fuel-energy consumption in watts.
---@field balloon_height? number Per-part balloon lift in kilograms.
---@field backfire_threshold? number Engine backfire threshold.
---@field backfire_frequency? integer Engine backfire frequency.
---@field damaged_power_factor? number Damaged engine power factor.
---@field noise_factor? integer Engine noise factor.
---@field m2c? integer Engine mechanical-to-combustion factor.
---@field categories? string[] Vehicle-part category ids replacing inherited categories.
---@field flags? string[] Vehicle-part flags replacing inherited flags.
---@field variants? VehiclePartVariantOptions[] Variants replacing inherited variants.
---@field fuel_options? string[] Engine fuel item ids replacing inherited options.
---@field engine_exclusions? string[] Engine exclusion flags replacing inherited exclusions.
---@field variant_bases? VehiclePartVariantOptions[] Ordered inherited variant bases.
---@field on_activate? string Platform handler invoked when the part activates.
---@field damage_reduction? table<string, number> Damage reduction keyed by damage-type id.
---@field breaks_into? string Existing or same-transaction item-group id.
---@field install? VehiclePartRequirementOptions
---@field removal? VehiclePartRequirementOptions
---@field repair? VehiclePartRequirementOptions
---@field control? VehiclePartControlOptions
---@field patch? VehiclePartCollectionPatch Typed extend/delete operations; requires copy_from.

---@class VehiclePartDefinition
---@field id string
local VehiclePartDefinition = {}

---@class VehiclePartPlacementOptions
---@field x integer Mount x coordinate.
---@field y integer Mount y coordinate.
---@field part string Vehicle-part id resolved after global finalization, including native auto-generated turrets.
---@field variant? string Vehicle-part variant id.
---@field with_ammo? integer Ammo fill percentage.
---@field ammo_types? string[] Allowed ammo item ids.
---@field ammo_quantity? integer[] Two-element ammo quantity interval.
---@field fuel? string Initial fuel item id.
---@field tools? string[] Initial tool item ids.

---@class VehicleItemPlacementOptions
---@field x integer Mount x coordinate.
---@field y integer Mount y coordinate.
---@field chance? integer Spawn chance from zero through 100.
---@field with_ammo? integer Ammo fill percentage.
---@field with_magazine? integer Magazine chance percentage.
---@field items? string[] Concrete item ids.
---@field groups? string[] Item-group ids.

---@class VehicleZonePlacementOptions
---@field x integer Mount x coordinate.
---@field y integer Mount y coordinate.
---@field type string Existing zone-type id.
---@field name? string Zone name.
---@field filter? string Zone item filter.

---@class VehicleDefinitionOptions
---@field id string Stable vehicle prototype id.
---@field copy_from? string Existing or same-transaction vehicle id used as the patch base.
---@field name string Player-facing vehicle name.
---@field color_palette? string Existing vehicle-color-palette id.
---@field parts VehiclePartPlacementOptions[]
---@field items? VehicleItemPlacementOptions[]
---@field zones? VehicleZonePlacementOptions[]
---@field patch? VehicleDefinitionPatch Typed extend/delete operations; requires copy_from.

---@class VehicleDefinitionPatch
---@field extend_parts? VehiclePartPlacementOptions[] Add placements absent from the inherited vehicle.
---@field delete_parts? VehiclePartPlacementOptions[] Remove exact placements from the inherited vehicle.

---@class VehicleDefinition
---@field id string
local VehicleDefinition = {}

---@class BionicDefinition
---@field activation_spell any
---@field armor any
---@field auto_deactivate any
---@field available_upgrade any
---@field cancel_mutation any
---@field conflict_mutation any
---@field enchantment any
---@field encumbers any
---@field environment_protection any
---@field flag any
---@field fuel any
---@field give_mutation_when_removed any
---@field id any
---@field include_bionic any
---@field installable_weapon_flag any
---@field learn_spell any
---@field martial_art any
---@field occupies any
---@field passive_item any
---@field proficiency any
---@field replace_bodypart any
---@field toggled_item any
local BionicDefinition = {}
---@class ComputerAccessContext
---@field access_denied any
---@field alerts any
---@field character any
---@field message any
---@field mission_id any
---@field name any
---@field position any
---@field security any
local ComputerAccessContext = {}
---@param key string
---@return any
function ComputerAccessContext.get_value(key) end
---@param key string
---@return any
function ComputerAccessContext.remove_value(key) end
---@param key string
---@param value any
---@return any
function ComputerAccessContext.set_value(key, value) end
---@class EnchantmentDefinition
---@field active_when any
---@field bodypart_change any
---@field custom any
---@field effect any
---@field encumbrance any
---@field every any
---@field hit_me any
---@field hit_you any
---@field id any
---@field incoming_damage any
---@field limb_score any
---@field max_hp any
---@field melee_damage any
---@field mutation any
---@field post_armor_damage any
---@field skill any
---@field value any
---@field vision any
local EnchantmentDefinition = {}
---@class EventStatisticDefinition
---@field id any
local EventStatisticDefinition = {}
---@class EventTransformationDefinition
---@field derive any
---@field drop any
---@field id any
---@field where_any any
---@field where_equals any
---@field where_gt any
---@field where_gte any
---@field where_lt any
---@field where_lte any
---@field where_statistic any
local EventTransformationDefinition = {}
---@class MathFunctionDefinition
---@field arguments any
---@field id any
---@field returns any
local MathFunctionDefinition = {}
---@class MissionDefinition
---@field complete_when any
---@field deadline any
---@field dialogue any
---@field dynamic_deadline any
---@field fail_with any
---@field finish_with any
---@field id any
---@field origin any
---@field place_when any
---@field reward any
---@field start_with any
local MissionDefinition = {}
---@class MutationDefinition
---@field armor any
---@field attack any
---@field comfort any
---@field decimal_value any
---@field id any
---@field integer_value any
---@field personality any
---@field reflex any
---@field relationship any
---@field transform any
---@field variant any
---@field vitamin_absorption any
---@field wet_protection any
local MutationDefinition = {}
---@class PlantLifecycleDefinition
---@field id any
---@field on any
local PlantLifecycleDefinition = {}
---@class PostProcessGeneratorDefinition
---@field id any
---@field stage any
local PostProcessGeneratorDefinition = {}
---@class ProfessionDefinition
---@field addiction any
---@field cbm any
---@field flag any
---@field forbid_trait any
---@field hobby any
---@field id any
---@field items any
---@field martial_art any
---@field martial_art_choice any
---@field mission any
---@field on_start any
---@field pet any
---@field proficiency any
---@field recipe any
---@field requirement any
---@field skill any
---@field spell any
---@field trait any
local ProfessionDefinition = {}
---@class ProfessionItemBonusDefinition
---@field id any
---@field when any
local ProfessionItemBonusDefinition = {}
---@class ProfessionItemSubstitutionDefinition
---@field id any
---@field when any
local ProfessionItemSubstitutionDefinition = {}
---@class RelicProcgenDefinition
---@field activated_spell any
---@field charge any
---@field id any
---@field item any
---@field on_hit_me any
---@field on_hit_you any
---@field passive_add any
---@field passive_multiplier any
---@field type any
local RelicProcgenDefinition = {}
---@class SpellDefinition
---@field bodypart any
---@field caster_when any
---@field dynamic_stat any
---@field extra_spell any
---@field flag any
---@field id any
---@field ignore_species any
---@field learn_spell any
---@field lua_effect any
---@field stat any
---@field stat_range any
---@field target any
---@field target_monster any
---@field target_species any
---@field target_when any
local SpellDefinition = {}
---@class TerrainTransformDefinition
---@field field any
---@field furniture any
---@field id any
---@field terrain any
---@field trap any
local TerrainTransformDefinition = {}
---@class VehiclePlacementDefinition
---@field id any
---@field location any
local VehiclePlacementDefinition = {}
---@class VehicleSpawnDefinition
---@field builtin any
---@field id any
---@field vehicle any
local VehicleSpawnDefinition = {}
---@class WidgetDefinition
---@field bodypart any
---@field break_at any
---@field child any
---@field clause any
---@field color any
---@field custom_value any
---@field default_clause any
---@field flag any
---@field id any
local WidgetDefinition = {}
---@param options CcbLuaValue
---@return any
function CcbPlatformContent.Bionic(options) end
---@param options CcbLuaValue
---@return any
function CcbPlatformContent.Enchantment(options) end
---@param options CcbLuaValue
---@return any
function CcbPlatformContent.EventStatistic(options) end
---@param options CcbLuaValue
---@return any
function CcbPlatformContent.EventTransformation(options) end
---@param options CcbLuaValue
---@return any
function CcbPlatformContent.MathFunction(options) end
---@param options CcbLuaValue
---@return any
function CcbPlatformContent.Mission(options) end
---@param options CcbLuaValue
---@return any
function CcbPlatformContent.Mutation(options) end
---@param options CcbLuaValue
---@return any
function CcbPlatformContent.PlantLifecycle(options) end
---@param options CcbLuaValue
---@return any
function CcbPlatformContent.PostProcessGenerator(options) end
---@param options CcbLuaValue
---@return any
function CcbPlatformContent.Profession(options) end
---@param options CcbLuaValue
---@return any
function CcbPlatformContent.ProfessionItemBonus(options) end
---@param options CcbLuaValue
---@return any
function CcbPlatformContent.ProfessionItemSubstitution(options) end
---@param options CcbLuaValue
---@return any
function CcbPlatformContent.RelicProcgen(options) end
---@param options CcbLuaValue
---@return any
function CcbPlatformContent.Spell(options) end
---@param options CcbLuaValue
---@return any
function CcbPlatformContent.TerrainTransform(options) end
---@param options CcbLuaValue
---@return any
function CcbPlatformContent.VehiclePlacement(options) end
---@param options CcbLuaValue
---@return any
function CcbPlatformContent.VehicleSpawn(options) end
---@param options CcbLuaValue
---@return any
function CcbPlatformContent.Widget(options) end
---@param id string
---@return any
function CcbPlatformContent.edit_bionic(id) end
---@param id string
---@return any
function CcbPlatformContent.edit_enchantment(id) end
---@param id string
---@return any
function CcbPlatformContent.edit_event_statistic(id) end
---@param id string
---@return any
function CcbPlatformContent.edit_event_transformation(id) end
---@param id string
---@return any
function CcbPlatformContent.edit_math_function(id) end
---@param id string
---@return any
function CcbPlatformContent.edit_mission(id) end
---@param id string
---@return any
function CcbPlatformContent.edit_mutation(id) end
---@param id string
---@return any
function CcbPlatformContent.edit_post_process_generator(id) end
---@param id string
---@return any
function CcbPlatformContent.edit_profession(id) end
---@param id string
---@return any
function CcbPlatformContent.edit_profession_item_bonus(id) end
---@param id string
---@return any
function CcbPlatformContent.edit_profession_item_substitution(id) end
---@param id string
---@return any
function CcbPlatformContent.edit_relic_procgen(id) end
---@param id string
---@return any
function CcbPlatformContent.edit_spell(id) end
---@param id string
---@return any
function CcbPlatformContent.edit_terrain_transform(id) end
---@param id string
---@return any
function CcbPlatformContent.edit_vehicle_placement(id) end
---@param id string
---@return any
function CcbPlatformContent.edit_vehicle_spawn(id) end
---@param id string
---@return any
function CcbPlatformContent.edit_widget(id) end
---@param dimension string
---@return any
function CcbPlatformEnvironmentQueries.clear_saved_dimension(dimension) end
---@class CcbPlatformGameplayOptionsApi
local CcbPlatformGameplayOptionsApi = {}
---@param id string
---@return any
function CcbPlatformGameplayOptionsApi.get(id) end
---@param id string
---@return any
function CcbPlatformGameplayOptionsApi.has(id) end
---@param id string
---@return any
function CcbPlatformGameplayOptionsApi.value(id) end
---@class CcbPlatformLoreApi
local CcbPlatformLoreApi = {}
---@return any
function CcbPlatformLoreApi.known_snippets() end
---@param id string
---@return any
function CcbPlatformLoreApi.knows_snippet(id) end
---@param id string
---@return any
function CcbPlatformLoreApi.remember_snippet(id) end
---@class CcbPlatformNativeEventsApi
local CcbPlatformNativeEventsApi = {}
---@param type_name string
---@param requested_args? table
---@return any
function CcbPlatformNativeEventsApi.emit(type_name, requested_args) end
---@class CcbPlatformMessagesApi
local CcbPlatformMessagesApi = {}
---@param message string
---@param type? string One of the native message severity names.
---@return boolean
function CcbPlatformMessagesApi.add(message, type) end
---@param message string
---@param type? string
---@return any
function CcbPlatformMessagesApi.add_from_outdoors(message, type) end
---@param message string
---@param type? string
---@return any
function CcbPlatformMessagesApi.add_if_audible(message, type) end

---@class CcbPlatformSoundApi
local CcbPlatformSoundApi = {}
---@param id string
---@param variant string
---@param volume? integer
---@return any
function CcbPlatformSoundApi.play_from_outdoors(id, variant, volume) end
---@param id string
---@param variant string
---@param volume? integer
---@return any
function CcbPlatformSoundApi.play_if_audible(id, variant, volume) end
---@class CcbPlatformSnippetsApi
local CcbPlatformSnippetsApi = {}
---@param text string
---@return any
function CcbPlatformSnippetsApi.expand(text) end
---@param id string
---@return any
function CcbPlatformSnippetsApi.get(id) end
---@param id string
---@return any
function CcbPlatformSnippetsApi.has(id) end
---@param category string
---@return any
function CcbPlatformSnippetsApi.has_category(category) end
---@param category string
---@return any
function CcbPlatformSnippetsApi.random(category) end
---@param category string
---@return any
function CcbPlatformSnippetsApi.random_named(category) end
---@class CcbPlatformTextApi
local CcbPlatformTextApi = {}
---@param text string
---@param speaker_handle GameHandle
---@param interlocutor_handle? GameHandle Optional interlocutor; nil is not replaced by the avatar.
---@param item_id? string
---@return any
function CcbPlatformTextApi.expand_for(text, speaker_handle, interlocutor_handle, item_id) end
---@class CcbPlatformTilesetApi
local CcbPlatformTilesetApi = {}
---@return any
function CcbPlatformTilesetApi.limits() end
---@param descriptor table
---@return any
function CcbPlatformTilesetApi.register(descriptor) end
---@class CcbPlatformContent
local CcbPlatformContent = {}

---@param options ItemDefinitionOptions
---@return ItemDefinition
function CcbPlatformContent.Item(options) end

---@param options FactionDefinitionOptions
---@return FactionDefinition
function CcbPlatformContent.Faction(options) end

---@param options NpcClassDefinitionOptions
---@return NpcClassDefinition
function CcbPlatformContent.NpcClass(options) end

---@param options NpcDefinitionOptions
---@return NpcDefinition
function CcbPlatformContent.Npc(options) end

---@param options OvermapTerrainDefinitionOptions
---@return OvermapTerrainDefinition
function CcbPlatformContent.OvermapTerrain(options) end

---@param options OvermapSpecialDefinitionOptions
---@return OvermapSpecialDefinition
function CcbPlatformContent.OvermapSpecial(options) end

---@param options VehiclePartDefinitionOptions
---@return VehiclePartDefinition
function CcbPlatformContent.VehiclePart(options) end

---@param options VehicleDefinitionOptions
---@return VehicleDefinition
function CcbPlatformContent.Vehicle(options) end

---@param options RecipeDefinitionOptions
---@return RecipeDefinition
function CcbPlatformContent.Recipe(options) end

---@param options NestedRecipeCategoryDefinitionOptions
---@return NestedRecipeCategoryDefinition
function CcbPlatformContent.NestedRecipeCategory(options) end

---@param options ToolQualityDefinitionOptions
---@return ToolQualityDefinition
function CcbPlatformContent.ToolQuality(options) end

---@param options SkillDisplayDefinitionOptions
---@return SkillDisplayDefinition
function CcbPlatformContent.SkillDisplay(options) end

---@param options SkillDefinitionOptions
---@return SkillDefinition
function CcbPlatformContent.Skill(options) end

---@param options VitaminDefinitionOptions
---@return VitaminDefinition
function CcbPlatformContent.Vitamin(options) end

---@param options JsonFlagDefinitionOptions
---@return JsonFlagDefinition
function CcbPlatformContent.JsonFlag(options) end

---@param options DamageTypeDefinitionOptions
---@return DamageTypeDefinition
function CcbPlatformContent.DamageType(options) end

---@param options MaterialDefinitionOptions
---@return MaterialDefinition
function CcbPlatformContent.Material(options) end

---@param options AmmunitionTypeDefinitionOptions
---@return AmmunitionTypeDefinition
function CcbPlatformContent.AmmunitionType(options) end

---@param options ItemCategoryDefinitionOptions
---@return ItemCategoryDefinition
function CcbPlatformContent.ItemCategory(options) end

---@param options RecipeCategoryDefinitionOptions
---@return RecipeCategoryDefinition
function CcbPlatformContent.RecipeCategory(options) end

---@param options ProficiencyCategoryDefinitionOptions
---@return ProficiencyCategoryDefinition
function CcbPlatformContent.ProficiencyCategory(options) end

---@param options ProficiencyDefinitionOptions
---@return ProficiencyDefinition
function CcbPlatformContent.Proficiency(options) end

---@param options WeaponCategoryDefinitionOptions
---@return WeaponCategoryDefinition
function CcbPlatformContent.WeaponCategory(options) end

---@param options RequirementDefinitionOptions
---@return RequirementDefinition
function CcbPlatformContent.Requirement(options) end

---@param options RecipeGroupDefinitionOptions
---@return RecipeGroupDefinition
function CcbPlatformContent.RecipeGroup(options) end

---@param options ScentTypeDefinitionOptions
---@return ScentTypeDefinition
function CcbPlatformContent.ScentType(options) end

---@param options ButcheryRequirementDefinitionOptions
---@return ButcheryRequirementDefinition
function CcbPlatformContent.ButcheryRequirement(options) end

---@param options ItemActionDefinitionOptions
---@return ItemActionDefinition
function CcbPlatformContent.ItemAction(options) end

---@param options ScenarioDefinitionOptions
---@return ScenarioDefinition
function CcbPlatformContent.Scenario(options) end

---@param options VehicleColorPaletteDefinitionOptions
---@return VehicleColorPaletteDefinition
function CcbPlatformContent.VehicleColorPalette(options) end

---@param options MonsterGroupDefinitionOptions
---@return MonsterGroupDefinition
function CcbPlatformContent.MonsterGroup(options) end

---@param options OvermapConnectionDefinitionOptions
---@return OvermapConnectionDefinition
function CcbPlatformContent.OvermapConnection(options) end

---@param options SpeedDescriptionDefinitionOptions
---@return SpeedDescriptionDefinition
function CcbPlatformContent.SpeedDescription(options) end

---@param options HarvestDropTypeDefinitionOptions
---@return HarvestDropTypeDefinition
function CcbPlatformContent.HarvestDropType(options) end

---@param options HarvestDefinitionOptions
---@return HarvestDefinition
function CcbPlatformContent.Harvest(options) end

---@param options BehaviorDefinitionOptions
---@return BehaviorDefinition
function CcbPlatformContent.Behavior(options) end

---@param options MonsterAttackDefinitionOptions
---@return MonsterAttackDefinition
function CcbPlatformContent.MonsterAttack(options) end

---@param options EffectTypeDefinitionOptions
---@return EffectTypeDefinition
function CcbPlatformContent.EffectType(options) end

---@param options WeakpointSetDefinitionOptions
---@return WeakpointSetDefinition
function CcbPlatformContent.WeakpointSet(options) end

---@param options FieldTypeDefinitionOptions
---@return FieldTypeDefinition
function CcbPlatformContent.FieldType(options) end

---@param options ItemGroupDefinitionOptions
---@return ItemGroupDefinition
function CcbPlatformContent.ItemGroup(options) end

---@param options SubBodyPartDefinitionOptions
---@return SubBodyPartDefinition
function CcbPlatformContent.SubBodyPart(options) end

---@param options WoundDefinitionOptions
---@return WoundDefinition
function CcbPlatformContent.Wound(options) end

---@param options BodyPartDefinitionOptions
---@return BodyPartDefinition
function CcbPlatformContent.BodyPart(options) end

---@param options WoundFixDefinitionOptions
---@return WoundFixDefinition
function CcbPlatformContent.WoundFix(options) end

---@param options AnatomyDefinitionOptions
---@return AnatomyDefinition
function CcbPlatformContent.Anatomy(options) end

---@param options BodyGraphDefinitionOptions
---@return BodyGraphDefinition
function CcbPlatformContent.BodyGraph(options) end

---@param options MonsterDefinitionOptions
---@return MonsterDefinition
function CcbPlatformContent.Monster(options) end

---@param options MoraleTypeDefinitionOptions
---@return MoraleTypeDefinition
function CcbPlatformContent.MoraleType(options) end

---@param options DiseaseTypeDefinitionOptions
---@return DiseaseTypeDefinition
function CcbPlatformContent.DiseaseType(options) end

---@param options MonsterFlagDefinitionOptions
---@return MonsterFlagDefinition
function CcbPlatformContent.MonsterFlag(options) end

---@param options SpeciesDefinitionOptions
---@return SpeciesDefinition
function CcbPlatformContent.Species(options) end

---@param options EmissionDefinitionOptions
---@return EmissionDefinition
function CcbPlatformContent.Emission(options) end

---@param options MonsterFactionDefinitionOptions
---@return MonsterFactionDefinition
function CcbPlatformContent.MonsterFaction(options) end

---@param options MutationTypeDefinitionOptions
---@return MutationTypeDefinition
function CcbPlatformContent.MutationType(options) end

---@param options ConnectGroupDefinitionOptions
---@return ConnectGroupDefinition
function CcbPlatformContent.ConnectGroup(options) end

---@param options MutationCategoryDefinitionOptions
---@return MutationCategoryDefinition
function CcbPlatformContent.MutationCategory(options) end

---@param options ConstructionCategoryDefinitionOptions
---@return ConstructionCategoryDefinition
function CcbPlatformContent.ConstructionCategory(options) end

---@param options ConstructionGroupDefinitionOptions
---@return ConstructionGroupDefinition
function CcbPlatformContent.ConstructionGroup(options) end

---@param options VehiclePartLocationDefinitionOptions
---@return VehiclePartLocationDefinition
function CcbPlatformContent.VehiclePartLocation(options) end

---@param options MoodFaceDefinitionOptions
---@return MoodFaceDefinition
function CcbPlatformContent.MoodFace(options) end

---@param options DamageInfoOrderDefinitionOptions
---@return DamageInfoOrderDefinition
function CcbPlatformContent.DamageInfoOrder(options) end

---@param options VehiclePartCategoryDefinitionOptions
---@return VehiclePartCategoryDefinition
function CcbPlatformContent.VehiclePartCategory(options) end

---@param options NamedColorDefinitionOptions
---@return NamedColorDefinition
function CcbPlatformContent.NamedColor(options) end

---@param options RotatableSymbolDefinitionOptions
---@return RotatableSymbolDefinition
function CcbPlatformContent.RotatableSymbol(options) end

---@param options AsciiArtDefinitionOptions
---@return AsciiArtDefinition
function CcbPlatformContent.AsciiArt(options) end

---@param options LimbScoreDefinitionOptions
---@return LimbScoreDefinition
function CcbPlatformContent.LimbScore(options) end

---@param options HitRangeDefinitionOptions
---@return HitRangeDefinition
function CcbPlatformContent.HitRange(options) end

---@param options BashDamageProfileDefinitionOptions
---@return BashDamageProfileDefinition
function CcbPlatformContent.BashDamageProfile(options) end

---@param options ClothingModDefinitionOptions
---@return ClothingModDefinition
function CcbPlatformContent.ClothingMod(options) end

---@param options OvermapLandUseCodeDefinitionOptions
---@return OvermapLandUseCodeDefinition
function CcbPlatformContent.OvermapLandUseCode(options) end

---@param options OvermapVisionDefinitionOptions
---@return OvermapVisionDefinition
function CcbPlatformContent.OvermapVision(options) end

---@param options OvermapLocationDefinitionOptions
---@return OvermapLocationDefinition
function CcbPlatformContent.OvermapLocation(options) end

---@param options ProfessionGroupDefinitionOptions
---@return ProfessionGroupDefinition
function CcbPlatformContent.ProfessionGroup(options) end

---@param options MapExtraCollectionDefinitionOptions
---@return MapExtraCollectionDefinition
function CcbPlatformContent.MapExtraCollection(options) end

---@param options VehicleGroupDefinitionOptions
---@return VehicleGroupDefinition
function CcbPlatformContent.VehicleGroup(options) end

---@param options FaultGroupDefinitionOptions
---@return FaultGroupDefinition
function CcbPlatformContent.FaultGroup(options) end

---@param options ExplosionLightDefinitionOptions
---@return ExplosionLightDefinition
function CcbPlatformContent.ExplosionLight(options) end

---@param options AmmoEffectDefinitionOptions
---@return AmmoEffectDefinition
function CcbPlatformContent.AmmoEffect(options) end

---@param options AddictionTypeDefinitionOptions
---@return AddictionTypeDefinition
function CcbPlatformContent.AddictionType(options) end

---@param options CharacterModifierDefinitionOptions
---@return CharacterModifierDefinition
function CcbPlatformContent.CharacterModifier(options) end

---@param options StartLocationDefinitionOptions
---@return StartLocationDefinition
function CcbPlatformContent.StartLocation(options) end

---@param options ClimbingAidDefinitionOptions
---@return ClimbingAidDefinition
function CcbPlatformContent.ClimbingAid(options) end

---@param options WeatherTypeDefinitionOptions
---@return WeatherTypeDefinition
function CcbPlatformContent.WeatherType(options) end

---@param options ScoreDefinitionOptions
---@return ScoreDefinition
function CcbPlatformContent.Score(options) end

---@return OverlayOrderDefinition
function CcbPlatformContent.OverlayOrder() end

---@param options ZoneTypeDefinitionOptions
---@return ZoneTypeDefinition
function CcbPlatformContent.ZoneType(options) end

---@param options SpeechPoolDefinitionOptions
---@return SpeechPoolDefinition
function CcbPlatformContent.SpeechPool(options) end

---@param options EndScreenDefinitionOptions
---@return EndScreenDefinition
function CcbPlatformContent.EndScreen(options) end

---@param options ActivityTypeDefinitionOptions
---@return ActivityTypeDefinition
function CcbPlatformContent.ActivityType(options) end

---@param options HelpTopicDefinitionOptions
---@return HelpTopicDefinition
function CcbPlatformContent.HelpTopic(options) end

---@param options SnippetCategoryDefinitionOptions
---@return SnippetCategoryDefinition
function CcbPlatformContent.SnippetCategory(options) end

---@param options PlaylistDefinitionOptions
---@return PlaylistDefinition
function CcbPlatformContent.Playlist(options) end

---@param options SoundEffectDefinitionOptions
---@return SoundEffectDefinition
function CcbPlatformContent.SoundEffect(options) end

---@param options SoundEffectPreloadDefinitionOptions
---@return SoundEffectDefinition
function CcbPlatformContent.SoundEffectPreload(options) end

---@param options AttackVectorDefinitionOptions
---@return AttackVectorDefinition
function CcbPlatformContent.AttackVector(options) end

---@param options TechniqueDefinitionOptions
---@return TechniqueDefinition
function CcbPlatformContent.Technique(options) end

---@param options MartialArtDefinitionOptions
---@return MartialArtDefinition
function CcbPlatformContent.MartialArt(options) end

---@param options TrapDefinitionOptions
---@return TrapDefinition
function CcbPlatformContent.Trap(options) end

---@param options ConstructionDefinitionOptions
---@return ConstructionDefinition
function CcbPlatformContent.Construction(options) end

---@param options FurnitureDefinitionOptions
---@return FurnitureDefinition
function CcbPlatformContent.Furniture(options) end

---@param options TerrainDefinitionOptions
---@return TerrainDefinition
function CcbPlatformContent.Terrain(options) end

---@param options GateDefinitionOptions
---@return GateDefinition
function CcbPlatformContent.Gate(options) end

---@param options FaultDefinitionOptions
---@return FaultDefinition
function CcbPlatformContent.Fault(options) end

---@param options FaultFixDefinitionOptions
---@return FaultFixDefinition
function CcbPlatformContent.FaultFix(options) end

---@param options DreamDefinitionOptions
---@return DreamDefinition
function CcbPlatformContent.Dream(options) end

---@param options AchievementDefinitionOptions
---@return AchievementDefinition
function CcbPlatformContent.Achievement(options) end

---@param options ConductDefinitionOptions
---@return AchievementDefinition
function CcbPlatformContent.Conduct(options) end

---@param options BlacklistDefinitionOptions
---@return BlacklistDefinition
function CcbPlatformContent.Blacklist(options) end

---@param options MapExtraDefinitionOptions
---@return MapExtraDefinition
function CcbPlatformContent.MapExtra(options) end

---@param options WeatherGeneratorDefinitionOptions
---@return WeatherGeneratorDefinition
function CcbPlatformContent.WeatherGenerator(options) end

---@param options MigrationDefinitionOptions
---@return MigrationDefinition
function CcbPlatformContent.Migration(options) end

---@param options TraitGroupDefinitionOptions
---@return TraitGroupDefinition
function CcbPlatformContent.TraitGroup(options) end

---@param options MonsterAdjustmentDefinitionOptions
---@return MonsterAdjustmentDefinition
function CcbPlatformContent.MonsterAdjustment(options) end

---@param options ShopkeeperDefinitionOptions
---@return ShopkeeperDefinition
function CcbPlatformContent.ShopkeeperBlacklist(options) end

---@param options ShopkeeperDefinitionOptions
---@return ShopkeeperDefinition
function CcbPlatformContent.ShopkeeperWhitelist(options) end

---@param options ShopkeeperDefinitionOptions
---@return ShopkeeperDefinition
function CcbPlatformContent.ShopkeeperConsumptionRates(options) end

---@param options MagicTypeDefinitionOptions
---@return MagicTypeDefinition
function CcbPlatformContent.MagicType(options) end

---@param options MovementModeDefinitionOptions
---@return MovementModeDefinition
function CcbPlatformContent.MovementMode(options) end

---@param options RegionSettingsRavineDefinitionOptions
---@return RegionSettingsRavineDefinition
function CcbPlatformContent.RegionSettingsRavine(options) end

---@param options RegionSettingsLakeDefinitionOptions
---@return RegionSettingsLakeDefinition
function CcbPlatformContent.RegionSettingsLake(options) end

---@param options RegionSettingsOceanDefinitionOptions
---@return RegionSettingsOceanDefinition
function CcbPlatformContent.RegionSettingsOcean(options) end

---@param options RegionSettingsForestDefinitionOptions
---@return RegionSettingsForestDefinition
function CcbPlatformContent.RegionSettingsForest(options) end

---@param options RegionSettingsRiverDefinitionOptions
---@return RegionSettingsRiverDefinition
function CcbPlatformContent.RegionSettingsRiver(options) end

---@param options RegionSettingsForestMapgenDefinitionOptions
---@return RegionSettingsForestMapgenDefinition
function CcbPlatformContent.RegionSettingsForestMapgen(options) end

---@param options RegionSettingsMapExtrasDefinitionOptions
---@return RegionSettingsMapExtrasDefinition
function CcbPlatformContent.RegionSettingsMapExtras(options) end

---@param options RegionSettingsTerrainFurnitureDefinitionOptions
---@return RegionSettingsTerrainFurnitureDefinition
function CcbPlatformContent.RegionSettingsTerrainFurniture(options) end

---@param options RegionSettingsForestTrailDefinitionOptions
---@return RegionSettingsForestTrailDefinition
function CcbPlatformContent.RegionSettingsForestTrail(options) end

---@param options RegionSettingsHighwayDefinitionOptions
---@return RegionSettingsHighwayDefinition
function CcbPlatformContent.RegionSettingsHighway(options) end

---@param options RegionSettingsDefinitionOptions
---@return RegionSettingsDefinition
function CcbPlatformContent.RegionSettings(options) end

---@param options OptionSliderDefinitionOptions
---@return OptionSliderDefinition
function CcbPlatformContent.OptionSlider(options) end

---@param options DimensionRegionLayoutDefinitionOptions
---@return DimensionRegionLayoutDefinition
function CcbPlatformContent.DimensionRegionLayout(options) end

---@param options DimensionDefinitionOptions
---@return DimensionDefinition
function CcbPlatformContent.Dimension(options) end

---@param options OmtPlaceholderDefinitionOptions
---@return OmtPlaceholderDefinition
function CcbPlatformContent.OmtPlaceholder(options) end

---@param options RegionTerrainFurnitureDefinitionOptions
---@return RegionTerrainFurnitureDefinition
function CcbPlatformContent.RegionTerrainFurniture(options) end

---@param options ForestBiomeComponentDefinitionOptions
---@return ForestBiomeComponentDefinition
function CcbPlatformContent.ForestBiomeComponent(options) end

---@param options CityDefinitionOptions
---@return CityDefinition
function CcbPlatformContent.City(options) end

---@param options CcbLuaValue
---@return any
function CcbPlatformContent.CityBuilding(options) end

---@param options FactionMissionDefinitionOptions
---@return FactionMissionDefinition
function CcbPlatformContent.FactionMission(options) end

---@param options RegionSettingsCityDefinitionOptions
---@return RegionSettingsCityDefinition
function CcbPlatformContent.RegionSettingsCity(options) end

---@param options ForestBiomeMapgenDefinitionOptions
---@return ForestBiomeMapgenDefinition
function CcbPlatformContent.ForestBiomeMapgen(options) end

---@alias PlatformContentDefinition FactionDefinition|NpcClassDefinition|NpcDefinition|OvermapTerrainDefinition|OvermapSpecialDefinition|VehiclePartDefinition|VehicleDefinition|ItemDefinition|RecipeDefinition|NestedRecipeCategoryDefinition|ToolQualityDefinition|SkillDisplayDefinition|SkillDefinition|VitaminDefinition|JsonFlagDefinition|DamageTypeDefinition|MaterialDefinition|AmmunitionTypeDefinition|ItemCategoryDefinition|RecipeCategoryDefinition|ProficiencyCategoryDefinition|ProficiencyDefinition|WeaponCategoryDefinition|RequirementDefinition|RecipeGroupDefinition|ScentTypeDefinition|SpeedDescriptionDefinition|HarvestDropTypeDefinition|HarvestDefinition|BehaviorDefinition|MonsterAttackDefinition|EffectTypeDefinition|WeakpointSetDefinition|FieldTypeDefinition|ItemGroupDefinition|SubBodyPartDefinition|WoundDefinition|BodyPartDefinition|WoundFixDefinition|AnatomyDefinition|BodyGraphDefinition|MonsterDefinition|MoraleTypeDefinition|DiseaseTypeDefinition|MonsterFlagDefinition|SpeciesDefinition|EmissionDefinition|MonsterFactionDefinition|MutationTypeDefinition|ConnectGroupDefinition|MutationCategoryDefinition|ConstructionCategoryDefinition|ConstructionGroupDefinition|VehiclePartLocationDefinition|MoodFaceDefinition|DamageInfoOrderDefinition|VehiclePartCategoryDefinition|NamedColorDefinition|RotatableSymbolDefinition|AsciiArtDefinition|LimbScoreDefinition|HitRangeDefinition|BashDamageProfileDefinition|ClothingModDefinition|OvermapLandUseCodeDefinition|OvermapVisionDefinition|OvermapLocationDefinition|ProfessionGroupDefinition|MapExtraCollectionDefinition|VehicleGroupDefinition|FaultGroupDefinition|ExplosionLightDefinition|AmmoEffectDefinition|AddictionTypeDefinition|CharacterModifierDefinition|StartLocationDefinition|ClimbingAidDefinition|WeatherTypeDefinition|ScoreDefinition|OverlayOrderDefinition|ZoneTypeDefinition|SpeechPoolDefinition|EndScreenDefinition|ActivityTypeDefinition|HelpTopicDefinition|SnippetCategoryDefinition|PlaylistDefinition|AttackVectorDefinition|MagicTypeDefinition|MovementModeDefinition|RegionSettingsRavineDefinition|RegionSettingsLakeDefinition|RegionSettingsOceanDefinition|RegionSettingsForestDefinition|RegionSettingsRiverDefinition|RegionSettingsForestMapgenDefinition|RegionSettingsMapExtrasDefinition|RegionSettingsTerrainFurnitureDefinition|RegionSettingsForestTrailDefinition|RegionSettingsHighwayDefinition|RegionSettingsDefinition|OptionSliderDefinition|DimensionRegionLayoutDefinition|DimensionDefinition|OmtPlaceholderDefinition|RegionTerrainFurnitureDefinition|ForestBiomeComponentDefinition|CityDefinition|FactionMissionDefinition|RegionSettingsCityDefinition|ForestBiomeMapgenDefinition

---@param definition PlatformContentDefinition
function CcbPlatformContent.add(definition) end
---@param definition PlatformContentDefinition
function CcbPlatformContent.replace(definition) end
---@param definition PlatformContentDefinition Clone of a definition staged earlier by this Mod.
function CcbPlatformContent.edit(definition) end
---@param definition ItemGroupDefinition Entry-only patch for an existing group of the same kind; preserves prior entries and rolls back transactionally.
function CcbPlatformContent.extend_item_group(definition) end

---@param id string Item id staged earlier by this Mod in the current candidate.
---@return ItemDefinition
function CcbPlatformContent.edit_item(id) end

---@param id string Recipe id staged earlier by this Mod in the current candidate.
---@return RecipeDefinition
function CcbPlatformContent.edit_recipe(id) end

---@param id string Nested recipe-category id staged earlier by this Mod.
---@return NestedRecipeCategoryDefinition
function CcbPlatformContent.edit_nested_recipe_category(id) end

---@param id string Tool-quality id staged earlier by this Mod.
---@return ToolQualityDefinition
function CcbPlatformContent.edit_tool_quality(id) end

---@param id string Skill display-category id staged earlier by this Mod.
---@return SkillDisplayDefinition
function CcbPlatformContent.edit_skill_display(id) end

---@param id string Skill id staged earlier by this Mod.
---@return SkillDefinition
function CcbPlatformContent.edit_skill(id) end

---@param id string Vitamin id staged earlier by this Mod.
---@return VitaminDefinition
function CcbPlatformContent.edit_vitamin(id) end

---@param id string JSON flag id staged earlier by this Mod.
---@return JsonFlagDefinition
function CcbPlatformContent.edit_json_flag(id) end

---@param id string Damage type id staged earlier by this Mod.
---@return DamageTypeDefinition
function CcbPlatformContent.edit_damage_type(id) end

---@param id string Material id staged earlier by this Mod.
---@return MaterialDefinition
function CcbPlatformContent.edit_material(id) end

---@param id string Ammunition-type id staged earlier by this Mod.
---@return AmmunitionTypeDefinition
function CcbPlatformContent.edit_ammunition_type(id) end

---@param id string Item-category id staged earlier by this Mod.
---@return ItemCategoryDefinition
function CcbPlatformContent.edit_item_category(id) end

---@param id string Recipe-category id staged earlier by this Mod.
---@return RecipeCategoryDefinition
function CcbPlatformContent.edit_recipe_category(id) end

---@param id string Proficiency-category id staged earlier by this Mod.
---@return ProficiencyCategoryDefinition
function CcbPlatformContent.edit_proficiency_category(id) end

---@param id string Proficiency id staged earlier by this Mod.
---@return ProficiencyDefinition
function CcbPlatformContent.edit_proficiency(id) end

---@param id string Weapon-category id staged earlier by this Mod.
---@return WeaponCategoryDefinition
function CcbPlatformContent.edit_weapon_category(id) end

---@param id string Reusable requirement id staged earlier by this Mod.
---@return RequirementDefinition
function CcbPlatformContent.edit_requirement(id) end

---@param id string Recipe-group id staged earlier by this Mod.
---@return RecipeGroupDefinition
function CcbPlatformContent.edit_recipe_group(id) end

---@param id string Scent-type id staged earlier by this Mod.
---@return ScentTypeDefinition
function CcbPlatformContent.edit_scent_type(id) end

---@param id string Speed-description id staged earlier by this Mod.
---@return SpeedDescriptionDefinition
function CcbPlatformContent.edit_speed_description(id) end

---@param id string Harvest-drop type id staged earlier by this Mod.
---@return HarvestDropTypeDefinition
function CcbPlatformContent.edit_harvest_drop_type(id) end

---@param id string Harvest-list id staged earlier by this Mod.
---@return HarvestDefinition
function CcbPlatformContent.edit_harvest(id) end

---@param id string Behavior id staged earlier by this Mod.
---@return BehaviorDefinition
function CcbPlatformContent.edit_behavior(id) end

---@param id string MonsterAttack id staged earlier by this Mod.
---@return MonsterAttackDefinition
function CcbPlatformContent.edit_monster_attack(id) end

---@param id string EffectType id staged earlier by this Mod.
---@return EffectTypeDefinition
function CcbPlatformContent.edit_effect_type(id) end

---@param id string WeakpointSet id staged earlier by this Mod.
---@return WeakpointSetDefinition
function CcbPlatformContent.edit_weakpoint_set(id) end

---@param id string FieldType id staged earlier by this Mod.
---@return FieldTypeDefinition
function CcbPlatformContent.edit_field_type(id) end

---@param id string ItemGroup id staged earlier by this Mod.
---@return ItemGroupDefinition
function CcbPlatformContent.edit_item_group(id) end

---@param id string SubBodyPart id staged earlier by this Mod.
---@return SubBodyPartDefinition
function CcbPlatformContent.edit_sub_body_part(id) end

---@param id string Wound id staged earlier by this Mod.
---@return WoundDefinition
function CcbPlatformContent.edit_wound(id) end

---@param id string BodyPart id staged earlier by this Mod.
---@return BodyPartDefinition
function CcbPlatformContent.edit_body_part(id) end

---@param id string Wound-fix id staged earlier by this Mod.
---@return WoundFixDefinition
function CcbPlatformContent.edit_wound_fix(id) end

---@param id string Anatomy id staged earlier by this Mod.
---@return AnatomyDefinition
function CcbPlatformContent.edit_anatomy(id) end

---@param id string BodyGraph id staged earlier by this Mod.
---@return BodyGraphDefinition
function CcbPlatformContent.edit_body_graph(id) end

---@param id string Monster id staged earlier by this Mod.
---@return MonsterDefinition
function CcbPlatformContent.edit_monster(id) end

---@param id string Morale-type id staged earlier by this Mod.
---@return MoraleTypeDefinition
function CcbPlatformContent.edit_morale_type(id) end

---@param id string Disease-type id staged earlier by this Mod.
---@return DiseaseTypeDefinition
function CcbPlatformContent.edit_disease_type(id) end

---@param id string Monster-flag id staged earlier by this Mod.
---@return MonsterFlagDefinition
function CcbPlatformContent.edit_monster_flag(id) end

---@param id string Species id staged earlier by this Mod.
---@return SpeciesDefinition
function CcbPlatformContent.edit_species(id) end

---@param id string Emission id staged earlier by this Mod.
---@return EmissionDefinition
function CcbPlatformContent.edit_emission(id) end

---@param id string Monster-faction id staged earlier by this Mod.
---@return MonsterFactionDefinition
function CcbPlatformContent.edit_monster_faction(id) end

---@param id string Mutation-type id staged earlier by this Mod.
---@return MutationTypeDefinition
function CcbPlatformContent.edit_mutation_type(id) end

---@param id string Connect-group id staged earlier by this Mod.
---@return ConnectGroupDefinition
function CcbPlatformContent.edit_connect_group(id) end

---@param id string Mutation-category id staged earlier by this Mod.
---@return MutationCategoryDefinition
function CcbPlatformContent.edit_mutation_category(id) end

---@param id string Construction-category id staged earlier by this Mod.
---@return ConstructionCategoryDefinition
function CcbPlatformContent.edit_construction_category(id) end

---@param id string Construction-group id staged earlier by this Mod.
---@return ConstructionGroupDefinition
function CcbPlatformContent.edit_construction_group(id) end

---@param id string Vehicle-part location id staged earlier by this Mod.
---@return VehiclePartLocationDefinition
function CcbPlatformContent.edit_vehicle_part_location(id) end

---@param id string Mood-face id staged earlier by this Mod.
---@return MoodFaceDefinition
function CcbPlatformContent.edit_mood_face(id) end

---@param id string Damage-info order id staged earlier by this Mod.
---@return DamageInfoOrderDefinition
function CcbPlatformContent.edit_damage_info_order(id) end

---@param id string Vehicle-part category id staged earlier by this Mod.
---@return VehiclePartCategoryDefinition
function CcbPlatformContent.edit_vehicle_part_category(id) end

---@param name string Named-color identity staged earlier by this Mod.
---@return NamedColorDefinition
function CcbPlatformContent.edit_named_color(name) end

---@param key string First glyph of a rotatable-symbol group staged earlier by this Mod.
---@return RotatableSymbolDefinition
function CcbPlatformContent.edit_rotatable_symbol(key) end

---@param id string ASCII-art id staged earlier by this Mod.
---@return AsciiArtDefinition
function CcbPlatformContent.edit_ascii_art(id) end

---@param id string Limb-score id staged earlier by this Mod.
---@return LimbScoreDefinition
function CcbPlatformContent.edit_limb_score(id) end

---@param id string Bash-damage profile id staged earlier by this Mod.
---@return BashDamageProfileDefinition
function CcbPlatformContent.edit_bash_damage_profile(id) end

---@param id string Clothing-modification id staged earlier by this Mod.
---@return ClothingModDefinition
function CcbPlatformContent.edit_clothing_mod(id) end

---@param id string Overmap land-use id staged earlier by this Mod.
---@return OvermapLandUseCodeDefinition
function CcbPlatformContent.edit_overmap_land_use_code(id) end

---@param id string Overmap-vision id staged earlier by this Mod.
---@return OvermapVisionDefinition
function CcbPlatformContent.edit_overmap_vision(id) end

---@param id string Overmap-location id staged earlier by this Mod.
---@return OvermapLocationDefinition
function CcbPlatformContent.edit_overmap_location(id) end

---@param id string Profession-group id staged earlier by this Mod.
---@return ProfessionGroupDefinition
function CcbPlatformContent.edit_profession_group(id) end

---@param id string Map-extra collection id staged earlier by this Mod.
---@return MapExtraCollectionDefinition
function CcbPlatformContent.edit_map_extra_collection(id) end

---@param id string Vehicle-group id staged earlier by this Mod.
---@return VehicleGroupDefinition
function CcbPlatformContent.edit_vehicle_group(id) end

---@param id string Fault-group id staged earlier by this Mod.
---@return FaultGroupDefinition
function CcbPlatformContent.edit_fault_group(id) end

---@param id string Explosion-light id staged earlier by this Mod.
---@return ExplosionLightDefinition
function CcbPlatformContent.edit_explosion_light(id) end

---@param id string Ammunition-effect id staged earlier by this Mod.
---@return AmmoEffectDefinition
function CcbPlatformContent.edit_ammo_effect(id) end

---@param id string Addiction-type id staged earlier by this Mod.
---@return AddictionTypeDefinition
function CcbPlatformContent.edit_addiction_type(id) end

---@param id string Character-modifier id staged earlier by this Mod.
---@return CharacterModifierDefinition
function CcbPlatformContent.edit_character_modifier(id) end

---@param id string Start-location id staged earlier by this Mod.
---@return StartLocationDefinition
function CcbPlatformContent.edit_start_location(id) end

---@param id string Climbing-aid id staged earlier by this Mod.
---@return ClimbingAidDefinition
function CcbPlatformContent.edit_climbing_aid(id) end

---@param id string Weather-type id staged earlier by this Mod.
---@return WeatherTypeDefinition
function CcbPlatformContent.edit_weather_type(id) end

---@param id string Score id staged earlier by this Mod.
---@return ScoreDefinition
function CcbPlatformContent.edit_score(id) end

---@return OverlayOrderDefinition Clone of the global overlay-order singleton staged earlier by this Mod.
function CcbPlatformContent.edit_overlay_order() end

---@param id string Zone-type id staged earlier by this Mod.
---@return ZoneTypeDefinition
function CcbPlatformContent.edit_zone_type(id) end

---@param id string Speech-pool id staged earlier by this Mod.
---@return SpeechPoolDefinition
function CcbPlatformContent.edit_speech_pool(id) end

---@param id string End-screen id staged earlier by this Mod.
---@return EndScreenDefinition
function CcbPlatformContent.edit_end_screen(id) end

---@param id string Activity-type id staged earlier by this Mod.
---@return ActivityTypeDefinition
function CcbPlatformContent.edit_activity_type(id) end

---@param id string Help-topic id staged earlier by this Mod.
---@return HelpTopicDefinition
function CcbPlatformContent.edit_help_topic(id) end

---@param id string Snippet-category id staged earlier by this Mod.
---@return SnippetCategoryDefinition
function CcbPlatformContent.edit_snippet_category(id) end

---@param id string Playlist id staged earlier by this Mod.
---@return PlaylistDefinition
function CcbPlatformContent.edit_playlist(id) end

---@param id string Attack-vector id staged earlier by this Mod.
---@return AttackVectorDefinition
function CcbPlatformContent.edit_attack_vector(id) end

---@param id string Magic-type id staged earlier by this Mod.
---@return MagicTypeDefinition
function CcbPlatformContent.edit_magic_type(id) end

---@param id string Movement-mode id staged earlier by this Mod.
---@return MovementModeDefinition
function CcbPlatformContent.edit_movement_mode(id) end

---@param id string Region-settings-ravine id staged earlier by this Mod.
---@return RegionSettingsRavineDefinition
function CcbPlatformContent.edit_region_settings_ravine(id) end

---@param id string Region-settings-lake id staged earlier by this Mod.
---@return RegionSettingsLakeDefinition
function CcbPlatformContent.edit_region_settings_lake(id) end

---@param id string Region-settings-ocean id staged earlier by this Mod.
---@return RegionSettingsOceanDefinition
function CcbPlatformContent.edit_region_settings_ocean(id) end

---@param id string Region-settings-forest id staged earlier by this Mod.
---@return RegionSettingsForestDefinition
function CcbPlatformContent.edit_region_settings_forest(id) end

---@param id string Region-settings-river id staged earlier by this Mod.
---@return RegionSettingsRiverDefinition
function CcbPlatformContent.edit_region_settings_river(id) end

---@param id string Region-settings-forest-mapgen id staged earlier by this Mod.
---@return RegionSettingsForestMapgenDefinition
function CcbPlatformContent.edit_region_settings_forest_mapgen(id) end

---@param id string Region-settings-map-extras id staged earlier by this Mod.
---@return RegionSettingsMapExtrasDefinition
function CcbPlatformContent.edit_region_settings_map_extras(id) end

---@param id string Region-settings-terrain-furniture id staged earlier by this Mod.
---@return RegionSettingsTerrainFurnitureDefinition
function CcbPlatformContent.edit_region_settings_terrain_furniture(id) end

---@param id string Region-settings-forest-trail id staged earlier by this Mod.
---@return RegionSettingsForestTrailDefinition
function CcbPlatformContent.edit_region_settings_forest_trail(id) end

---@param id string Region-settings-highway id staged earlier by this Mod.
---@return RegionSettingsHighwayDefinition
function CcbPlatformContent.edit_region_settings_highway(id) end

---@param id string Region-settings id staged earlier by this Mod.
---@return RegionSettingsDefinition
function CcbPlatformContent.edit_region_settings(id) end

---@param id string Option-slider id staged earlier by this Mod.
---@return OptionSliderDefinition
function CcbPlatformContent.edit_option_slider(id) end

---@param id string Dimension-region-layout id staged earlier by this Mod.
---@return DimensionRegionLayoutDefinition
function CcbPlatformContent.edit_dimension_region_layout(id) end

---@param id string Dimension id staged earlier by this Mod.
---@return DimensionDefinition
function CcbPlatformContent.edit_dimension(id) end

---@param id string Overmap-terrain-placeholder id staged earlier by this Mod.
---@return OmtPlaceholderDefinition
function CcbPlatformContent.edit_omt_placeholder(id) end

---@param id string Region-terrain-furniture id staged earlier by this Mod.
---@return RegionTerrainFurnitureDefinition
function CcbPlatformContent.edit_region_terrain_furniture(id) end

---@param id string Forest-biome-component id staged earlier by this Mod.
---@return ForestBiomeComponentDefinition
function CcbPlatformContent.edit_forest_biome_component(id) end

---@param id string City id staged earlier by this Mod.
---@return CityDefinition
function CcbPlatformContent.edit_city(id) end

---@param id string Faction-mission id staged earlier by this Mod.
---@return FactionMissionDefinition
function CcbPlatformContent.edit_faction_mission(id) end

---@param id string Region-settings-city id staged earlier by this Mod.
---@return RegionSettingsCityDefinition
function CcbPlatformContent.edit_region_settings_city(id) end

---@param id string Forest-biome-mapgen id staged earlier by this Mod.
---@return ForestBiomeMapgenDefinition
function CcbPlatformContent.edit_forest_biome_mapgen(id) end

---@class CcbPlatformNativeEvent
---@field type string Native event type without the `game:` prefix.
---@field turn integer Absolute event turn.
---@field data table<string, boolean|integer|string>
---@field data_types table<string, string>
---Live handles keyed by semantic native event fields. Character-id fields use
---names such as `character`, `attacker`, `killer`, or `victim`. `item` exists
---only for character_wields_item, character_wears_item,
---character_takeoff_item, and character_armor_destroyed when the native event
---actually carries an item_location talker. Only semantic event-field names
---and detached snapshots are exposed; no positional/avatar fallback or
---compatibility aliases are added.
---@field actors table<string, CcbDialogueParticipant|CcbDetachedDialogueParticipant>

---@class CcbDetachedDialogueParticipant
---@field kind 'computer'|'zone'|'topic'|'talker'|'item' Detached participant kind.
---@field name string Bounded display name snapshot.
---@field position TripointCoord Bounded absolute map-square position snapshot.

---@alias CcbDialogueParticipant GameHandle|CcbDetachedDialogueParticipant

---@class CcbPlatformDialogueStartHook
---@field speaker CcbDialogueParticipant Actual dialogue speaker; no positional avatar fallback.
---@field interlocutor CcbDialogueParticipant The exact entity handle or detached non-entity snapshot.
---@field initial_topic string Initial dialogue topic id.
---@field by_radio? boolean Present and true only when the dialogue runs over radio contact.
---@field reason? string Present only when the dialogue was opened with a reason string.

---@class CcbPlatformDialogueOptionHook
---@field speaker CcbDialogueParticipant Actual dialogue speaker; no positional avatar fallback.
---@field interlocutor CcbDialogueParticipant The exact entity handle or detached non-entity snapshot.
---@field current_topic string Topic being left.
---@field selected_topic string Topic selected by the native dialogue response.
---@field by_radio? boolean Present and true only when the dialogue runs over radio contact.
---@field reason? string Present only when the dialogue was opened with a reason string.

---@class CcbPlatformDialogueEndHook
---@field speaker CcbDialogueParticipant Actual dialogue speaker; no positional avatar fallback.
---@field interlocutor CcbDialogueParticipant The exact entity handle or detached non-entity snapshot.
---@field last_topic string Last processed dialogue topic id.
---@field by_radio? boolean Present and true only when the dialogue runs over radio contact.
---@field reason? string Present only when the dialogue was opened with a reason string.

---@class CcbPlatformAvatarFatalHook
---@field hook 'on_avatar_fatal'
---@field character GameHandle Avatar at the synchronous fatal-damage boundary.
---@field killer? GameHandle Creature credited with the fatal damage, when still available.
---@field cancellable true Returning false prevents death by restoring each vital body part to at least one HP.
---@field results table Aggregate results from earlier handlers; `allowed` is false after a veto.

---@class CcbPlatformNpcFatalHook
---@field hook 'on_npc_fatal'
---@field character GameHandle NPC at the synchronous fatal-damage boundary.
---@field killer? GameHandle Creature credited with the fatal damage, when available.
---@field cancellable true Returning false prevents death by restoring each vital body part to at least one HP.
---@field results table Aggregate results from earlier handlers; `allowed` is false after a veto.

---@class CcbPlatformRuntime
local CcbPlatformRuntime = {}

---@param id string
---@param callback fun(payload: any): any
---@param payload_version? integer
function CcbPlatformRuntime.handler(id, callback, payload_version) end

---Register one per-Character recurring policy. The effect handler runs only
---when the Character-local due turn is reached; the interval handler runs on
---initial enrollment and after every due effect and must return 1..31536000
---integral turns. Due state is stored on each Character and survives save/load.
---@param effect_handler string Registered handler receiving PlatformCharacterRecurringPayload.
---@param interval_handler string Registered handler receiving PlatformCharacterRecurringPayload and returning integer turns.
function CcbPlatformRuntime.character_recurring(effect_handler, interval_handler) end

---@class PlatformCharacterRecurringPayload
---@field character GameHandle Generation-safe Character handle.
---@field first_schedule boolean True while initializing this Character's first due turn.
---@field due_turn? integer Absolute due turn when an effect is running.
---@field overdue_turns integer Non-negative lateness at invocation.

---@param event_name string `world_ready`, `before_save`, `after_save`, `shutdown`, or `game:<event>`.
---@param handler_id string
function CcbPlatformRuntime.on(event_name, handler_id) end

---@param hook_name string Native synchronous hook name from the checked hook catalog.
---@param handler_id string Named Platform handler.
function CcbPlatformRuntime.hook(hook_name, handler_id) end

---Render a low-level Lua-owned topic inside the native NPC dialogue window.
---The named handler receives CcbPlatformDialogueRenderHook for both phases.
---A topic id cannot also be registered with ccb.dialogue.register_topic.
---@param topic_id string Native dialogue topic id.
---@param handler_id string Named Platform handler returning a line or response array.
function CcbPlatformRuntime.dialogue_topic(topic_id, handler_id) end

---@class CcbPlatformDialogueResponse
---@field text string Player response displayed by the native dialogue window.
---@field topic? string Next native or Lua-owned topic; defaults to `TALK_NONE`.

---@class PlatformDialogueContext
local PlatformDialogueContext = {}

---@return boolean Whether this callback-scoped context can still be used.
function PlatformDialogueContext:valid() end

---@return integer Current dialogue session generation; stale contexts cannot be reused.
function PlatformDialogueContext:generation() end

---@return string Native dialogue topic currently being rendered or selected.
function PlatformDialogueContext:topic() end

---@return string
function PlatformDialogueContext:topic_item() end

---@return boolean
function PlatformDialogueContext:has_speaker() end

---@return boolean
function PlatformDialogueContext:has_interlocutor() end

---@return boolean
function PlatformDialogueContext:by_radio() end

---@return boolean
function PlatformDialogueContext:has_reason() end

---@return string
function PlatformDialogueContext:reason() end

---@param kind string
---@param difficulty integer
---@param skill? string
---@return integer
function PlatformDialogueContext:trial_chance(kind, difficulty, skill) end

---@param kind string
---@param difficulty integer
---@param skill? string
---@return boolean
function PlatformDialogueContext:roll_trial(kind, difficulty, skill) end

---@param text string
---@param item_id? string
---@return string
function PlatformDialogueContext:expand_text(text, item_id) end

---@return CcbDialogueParticipant|nil
function PlatformDialogueContext:speaker() end

---@return CcbDialogueParticipant|nil
function PlatformDialogueContext:interlocutor() end

---@param key string
---@return boolean|number|string|nil value
function PlatformDialogueContext:get(key) end

---@param key string
---@param value boolean|number|string|nil
function PlatformDialogueContext:set(key, value) end

---@param key string
function PlatformDialogueContext:remove(key) end

---@class CcbPlatformDialogueResponseDescriptor
---@field text string Player response displayed by the native dialogue window.
---@field topic? string Next native or Lua-owned topic; defaults to `TALK_NONE`.
---@field on_select? fun(context: PlatformDialogueContext): string|{ topic?: string }|nil Runs after the native response effect and may override its next topic.

---@alias CcbPlatformDialogueResponses CcbPlatformDialogueResponseDescriptor[]|fun(context: PlatformDialogueContext): CcbPlatformDialogueResponseDescriptor[]

---@class CcbPlatformDialogueTopicDescriptor
---@field id string Native dialogue topic id.
---@field dynamic_line string|fun(context: PlatformDialogueContext): string
---@field responses CcbPlatformDialogueResponses

---@class CcbPlatformDialogueExtensionDescriptor
---@field id string Native dialogue topic id to extend.
---@field insert_before_standard_exits? boolean Insert responses before the native standard exits.
---@field responses CcbPlatformDialogueResponses

---@class CcbPlatformDialogueLimits
---@field topics integer
---@field extensions integer
---@field responses_per_topic integer
---@field id_bytes integer
---@field text_bytes integer

---@class CcbPlatformDialogueApi
local CcbPlatformDialogueApi = {}

---@param descriptor CcbPlatformDialogueTopicDescriptor
---@return integer registration_id
function CcbPlatformDialogueApi.register_topic(descriptor) end

---@param descriptor CcbPlatformDialogueExtensionDescriptor
---@return integer registration_id
function CcbPlatformDialogueApi.extend_topic(descriptor) end

---@return CcbPlatformDialogueLimits
function CcbPlatformDialogueApi.limits() end

---@class CcbPlatformDialogueRenderHook
---@field speaker CcbDialogueParticipant Actual dialogue speaker; no positional avatar fallback.
---@field interlocutor CcbDialogueParticipant The exact entity handle or detached snapshot.
---@field has_speaker boolean Whether the native speaker exists.
---@field has_interlocutor boolean Whether the native interlocutor exists.
---@field by_radio boolean Whether the dialogue is using radio contact.
---@field reason string Dialogue reason, possibly empty.
---@field topic string Topic currently being rendered.
---@field phase 'line'|'responses' Return a string for `line`, or CcbPlatformDialogueResponse[] for `responses`.

---@class PlatformTaskMigration
---@field task_id integer
---@field handler_id string
---@field owner 'character'|'world'
---@field from_version integer
---@field to_version integer

---@param handler_id string
---@param from_version integer
---@param to_version integer
---@param callback fun(payload: table<string, boolean|integer|number|string>, migration: PlatformTaskMigration): table<string, boolean|integer|number|string>
function CcbPlatformRuntime.migrate_task_payload(handler_id, from_version, to_version, callback) end

---@class CcbPlatformStateScope
local CcbPlatformStateScope = {}

---@param key string
---@param fallback? boolean|integer|number|string
---@return boolean|integer|number|string|nil
function CcbPlatformStateScope.get(key, fallback) end

---@param key string
---@param value boolean|integer|number|string|nil
function CcbPlatformStateScope.set(key, value) end

---@class CcbPlatformState
---@field character CcbPlatformStateScope
---@field world CcbPlatformStateScope

---@class PlatformTaskPayload
---@field id integer
---@field due_turn integer
---@field overdue_turns integer
---@field recurring boolean
---@field interval_turns integer
---@field next_due_turn? integer
---@field owner 'character'|'world'
---@field owner_mod_id string Exact owning Platform Mod id.
---@field actor? GameHandle Transient callback-only exact live Character, Item, Monster, or Vehicle handle; never persisted in the payload.
---@field actor_kind? 'character'|'item'|'monster'|'vehicle' Transient callback-only actor kind; nil when there is no actor.
---@field actor_character_id? integer Transient callback-only stable Character id; nil for an Item, Monster, Vehicle, or absent actor.
---@field actor_item_uid? integer Transient callback-only stable Item uid; nil for a Character, Monster, Vehicle, or absent actor.
---@field actor_monster_uid? integer Transient callback-only stable Monster uid; nil for a Character, Item, Vehicle, or absent actor.
---@field actor_vehicle_uid? integer Transient callback-only stable Vehicle uid; nil for a Character, Item, Monster, or absent actor.
---@field participants table<string, GameHandle> Transient callback-only exact live required participant handles keyed by role; never persisted in the payload.
---@field payload_version integer
---@field payload table<string, boolean|integer|number|string> Persistent scalar payload; live GameHandle values are rejected and never stored.

---@class CcbPlatformTaskParticipantDescriptor
---@field kind 'character'|'item'|'monster'|'vehicle' Persisted participant identity kind.
---@field character_id? integer Stable Character id; nil unless kind is 'character'.
---@field item_uid? integer Stable Item uid; nil unless kind is 'item'.
---@field monster_uid? integer Stable Monster uid; nil unless kind is 'monster'.
---@field vehicle_uid? integer Stable Vehicle uid; nil unless kind is 'vehicle'.
---@field pending boolean True when this required participant is unavailable; the whole task retries after 3600 turns without invoking its handler or scheduling its next recurring cycle.

---@class CcbPlatformTaskSnapshot
---@field id integer
---@field handler string
---@field due_turn integer
---@field remaining_turns integer
---@field overdue_turns integer
---@field recurring boolean
---@field interval_turns integer
---@field owner 'character'|'world'
---@field owner_mod_id string Exact owning Platform Mod id.
---@field actor_kind? 'character'|'item'|'monster'|'vehicle' Actor identity kind; nil when there is no actor.
---@field actor_character_id? integer Stable Character id; nil unless actor_kind is 'character'.
---@field actor_item_uid? integer Stable Item uid; nil unless actor_kind is 'item'.
---@field actor_item_pending boolean True when an Item actor is absent from the bounded loaded lookup; the task retries after 3600 turns without invoking its handler or scheduling its next recurring cycle.
---@field actor_monster_uid? integer Stable Monster uid; nil unless actor_kind is 'monster'.
---@field actor_monster_pending boolean True when a Monster actor is absent from the loaded creature lookup; the task retries after 3600 turns without invoking its handler or scheduling its next recurring cycle.
---@field actor_vehicle_uid? integer Stable Vehicle uid; nil unless actor_kind is 'vehicle'.
---@field actor_vehicle_pending boolean True when a Vehicle actor is absent from the loaded map lookup; the task retries after 3600 turns without invoking its handler or scheduling its next recurring cycle.
---@field participants table<string, CcbPlatformTaskParticipantDescriptor> Required participant descriptors keyed by validated role name; if any participant is pending, the whole task retries after 3600 turns without invoking its handler or scheduling its next recurring cycle.
---@field payload_version integer
---@field handler_available boolean
---@field payload_current boolean
---@field payload table<string, boolean|integer|number|string>

---@class CcbPlatformTaskPage
---@field items CcbPlatformTaskSnapshot[]
---@field total integer
---@field returned integer
---@field limit integer
---@field truncated boolean

---@class CcbPlatformTasks
local CcbPlatformTasks = {}

---@param turns integer Non-negative delay in game turns.
---@param handler_id string
---@param payload? table<string, boolean|integer|number|string> Persistent scalar payload; live GameHandle values are rejected and never stored.
---@param payload_version? integer
---@param scope? 'character'|'world'
---@param actor? GameHandle Exact live Character, Item, Monster, or Vehicle handle; only the stable actor identity is persisted and the live handle is callback-transient.
---@param participants? table<string, GameHandle> Optional required participant handles keyed by unique role names; at most 4 participants. Role names must match ASCII `[A-Za-z_][A-Za-z0-9_]{0,31}`.
---@return integer task_id
function CcbPlatformTasks.after(turns, handler_id, payload, payload_version, scope, actor, participants) end

---@param task_id integer
---@return boolean cancelled
function CcbPlatformTasks.cancel(task_id) end

---@class PlatformChoice
---@field id string Stable value returned to Lua when selected.
---@field label string Player-facing label.
---@field description? string Optional longer explanation.
---@field enabled? boolean Whether the choice can be selected; defaults to true.

---@class PlatformTextInputOptions
---@field initial? string Initial editable value.
---@field description? string Help text displayed with the input.
---@field width? integer Input width from zero through 240 cells; zero uses the native default.
---@field max_length? integer Maximum Unicode characters, from one through 32768.
---@field only_digits? boolean Reject non-digit input.

---@class PlatformCanvasOptions
---@field title? string Nonempty title, at most 256 bytes.
---@field width? integer Logical pixel width, 1..2048; default 960.
---@field height? integer Logical pixel height, 1..2048; default 720.
---@field allow_quit? boolean Allow the native close control and QUIT action; default true. Otherwise the callback must provide a close button.
---@field music? string Existing audio file relative to the owning Mod. Canonical paths must remain inside that Mod; temporary music is restored on exit.

---@class PlatformCanvasContext
---@field width integer Logical pixel width (not the scaled window width); read-only.
---@field height integer Logical pixel height; read-only.
---@field elapsed_ms integer Monotonic real milliseconds since opening; read-only.
---@field delta_ms integer Real milliseconds since the previous frame, capped at 250; read-only.
local PlatformCanvasContext = {}

---Every method and property rejects use after its frame callback returns.
---@return boolean open
function PlatformCanvasContext:is_open() end

function PlatformCanvasContext:close() end

---Primitives share a 4096-operation limit per frame and are clipped to the canvas. Coordinates are finite, within +/-8192; sizes within 0..8192. Colors use finite 0..1 RGBA.
---@param x number
---@param y number
---@param width number
---@param height number
---@param r number
---@param g number
---@param b number
---@param a number
function PlatformCanvasContext:rect(x, y, width, height, r, g, b, a) end

---@param x number
---@param y number
---@param value string Text up to 4096 bytes; no NUL.
---@param r number
---@param g number
---@param b number
---@param a number
function PlatformCanvasContext:text(x, y, value, r, g, b, a) end

---@param id string Registered tileset tile id, at most 256 bytes.
---@param x number
---@param y number
---@param width number
---@param height number
---@return boolean drawn False when the tile or texture is unavailable.
function PlatformCanvasContext:sprite(id, x, y, width, height) end

---@param id string Stable nonempty button id up to 96 bytes; unique within the frame.
---@param label string Label up to 512 bytes.
---@param x number
---@param y number
---@param width number Positive width.
---@param height number Positive height.
---@param request_focus? boolean Request keyboard focus; default false.
---@return boolean clicked
function PlatformCanvasContext:button(id, label, x, y, width, height, request_focus) end

---@class CcbPlatformPresentation
local CcbPlatformPresentation = {}

---Runtime callbacks in a ready world only. Uses native ImGui/tileset rendering, fits logical pixels to the display, and does not advance game turns. Nested canvases are rejected. Callback errors close the window, invalidate the frame and propagate; music is restored on every exit.
---@param options PlatformCanvasOptions
---@param draw fun(context: PlatformCanvasContext) Frame-local drawing and interaction callback; do not retain the context.
---@return boolean available False without a graphical renderer; the callback is never invoked in that case.
function CcbPlatformPresentation.canvas(options, draw) end

---Play an existing Mod-relative audio asset from a runtime callback. Canonical paths must stay inside the owning Mod. No-op without sound support.
---@param file string Relative audio path, at most 1024 bytes.
---@param volume? integer Native volume 0..128, default 100.
function CcbPlatformPresentation.play_sound(file, volume) end

---@param message string
function CcbPlatformPresentation.notice(message) end

---@param question string
---@return boolean confirmed
function CcbPlatformPresentation.confirm(question) end

---@param prompt string
---@param entries PlatformChoice[] Dense one-based array; holes and non-integer keys are rejected.
---@return string|nil selected_id
function CcbPlatformPresentation.choose(prompt, entries) end

---@param prompt string
---@param options? PlatformTextInputOptions
---@return string|nil text
function CcbPlatformPresentation.input_text(prompt, options) end

---@class CcbPlatformInteractionApi
local CcbPlatformInteractionApi = {}

---@class CcbPlatformInteractionChoice
---@field id string
---@field label string
---@field description? string
---@field enabled? boolean
---@field hotkey? string One ASCII letter or digit.

---@class CcbPlatformInteractionChoiceOptions
---@field title? string
---@field allow_cancel? boolean
---@field highlight_disabled? boolean

---@class CcbPlatformInteractionChoiceResult
---@field accepted boolean
---@field cancelled boolean
---@field index? integer One-based selected index.
---@field id? string Selected entry id.

---@param message string
---@return boolean confirmed
function CcbPlatformInteractionApi.confirm(message) end

---@param title string
---@param options? PlatformTextInputOptions
---@return string|nil text
function CcbPlatformInteractionApi.input_text(title, options) end

---@param description string
---@param default_value integer
---@return integer|nil value
function CcbPlatformInteractionApi.input_number(description, default_value) end

---@param entries CcbPlatformInteractionChoice[]
---@param options? CcbPlatformInteractionChoiceOptions
---@return CcbPlatformInteractionChoiceResult
function CcbPlatformInteractionApi.choose(entries, options) end

---Callback-scoped mapgen transaction context. A callback transaction failure
---automatically rolls back its mapgen mutations. Ordinary `services` write
---operations are prohibited from mapgen callbacks; use this context's
---transactional operations instead.
---@class ScriptMapgenContext
local ScriptMapgenContext = {}

---@return boolean
function ScriptMapgenContext:valid() end

---@return integer
function ScriptMapgenContext:operations_used() end

---@return integer
function ScriptMapgenContext:operations_remaining() end

---@return GameId
function ScriptMapgenContext:id() end

---@return GameId
function ScriptMapgenContext:north() end

---@return GameId
function ScriptMapgenContext:east() end

---@return GameId
function ScriptMapgenContext:south() end

---@return GameId
function ScriptMapgenContext:west() end

---@return GameId
function ScriptMapgenContext:neast() end

---@return GameId
function ScriptMapgenContext:seast() end

---@return GameId
function ScriptMapgenContext:swest() end

---@return GameId
function ScriptMapgenContext:nwest() end

---@return GameId
function ScriptMapgenContext:above() end

---@return GameId
function ScriptMapgenContext:below() end

---@param index integer
---@return GameId
function ScriptMapgenContext:get_nesw(index) end

---@return integer
function ScriptMapgenContext:zlevel() end

---@param index integer
---@return integer
function ScriptMapgenContext:get_direction(index) end

---@param index integer
---@param value integer
function ScriptMapgenContext:set_dir(index, value) end

---@return integer
function ScriptMapgenContext:get_rotation() end

---@return string
function ScriptMapgenContext:get_rot_suffix() end

---@param minimum integer
---@param maximum integer
---@return integer
function ScriptMapgenContext:random_int(minimum, maximum) end

---@param numerator integer
---@param denominator integer
---@return boolean
function ScriptMapgenContext:random_chance(numerator, denominator) end

---@param x integer
---@param y integer
---@return GameId
function ScriptMapgenContext:terrain_at(x, y) end

---@param x integer
---@param y integer
---@return GameId|nil
function ScriptMapgenContext:furniture_at(x, y) end

---@param x integer
---@param y integer
---@return GameId|nil
function ScriptMapgenContext:trap_at(x, y) end

---@param x integer
---@param y integer
---@param id GameId
---@return boolean
function ScriptMapgenContext:set_terrain(x, y, id) end

---@param x integer
---@param y integer
---@param id GameId|nil
---@return boolean
function ScriptMapgenContext:set_furniture(x, y, id) end

---@param x integer
---@param y integer
---@param id GameId|nil
---@return boolean
function ScriptMapgenContext:set_trap(x, y, id) end

---@param x integer
---@param y integer
---@param id string
---@return boolean
function ScriptMapgenContext:set_terrain_id(x, y, id) end

---@param x integer
---@param y integer
---@param id string
---@return boolean
function ScriptMapgenContext:set_furniture_id(x, y, id) end

---@param x integer
---@param y integer
---@param id string
---@return boolean
function ScriptMapgenContext:set_trap_id(x, y, id) end

---@param terrain_id string
function ScriptMapgenContext:reset(terrain_id) end

---Assign ownership to ground items and their contents within the current OMT.
---Does not change vehicles, vehicle cargo, NPCs, furniture or terrain.
---Uses the submap transaction, so callback failure restores prior ownership.
---Consumes one operation per tile and per top-level item, reserved before any change.
---@param x1 integer Local start x, 0..23.
---@param y1 integer Local start y, 0..23.
---@param x2 integer Local end x, x1..23.
---@param y2 integer Local end y, y1..23.
---@param faction string Existing non-empty faction ID.
function ScriptMapgenContext:set_item_faction(x1, y1, x2, y2, faction) end

---@param x integer
---@param y integer
---@param item_id string
---@param quantity integer
---@param charges integer
---@param faction_id string
function ScriptMapgenContext:place_item(x, y, item_id, quantity, charges, faction_id) end

---@param x1 integer
---@param y1 integer
---@param x2 integer
---@param y2 integer
---@param group_id string
---@param chance integer
---@param faction_id string
function ScriptMapgenContext:place_item_group(x1, y1, x2, y2, group_id, chance, faction_id) end

---@param x integer
---@param y integer
---@param item_id string
---@param charges integer
function ScriptMapgenContext:place_liquid(x, y, item_id, charges) end

---@param x integer
---@param y integer
---@param charges integer
function ScriptMapgenContext:place_toilet(x, y, charges) end

---@param x integer
---@param y integer
---@param field_id string
---@param intensity integer
---@param age_turns integer
---@return boolean
function ScriptMapgenContext:add_field(x, y, field_id, intensity, age_turns) end

---@param x integer
---@param y integer
---@param field_id string
---@return boolean
function ScriptMapgenContext:remove_field(x, y, field_id) end

---@param x integer
---@param y integer
---@param item_group_id string
---@param reinforced boolean
---@param lootable boolean
---@param powered boolean
---@param networked boolean
function ScriptMapgenContext:place_vending_machine(x, y, item_group_id, reinforced, lootable, powered, networked) end

---@param x integer
---@param y integer
---@param charges integer
---@param fuel_id string
function ScriptMapgenContext:place_gas_pump(x, y, charges, fuel_id) end

---@param x1 integer
---@param y1 integer
---@param x2 integer
---@param y2 integer
---@param group_id string
---@param chance integer
---@param density number
---@param individual boolean
---@param friendly boolean
---@param name string
---@param mission_target boolean
function ScriptMapgenContext:place_monster_group(x1, y1, x2, y2, group_id, chance, density, individual, friendly, name, mission_target) end

---@param x integer
---@param y integer
---@param monster_id string
---@param count integer
---@param friendly boolean
---@param name string
---@param mission_target boolean
function ScriptMapgenContext:place_monster(x, y, monster_id, count, friendly, name, mission_target) end

---@param x integer
---@param y integer
---@param monster_id string
---@param age_days integer
function ScriptMapgenContext:place_corpse(x, y, monster_id, age_days) end

---@param x integer
---@param y integer
---@param group_id string
---@param age_days integer
function ScriptMapgenContext:place_corpse_from_group(x, y, group_id, age_days) end

---@param x integer
---@param y integer
---@param furniture_id string
---@param items boolean
---@param floor_terrain_id string
---@param overwrite boolean
function ScriptMapgenContext:make_rubble(x, y, furniture_id, items, floor_terrain_id, overwrite) end

---@param x integer
---@param y integer
---@param name string
---@param security integer
---@param access_denied string
---@param mission_target boolean
---@return boolean
function ScriptMapgenContext:place_computer(x, y, name, security, access_denied, mission_target) end

---@param x integer
---@param y integer
---@param name string
---@param action string
---@param security integer
function ScriptMapgenContext:add_computer_option(x, y, name, action, security) end

---@param x integer
---@param y integer
---@param failure string
function ScriptMapgenContext:add_computer_failure(x, y, failure) end

---@param x integer
---@param y integer
---@param eoc_id string
function ScriptMapgenContext:add_computer_eoc(x, y, eoc_id) end

---@param x integer
---@param y integer
---@param handler_id string
function ScriptMapgenContext:set_computer_access_handler(x, y, handler_id) end

---@param x integer
---@param y integer
---@param topic_id string
function ScriptMapgenContext:add_computer_chat_topic(x, y, topic_id) end

---@param x integer
---@param y integer
---@param furniture_id string
---@param item_id string
---@param quantity integer
---@param charges integer
---@param item_group_name string
---@param item_group_chance integer
---@param faction_id string
function ScriptMapgenContext:place_sealed_item(x, y, furniture_id, item_id, quantity, charges, item_group_name, item_group_chance, faction_id) end

---@param x integer
---@param y integer
---@param text string
---@param furniture_id string
function ScriptMapgenContext:place_sign(x, y, text, furniture_id) end

---@param x integer
---@param y integer
---@param text string
function ScriptMapgenContext:set_graffiti(x, y, text) end

---@param name string
---@param x integer
---@param y integer
function ScriptMapgenContext:queue_point(name, x, y) end

---Stage a native static NPC; published only after this map callback commits.
---At most 128 NPC requests per context. Existing unique IDs are skipped at publication.
---Callback failure discards all requests; this method does not return a live NPC handle.
---Native publication errors are logged without rolling back the already committed map.
---@param x integer Local x, 0..23.
---@param y integer Local y, 0..23.
---@param template_id string Existing NPC template ID.
---@param unique_id string Empty, or a unique ID of at most 256 non-NUL bytes.
function ScriptMapgenContext:queue_npc(x, y, template_id, unique_id) end

---Stage a global zone; published before queued NPCs, only after the map callback commits.
---At most 128 zone requests per context; no vehicle binding or personal zones.
---Native publication errors are logged without rolling back the already committed map.
---@param x1 integer Local start x, 0..23.
---@param y1 integer Local start y, 0..23.
---@param x2 integer Local end x, x1..23.
---@param y2 integer Local end y, y1..23.
---@param zone_type string Existing zone type ID.
---@param faction string Existing faction ID.
---@param name string At most 4096 non-NUL bytes.
---@param filter string Empty, or at most 4096 non-NUL bytes for a custom loot zone.
function ScriptMapgenContext:queue_zone(x1, y1, x2, y2, zone_type, faction, name, filter) end

function ScriptMapgenContext:fill_groundcover() end

---@class CcbPlatformMapgenRegistrationOptions
---@field terrain_ids? string[] Concrete directional overmap-terrain ids to match.
---@field z_min? integer Minimum generated z level.
---@field z_max? integer Maximum generated z level.

---@class MapgenUpdateToken
---@field id GameId GameId<update_mapgen> Typed identity of the registered update-mapgen definition.
---@field runtime_generation integer Lua Platform runtime generation bound at issuance.
---@field world_generation integer World generation bound at issuance.
---@field owner_is_current fun(self: MapgenUpdateToken): boolean False when the issuing runtime owner is no longer live.
---@field is_valid fun(self: MapgenUpdateToken): boolean False when the owner, runtime, world, or registered update-mapgen identity is stale.

---@class MapgenTransactionFootprint
---@field min_submap_x integer Inclusive minimum submap x offset relative to the target OMT.
---@field max_submap_x integer Inclusive maximum submap x offset relative to the target OMT.
---@field min_submap_y integer Inclusive minimum submap y offset relative to the target OMT.
---@field max_submap_y integer Inclusive maximum submap y offset relative to the target OMT.
---@field min_z integer Inclusive minimum z-level in the transactional footprint.
---@field max_z integer Inclusive maximum z-level in the transactional footprint.
---@field complete_omt_z_stack boolean True when the footprint covers the complete target OMT z-stack.

---@class MapgenTransactionResult
---@field state 'committed' Committed native transaction state; this value is published only after commit.
---@field code 'committed' Stable native transaction success code.
---@field message '' Empty native transaction diagnostic on success.
---@field footprint MapgenTransactionFootprint Exact valid transactional footprint committed by native mapgen.
---@field target OvermapTileToken Exact target token supplied to the transaction.
---@field update MapgenUpdateToken Exact update token supplied to the transaction.

---@class CcbMapgenTransactionError: CcbPlatformResultError
---@field state 'rejected'|'rolled_back'|'rollback_failed' Native terminal transaction failure state.
---@field code string Stable native transaction failure code.
---@field message string Native transaction diagnostic for the failed transaction.
---@field footprint? MapgenTransactionFootprint Exact footprint when native preflight established one; omitted when no valid footprint exists.
---@field target OvermapTileToken Exact target token supplied to the transaction.
---@field update MapgenUpdateToken Exact update token supplied to the transaction.

---@class CcbMapgenTransactionResult: CcbResult
---@field value? MapgenTransactionResult Present only when the transaction commits with `state = 'committed'`.
---@field error? CcbMapgenTransactionError Present for rejected, rolled-back, or rollback-failed transactions.

---@class CcbMapgenApplyOptions
---Transforms are intentionally unavailable and fail closed until external NPC, zone,
---and vehicle state can participate in the transaction.
---@field cancel_on_collision? true Omitted or `{}` uses transactional collision cancellation; when supplied, this must be true.

---@class CcbMapgenApi
local CcbMapgenApi = {}

---@param id GameId GameId<update_mapgen> Existing registered update-mapgen definition.
---@return CcbResult result `value` is a value-only MapgenUpdateToken.
function CcbMapgenApi.update_token(id) end

---@param target OvermapTileToken Exact target absolute OMT token.
---@param update MapgenUpdateToken Exact value-only update-mapgen token.
---@param options? CcbMapgenApplyOptions Optional strict transactional mapgen options.
---@return CcbMapgenTransactionResult result `ok=true` only when `value.state` is `'committed'`; `rejected`, `rolled_back`, and `rollback_failed` are reported in `error`.
function CcbMapgenApi.apply(target, update, options) end

---Register a primary OMT generator invoked before native missing-mapgen fallback.
---@param handler_id string Registered Platform handler receiving `{ context = ScriptMapgenContext }`.
---@param options? CcbPlatformMapgenRegistrationOptions
function CcbMapgenApi.on_generate(handler_id, options) end

---Register a generator invoked after the primary native or Platform mapgen finishes.
---@param handler_id string Registered Platform handler receiving `{ context = ScriptMapgenContext }`.
---@param options? CcbPlatformMapgenRegistrationOptions
function CcbMapgenApi.on_postprocess(handler_id, options) end

---@class CcbCampResourceEntry
---@field id GameId GameId<item> fake resource id; it is unique within this camp.
---@field ammo_id? GameId GameId<item> Native charge id when the resource has one.
---@field available integer Current available native charges.
---@field consumed integer Native consumption bookkeeping value.

---@class CcbCampResourceChange
---@field id GameId GameId<item> Existing camp resource fake id; vector indexes are not accepted.
---@field delta integer Positive adds and negative consumes; the whole batch is preflighted.

---@class CcbCampFoodSnapshot
---@field kcal integer Current owner-faction food supply in kilocalories.
---@field consumes_food boolean Whether the owner has a finite consumable food supply.

---@class CcbCampResourcePage
---@field camp GameHandle Exact camp handle used for the snapshot.
---@field resources CcbCampResourceEntry[] Semantically unique camp resources.
---@field food CcbCampFoodSnapshot Real food supply of the camp owner faction.
---@field total integer Number of unique resource keys.
---@field offset integer Explicit resource-page offset.
---@field limit integer Effective bounded page limit.
---@field returned integer Number of entries in this page.
---@field complete boolean True when the unique resource list was exhausted.
---@field truncated boolean True when the page limit capped the list.

---@class CcbCampResourcesApi
local CcbCampResourcesApi = {}

---@param camp GameHandle Exact live camp handle.
---@param manager GameHandle Exact live avatar or NPC Character authorized for the camp.
---@param options? table<string, integer> Bounded `offset` and `limit`.
---@return CcbResult result `value` is a CcbCampResourcePage.
function CcbCampResourcesApi.snapshot(camp, manager, options) end

---@param camp GameHandle Exact live camp handle.
---@param manager GameHandle Exact live avatar or NPC Character authorized for the camp.
---@param changes CcbCampResourceChange[] Dense typed resource changes; all are checked before commit.
---@return CcbResult result
function CcbCampResourcesApi.adjust(camp, manager, changes) end

---@param camp GameHandle Exact live camp handle.
---@param manager GameHandle Exact live avatar or NPC Character authorized for the camp.
---@param resource_id GameId GameId<item> existing camp resource fake id.
---@param amount integer Positive bounded native quantity.
---@return CcbResult result
function CcbCampResourcesApi.add(camp, manager, resource_id, amount) end

---@param camp GameHandle Exact live camp handle.
---@param manager GameHandle Exact live avatar or NPC Character authorized for the camp.
---@param resource_id GameId GameId<item> existing camp resource fake id.
---@param amount integer Positive bounded native quantity.
---@return CcbResult result
function CcbCampResourcesApi.consume(camp, manager, resource_id, amount) end

---@class CcbCampFoodMutation
---@field camp GameHandle Exact camp handle used for the mutation.
---@field before_kcal integer Food supply before the operation.
---@field after_kcal integer Food supply after the operation.
---@field amount_kcal integer Applied bounded quantity.
---@field added boolean True for an add operation.
---@field consumed boolean True for a consume operation.
---@field changed boolean Whether the native calorie value changed.

---@class CcbCampFoodApi
local CcbCampFoodApi = {}

---@param camp GameHandle Exact live camp handle.
---@param manager GameHandle Exact live avatar or NPC Character authorized for the camp.
---@param kcal integer Positive bounded calorie quantity.
---@return CcbResult result `value` is a CcbCampFoodMutation.
function CcbCampFoodApi.add(camp, manager, kcal) end

---@param camp GameHandle Exact live camp handle.
---@param manager GameHandle Exact live avatar or NPC Character authorized for the camp.
---@param kcal integer Positive bounded calorie quantity.
---@return CcbResult result `value` is a CcbCampFoodMutation.
function CcbCampFoodApi.consume(camp, manager, kcal) end

---@class CampExpansionToken
---@field expansion_id integer Stable Platform expansion identity; never reused.
---@field identity_generation integer Retired when the expansion is removed, replaced, or its camp owner changes.
---@field runtime_generation integer Runtime generation bound at issuance.
---@field world_generation integer World generation bound at issuance.
---@field camp_stable_id integer Stable owning camp identity.
---@field camp_identity_generation integer Owning camp generation bound at issuance.
---@field owner_faction string Stable faction id snapshot; owner changes stale the token.
---@field is_valid fun(self: CampExpansionToken): boolean False after expansion/camp/owner/runtime/world retirement.

---@alias CcbCampTaskKind 'worker_reservation'|'resource_work'|'recipe_work'|'upgrade_work'

---@alias CcbCampTaskState 'pending'|'running'|'refund_pending'|'completed_unclaimed'|'completed'|'cancelled'

---@class CcbCampResourceWorkChange
---@field id GameId GameId<item> Existing camp resource fake id.
---@field amount integer Positive bounded amount; duplicate keys are rejected.

---@class CcbCampResourceWorkDescriptor
---@field resource_inputs? CcbCampResourceWorkChange[] Explicit resource inputs reserved at start.
---@field resource_outputs? CcbCampResourceWorkChange[] Explicit resource outputs applied at completion.
---@field food_input_kcal? integer Optional owner-faction food input reserved at start.
---@field food_output_kcal? integer Optional owner-faction food output applied at completion.
---@field duration_turns integer Positive bounded task duration; persisted with the task.

---@class CcbCampRecipeHolder
---@field kind 'character' Exact holder kind accepted by recipe_work and upgrade_work.
---@field character GameHandle Exact avatar or NPC Character handle owning the slot.
---@field slot 'inventory'|'worn'|'wielded' Explicit Character slot; no current-item fallback.

---@class CcbCampRecipeWorkDescriptor
---@field recipe_id GameId GameId<recipe> concrete craftable recipe.
---@field batch integer Positive bounded recipe batch.
---@field duration_turns integer Positive bounded duration matching the authoritative recipe.
---@field source_holders CcbCampRecipeHolder[] Dense explicit source-holder descriptors.
---@field destination_holder CcbCampRecipeHolder Explicit Character inventory holder for outputs.

---@class CcbCampUpgradeMapgenArgument
---@field type 'int'|'bool'|'string' Detached primitive mapgen argument type.
---@field value integer|boolean|string Detached primitive mapgen argument value.

---@alias CcbCampUpgradeMapgenArguments table<string, CcbCampUpgradeMapgenArgument>

---@class CcbCampUpgradeCoreTarget
---@field kind 'camp_core' Exact camp-core target discriminator.
---@field generation integer Exact camp-core upgrade generation captured before start.
---@field position TripointCoord Exact absolute overmap-terrain target position.
---@field terrain string Exact currently authoritative target terrain.
---@field mapgen_args CcbCampUpgradeMapgenArguments Authoritative blueprint mapgen arguments.

---@class CcbCampUpgradeExpansionTarget
---@field kind 'expansion' Exact expansion target discriminator.
---@field expansion CampExpansionToken Exact expansion token; no current/nearest lookup is performed.
---@field position TripointCoord Exact absolute overmap-terrain target position.
---@field terrain string Exact currently authoritative target terrain.
---@field mapgen_args CcbCampUpgradeMapgenArguments Authoritative blueprint mapgen arguments.

---@alias CcbCampUpgradeTarget CcbCampUpgradeCoreTarget|CcbCampUpgradeExpansionTarget

---@class CcbCampUpgradeWorkDescriptor
---@field upgrade_id GameId GameId<recipe> concrete blueprint result recipe.
---@field blueprint_id string Exact update-mapgen blueprint id matching the recipe.
---@field target CcbCampUpgradeTarget Exact camp-core or ExpansionToken target.
---@field duration_turns integer Positive bounded duration matching the authoritative blueprint requirement.
---@field source_holders CcbCampRecipeHolder[] Dense explicit source-holder descriptors.
---@field destination_holder CcbCampRecipeHolder Explicit Character inventory destination for retained/refunded values.

---@class CcbCampRecipeWorkSnapshot
---@field recipe_id GameId GameId<recipe> recorded concrete recipe id.
---@field batch integer Persisted recipe batch.
---@field duration_turns integer Persisted authoritative duration.
---@field source_holders CcbCampRecipeHolderSnapshot[] Detached source-holder identities.
---@field destination_holder CcbCampRecipeHolderSnapshot Detached output-holder identity.

---@class CcbCampUpgradeCoreTargetSnapshot
---@field kind 'camp_core'
---@field generation integer Exact camp-core generation recorded in the task.
---@field position TripointCoord Exact absolute overmap-terrain target position.
---@field terrain string Exact expected pre-upgrade terrain.
---@field mapgen_args CcbCampUpgradeMapgenArguments Detached authoritative blueprint arguments.

---@class CcbCampUpgradeExpansionTargetSnapshot
---@field kind 'expansion'
---@field expansion_id integer Stable expansion identity recorded in the task.
---@field expansion_generation integer Expansion identity generation recorded in the task.
---@field position TripointCoord Exact absolute overmap-terrain target position.
---@field terrain string Exact expected pre-upgrade terrain.
---@field mapgen_args CcbCampUpgradeMapgenArguments Detached authoritative blueprint arguments.

---@alias CcbCampUpgradeTargetSnapshot CcbCampUpgradeCoreTargetSnapshot|CcbCampUpgradeExpansionTargetSnapshot

---@class CcbCampUpgradeWorkSnapshot
---@field upgrade_id GameId GameId<recipe> recorded blueprint result recipe.
---@field blueprint_id string Recorded update-mapgen blueprint id.
---@field target CcbCampUpgradeTargetSnapshot Detached exact target identity.
---@field duration_turns integer Persisted authoritative duration.
---@field source_holders CcbCampRecipeHolderSnapshot[] Detached source-holder identities.
---@field destination_holder CcbCampRecipeHolderSnapshot Detached refund/output-holder identity.

---@class CcbCampRecipeItemRequest
---@field item GameHandle Exact generation-safe Item handle to escrow.
---@field source_holder CcbCampRecipeHolder Exact holder containing `item` at start.
---@field quantity integer Exact whole-item or charge quantity.
---@field tool boolean True only for a complete owning tool Item; tools remain escrowed until claim.

---@class CcbCampRecipeHolderSnapshot
---@field kind 'character'
---@field character_id integer Stable Character id recorded in the task descriptor.
---@field identity_generation integer Character identity generation recorded at binding time.
---@field slot 'inventory'|'worn'|'wielded'

---@class CcbCampRecipeEscrowItemSnapshot
---@field uid integer Stable Item UID; display-only and never a lookup key.
---@field identity_generation integer Item identity generation captured at staging.
---@field charges integer Exact detached charge count.
---@field tool boolean Whether this value is retained as a non-consumable tool.
---@field valid boolean Whether the serialized detached value passed snapshot decoding.
---@field item? table<string, any> Bounded detached Item snapshot when valid.
---@field error? string Diagnostic when the detached value is invalid.
---@field source_holder CcbCampRecipeHolderSnapshot Original explicit holder identity.

---@class CcbCampRecipeEscrowPage
---@field items CcbCampRecipeEscrowItemSnapshot[] Dense bounded detached recipe/upgrade escrow values.
---@field total integer Number of values in the task-owned escrow.
---@field returned integer Number of values returned in this page.
---@field limit integer Fixed bounded escrow page limit.
---@field complete boolean Always true for the bounded task escrow snapshot.
---@field truncated boolean Always false when the escrow bound is respected.

---@class CcbCampTaskReservation
---@field resources CcbCampResourceWorkChange[] Detached resource input liability currently held by the task.
---@field food_kcal integer Detached owner-faction food liability currently held by the task.
---@field active boolean True only while a reservation is held by a running task.
---@field discarded boolean True when a terminal lifecycle boundary could not safely refund the liability.

---@class CampTaskToken
---@field task_id integer Stable persisted Platform task id.
---@field identity_generation integer Task generation; terminal transitions retire the previous token.
---@field runtime_generation integer Lua runtime generation bound to this token.
---@field world_generation integer World generation bound to this token.
---@field camp_stable_id integer Persisted camp identity bound to this token.
---@field camp_identity_generation integer Camp identity generation bound to this token.
---@field manager_stable_id integer Explicit manager Character identity.
---@field worker_stable_id integer Explicit worker NPC identity.
---@field manager_identity_generation integer Persisted manager identity generation, or zero for the avatar.
---@field worker_identity_generation integer Persisted worker identity generation.
---@field is_valid fun(self: CampTaskToken): boolean False after runtime/world/camp/actor/task retirement.

---@class CcbCampTaskSnapshot
---@field task_id integer Stable persisted Platform task id.
---@field identity_generation integer Current task generation.
---@field camp GameHandle Exact camp handle.
---@field owner? GameId GameId<faction> owner recorded at task creation.
---@field manager GameHandle Exact manager handle recorded by the task.
---@field worker GameHandle Exact worker NPC handle recorded by the task.
---@field kind CcbCampTaskKind Registered Platform task kind.
---@field parameter_schema string Internal schema tag; no raw JSON or legacy object is accepted.
---@field resource_work? CcbCampResourceWorkDescriptor Typed descriptor for the resource_work kind.
---@field recipe_work? CcbCampRecipeWorkSnapshot Detached descriptor snapshot for the recipe_work kind.
---@field upgrade_work? CcbCampUpgradeWorkSnapshot Detached descriptor snapshot for the upgrade_work kind.
---@field recipe_escrow? CcbCampRecipeEscrowPage Detached task-owned recipe/upgrade Item escrow; present while running, refund_pending, or completed_unclaimed; no ItemHandle is exposed here.
---@field recipe_commit_marker integer Non-zero after one committed authoritative settlement; zero before settlement/refund.
---@field upgrade_commit_marker integer Non-zero after one committed upgrade mapgen/metadata settlement; zero before settlement/refund.
---@field upgrade_applying_marker integer Non-zero only while an upgrade mapgen transaction is in flight; unknown recovery states are never replayed.
---@field recipe_recovery_required boolean True only for an isolated recipe/upgrade save record requiring explicit refund recovery.
---@field reservation CcbCampTaskReservation Detached task-owned reservation ledger.
---@field state CcbCampTaskState `refund_pending` and `completed_unclaimed` retain escrow for explicit resolve/claim/retry.
---@field started_at TimePoint before_time_starts while pending.
---@field due_at TimePoint before_time_starts while pending.
---@field finished_at? TimePoint Present for completed/cancelled records.
---@field reservation_active boolean True only while the exact worker is reserved.
---@field token? CampTaskToken Present for pending/running/recoverable escrow records; retired after claim.

---@class CcbCampTaskPage
---@field camp GameHandle Exact camp handle used for the query.
---@field manager GameHandle Exact manager handle used for the query.
---@field worker GameHandle Exact worker handle used for the query.
---@field tasks CcbCampTaskSnapshot[] Bounded records for the exact worker.
---@field total integer Number of matching persisted task records.
---@field offset integer Explicit task-page offset.
---@field limit integer Effective bounded page limit.
---@field returned integer Number of records in this page.
---@field complete boolean True when all matching records were returned.
---@field truncated boolean True when the page limit capped the records.

---@class CcbCampTasksApi
local CcbCampTasksApi = {}

---@param camp GameHandle Exact live camp handle.
---@param manager GameHandle Exact live avatar or NPC Character authorized for the camp.
---@param worker GameHandle Exact live NPC worker handle; no selected/current worker is used.
---@param kind CcbCampTaskKind Registered task kind; unsupported kinds fail closed.
---@param descriptor? CcbCampResourceWorkDescriptor|CcbCampRecipeWorkDescriptor|CcbCampUpgradeWorkDescriptor Required for typed task kinds; forbidden for `worker_reservation`.
---@return CcbResult result `value` is a pending CcbCampTaskSnapshot with a CampTaskToken.
function CcbCampTasksApi.create(camp, manager, worker, kind, descriptor) end

---@param camp GameHandle Exact live camp handle.
---@param manager GameHandle Exact live avatar or NPC Character authorized for the camp.
---@param worker GameHandle Exact live NPC worker handle.
---@param options? table<string, integer> Bounded `offset` and `limit`.
---@return CcbResult result `value` is a CcbCampTaskPage.
function CcbCampTasksApi.page(camp, manager, worker, options) end

---@param camp GameHandle Exact live camp handle.
---@param manager GameHandle Exact live avatar or NPC Character authorized for the camp.
---@param worker GameHandle Exact live NPC worker handle.
---@param token CampTaskToken Exact task token bound to all three handles.
---@return CcbResult result `value` is a CcbCampTaskSnapshot.
function CcbCampTasksApi.get(camp, manager, worker, token) end

---@param camp GameHandle Exact live camp handle.
---@param manager GameHandle Exact live avatar or NPC Character authorized for the camp.
---@param worker GameHandle Exact live NPC worker handle.
---@param token CampTaskToken Exact task token bound to all three handles.
---@param destination_holder? CcbCampRecipeHolder Explicit Character destination for recipe/upgrade `refund_pending` or `completed_unclaimed` escrow; omitted means detached read only.
---@return CcbResult result `value` is a CcbCampTaskSnapshot.
function CcbCampTasksApi.resolve(camp, manager, worker, token, destination_holder) end

---@param camp GameHandle Exact live camp handle.
---@param manager GameHandle Exact live avatar or NPC Character authorized for the camp.
---@param worker GameHandle Exact worker identity carried by the token; recoverable escrow may use a stale unloaded handle.
---@param token CampTaskToken Exact refund_pending or completed_unclaimed token.
---@param destination_holder CcbCampRecipeHolder Explicit Character destination for recipe/upgrade escrow; all values must fit atomically.
---@return CcbResult result `value` is a retired CcbCampTaskSnapshot after successful claim.
function CcbCampTasksApi.claim(camp, manager, worker, token, destination_holder) end

---@param camp GameHandle Exact live camp handle.
---@param manager GameHandle Exact live avatar or NPC Character authorized for the camp.
---@param worker GameHandle Exact worker identity carried by the token; recoverable escrow may use a stale unloaded handle.
---@param token CampTaskToken Exact retryable refund_pending or completed_unclaimed token.
---@param destination_holder CcbCampRecipeHolder Explicit fallback holder for recipe/upgrade escrow; failure keeps escrow and token intact.
---@return CcbResult result `value` is a retired CcbCampTaskSnapshot after successful retry.
function CcbCampTasksApi.retry(camp, manager, worker, token, destination_holder) end

---@param camp GameHandle Exact live camp handle.
---@param manager GameHandle Exact live avatar or NPC Character authorized for the camp.
---@param worker GameHandle Exact live NPC worker handle.
---@param token CampTaskToken Exact pending task token.
---@param requests_or_duration? CcbCampRecipeItemRequest[]|integer Typed recipe/upgrade Item requests, or the existing duration integer for worker/resource tasks.
---@param duration_turns? integer Optional second duration; recipe/upgrade/resource descriptors must match it exactly.
---@return CcbResult result `value` is a running CcbCampTaskSnapshot with task-owned escrow for recipe_work or upgrade_work.
function CcbCampTasksApi.start(camp, manager, worker, token, requests_or_duration, duration_turns) end

---@param camp GameHandle Exact live camp handle.
---@param manager GameHandle Exact live avatar or NPC Character authorized for the camp.
---@param worker GameHandle Exact live NPC worker handle.
---@param token CampTaskToken Exact active task token.
---@return CcbResult result `value` is a cancelled or `refund_pending` CcbCampTaskSnapshot; recipe/upgrade escrow is never silently dropped.
function CcbCampTasksApi.cancel(camp, manager, worker, token) end

---@param camp GameHandle Exact live camp handle.
---@param manager GameHandle Exact live avatar or NPC Character authorized for the camp.
---@param worker GameHandle Exact live NPC worker handle.
---@param token CampTaskToken Exact active task token.
---@return CcbResult result `value` is a cancelled or `refund_pending` CcbCampTaskSnapshot; recipe/upgrade escrow is never silently dropped.
function CcbCampTasksApi.recall(camp, manager, worker, token) end

---@param camp GameHandle Exact live camp handle.
---@param manager GameHandle Exact live avatar or NPC Character authorized for the camp.
---@param worker GameHandle Exact live NPC worker handle.
---@param token CampTaskToken Exact due running task token.
---@return CcbResult result `value` is a `completed_unclaimed` CcbCampTaskSnapshot for recipe_work or upgrade_work when escrow remains, or a completed snapshot otherwise.
function CcbCampTasksApi.complete(camp, manager, worker, token) end

---@class CcbCampExpansionDirection
---@field x integer Relative OMT x direction in -1..1.
---@field y integer Relative OMT y direction in -1..1.

---@class CcbCampExpansionSnapshot
---@field token CampExpansionToken Exact expansion token.
---@field expansion_id integer Stable expansion identity.
---@field identity_generation integer Current expansion generation.
---@field camp GameHandle Exact owning camp handle.
---@field camp_stable_id integer Stable owning camp identity.
---@field direction CcbCampExpansionDirection Detached relative direction.
---@field position TripointCoord Absolute OMT position.
---@field type string Stable Platform expansion type.
---@field name string Detached expansion name.
---@field owner? GameId Faction owner snapshot.
---@field work_in_progress boolean True when legacy/native expansion work occupies this identity.

---@class CcbCampExpansionPageOptions
---@field offset? integer Explicit page offset, from 0 through 1000000.
---@field limit? integer Maximum returned expansions, from 0 through 256.

---@class CcbCampExpansionPage
---@field camp GameHandle Exact owning camp handle.
---@field items CcbCampExpansionSnapshot[] Bounded expansion snapshots ordered by stable id.
---@field total integer Total current expansions for this exact camp.
---@field offset integer Explicit page offset.
---@field limit integer Effective bounded page limit.
---@field returned integer Number of snapshots in this page.
---@field complete boolean True only when all expansions were returned.
---@field truncated boolean True when the explicit page limit capped the result.

---@class CcbCampExpansionsApi
local CcbCampExpansionsApi = {}

---@param camp GameHandle Exact live camp handle.
---@param manager GameHandle Exact live avatar or NPC Character authorized for the camp.
---@param position TripointCoord Explicit absolute OMT expansion position in the camp domain.
---@param type string Valid Platform camp expansion type.
---@param name string Bounded detached expansion name.
---@return CcbResult result `value` is a CcbCampExpansionSnapshot with a stable token.
function CcbCampExpansionsApi.create(camp, manager, position, type, name) end

---@param camp GameHandle Exact live camp handle.
---@param manager GameHandle Exact live avatar or NPC Character authorized for the camp.
---@param options? CcbCampExpansionPageOptions
---@return CcbResult result `value` is a bounded CcbCampExpansionPage.
function CcbCampExpansionsApi.list(camp, manager, options) end

---@param camp GameHandle Exact live camp handle.
---@param manager GameHandle Exact live avatar or NPC Character authorized for the camp.
---@param token CampExpansionToken Exact token for this camp and owner generation.
---@return CcbResult result `value` is a detached CcbCampExpansionSnapshot.
function CcbCampExpansionsApi.get(camp, manager, token) end

---@param camp GameHandle Exact live camp handle.
---@param manager GameHandle Exact live avatar or NPC Character authorized for the camp.
---@param token CampExpansionToken Exact token for this camp and owner generation.
---@return CcbResult result `value` contains the retired expansion identity.
function CcbCampExpansionsApi.remove(camp, manager, token) end

---@class CcbCampStorageTile
---@field holder CcbItemHolder Explicit `map_tile` holder for services.items.page/transfer.

---@class CcbCampStorageTilePage
---@field camp GameHandle Exact camp handle used for the query.
---@field items CcbCampStorageTile[] Bounded, sorted storage holders.
---@field total integer Number of stored camp storage tiles.
---@field offset integer Explicit page offset.
---@field limit integer Effective bounded page limit.
---@field returned integer Number of holders in this page.
---@field complete boolean True when all stored holders were returned.
---@field truncated boolean True when the page limit capped the holders.
---@field page_api string Always `services.items.page` for exact item traversal.

---@class CcbCampInventoryApi
local CcbCampInventoryApi = {}

---@param camp GameHandle Exact live camp handle.
---@param manager GameHandle Exact live avatar or NPC Character authorized for the camp.
---@param options? table<string, integer> Bounded `offset` and `limit`.
---@return CcbResult result `value` is a CcbCampStorageTilePage; call services.items.page for live items.
function CcbCampInventoryApi.storage_tiles(camp, manager, options) end

---@class CcbCampListOptions
---@field radius_omt? integer Explicit query radius around the supplied absolute OMT center, from 0 through 360.
---@field limit? integer Maximum returned snapshots, from 0 through 256.

---@class CcbCampSnapshot
---@field handle GameHandle Exact generation-safe camp handle. Position is a detached snapshot, never an identity lookup key.
---@field stable_id integer Persisted stable camp identity.
---@field identity_generation integer Camp identity generation for this handle.
---@field name string Detached camp name.
---@field board_name string Detached bulletin-board name.
---@field valid boolean False when the native camp is not usable.
---@field position TripointCoord Absolute overmap-terrain position snapshot.
---@field board_position TripointCoord Absolute map-square board position snapshot.
---@field owner? GameId Camp owner faction, when present.
---@field assigned_worker_count integer Current exact worker count snapshot.

---@class CcbCampListPage
---@field items CcbCampSnapshot[] Bounded explicit-center query results.
---@field center TripointCoord Absolute overmap-terrain query center.
---@field radius_omt integer Effective query radius.
---@field returned integer Number of snapshots in this page.
---@field limit integer Effective page limit.
---@field complete boolean True only when the explicit query was not capped by limit.

---@class CcbCampsApi
---@field resources CcbCampResourcesApi
---@field food CcbCampFoodApi
---@field inventory CcbCampInventoryApi
---@field tasks CcbCampTasksApi
---@field expansions CcbCampExpansionsApi
local CcbCampsApi = {}

---@class CcbCampCreateOptions
---@field type string Valid Platform camp type used to initialize the camp's base domain.

---@param owner_faction GameId Explicit faction owner; no player/avatar owner is inferred.
---@param manager GameHandle Exact live avatar or NPC Character belonging to owner_faction.
---@param omt_position TripointCoord Explicit absolute OMT position.
---@param name string Bounded camp name.
---@param options CcbCampCreateOptions Explicit camp type options.
---@return CcbResult result `value` is a detached CcbCampSnapshot with a new camp handle.
function CcbCampsApi.create(owner_faction, manager, omt_position, name, options) end

---@param camp GameHandle Exact live camp handle.
---@param manager GameHandle Exact live avatar or NPC Character authorized for the camp.
---@return CcbResult result `value` contains the retired camp handle and stable id.
function CcbCampsApi.remove(camp, manager) end

---@param center TripointCoord Explicit absolute overmap-terrain query center; never inferred from the avatar.
---@param options? CcbCampListOptions
---@return CcbResult result `value` is a bounded CcbCampListPage.
function CcbCampsApi.list(center, options) end

---@param camp GameHandle Exact live camp handle.
---@param manager GameHandle Exact live avatar or NPC Character authorized for the camp.
---@return CcbResult result `value` is a detached CcbCampSnapshot.
function CcbCampsApi.get(camp, manager) end

---@param camp GameHandle Exact live camp handle.
---@param manager GameHandle Exact live avatar or NPC Character authorized for the camp.
---@param name string New bounded camp name.
---@return CcbResult result `value` contains the current camp handle and before/after names.
function CcbCampsApi.rename(camp, manager, name) end

---@param camp GameHandle Exact live camp handle.
---@param manager GameHandle Exact live avatar or NPC Character authorized for the camp.
---@param owner GameId Faction owner.
---@return CcbResult result `value` contains the current camp handle and before/after owner.
function CcbCampsApi.set_owner(camp, manager, owner) end

---@param camp GameHandle Exact live camp handle.
---@param manager GameHandle Exact live avatar or NPC Character authorized for the camp.
---@param position TripointCoord Explicit absolute map-square board position inside this camp.
---@return CcbResult result `value` contains the current camp handle and before/after positions.
function CcbCampsApi.set_board_position(camp, manager, position) end

---@param camp GameHandle Exact live camp handle.
---@param manager GameHandle Exact live avatar or NPC Character authorized for the camp.
---@param worker GameHandle Exact live NPC worker handle.
---@return CcbResult result `value` contains current camp/worker handles and assignment state.
function CcbCampsApi.assign_worker(camp, manager, worker) end

---@param camp GameHandle Exact live camp handle.
---@param manager GameHandle Exact live avatar or NPC Character authorized for the camp.
---@param worker GameHandle Exact live NPC worker handle.
---@return CcbResult result `value` contains current camp/worker handles and assignment state.
function CcbCampsApi.recall_worker(camp, manager, worker) end

-- Shared character combat methods are installed under `ccb.services.characters`
--- by the same generation-safe native layer used by `ccb.services.characters`.
---@class CcbCharactersApi
local CcbCharactersApi = {}

---@param character GameHandle Exact live Character handle; subtype and lifecycle are checked before access.
---@param body_part_limit? integer
---@return CcbResult result `value` is a detached Character snapshot.
function CcbCharactersApi.snapshot(character, body_part_limit) end

---@param observer GameHandle Exact live Character observer handle.
---@param options? CcbCharacterNearbyOptions
---@return CcbResult result
function CcbCharactersApi.nearby(observer, options) end

---@param attacker GameHandle Character handle performing the attack.
---@param target GameHandle Any live Creature handle to attack.
---@param technique string Literal martial-art technique id; empty means no forced technique.
---@param options? CcbCharacterAttackOptions
---@return CcbResult
function CcbCharactersApi.attack(attacker, target, technique, options) end

---@param attacker GameHandle Character handle with the wielded firearm.
---@param target GameHandle Any live Creature handle at which to fire.
---@return CcbResult
function CcbCharactersApi.ranged_attack(attacker, target) end

---@param character GameHandle Character to knock back.
---@param options? CcbCharacterKnockbackOptions
---@return CcbResult
function CcbCharactersApi.knockback(character, options) end

---@param character GameHandle Character supplying the explosion source and default position.
---@param options? CcbCharacterExplosionOptions
---@return CcbResult
function CcbCharactersApi.explosion(character, options) end

---@param character GameHandle Character whose tile receives the emission.
---@param emission string Valid native emission id.
---@param chance? number Finite multiplier from 0 through 1000; defaults to 1.
---@return CcbResult
function CcbCharactersApi.emit(character, emission, chance) end

---@param character GameHandle Character caster.
---@param spell GameId GameId<spell> to construct as a native fake spell.
---@param options? CcbCharacterCastSpellOptions
---@return CcbResult
function CcbCharactersApi.cast_spell(character, spell, options) end

---@param character GameHandle Character to kill through native death rules.
---@param options? CcbCharacterDieOptions
---@return CcbResult
function CcbCharactersApi.die(character, options) end

---@param character GameHandle Character whose vital parts should be restored through the virtual hook.
---@return CcbResult
function CcbCharactersApi.prevent_death(character) end

---@param character GameHandle Character whose native enchantment cache should be rebuilt.
---@return CcbResult
function CcbCharactersApi.recalculate_enchantments(character) end

---@class CcbRelocationMoveOptions
---@field strict? true Strict mode; when supplied it must be `true`. This is the only accepted option; force and fallback policies are unsupported.

---@class CcbRelocationMoveValue
---@field changed boolean True after a committed move; false for a same-tile no-op.
---@field scope 'monster'|'avatar'|'npc'|'vehicle' Current result scope; only exact Monster, Avatar, NPC, or Vehicle subtypes are supported.
---@field handle GameHandle Current exact Monster, Avatar, NPC, or Vehicle handle after the no-op or committed move. VehiclePart handles and their identity remain valid across this move.
---@field position TripointCoord Current absolute map-square position.
---@field overmap_terrain TripointCoord Absolute overmap-terrain position derived from the current map-square position.

---@class CcbRelocationMoveResult: CcbResult
---@field value? CcbRelocationMoveValue Present only when the typed relocation succeeds.
---@field error? CcbPlatformResultError Present when the exact handle, target token, or strict relocation precondition is rejected.

---@class CcbRelocationApi
local CcbRelocationApi = {}

---@param entity GameHandle Exact live Monster, Avatar, NPC, or Vehicle GameHandle; generic Character and other unsupported subtypes return `unsupported`.
---@param target MapTileToken Exact token for the target map square; raw coordinates and implicit/fallback target lookup are unsupported.
---@param options? CcbRelocationMoveOptions Optional strict-only policy; omitted means strict mode. No force or fallback policy is supported.
---@return CcbRelocationMoveResult result `value` is a CcbRelocationMoveValue; failures return the typed error envelope.
function CcbRelocationApi.move(entity, target, options) end

---@param avatar GameHandle Exact live Avatar handle; generic Character and other GameHandle subtypes are unsupported.
---@param target OvermapTileToken Exact absolute OMT target token; the operation is expected to shift/load the active map as needed.
---@param options? CcbRelocationMoveOptions Optional strict-only policy; omitted means strict mode. No force or fallback policy is supported.
---@return CcbRelocationMoveResult result `value` is a CcbRelocationMoveValue; failures return the typed error envelope.
function CcbRelocationApi.travel_to_omt(avatar, target, options) end

---@class CcbWeatherTypeIdPage
---@field items GameId[] Bounded weather-type ids.
---@field total integer Total nested weather-type ids.
---@field returned integer Number of ids returned in the bounded page.
---@field truncated boolean True when the native list exceeded the nested bound.

---@class CcbWeatherSourceSnapshot
---@field weather GameId GameId<weather_type> Source weather type.
---@field mod string Mod id that supplied the source.

---@class CcbWeatherSourcePage
---@field items CcbWeatherSourceSnapshot[] Bounded weather-type sources.
---@field total integer Total sources.
---@field returned integer Number of sources returned in the bounded page.
---@field truncated boolean True when the native source list exceeded the nested bound.

---@class CcbWeatherTypeSnapshot
---@field id GameId GameId<weather_type>
---@field name string Detached translated weather name.
---@field loaded boolean Whether the native definition was loaded.
---@field symbol string Weather display symbol.
---@field sun_symbol string Sun display symbol.
---@field ranged_penalty integer
---@field sight_penalty number
---@field light_modifier integer
---@field light_multiplier number
---@field sun_multiplier number
---@field sound_attenuation integer
---@field dangerous boolean
---@field precipitation 'none'|'very_light'|'light'|'heavy'
---@field precipitation_mm_per_hour number
---@field rains boolean
---@field temperature_modifier_c number
---@field priority integer
---@field tiles_animation string
---@field sound_category 'silent'|'drizzle'|'rainy'|'rainstorm'|'thunder'|'flurries'|'snowstorm'|'snow'|'portal_storm'|'clear'|'sunny'|'cloudy'
---@field duration_min TimeDuration
---@field duration_max TimeDuration
---@field required_weathers CcbWeatherTypeIdPage
---@field sources CcbWeatherSourcePage

---@class CcbWeatherListOptions
---@field offset? integer Non-negative offset, bounded to 0..1000000.
---@field limit? integer Requested page size, bounded to 0..256.
---@field query? string Case-insensitive id/name query, at most 128 bytes.
---@field dangerous? boolean Filter by the dangerous flag.
---@field rains? boolean Filter by the rains flag.

---@class CcbWeatherListPage
---@field items CcbWeatherTypeSnapshot[] Bounded weather-type snapshots ordered by id.
---@field total integer Total matching weather types.
---@field returned integer Number of snapshots returned.
---@field offset integer Effective page offset.
---@field limit integer Effective page limit.
---@field truncated boolean True when the page limit capped the result.

---@class CcbWeatherPointSnapshot
---@field at TimePoint Sample time.
---@field weather GameId GameId<weather_type> Weather condition at the sample.
---@field temperature UnitValue Temperature UnitValue<temperature> in kelvins.
---@field temperature_c number Temperature in Celsius.
---@field humidity number
---@field pressure number
---@field wind_speed_mph number
---@field wind_direction_degrees integer
---@field wind_description string
---@field position TripointCoord Absolute map-square sample position.
---@field precipitation_mm_per_hour number
---@field sunlight number
---@field sun_irradiance number
---@field moonlight number
---@field is_day boolean
---@field is_night boolean

---@class CcbWeatherCurrentSnapshot
---@field weather GameId GameId<weather_type> Current weather id.
---@field type? CcbWeatherTypeSnapshot Current weather definition, when valid.
---@field temperature UnitValue Current temperature UnitValue<temperature> in kelvins.
---@field temperature_c number Current temperature in Celsius.
---@field wind_speed_mph integer
---@field wind_direction_degrees integer
---@field next_update TimePoint
---@field changed boolean
---@field lightning_active boolean
---@field weather_override? GameId GameId<weather_type> Active weather override, when present.
---@field temperature_override? UnitValue Temperature override UnitValue<temperature>, when present.
---@field wind_speed_override_mph? integer Wind-speed override, when present.
---@field wind_direction_override_degrees? integer Wind-direction override, when present.
---@field precise CcbWeatherPointSnapshot Precise current weather sample.

---@class CcbWeatherStringPage
---@field items string[] Bounded native strings.
---@field total integer Total native strings.
---@field returned integer Number of strings returned.
---@field truncated boolean True when the native list exceeded the nested bound.

---@class CcbWeatherSeasonModifiers
---@field temperature_modifier integer
---@field humidity_modifier integer

---@class CcbWeatherSeasonalSnapshot
---@field spring CcbWeatherSeasonModifiers
---@field summer CcbWeatherSeasonModifiers
---@field autumn CcbWeatherSeasonModifiers
---@field winter CcbWeatherSeasonModifiers

---@class CcbWeatherGeneratorSnapshot
---@field id GameId GameId<weather_generator>
---@field loaded boolean Whether the native generator was loaded.
---@field base_temperature_c number
---@field base_humidity number
---@field base_pressure number
---@field base_wind_mph number
---@field wind_distribution_peaks integer
---@field wind_season_variation integer
---@field seasonal CcbWeatherSeasonalSnapshot
---@field blacklist CcbWeatherStringPage
---@field whitelist CcbWeatherStringPage
---@field sorted_weather CcbWeatherTypeIdPage

---@class CcbWeatherForecastOptions
---@field start? TimePoint Forecast start; defaults to the current turn.
---@field position? TripointCoord Absolute map-square position; defaults to the avatar position.
---@field step? TimeDuration Forecast step, from 1 minute through 24 hours.
---@field limit? integer Number of samples, bounded to 0..168.
---@field respect_override? boolean Whether the weather override affects conditions.

---@class CcbWeatherForecastPage
---@field items CcbWeatherPointSnapshot[] Dense forecast samples.
---@field returned integer Number of samples returned.
---@field limit integer Effective sample limit.
---@field start TimePoint Effective forecast start.
---@field step TimeDuration Effective forecast step.
---@field position TripointCoord Effective absolute map-square position.
---@field respected_override boolean Whether an active weather override was applied.

---@class CcbWeatherLimits
---@field catalog_limit integer Maximum weather-type page size.
---@field maximum_catalog_offset integer Maximum weather-type catalog offset.
---@field maximum_nested_values integer Maximum nested values returned by the weather API.
---@field forecast_limit integer Maximum forecast sample count.
---@field forecast_minimum_step TimeDuration Minimum forecast step.
---@field forecast_maximum_step TimeDuration Maximum forecast step.
---@field forecast_maximum_horizon TimeDuration Maximum forecast horizon.
---@field maximum_wind_speed_mph integer Maximum wind-speed override.
---@field maximum_wind_direction_degrees integer Maximum wind-direction override.
---@field maximum_temperature_kelvin number Maximum temperature override in kelvins.
---@field maximum_custom_light_level integer Maximum custom-light level.
---@field maximum_custom_light_duration TimeDuration Maximum custom-light duration.
---@field maximum_custom_light_key_bytes integer Maximum custom-light key length in bytes.
---@field maximum_pending_custom_light_events integer Maximum pending custom-light events.

---@class CcbWeatherApi
local CcbWeatherApi = {}

---@param options? CcbWeatherListOptions
---@return CcbWeatherListPage result Detached bounded weather-type page.
function CcbWeatherApi.types(options) end

---@param id GameId GameId<weather_type>
---@return CcbWeatherTypeSnapshot result Detached weather-type snapshot.
function CcbWeatherApi.type(id) end

---@return CcbWeatherCurrentSnapshot result Detached current-weather snapshot.
function CcbWeatherApi.current() end

---@return CcbWeatherGeneratorSnapshot result Detached weather-generator snapshot.
function CcbWeatherApi.generator() end

---@param options? CcbWeatherForecastOptions
---@return CcbWeatherForecastPage result Detached bounded forecast page.
function CcbWeatherApi.forecast(options) end

---@return CcbWeatherLimits result Detached weather API limits.
function CcbWeatherApi.limits() end

---@class CcbWeatherWindOptions
---@field speed_mph? integer Wind-speed override in mph.
---@field direction_degrees? integer Wind-direction override in degrees.
---@field clear_speed? boolean Clear the wind-speed override.
---@field clear_direction? boolean Clear the wind-direction override.

---@class CcbWeatherLightOverrideResult
---@field level integer Applied custom-light level.
---@field duration TimeDuration Requested custom-light duration.
---@field expires_at TimePoint Custom-light expiration time.
---@field key string Custom-light coordination key, or an empty string.
---@field accepted boolean Whether the custom-light override was accepted.
---@field replaced boolean Whether an existing keyed custom-light event was replaced.

---@param id GameId GameId<weather_type>
---@return CcbResult result `value` is a CcbWeatherCurrentSnapshot.
function CcbWeatherApi.set_override(id) end

---@return CcbResult result `value` is a CcbWeatherCurrentSnapshot.
function CcbWeatherApi.clear_override() end

---@param temperature UnitValue UnitValue<temperature>
---@return CcbResult result `value` is a CcbWeatherCurrentSnapshot.
function CcbWeatherApi.set_temperature_override(temperature) end

---@return CcbResult result `value` is a CcbWeatherCurrentSnapshot.
function CcbWeatherApi.clear_temperature_override() end

---@param options CcbWeatherWindOptions
---@return CcbResult result `value` is a CcbWeatherCurrentSnapshot.
function CcbWeatherApi.set_wind(options) end

---@return CcbResult result `value` is a CcbWeatherCurrentSnapshot.
function CcbWeatherApi.clear_overrides() end

---@return CcbResult result `value` is a CcbWeatherCurrentSnapshot.
function CcbWeatherApi.refresh() end

---@return CcbResult result `value` is a CcbWeatherCurrentSnapshot.
function CcbWeatherApi.activate_lightning() end

---@param level integer
---@param duration TimeDuration
---@param key? string
---@return CcbResult result `value` is a CcbWeatherLightOverrideResult.
function CcbWeatherApi.override_light(level, duration, key) end

---@class ZoneToken
---@field faction GameId GameId<faction> Faction owning the zone.
---@field type GameId GameId<zone> Zone type identity.
---@field name string Zone name.
---@field start TripointCoord Absolute map-square start; for personal zones this is the current absolute view.
---@field end TripointCoord Absolute map-square end; for personal zones this is the current absolute view.
---@field relative_start? TripointCoord Relative map-square start for personal zones; use this for `set_position` round-trips.
---@field relative_end? TripointCoord Relative map-square end for personal zones; use this for `set_position` round-trips.
---@field vehicle boolean Whether the zone is vehicle-bound; vehicle zones are read-only loaded-map views.
---@field kind 'global'|'personal'|'vehicle' Zone storage and position kind.
---@field is_valid fun(self: ZoneToken): boolean False after the native zone, runtime, or world identity becomes stale.
---@field status fun(self: ZoneToken): CcbResult Typed status with a fail-closed error when the token is stale or no longer resolves.

---@class CcbZoneTypeSnapshot
---@field id GameId GameId<zone>
---@field name string

---@class CcbZoneTypeListOptions
---@field offset? integer
---@field limit? integer
---@field query? string

---@class CcbZoneTypePage
---@field items CcbZoneTypeSnapshot[]
---@field offset integer
---@field limit integer
---@field total integer
---@field returned integer
---@field has_more boolean

---@class CcbZoneListOptions
---@field offset? integer
---@field limit? integer
---@field query? string
---@field faction? GameId GameId<faction>
---@field type? GameId GameId<zone>
---@field kind? 'global'|'personal'|'vehicle' Filter by zone storage and position kind.

---@class CcbZoneOptionDescription
---@field label string Human-readable option label.
---@field value string Current option value.

---@class CcbZoneOptionPage
---@field items CcbZoneOptionDescription[] Bounded option descriptions.
---@field total integer Total native option descriptions.
---@field returned integer Number of option descriptions returned.
---@field truncated boolean True when the nested option bound capped the page.

---Personal-zone position round-trips through `set_position` use the optional
---relative coordinates; absolute `start`/`end` are the current view. Vehicle-bound
---zone views are read-only and describe the loaded map only.
---@class CcbZoneSnapshot
---@field token ZoneToken
---@field name string
---@field type GameId GameId<zone>
---@field type_name string Player-facing zone type name.
---@field faction GameId GameId<faction>
---@field start TripointCoord
---@field end TripointCoord
---@field relative_start? TripointCoord Relative map-square start for personal zones.
---@field relative_end? TripointCoord Relative map-square end for personal zones.
---@field center TripointCoord Absolute map-square center.
---@field invert boolean Whether the zone's inclusion rule is inverted.
---@field temporarily_disabled boolean Whether the zone is temporarily disabled.
---@field displayed boolean Whether the zone is currently displayed.
---@field vehicle boolean Whether the zone is vehicle-bound; vehicle zones are read-only views limited to the loaded map.
---@field kind 'global'|'personal'|'vehicle' Zone storage and position kind.
---@field enabled boolean
---@field has_options boolean Whether the zone has configurable options.
---@field options CcbZoneOptionPage Basic bounded option-description page.

---@class CcbZoneListPage
---@field items CcbZoneSnapshot[]
---@field faction GameId GameId<faction>
---@field position? TripointCoord
---@field offset integer
---@field limit integer
---@field total integer
---@field returned integer
---@field has_more boolean

---@class CcbZoneCreateOptions
---@field name string Bounded zone name.
---@field type GameId GameId<zone> Zone type identity.
---@field faction? GameId GameId<faction> Faction owning the zone; defaults to the native default faction.
---@field start TripointCoord Zone start position; personal zones require relative coordinates, other kinds require absolute coordinates.
---@field end TripointCoord Zone end position; personal zones require relative coordinates, other kinds require absolute coordinates.
---@field invert? boolean Whether the zone's inclusion rule is inverted.
---@field enabled? boolean Whether the zone is enabled.
---@field kind 'global'|'personal' Zone storage and position kind; required.

---@class CcbZoneMutationResult
---@field changed boolean Whether the requested mutation changed the zone.
---@field zone CcbZoneSnapshot Resulting detached zone snapshot.

---@class CcbZoneRemoveResult
---@field removed boolean Whether the zone was removed.
---@field zone CcbZoneSnapshot Detached snapshot of the removed zone.

---@class CcbZonesApi
local CcbZonesApi = {}

---@param options? CcbZoneTypeListOptions
---@return CcbZoneTypePage
function CcbZonesApi.types(options) end

---@param id GameId GameId<zone>
---@return CcbZoneTypeSnapshot
function CcbZonesApi.type(id) end

---@param options? CcbZoneListOptions
---@return CcbResult result `value` is a CcbZoneListPage.
function CcbZonesApi.list(options) end

---@param position TripointCoord
---@param options? CcbZoneListOptions
---@return CcbResult result `value` is a CcbZoneListPage.
function CcbZonesApi.at(position, options) end

---@param token ZoneToken
---@return CcbResult result `value` is a CcbZoneSnapshot.
function CcbZonesApi.get(token) end

---@param token ZoneToken
---@param position TripointCoord
---@return CcbResult result `value` is boolean.
function CcbZonesApi.contains(token, position) end

---Vehicle zones are read-only loaded-map views and cannot be created.
---@param options CcbZoneCreateOptions
---@return CcbResult result `value` is a CcbZoneSnapshot.
function CcbZonesApi.create(options) end

---@param token ZoneToken
---@param name string New bounded zone name.
---@return CcbResult result `value` is a CcbZoneMutationResult; vehicle tokens return error.code `unsupported_vehicle_mutation`.
function CcbZonesApi.rename(token, name) end

---@param token ZoneToken
---@param enabled boolean
---@return CcbResult result `value` is a CcbZoneMutationResult; vehicle tokens return error.code `unsupported_vehicle_mutation`.
function CcbZonesApi.set_enabled(token, enabled) end

---@param token ZoneToken
---@param disabled boolean
---@return CcbResult result `value` is a CcbZoneMutationResult; vehicle tokens return error.code `unsupported_vehicle_mutation`.
function CcbZonesApi.set_temporary_disabled(token, disabled) end

---Personal zones require relative map-square coordinates; all other kinds require absolute map-square coordinates.
---@param token ZoneToken
---@param start TripointCoord
---@param finish TripointCoord
---@return CcbResult result `value` is a CcbZoneMutationResult; vehicle tokens return error.code `unsupported_vehicle_mutation`.
function CcbZonesApi.set_position(token, start, finish) end

---@param token ZoneToken
---@return CcbResult result `value` is a CcbZoneRemoveResult; vehicle tokens return error.code `unsupported_vehicle_mutation`.
function CcbZonesApi.remove(token) end

---@class CcbHordeLimits
---@field maximum_radius integer Maximum supported horde query radius.
---@field maximum_radius_z integer Maximum supported vertical horde query radius.
---@field maximum_limit integer Maximum number of horde results per query.
---@field maximum_offset integer Maximum horde query offset.
---@field maximum_tracking_intensity integer Maximum supported horde tracking intensity.
---@field maximum_legacy_population integer Maximum supported legacy horde population.
---@field flavors string[] Supported horde flavors.
---@field existing_only boolean Whether live horde entities/groups are restricted to existing overmaps.

---@class HordeEntityToken
---@field position TripointCoord Absolute map-square position captured by this token.
---@field monster GameId GameId<monster> captured by this token.
---@field runtime_generation integer Lua Platform runtime generation bound at issuance.
---@field world_generation integer World generation bound at issuance.
---@field owner_generation integer Horde-token owner generation; changes when Platform runtime/world ownership is reset.
---@field identity_generation integer Process-local native identity generation of the referenced entity.
---@field is_valid fun(self: HordeEntityToken): boolean False when the token no longer resolves to the same live entity.
---@field __tostring fun(self: HordeEntityToken): string Stable token identity string.
---@operator eq(HordeEntityToken): boolean Equality compares position, monster, runtime, world, and native identity.

---@class LegacyHordeToken
---@field position TripointCoord Absolute submap position captured by this token.
---@field group GameId GameId<monster_group> captured by this token.
---@field runtime_generation integer Lua Platform runtime generation bound at issuance.
---@field world_generation integer World generation bound at issuance.
---@field owner_generation integer Horde-token owner generation; changes when Platform runtime/world ownership is reset.
---@field identity_generation integer Process-local native identity generation of the referenced group.
---@field is_valid fun(self: LegacyHordeToken): boolean False when the token no longer resolves to the same live group.
---@field __tostring fun(self: LegacyHordeToken): string Stable token identity string.
---@operator eq(LegacyHordeToken): boolean Equality compares position, group, runtime, world, and native identity.

---@class CcbHordePageOptions
---@field offset? integer Non-negative bounded page offset.
---@field limit? integer Page size, capped by CcbHordeLimits.maximum_limit.

---@class CcbHordeEntityQueryOptions: CcbHordePageOptions
---@field radius? integer Absolute OMT query radius from 0 through CcbHordeLimits.maximum_radius.
---@field radius_z? integer Absolute vertical query radius from 0 through CcbHordeLimits.maximum_radius_z.
---@field flavors? string[] Dense one-based flavor names.
---@field monster? GameId GameId<monster> filter.

---@class CcbHordeLegacyQueryOptions: CcbHordePageOptions
---@field radius? integer Absolute OMT query radius from 0 through CcbHordeLimits.maximum_radius.
---@field radius_z? integer Absolute vertical query radius from 0 through CcbHordeLimits.maximum_radius_z.
---@field horde_only? boolean Restrict results to legacy groups marked as hordes.

---@class CcbHordeLegacyGroupOptions
---@field group GameId GameId<monster_group> to instantiate.
---@field position TripointCoord Absolute submap insertion position.
---@field population? integer Population from 0 through CcbHordeLimits.maximum_legacy_population.
---@field interest? integer Interest from 15 through 100.
---@field dying? boolean Whether native decay is enabled.
---@field horde? boolean Whether this is a horde group.
---@field behavior? "none"|"city"|"roam"|"nemesis" Native horde behavior.
---@field target? TripointCoord Absolute submap target on the group's z-level.
---@field nemesis_target? TripointCoord Absolute submap nemesis target on the group's z-level.

---@class CcbHordeLegacyGroupUpdateOptions
---@field population? integer Population from 0 through CcbHordeLimits.maximum_legacy_population.
---@field interest? integer Interest from 15 through 100.
---@field dying? boolean Whether native decay is enabled.
---@field horde? boolean Whether this is a horde group.
---@field behavior? "none"|"city"|"roam"|"nemesis" Native horde behavior.
---@field target? TripointCoord Absolute submap target on the group's z-level.
---@field nemesis_target? TripointCoord Absolute submap target on the group's z-level.

---@class CcbHordeEntitySnapshot
---@field token HordeEntityToken Generation-bound identity token.
---@field position TripointCoord Absolute map-square position.
---@field overmap_position TripointCoord Absolute OMT position.
---@field monster GameId GameId<monster> identity.
---@field name string Detached monster name.
---@field flavor "active"|"idle"|"dormant"|"immobile" Native horde-map flavor.
---@field active boolean Whether tracking is active.
---@field heavy boolean Whether detailed monster state is retained.
---@field destination TripointCoord Absolute map-square destination.
---@field tracking_intensity integer Native tracking intensity.
---@field moves integer Native movement counter.
---@field last_processed TimePoint Native last-processed turn.

---@class CcbHordeEntityPage
---@field items CcbHordeEntitySnapshot[] Detached entity snapshots.
---@field total integer
---@field offset integer
---@field limit integer
---@field returned integer
---@field has_more boolean
---@field radius integer Effective query radius.
---@field radius_z integer Effective vertical query radius.
---@field existing_overmaps integer Number of existing overmaps inspected.
---@field existing_only boolean Always true for this bounded API.
---@field flavors integer Effective native flavor mask.

---@class CcbHordeLegacyMonsterSnapshot
---@field id GameId GameId<monster> identity.
---@field name string Detached monster name.
---@field position TripointCoord Absolute map-square position.

---@class CcbHordeLegacyMonsterPage
---@field items CcbHordeLegacyMonsterSnapshot[] Detached tracked-monster snapshots.
---@field total integer Total tracked monsters.
---@field limit integer Fixed native safety limit.
---@field returned integer
---@field truncated boolean True when the tracked-monster list exceeded the limit.

---@class CcbHordeLegacyGroupSnapshot
---@field token LegacyHordeToken Generation-bound identity token.
---@field group GameId GameId<monster_group> identity.
---@field position TripointCoord Absolute submap position.
---@field overmap_position TripointCoord Absolute OMT position.
---@field target TripointCoord Absolute submap target.
---@field nemesis_target TripointCoord Absolute submap target.
---@field population integer Native population when no individual monsters are tracked.
---@field tracked_monsters integer Number of individually tracked monsters.
---@field interest integer Native interest.
---@field dying boolean Native decay flag.
---@field horde boolean Native horde flag.
---@field behavior "none"|"city"|"roam"|"nemesis" Native behavior.
---@field empty boolean Whether the group is empty.
---@field safe boolean Native safety classification.
---@field average_speed number Native average speed.
---@field monsters CcbHordeLegacyMonsterPage Bounded tracked-monster page.

---@class CcbHordeLegacyGroupPage
---@field items CcbHordeLegacyGroupSnapshot[] Detached legacy-group snapshots.
---@field offset integer
---@field limit integer
---@field total integer
---@field returned integer
---@field has_more boolean
---@field radius integer Effective query radius.
---@field radius_z integer Effective vertical query radius.
---@field horde_only boolean Effective horde-only filter.
---@field existing_overmaps integer Number of existing overmaps inspected.
---@field existing_only boolean Always true for this bounded API.

---@class CcbHordeSummary
---@field position TripointCoord Absolute OMT query center.
---@field entities integer Number of horde entities.
---@field active integer Active entity count.
---@field idle integer Idle entity count.
---@field dormant integer Dormant entity count.
---@field immobile integer Immobile entity count.
---@field legacy_hordes integer Number of legacy horde groups.
---@field legacy_population integer Estimated legacy population.
---@field estimated_size integer Combined bounded estimate.
---@field has_horde boolean Whether any matching horde exists.
---@field existing_only boolean Always true for this bounded API.

---@class CcbHordeAlertResult
---@field status "committed" Status of the single-entity commit.
---@field before CcbHordeEntitySnapshot Detached pre-commit snapshot.
---@field after CcbHordeEntitySnapshot Detached post-commit snapshot; the token remains valid.

---@class CcbHordeEntityCreateResult: CcbHordeEntitySnapshot
---@field status "committed" Status of the single-entity creation commit.

---@class CcbHordeLegacyGroupUpdateResult
---@field status "committed" Status of the single-group commit.
---@field before CcbHordeLegacyGroupSnapshot Detached pre-commit snapshot.
---@field after CcbHordeLegacyGroupSnapshot Detached post-commit snapshot; the token remains valid.

---@class CcbHordeLegacyGroupCreateResult: CcbHordeLegacyGroupSnapshot
---@field status "committed" Status of the single-group creation commit.

---@class CcbHordeEntityRemoveResult: CcbHordeEntitySnapshot
---@field status "committed" Status of the single removal commit.
---@field removed boolean Always true when returned as a successful value; the token is stale afterward.

---@class CcbHordeLegacyGroupRemoveResult: CcbHordeLegacyGroupSnapshot
---@field status "committed" Status of the single removal commit.
---@field removed boolean Always true when returned as a successful value; the token is stale afterward.

---@class CcbHordeDefinitionSummary
---@field id GameId GameId<monster_group> Horde definition identity.
---@field default_monster GameId|nil GameId<monster>, if any.
---@field entries integer Number of entries in the definition.
---@field is_animal boolean Whether the definition is for animals.
---@field safe boolean Whether the definition is safe.

---@class CcbHordeStringPage
---@field items string[] Detached strings.
---@field total integer
---@field limit integer
---@field returned integer
---@field truncated boolean

---@class CcbHordeDefinitionEntry
---@field kind "group"|"monster" Entry kind.
---@field id GameId Monster or monster-group identity.
---@field frequency integer Entry frequency.
---@field cost_multiplier number Entry cost multiplier.
---@field pack_minimum integer Minimum pack size.
---@field pack_maximum integer Maximum pack size.
---@field starts TimeDuration Entry start delay.
---@field ends TimeDuration Entry end delay.
---@field lasts_forever boolean Whether the entry lasts forever.
---@field event string Holiday event name.
---@field conditions CcbHordeStringPage Entry conditions.

---@class CcbHordeDefinitionEntryPage
---@field items CcbHordeDefinitionEntry[] Detached horde definition entries.
---@field total integer
---@field offset integer
---@field limit integer
---@field returned integer
---@field has_more boolean

---@class CcbHordeDefinitionPage
---@field items CcbHordeDefinitionSummary[] Detached horde definitions.
---@field offset integer
---@field limit integer
---@field total integer
---@field returned integer
---@field has_more boolean

---@class CcbHordeDefinition
---@field id GameId GameId<monster_group> Horde definition identity.
---@field default_monster GameId|nil GameId<monster>, if any.
---@field is_animal boolean Whether the definition is for animals.
---@field replace_monster_group boolean Whether the definition replaces another group.
---@field new_monster_group GameId|nil Replacement monster-group identity, if any.
---@field replacement_time TimeDuration Replacement time.
---@field safe boolean Whether the definition is safe.
---@field frequency_total integer Total entry frequency.
---@field entries CcbHordeDefinitionEntryPage Definition entries page.

---@class CcbHordeMonsterPage
---@field items GameId[] GameId<monster> identities.
---@field group GameId GameId<monster_group> Horde definition identity.
---@field recursive boolean Whether recursively referenced groups were included.
---@field offset integer
---@field limit integer
---@field total integer
---@field returned integer
---@field has_more boolean

---@class CcbHordesApi
---@return CcbHordeLimits
function CcbHordesApi.limits() end

---@param options? CcbHordePageOptions
---@return CcbHordeDefinitionPage
function CcbHordesApi.definitions(options) end

---@param id GameId GameId<monster_group> Horde definition identity.
---@param options? CcbHordePageOptions
---@return CcbHordeDefinition
function CcbHordesApi.definition(id, options) end

---@param id GameId GameId<monster_group> Horde definition identity.
---@param recursive? boolean Include recursively referenced groups.
---@param options? CcbHordePageOptions
---@return CcbHordeMonsterPage
function CcbHordesApi.monsters(id, recursive, options) end

---@param group GameId GameId<monster_group> Horde definition identity.
---@param monster GameId GameId<monster> Monster identity.
---@return boolean
function CcbHordesApi.contains(group, monster) end

---@param center TripointCoord Absolute OMT query center.
---@param options? CcbHordeEntityQueryOptions
---@return CcbHordeEntityPage
function CcbHordesApi.entities(center, options) end

---@param token HordeEntityToken Exact generation-bound entity token.
---@return CcbResult result `value` is a CcbHordeEntitySnapshot.
function CcbHordesApi.entity(token) end

---@param center TripointCoord Absolute OMT query center.
---@param options? CcbHordeLegacyQueryOptions
---@return CcbHordeLegacyGroupPage
function CcbHordesApi.legacy_groups(center, options) end

---@param token LegacyHordeToken Exact generation-bound legacy-group token.
---@return CcbResult result `value` is a CcbHordeLegacyGroupSnapshot.
function CcbHordesApi.legacy_group(token) end

---@param position TripointCoord Absolute OMT query center.
---@return CcbHordeSummary
function CcbHordesApi.summary(position) end

---@param position TripointCoord Absolute map-square insertion position.
---@param monster GameId GameId<monster> to create.
---@return CcbResult result `value` is a CcbHordeEntityCreateResult; the returned token is valid.
function CcbHordesApi.spawn_entity(position, monster) end

---@param token HordeEntityToken Exact generation-bound entity token.
---@param destination TripointCoord Absolute map-square destination.
---@param intensity integer Tracking intensity from 0 through CcbHordeLimits.maximum_tracking_intensity.
---@return CcbResult result `value` is a CcbHordeAlertResult; the token remains valid after commit.
function CcbHordesApi.alert_entity(token, destination, intensity) end

---@param token HordeEntityToken Exact generation-bound entity token.
---@return CcbResult result `value` is a CcbHordeEntityRemoveResult; the token is stale after commit.
function CcbHordesApi.remove_entity(token) end

---@param options CcbHordeLegacyGroupOptions
---@return CcbResult result `value` is a CcbHordeLegacyGroupCreateResult; the returned token is valid.
function CcbHordesApi.spawn_legacy_group(options) end

---@param token LegacyHordeToken Exact generation-bound legacy-group token.
---@param options CcbHordeLegacyGroupUpdateOptions
---@return CcbResult result `value` is a CcbHordeLegacyGroupUpdateResult; the token remains valid after commit.
function CcbHordesApi.update_legacy_group(token, options) end

---@param token LegacyHordeToken Exact generation-bound legacy-group token.
---@return CcbResult result `value` is a CcbHordeLegacyGroupRemoveResult; the token is stale after commit.
function CcbHordesApi.remove_legacy_group(token) end

---@class CcbPlatformServices
---@field lore CcbPlatformLoreApi
---@field native_events CcbPlatformNativeEventsApi
---@field snippets CcbPlatformSnippetsApi
---@field text CcbPlatformTextApi
---@field tileset CcbPlatformTilesetApi
---@field achievements CcbPlatformAchievementsApi
---@field activities CcbPlatformActivitiesApi
---@field addictions CcbAddictionsApi
---@field bionics CcbPlatformBionicsApi
---@field camps CcbCampsApi
---@field characters CcbCharactersApi
---@field constants CcbConstantsApi
---@field coords CcbCoordsApi
---@field crafting CcbCraftingApi
---@field creatures CcbCreaturesApi
---@field effects CcbEffectsApi
---@field enums CcbEnumsApi
---@field factions CcbFactionsApi
---@field followers CcbFollowersApi
---@field handles CcbHandlesApi Handles are bound to the exact Platform Mod runtime owner as well as its runtime/world generations.
---@field interaction CcbPlatformInteractionApi
---@field hordes CcbHordesApi
---@field inventory CcbPlatformInventoryApi
---@field items CcbItemsApi
---@field item_categories CcbItemCategoriesApi Runtime item-category spawn-rate service; distinct from content.ItemCategoryDefinition.
---@field martial_arts CcbPlatformMartialArtsApi
---@field messages CcbPlatformMessagesApi
---@field missions CcbMissionsApi
---@field morale CcbPlatformMoraleApi
---@field mapgen CcbMapgenApi
---@field map CcbMapApi Token-gated loaded map tile snapshots and edits.
---@field mutations CcbMutationsApi
---@field needs CcbNeedsApi
---@field npcs CcbNpcsApi
---@field overmap CcbOvermapApi
---@field proficiencies CcbProficienciesApi
---@field random CcbPlatformRandomApi
---@field recipes CcbPlatformRecipesApi
---@field relocation CcbRelocationApi
---@field requirements CcbRequirementsApi
---@field registry CcbRegistryApi Read-only native definition registry.
---@field serde CcbSerdeApi
---@field skills CcbSkillsApi
---@field sound CcbPlatformSoundApi
---@field spawns CcbSpawnsApi
---@field spells CcbSpellsApi
---@field statistics CcbStatisticsApi
---@field targeting CcbTargetingApi
---@field time CcbTimeApi
---@field trade CcbTradeApi
---@field types CcbTypesApi
---@field units CcbUnitsApi
---@field variables CcbVariablesApi
---@field vehicles CcbVehiclesApi
---@field vitamins CcbVitaminsApi
---@field weather CcbWeatherApi
---@field wounds CcbPlatformWoundsApi
---@field world CcbWorldApi
---@field zones CcbZonesApi
---@field gameplay CcbPlatformGameplayApi
---@field equipment CcbEquipmentApi
local CcbPlatformServices = {}
---@param handle GameHandle
---@param job string
---@return any
function CcbPlatformActivitiesApi.assign_npc_job(handle, job) end
---@param character_handle GameHandle
---@return any
function CcbPlatformActivitiesApi.clear_backlog(character_handle) end
---@param npc_handle GameHandle
---@return any
function CcbPlatformActivitiesApi.dismount(npc_handle) end
---@param character_handle GameHandle
---@param item_handle GameHandle
---@param quantity integer
---@param placement TripointCoord Required explicit relative map-square placement.
---@param force_ground? boolean
---@return CcbResult result `value` is a CcbItemActivityResult; the input handle is retired before scheduling.
function CcbPlatformActivitiesApi.drop_item(character_handle, item_handle, quantity, placement, force_ground) end
---@param npc_handle GameHandle
---@return any
function CcbPlatformActivitiesApi.drop_nonfavorite_items(npc_handle) end
---@param reason string
---@return any
function CcbPlatformActivitiesApi.offer_interruption(reason) end
---@param message string
---@return any
function CcbPlatformActivitiesApi.offer_portal_storm_interruption(message) end
---@param character_handle GameHandle
---@param item_handle GameHandle
---@param quantity integer
---@param autopickup? boolean
---@return CcbResult result `value` is a CcbItemActivityResult; the input handle is retired before scheduling.
function CcbPlatformActivitiesApi.pickup_item(character_handle, item_handle, quantity, autopickup) end
---@param character_handle GameHandle
---@param book_handle GameHandle
---@param duration TimeDuration
---@param ereader_handle? GameHandle
---@param continuous? boolean
---@param learner_handle? GameHandle
---@return any
function CcbPlatformActivitiesApi.read(character_handle, book_handle, duration, ereader_handle, continuous, learner_handle) end
---@param character_handle GameHandle
---@return any
function CcbPlatformActivitiesApi.resume(character_handle) end
---@param handle GameHandle
---@return any
function CcbPlatformActivitiesApi.revert_npc_job(handle) end
---@param character_handle GameHandle
---@param partner_handle GameHandle
---@param duration TimeDuration
---@return any
function CcbPlatformActivitiesApi.socialize(character_handle, partner_handle, duration) end
---@param teacher_handle GameHandle
---@param trainee_handles table
---@param subject_id GameId
---@param duration TimeDuration
---@return any
function CcbPlatformActivitiesApi.start_training(teacher_handle, trainee_handles, subject_id, duration) end
---@param character_handle GameHandle
---@return any
function CcbPlatformActivitiesApi.suspend(character_handle) end
---@param character_handle GameHandle
---@return any
function CcbPlatformActivitiesApi.target_practice(character_handle) end
---@param character_handle GameHandle
---@param npc_handle GameHandle
---@param duration TimeDuration
---@return any
function CcbPlatformActivitiesApi.wait_for_npc(character_handle, npc_handle, duration) end
---@param descriptor table
---@return any
function CcbMapgenApi.define(descriptor) end
---@return any
function CcbMapgenApi.limits() end
---@param descriptor table
---@return any
function CcbMapgenApi.register_palette(descriptor) end
---@param id string
---@return any
function CcbPlatformModQueries.load_order(id) end
---@param interval_turns integer
---@param handler_id string
---@param payload? table<string, boolean|integer|number|string> Persistent scalar payload; live GameHandle values are rejected and never stored.
---@param payload_version? integer
---@param scope? 'character'|'world'
---@param actor? GameHandle Exact live Character, Item, Monster, or Vehicle handle; only the stable actor identity is persisted and the live handle is callback-transient.
---@param participants? table<string, GameHandle> Optional required participant handles keyed by unique role names; at most 4 participants. Role names must match ASCII `[A-Za-z_][A-Za-z0-9_]{0,31}`.
---@return integer task_id
function CcbPlatformTasks.every(interval_turns, handler_id, payload, payload_version, scope, actor, participants) end
---@param id integer
---@return CcbPlatformTaskSnapshot|nil
function CcbPlatformTasks.get(id) end
---@param handler_id? string
---@param scope? string
---@param requested_limit? integer
---@return CcbPlatformTaskPage
function CcbPlatformTasks.list(handler_id, scope, requested_limit) end
---@param handler_id string
---@param scope? string
---@return CcbPlatformTaskSnapshot|nil
function CcbPlatformTasks.next(handler_id, scope) end
---@param message string
---@return any
function CcbPlatformPresentation.notice_any_key(message) end
---@param message string
---@return any
function CcbPlatformPresentation.notice_large(message) end
---@param message string
---@return any
function CcbPlatformPresentation.notice_top(message) end

---@class CcbVehiclePartSnapshot
---@field handle? GameHandle Exact stable VehiclePart handle; absent for removed, fake, or unidentifiable parts.
---@field vehicle GameHandle Exact owning Vehicle handle.
---@field part_uid? integer Stable base-item UID; never a part-index lookup key.
---@field index integer Current diagnostic ordering only; never an identity.
---@field id GameId GameId<vehicle_part>
---@field location GameId GameId<vehicle_part_location>
---@field name string Detached bounded part name.
---@field mount table<string, integer> Stable mount coordinates for diagnostics.
---@field position TripointCoord Current absolute map-square position.
---@field variant string
---@field hp integer
---@field durability integer
---@field damage_percent number
---@field broken boolean
---@field available boolean
---@field enabled boolean
---@field removed boolean
---@field fake boolean
---@field features table<string, boolean>
---@field ammo? table<string, any>

---@class CcbVehiclePartsPage
---@field items CcbVehiclePartSnapshot[] Dense bounded native-order snapshots.
---@field offset integer Requested diagnostic offset, not an identity cursor.
---@field limit integer Bounded page limit.
---@field total integer Current count of matching parts at query time.
---@field returned integer Number of returned parts.
---@field has_more boolean Whether another bounded page existed at query time.
---@field include_fake boolean
---@field include_removed boolean

---@class CcbVehicleSnapshot
---@field name string
---@field display_name string
---@field prototype GameId GameId<vehicle_prototype>
---@field position TripointCoord
---@field parts integer Current part count; part identity is exposed only by `vehicles.parts`.
---@field real_parts integer
---@field state table<string, any> Detached vehicle state.
---@field motion table<string, any> Detached motion state.
---@field lift table<string, any> Detached lift state.

---@class CcbVehicleSpawnOptions
---@field rotation_degrees? integer
---@field fuel_percent? integer
---@field status? integer
---@field merge_wrecks? boolean
---@field owner? GameId GameId<faction>

---@class CcbVehicleSpawnResult
---@field handle GameHandle New exact Vehicle handle.
---@field vehicle CcbVehicleSnapshot Detached vehicle snapshot.

---@class CcbVehiclePartMutationResult
---@field changed boolean
---@field before? CcbVehiclePartSnapshot
---@field after? CcbVehiclePartSnapshot
---@field vehicle GameHandle Exact owning Vehicle handle.
---@field part? GameHandle New/current exact VehiclePart handle when still live.
---@field part_stale boolean True when the operation removed/replaced the part.
---@field part_error? string Stable stale diagnostic when no part handle remains.

---@class CcbVehiclesApi
local CcbVehiclesApi = {}

---@param options? CcbVehicleDefinitionQueryOptions
---@return CcbResult result `value` is a bounded page of detached prototype snapshots.
function CcbVehiclesApi.definitions(options) end
---@param id GameId GameId<vehicle_prototype>
---@return CcbResult result `value` is a detached prototype snapshot.
function CcbVehiclesApi.definition(id) end
---@param vehicle GameHandle Exact live Vehicle handle.
---@return CcbResult result `value` is a detached CcbVehicleSnapshot.
function CcbVehiclesApi.get(vehicle) end
---@param vehicle GameHandle Exact live Vehicle handle.
---@param options? CcbVehiclePartPageOptions `offset`/`limit` page diagnostics; returned part handles are stable and exact.
---@return CcbResult result `value` is a CcbVehiclePartsPage.
function CcbVehiclesApi.parts(vehicle, options) end
---@param vehicle GameHandle Exact live Vehicle handle.
---@return CcbResult result `value` is a bounded detached fuel page.
function CcbVehiclesApi.fuels(vehicle) end
---@param vehicle GameHandle Exact live Vehicle handle.
---@param name string Bounded vehicle name.
---@return CcbResult
function CcbVehiclesApi.rename(vehicle, name) end
---@param vehicle GameHandle Exact live Vehicle handle.
---@param velocity integer
---@return CcbResult
function CcbVehiclesApi.set_cruise_velocity(vehicle, velocity) end
---@param vehicle GameHandle Exact live Vehicle handle.
---@param options? CcbVehicleStopOptions
---@return CcbResult
function CcbVehiclesApi.stop(vehicle, options) end
---@param vehicle GameHandle Exact live Vehicle handle.
---@param enabled boolean
---@return CcbResult
function CcbVehiclesApi.set_tracking(vehicle, enabled) end
---@param vehicle GameHandle Exact live Vehicle handle.
---@param part GameHandle Exact stable VehiclePart handle returned by `vehicles.parts` and owned by `vehicle`.
---@param enabled boolean
---@return CcbResult result `value` is a CcbVehiclePartMutationResult; stale/replaced parts return no writable handle.
function CcbVehiclesApi.set_part_enabled(vehicle, part, enabled) end
---@param id GameId GameId<vehicle_prototype>
---@param post_cataclysm? boolean
---@return integer
function CcbVehiclesApi.prototype_value(id, post_cataclysm) end
---@param vehicle GameHandle Exact live Vehicle handle.
---@param options? CcbVehicleValueOptions
---@return CcbResult
function CcbVehiclesApi.value(vehicle, options) end
---@param vehicle GameHandle Exact live Vehicle handle.
---@return CcbResult
function CcbVehiclesApi.is_player_controlling(vehicle) end
---@param vehicle GameHandle Exact live Vehicle handle.
---@param flag string
---@param enabled? boolean
---@return CcbResult
function CcbVehiclesApi.has_part_flag(vehicle, flag, enabled) end
---@param prototype GameId GameId<vehicle_prototype>
---@param position TripointCoord Explicit absolute map-square spawn position.
---@param options? CcbVehicleSpawnOptions
---@return CcbResult result `value` is a CcbVehicleSpawnResult.
function CcbVehiclesApi.spawn(prototype, position, options) end
---@param vehicle GameHandle Exact live Vehicle handle.
---@return CcbResult result `value.handle_stale` is always true after destruction.
function CcbVehiclesApi.destroy(vehicle) end
---@param vehicle GameHandle Exact live Vehicle handle.
---@param owner GameId GameId<faction>
---@return CcbResult
function CcbVehiclesApi.set_owner(vehicle, owner) end
---@param vehicle GameHandle Exact live Vehicle handle.
---@param mechanic GameHandle Exact live NPC/Character mechanic handle.
---@param repair_multiplier? number
---@return CcbResult
function CcbVehiclesApi.quote_full_repair(vehicle, mechanic, repair_multiplier) end
---@param vehicle GameHandle Exact live Vehicle handle.
---@param mechanic GameHandle Exact live NPC/Character mechanic handle.
---@param repair_multiplier? number
---@return CcbResult
function CcbVehiclesApi.start_full_repair(vehicle, mechanic, repair_multiplier) end
---@param vehicle GameHandle Exact live Vehicle handle.
---@param mechanic GameHandle Exact live NPC/Character mechanic handle.
---@param repair_multiplier? number
---@param install_multiplier? number
---@return CcbResult
function CcbVehiclesApi.open_part_service(vehicle, mechanic, repair_multiplier, install_multiplier) end

---@class MissionToken
---@field uid integer Native mission instance id; not sufficient to resume after replacement.
---@field identity_generation integer Native mission-instance generation.
---@field runtime_generation integer Lua runtime generation bound to this token.
---@field world_generation integer World generation bound to this token.
---@field is_valid fun(self: MissionToken): boolean False after mission replacement, runtime replacement, or world reload.

---@class CcbMissionSnapshot
---@field token MissionToken Exact mission-instance token.
---@field uid integer Display-only native mission uid.
---@field id GameId GameId<mission> definition id.
---@field name string
---@field description string
---@field status 'reserved'|'active'|'success'|'failure'
---@field assigned boolean
---@field in_progress boolean
---@field failed boolean
---@field selected boolean True only relative to the explicit owner supplied to the query.
---@field has_deadline boolean
---@field deadline? TimePoint
---@field has_target boolean
---@field target? TripointCoord
---@field follow_up? GameId GameId<mission>
---@field value integer
---@field item? GameId GameId<item>
---@field npc_id? integer
---@field assigned_player_id? integer
---@field likely_rewards table
---@field has_generic_rewards boolean

---@class CcbMissionPage
---@field items CcbMissionSnapshot[] Missions assigned to the explicit owner.
---@field total integer
---@field offset integer
---@field limit integer
---@field returned integer
---@field has_more boolean
---@field owner GameHandle Exact avatar owner used for the query.
---@field status 'all'|'reserved'|'active'|'success'|'failure'

---@class CcbMissionMutation
---@field before? CcbMissionSnapshot
---@field after? CcbMissionSnapshot
---@field cancelled? CcbMissionSnapshot
---@field abandoned? CcbMissionSnapshot
---@field removed? boolean
---@field cleared? boolean
---@field changed? boolean
---@field step? integer
---@field forced? boolean

---@class CcbMissionsApi
local CcbMissionsApi = {}

---@param options? CcbMissionQueryOptions `offset`, `limit`, and `status`; definitions are detached and bounded.
---@return table
function CcbMissionsApi.definitions(options) end
---@param id GameId GameId<mission>
---@return table Detached mission definition.
function CcbMissionsApi.definition(id) end
---@param owner GameHandle Exact avatar owner; no ambient avatar is selected.
---@param options? CcbMissionQueryOptions `offset`, `limit`, and `status`.
---@return CcbMissionPage
function CcbMissionsApi.list(owner, options) end
---@param token MissionToken Exact mission-instance token.
---@return CcbResult result `value` is a CcbMissionSnapshot.
function CcbMissionsApi.get(token) end
---@param owner GameHandle Exact avatar owner; no ambient current mission is selected.
---@return CcbResult result `value` is the owner's selected mission snapshot.
function CcbMissionsApi.selected(owner) end
---@param owner GameHandle Exact avatar owner.
---@param id GameId GameId<mission>
---@return CcbResult result `value` is boolean.
function CcbMissionsApi.has_active(owner, id) end
---@param origin GameEnum GameEnum<MissionOrigin>
---@param position TripointCoord Absolute overmap-terrain position.
---@return CcbResult result `value` is GameId<mission>.
function CcbMissionsApi.random_definition(origin, position) end
---@param id GameId GameId<mission>
---@param npc_id? integer Mission giver id, or nil when there is no giver.
---@return CcbResult result `value` is a reserved CcbMissionSnapshot.
function CcbMissionsApi.reserve(id, npc_id) end
---@param origin GameEnum GameEnum<MissionOrigin>
---@param position TripointCoord Absolute overmap-terrain position.
---@param npc_id? integer Mission giver id, or nil when there is no giver.
---@return CcbResult result `value` is a reserved CcbMissionSnapshot.
function CcbMissionsApi.reserve_random(origin, position, npc_id) end
---@param owner GameHandle Exact avatar owner.
---@param token MissionToken Exact mission-instance token.
---@return CcbResult result `value` is a CcbMissionSnapshot.
function CcbMissionsApi.assign(owner, token) end
---@param token MissionToken Exact mission-instance token.
---@param deadline? TimePoint
---@return CcbResult result `value` is a CcbMissionMutation.
function CcbMissionsApi.set_deadline(token, deadline) end
---@param owner GameHandle Exact avatar owner.
---@param token MissionToken Exact mission-instance token.
---@return CcbResult result `value` is a CcbMissionSnapshot.
function CcbMissionsApi.select(owner, token) end
---@param owner GameHandle Exact avatar owner.
---@param token MissionToken Exact mission-instance token.
---@param npc_id? integer Explicit mission-giver id used by the native goal check.
---@return CcbResult result `value` is boolean.
function CcbMissionsApi.is_complete(owner, token, npc_id) end
---@param owner GameHandle Exact avatar owner.
---@param token MissionToken Exact mission-instance token.
---@param step integer Bounded native step.
---@return CcbResult result `value` is a CcbMissionMutation.
function CcbMissionsApi.step_complete(owner, token, step) end
---@param owner GameHandle Exact avatar owner.
---@param token MissionToken Exact mission-instance token.
---@return CcbResult result `value` is a CcbMissionMutation.
function CcbMissionsApi.fail(owner, token) end
---@param owner GameHandle Exact avatar owner.
---@param token MissionToken Exact mission-instance token.
---@param force? boolean Explicit completion override.
---@return CcbResult result `value` is a CcbMissionMutation.
function CcbMissionsApi.complete(owner, token, force) end
---@param token MissionToken Exact unassigned mission-instance token.
---@return CcbResult result `value` is a CcbMissionMutation.
function CcbMissionsApi.cancel(token) end
---@param owner GameHandle Exact avatar owner.
---@param token MissionToken Exact mission-instance token.
---@return CcbResult result `value` is a CcbMissionMutation.
function CcbMissionsApi.abandon(owner, token) end

---@class CcbFactionReputation
---@field likes integer
---@field respects integer
---@field trusts integer
---@field ranking string
---@field respect string

---@class CcbFactionResources
---@field size integer
---@field power integer
---@field wealth integer
---@field food_kcal integer
---@field wealth_description string
---@field combat_ability string

---@class CcbFactionPolicy
---@field consumes_food boolean
---@field lone_wolf boolean
---@field limited_area_claim boolean
---@field stealing 'ask'|'always'|'never'

---@class CcbFactionSnapshot
---@field id GameId GameId<faction>
---@field name string
---@field description string
---@field summary string
---@field known_by_player boolean
---@field reputation CcbFactionReputation
---@field resources CcbFactionResources
---@field policy CcbFactionPolicy
---@field currency? GameId GameId<item>
---@field monster_faction? GameId GameId<monster_faction>
---@field members integer
---@field relationship_targets integer

---@class CcbFactionPage
---@field items CcbFactionSnapshot[]
---@field offset integer
---@field limit integer
---@field total integer
---@field returned integer
---@field has_more boolean

---@class CcbFactionsApi
local CcbFactionsApi = {}

---@param options? CcbFactionQueryOptions `offset`, `limit`, and bounded text `query`.
---@return CcbResult result `value` is a CcbFactionPage.
function CcbFactionsApi.list(options) end
---@param id GameId GameId<faction>
---@return CcbResult result `value` is a CcbFactionSnapshot.
function CcbFactionsApi.get(id) end
---@param character GameHandle Exact live Character handle; no global player fallback.
---@return CcbResult result `value` is the Character's faction snapshot.
function CcbFactionsApi.for_character(character) end
---@param id GameId GameId<faction>
---@param options? CcbFactionQueryOptions Bounded `offset` and `limit`.
---@return CcbResult result `value` is a bounded member page.
function CcbFactionsApi.members(id, options) end
---@param id GameId GameId<faction>
---@param options? CcbFactionQueryOptions Bounded `offset` and `limit`.
---@return CcbResult result `value` is a bounded relationship page.
function CcbFactionsApi.relationships(id, options) end
---@param id GameId GameId<faction>
---@param target GameId GameId<faction>
---@return CcbResult result `value` is the typed relationship snapshot.
function CcbFactionsApi.relationship(id, target) end
---@param id GameId GameId<faction>
---@param options? CcbFactionQueryOptions Bounded `offset` and `limit`.
---@return CcbResult result `value` contains food and vitamin snapshots.
function CcbFactionsApi.food(id, options) end
---@param id GameId GameId<faction>
---@param name string Non-empty bounded faction name.
---@return CcbResult result
function CcbFactionsApi.rename(id, name) end
---@param id GameId GameId<faction>
---@param known boolean
---@return CcbResult result
function CcbFactionsApi.set_known(id, known) end
---@param id GameId GameId<faction>
---@param deltas table<string, integer> Typed `likes`, `respects`, and/or `trusts` deltas.
---@return CcbResult result
function CcbFactionsApi.modify_reputation(id, deltas) end
---@param id GameId GameId<faction>
---@param deltas table<string, integer> Typed `size`, `power`, and/or `wealth` deltas.
---@return CcbResult result
function CcbFactionsApi.modify_resources(id, deltas) end
---@param id GameId GameId<faction>
---@param kcal integer Bounded food delta.
---@return CcbResult result
function CcbFactionsApi.modify_food(id, kcal) end
---@param id GameId GameId<faction>
---@param options CcbFactionPolicyOptions Typed `consumes_food` and/or `stealing` values.
---@return CcbResult result
function CcbFactionsApi.set_policy(id, options) end
---@param id GameId GameId<faction>
---@param target GameId GameId<faction>
---@param options CcbFactionRelationshipOptions Typed relationship flags.
---@return CcbResult result
function CcbFactionsApi.set_relationship(id, target, options) end

---@class CcbItemPageContinuation
---@field continuation_id integer Opaque single-use cursor id; do not construct or reuse after consumption.
---@field holder CcbItemHolder Root holder bound to this cursor.
---@field page_size integer Bound page size.
---@field max_depth integer Bound nested-container depth.
---@field recursive boolean Whether nested contents are traversed.
---@field same_runtime_world_holder boolean True; runtime, world, holder, options, and holder mutation must remain unchanged.
---@field reason 'page'|'node_budget'

---@class CcbItemHolder
---@field kind 'character'|'map_tile'|'container_pocket'|'vehicle_cargo' Typed native holder kind; no item_location or string path is accepted.
---@field character? GameHandle Exact Character owner when kind is character.
---@field slot? 'inventory'|'worn'|'wielded' Explicit Character position when kind is character.
---@field tile? MapTileToken Exact token when kind is map_tile; bare/local/OMT coordinates are rejected.
---@field container? GameHandle Exact container Item handle when kind is container_pocket.
---@field pocket_index? integer Zero-based native pocket index when kind is container_pocket.
---@field vehicle? GameHandle Exact Vehicle handle when kind is vehicle_cargo.
---@field part? GameHandle Exact stable VehiclePart handle owned by `vehicle`; no part-index lookup is accepted.

---@class CcbItemPageEntry
---@field handle GameHandle Exact generation-safe Item handle.
---@field snapshot table<string, any> Detached bounded Item snapshot; no borrowed pointer.
---@field holder CcbItemHolder Exact holder of this Item at query time.
---@field depth integer Zero for a direct holder item.
---@field uid integer Display-only UID; never used to resume a cursor.
---@field parent_uid? integer Display-only immediate parent UID.

---@class CcbItemPageResult
---@field items CcbItemPageEntry[] Dense bounded page.
---@field holder CcbItemHolder Explicit query root holder.
---@field page_size integer Requested bounded page size.
---@field returned integer Number of entries in this page.
---@field complete boolean True only when traversal reached its natural end under the query bounds.
---@field truncated boolean True when a page, node budget, max depth, cycle, repetition, or invalid pocket stopped traversal.
---@field stop_reason 'empty'|'complete'|'page'|'node_budget'|'max_depth'|'cycle'|'repeated_item'|'invalid_pocket'|'stale_cursor'
---@field max_depth integer Explicit maximum nested depth.
---@field recursive boolean Whether nested contents were traversed.
---@field continuation? CcbItemPageContinuation Single-use continuation when traversal can safely resume.
---@field next? CcbItemPageContinuation Alias of continuation for callers that use next cursors.

---@class CcbItemUpdateOptions
---@field charges? integer
---@field damage? integer
---@field degradation? integer
---@field burnt? integer
---@field favorite? boolean
---@field active? boolean
---@field browsed? boolean
---@field relative_rot? number
---@field rot? TimeDuration

---@class CcbItemTransformOptions
---@field carrier? GameHandle Exact Character handle; if present the item must be owned by it.
---@field active? boolean
---@field browsed? boolean

---@class CcbItemTransformResult
---@field before table<string, any> Detached state before conversion.
---@field after table<string, any> Detached state after conversion.
---@field changed boolean
---@field old_handle_stale boolean Always true; the input handle is retired.
---@field handle GameHandle New generation-safe handle for the replacement identity.

---@class CcbItemActivationOptions
---@field target TripointCoord Required explicit absolute map-square target; no current-tile fallback.

---@class CcbItemActivationResult
---@field accepted boolean
---@field destroyed boolean
---@field stale boolean True when the input handle no longer resolves.
---@field method string
---@field item? table<string, any> Detached item snapshot when still live.
---@field handle? GameHandle Replacement/current handle when still live.

---@class CcbItemActivityResult
---@field quantity integer
---@field item_uid integer Display-only UID; never used to resolve a handle.
---@field input_handle_retired boolean The scheduled operation retires the input handle before it runs.
---@field activity table<string, any> Detached activity snapshot.

---@class CcbItemTransferResult
---@field accepted boolean True only after destination insertion and exact source removal/charge mutation commit.
---@field changed boolean
---@field quantity integer Exact transferred quantity or charge count.
---@field source_handle_stale boolean True for a full transfer; partial charge transfers retain the source handle.
---@field old_handle_stale boolean Alias for source_handle_stale; the source handle is never silently re-resolved.
---@field handle GameHandle Exact generation-safe handle for the destination identity.
---@field source_holder CcbItemHolder Holder proven before the transfer.
---@field holder CcbItemHolder Current typed destination holder.
---@field item table<string, any> Detached bounded snapshot of the destination item.

---@class CcbItemFaultOptions
---@field force? boolean
---@field message? boolean
---@field holder? GameHandle Exact Character handle owning the item; never inferred.

-- Runtime item-category rate mutations are intentionally separate from the
-- content.ItemCategoryDefinition constructor and its definition-time field.
---@class CcbItemCategorySpawnRateOptions
---@field id GameId GameId<item_category> Existing native item category.
---@field spawn_rate number Finite multiplier in the inclusive range 0..1000000.

---@class CcbItemCategorySpawnRateResult
---@field id GameId GameId<item_category> Category whose runtime rate was changed.
---@field before number Runtime spawn rate before the commit.
---@field after number Runtime spawn rate after the commit.
---@field changed boolean Whether the runtime spawn rate changed.

---@class CcbItemCategorySpawnRateBatchResult
---@field items CcbItemCategorySpawnRateResult[] Results in submitted order.
---@field count integer Number of committed unique category updates.

---@class CcbItemCategoriesApi
local CcbItemCategoriesApi = {}

---@param id GameId GameId<item_category> Existing native item category.
---@return CcbResult result `value` is the current runtime spawn-rate number.
function CcbItemCategoriesApi.spawn_rate(id) end

---@param id GameId GameId<item_category> Existing native item category.
---@param rate number Finite multiplier in the inclusive range 0..1000000.
---@return CcbResult result `value` is a CcbItemCategorySpawnRateResult.
function CcbItemCategoriesApi.set_spawn_rate(id, rate) end

---@param updates CcbItemCategorySpawnRateOptions[] Dense one-based array of at most 256 unique category updates; all entries are validated before the commit.
---@return CcbResult result `value` is a CcbItemCategorySpawnRateBatchResult.
function CcbItemCategoriesApi.set_spawn_rates(updates) end

---@class CcbItemsApi
local CcbItemsApi = {}

---@param item_handle GameHandle Exact live source Item handle; no same-id lookup.
---@param source_holder CcbItemHolder Exact current holder descriptor for the source.
---@param destination_holder CcbItemHolder Explicit destination holder descriptor.
---@param quantity? integer Whole item count or bounded charge count; defaults to the complete source item.
---@return CcbResult result `value` is a CcbItemTransferResult; destination rejection leaves the source unchanged.
function CcbItemsApi.transfer(item_handle, source_holder, destination_holder, quantity) end
---@param holder CcbItemHolder Explicit Character, map-tile, container-pocket, or vehicle-cargo root.
---@param options? table<string, integer|boolean> `page_size` defaults to 64 (max 256); `max_depth` defaults to 8 (max 64); `recursive` defaults to true.
---@param continuation? CcbItemPageContinuation Single-use cursor returned by the prior page; holder/options must match exactly.
---@return CcbResult result `value` is a CcbItemPageResult; no total is claimed unless `complete` is true.
function CcbItemsApi.page(holder, options, continuation) end
---@param handle GameHandle Exact live item handle.
---@param relation_limit? integer
---@return CcbResult result `value` is a detached bounded item snapshot.
function CcbItemsApi.snapshot(handle, relation_limit) end
---@param id GameId GameId<item>
---@return integer
function CcbItemsApi.food_fun(id) end
---@param group GameId GameId<item_group>
---@return table
function CcbItemsApi.possible_from_group(group) end
---@param handle GameHandle Exact live item handle.
---@param updates CcbItemUpdateOptions
---@return CcbResult
function CcbItemsApi.update(handle, updates) end
---@param handle GameHandle Exact live item handle.
---@param damage_type? GameId GameId<damage_type>
---@return CcbResult
function CcbItemsApi.melee_damage(handle, damage_type) end
---@param handle GameHandle Exact live item handle.
---@param damage_type? GameId GameId<damage_type>
---@param with_ammo? boolean
---@return CcbResult
function CcbItemsApi.gun_damage(handle, damage_type, with_ammo) end
---@param handle GameHandle Exact live item handle.
---@param quality GameId GameId<quality>
---@param strict? boolean
---@return CcbResult
function CcbItemsApi.quality(handle, quality, strict) end
---@param handle GameHandle Exact live item handle.
---@param target GameId GameId<item>
---@param options? CcbItemTransformOptions
---@return CcbResult result `value` is a CcbItemTransformResult; the old handle is always retired.
function CcbItemsApi.transform(handle, target, options) end
---@param handle GameHandle Exact live item handle.
---@param key string
---@return CcbResult
function CcbItemsApi.get_var(handle, key) end
---@param handle GameHandle Exact live item handle.
---@param key string
---@param value string|number|TripointCoord
---@return CcbResult
function CcbItemsApi.set_var(handle, key, value) end
---@param handle GameHandle Exact live item handle.
---@param key string
---@return CcbResult
function CcbItemsApi.erase_var(handle, key) end
---@param handle GameHandle Exact live item handle.
---@param flag GameId GameId<json_flag>
---@return CcbResult
function CcbItemsApi.has_flag(handle, flag) end
---@param item_handle GameHandle Exact live item handle.
---@param character GameHandle Exact live Character holder; no avatar fallback.
---@param method? string
---@param quantity? integer
---@return CcbResult
function CcbItemsApi.ammo_sufficient(item_handle, character, method, quantity) end
---@param handle GameHandle Exact live item handle.
---@param flag GameId GameId<json_flag>
---@param enabled boolean
---@return CcbResult
function CcbItemsApi.set_flag(handle, flag, enabled) end
---@param item_handle GameHandle Exact live item handle.
---@param character_handle GameHandle Exact live Character holder.
---@param method string
---@param options CcbItemActivationOptions Required explicit target; no current-tile fallback.
---@return CcbResult result `value` is a CcbItemActivationResult.
function CcbItemsApi.activate(item_handle, character_handle, method, options) end
---@param handle GameHandle Exact live item handle.
---@param fault GameId GameId<fault>
---@param options? CcbItemFaultOptions
---@return CcbResult
function CcbItemsApi.set_fault(handle, fault, options) end
---@param handle GameHandle Exact live item handle.
---@param fault_type string
---@param options? CcbItemFaultOptions
---@return CcbResult
function CcbItemsApi.set_random_fault(handle, fault_type, options) end
---@param handle GameHandle Exact live item handle.
---@param technique GameId GameId<martial_art_technique>
---@return CcbResult
function CcbItemsApi.has_technique(handle, technique) end
---@param handle GameHandle Exact live item handle.
---@param technique GameId GameId<martial_art_technique>
---@param enabled boolean
---@return CcbResult
function CcbItemsApi.set_technique(handle, technique, enabled) end
---@param item_handle GameHandle Exact live item handle.
---@param owner GameHandle Exact Character owner.
---@param remember_previous? boolean
---@return CcbResult
function CcbItemsApi.set_owner(item_handle, owner, remember_previous) end
---@param item_handle GameHandle Exact live item handle.
---@param remember_previous? boolean
---@return CcbResult
function CcbItemsApi.clear_owner(item_handle, remember_previous) end
---@param item_handle GameHandle Exact live item handle.
---@return CcbResult
function CcbItemsApi.clear_old_owner(item_handle) end

---@class CcbInventoryApi
local CcbInventoryApi = {}

---@param character GameHandle Exact live Character handle.
---@param candidates GameHandle[] Exact item handles belonging to character.
---@param title? string
---@return CcbResult
function CcbInventoryApi.choose(character, candidates, title) end
---@param character GameHandle Exact live Character handle.
---@param candidates GameHandle[] Exact item handles belonging to character.
---@param title? string
---@return CcbResult
function CcbInventoryApi.choose_many(character, candidates, title) end
---@param character GameHandle Exact live Character handle.
---@param candidates GameHandle[] Exact map item handles.
---@param options? CcbInventoryChoiceOptions
---@return CcbResult
function CcbInventoryApi.choose_map(character, candidates, options) end
---@param character GameHandle Exact live Character handle.
---@param candidates GameHandle[] Exact map item handles.
---@param options? CcbInventoryChoiceOptions
---@return CcbResult
function CcbInventoryApi.choose_many_map(character, candidates, options) end
---@param character GameHandle Exact live Character handle.
---@param item_type GameId GameId<item>
---@param quantity integer
---@return CcbResult
function CcbInventoryApi.resources(character, item_type, quantity) end
---@param character GameHandle Exact live Character handle.
---@param entries table
---@return CcbResult
function CcbInventoryApi.has_items_sum(character, entries) end
---@param character GameHandle Exact live Character handle.
---@param software GameId GameId<item>
---@param minimum_charges? integer
---@param device? GameId GameId<item>
---@return CcbResult
function CcbInventoryApi.has_software(character, software, minimum_charges, device) end
---@param character GameHandle Exact live Character handle.
---@param flag GameId GameId<json_flag>
---@param body_part? GameId GameId<body_part>
---@return CcbResult
function CcbInventoryApi.has_worn_flag(character, flag, body_part) end
---@param character GameHandle Exact live Character handle.
---@param item_type GameId GameId<item>
---@return CcbResult
function CcbInventoryApi.is_wearing(character, item_type) end
---@param character GameHandle Exact live Character handle.
---@param flag GameId GameId<json_flag>
---@return CcbResult
function CcbInventoryApi.has_item_flag(character, flag) end
---@param character GameHandle Exact live Character handle.
---@param category GameId GameId<item_category>
---@return CcbResult
function CcbInventoryApi.category_count(character, category) end
---@param character GameHandle Exact live Character handle.
---@param flag GameId GameId<json_flag>
---@param aggregate? 'first'|'last'|'min'|'max'|'sum'|'average'
---@return CcbResult
function CcbInventoryApi.item_radiation(character, flag, aggregate) end
---@param character GameHandle Exact live Character handle.
---@param criterion GameId
---@return CcbResult
function CcbInventoryApi.wielded_matches(character, criterion) end
---@param holder GameHandle Exact live Character handle.
---@param owner GameHandle Exact live Character handle.
---@return CcbResult
function CcbInventoryApi.has_stolen_from(holder, owner) end
---@param character GameHandle Exact live Character handle.
---@return CcbResult
function CcbInventoryApi.weapon_state(character) end
---@param character GameHandle Exact live Character handle.
---@param item_type GameId GameId<item>
---@param quantity integer
---@param options? CcbInventoryGiveOptions
---@return CcbResult
function CcbInventoryApi.give(character, item_type, quantity, options) end
---@param character GameHandle Exact live Character handle.
---@param group GameId GameId<item_group>
---@param options? CcbInventoryGiveOptions
---@return CcbResult
function CcbInventoryApi.give_group(character, group, options) end
---@param character GameHandle Exact live Character handle.
---@param item_type GameId GameId<item>
---@param count? integer
---@param charges? integer
---@return CcbResult
function CcbInventoryApi.consume(character, item_type, count, charges) end
---@param character GameHandle Exact live Character handle.
---@param recipient GameHandle Exact live Character handle.
---@param item_type GameId GameId<item>
---@param count? integer
---@param charges? integer
---@return CcbResult
function CcbInventoryApi.hand_in(character, recipient, item_type, count, charges) end
---@param character GameHandle Exact live Character handle.
---@param entries table
---@return CcbResult
function CcbInventoryApi.consume_sum(character, entries) end

---@alias CcbEquipmentOperation 'wield'|'wear'|'unequip'

---@alias CcbEquipmentErrorCode
---| 'stale_runtime'
---| 'stale_world'
---| 'stale_identity'
---| 'stale_item'
---| 'stale_holder'
---| 'destroyed'
---| 'dead'
---| 'invalid_item'
---| 'invalid_identity'
---| 'invalid_charges'
---| 'wrong_kind'
---| 'wrong_subtype'
---| 'wrong_holder'
---| 'not_owned'
---| 'not_equipped'
---| 'unsupported_holder'
---| 'already_equipped'
---| 'cannot_wield'
---| 'cannot_wear'
---| 'cannot_unwield'
---| 'cannot_takeoff'
---| 'destination_rejected'
---| 'invalid_equipment'
---| 'source_changed'
---| 'operation_failed'
---| 'rollback_failed'

---@class CcbEquipmentError: CcbPlatformResultError
---@field code CcbEquipmentErrorCode Stable preflight, operation, or rollback rejection.

---@class CcbEquipmentDisplacedItem
---@field source_uid integer Display-only UID of the displaced source Item.
---@field source_handle_stale boolean Always true after a committed displacement.
---@field handle GameHandle New exact handle after displacement into the destination holder.
---@field item table<string, any> Detached bounded snapshot of the displaced Item.

---@class CcbEquipmentValue
---@field accepted true True only after the complete equipment transaction commits.
---@field changed boolean Always true for a committed equipment operation.
---@field operation CcbEquipmentOperation
---@field source_uid integer Display-only UID of the requested source Item.
---@field source_handle_stale boolean Always true after a committed operation.
---@field old_handle_stale boolean Alias for source_handle_stale.
---@field source_holder CcbItemHolder Exact source holder proven during preflight.
---@field destination_holder CcbItemHolder Explicit Character inventory destination.
---@field handle GameHandle New exact handle for the equipped or unequipped Item.
---@field item table<string, any> Detached bounded snapshot of the resulting Item.
---@field displaced CcbEquipmentDisplacedItem[] Dense displaced-item results; empty when no Item was displaced.
---@field displaced_count integer Number of displaced Items returned.

---@class CcbEquipmentResult: CcbResult
---@field value? CcbEquipmentValue Present only after the atomic equipment transaction commits.
---@field error? CcbEquipmentError Present when preflight, operation, or rollback rejects the request.

---@class CcbEquipmentApi
local CcbEquipmentApi = {}

---@param actor GameHandle Exact live avatar, Character, or NPC actor handle; never inferred.
---@param item GameHandle Exact live Item handle; never selected by type or current-item state.
---@param source_holder CcbItemHolder Exact holder containing `item`; Character slot must be inventory, worn, or wielded.
---@param displaced_destination CcbItemHolder Explicit Character inventory holder for displaced Items; capacity is preflighted atomically.
---@return CcbEquipmentResult result `value` is published only after the complete wield transaction commits; `error` preserves source/equipment/destination on rejection.
function CcbEquipmentApi.wield(actor, item, source_holder, displaced_destination) end

---@param actor GameHandle Exact live avatar, Character, or NPC actor handle; never inferred.
---@param item GameHandle Exact live Item handle; never selected by type or current-item state.
---@param source_holder CcbItemHolder Exact holder containing `item`; Character slot must be inventory, worn, or wielded.
---@param displaced_destination CcbItemHolder Explicit Character inventory holder for displaced Items; capacity is preflighted atomically.
---@return CcbEquipmentResult result `value` is published only after the complete wear transaction commits; `error` preserves source/equipment/destination on rejection.
function CcbEquipmentApi.wear(actor, item, source_holder, displaced_destination) end

---@param actor GameHandle Exact live avatar, Character, or NPC actor handle; never inferred.
---@param item GameHandle Exact currently wielded or worn Item handle owned by `actor`.
---@param destination_holder CcbItemHolder Explicit Character inventory holder for the unequipped Item; capacity is preflighted atomically.
---@return CcbEquipmentResult result `value` is published only after the complete unequip transaction commits; `error` preserves equipment/destination on rejection.
function CcbEquipmentApi.unequip(actor, item, destination_holder) end

---@class CcbNpcOpinion
---@field trust integer
---@field fear integer
---@field value integer
---@field anger integer
---@field owed integer
---@field sold integer

---@class CcbNpcSnapshot
---@field handle GameHandle Exact live NPC handle.
---@field id integer Native character identity; display-only.
---@field unique_id string Stable unique NPC identity when present.
---@field name string
---@field display_name string
---@field position TripointCoord
---@field class GameId GameId<npc_class>
---@field template GameId|nil GameId<npc_template> when present.
---@field faction GameId|nil GameId<faction> when present.
---@field attitude GameId
---@field attitude_name string
---@field dead boolean
---@field player_ally boolean
---@field first_topic string
---@field opinion CcbNpcOpinion Stored opinion; no avatar lookup is performed.
---@field ai_rules table<string, any>

---@alias CcbNpcMissionStatus 'available'|'active'|'success'|'failure'

---@class CcbNpcMissionSnapshot
---@field token MissionToken Exact mission-instance token bound to this runtime and world.
---@field uid integer Display-only native mission instance id.
---@field id GameId GameId<mission> definition id.
---@field name string Native mission name.
---@field status CcbNpcMissionStatus Native mission lifecycle status.
---@field assigned boolean True when the mission is assigned to an avatar.
---@field in_progress boolean True while the mission is active.
---@field failed boolean True after native mission failure.
---@field has_generic_rewards boolean Whether the mission has generic NPC rewards.
---@field generic_reward_claimed boolean Whether Platform has committed this generic reward.
---@field follow_up? GameId GameId<mission> follow-up definition, when present.

---@class CcbNpcMissionPage
---@field items CcbNpcMissionSnapshot[] Dense live mission snapshots in native order.
---@field total integer Number of live entries belonging to the provider.
---@field returned integer Number of live entries returned in `items`.
---@field truncated boolean True when the bounded result omitted source entries.

---@class CcbNpcMissionsState
---@field provider_id integer Exact NPC provider id.
---@field available CcbNpcMissionPage Missions currently offered by the provider.
---@field assigned CcbNpcMissionPage Missions assigned through the provider.
---@field selected? CcbNpcMissionSnapshot Provider-selected mission, when live.
---@field selected_stale? boolean True when the provider's selected mission is no longer live.
---@field selected_invalid? boolean True when a live selected mission is not uniquely owned by this provider.

---@class CcbNpcProviderState
---@field id integer Native provider character id.
---@field name string Provider name.
---@field avatar boolean Always false for an NPC provider.
---@field hp integer Current summed main-body-part hit points.
---@field maximum_hp integer Maximum summed main-body-part hit points.
---@field bionics integer Number of bionics.
---@field mutations integer Number of mutations.
---@field mounted boolean Whether the provider is mounted.
---@field bleeding boolean Whether the provider has the bleeding effect.
---@field bitten boolean Whether the provider has the bite effect.
---@field infected boolean Whether the provider has the infected effect.
---@field inventory_stacks integer Number of inventory stacks.
---@field activity? GameId GameId<activity> for the current activity, when present.
---@field owed integer Provider debt/reward balance owed to the avatar.
---@field attitude integer Native NPC attitude enum value.
---@field busy_turns integer Remaining `currently_busy` duration in turns.
---@field current_activity string Native current-activity description.

---@class CcbNpcMissionsStateResult
---@field before CcbNpcMissionsState State before selecting a mission.
---@field after CcbNpcMissionsState State after selecting a mission.

---@class CcbNpcMissionOfferResult
---@field mission CcbNpcMissionSnapshot Newly offered mission.
---@field before CcbNpcMissionsState State before offering the mission.
---@field after CcbNpcMissionsState State after offering the mission.

---@class CcbNpcMissionAssignmentResult
---@field mission CcbNpcMissionSnapshot Newly assigned mission.
---@field owner GameHandle Exact avatar owner used for assignment.
---@field before CcbNpcMissionsState State before assignment.
---@field after CcbNpcMissionsState State after assignment.

---@class CcbNpcMissionActionResult
---@field action 'assign'|'success'|'failure'|'clear'|'reward' Native action performed.
---@field owner GameHandle Exact avatar owner used for the action.
---@field forced boolean True only for an explicit incomplete-goal success override.
---@field owed_delta integer Change to the provider's owed balance.
---@field before CcbNpcMissionsState Provider mission state before the action.
---@field after CcbNpcMissionsState Provider mission state after the action.
---@field provider_before CcbNpcProviderState Provider state before the action.
---@field provider_after CcbNpcProviderState Provider state after the action.

---@class CcbNpcMissionsApi
local CcbNpcMissionsApi = {}
---@param provider GameHandle Exact live NPC provider handle; no ambient provider is selected.
---@return CcbResult result `value` is a CcbNpcMissionsState.
function CcbNpcMissionsApi.state(provider) end
---@param provider GameHandle Exact live NPC provider handle.
---@param token MissionToken Exact mission-instance token offered or assigned by this provider.
---@return CcbResult result `value` is a CcbNpcMissionsStateResult.
function CcbNpcMissionsApi.select(provider, token) end
---@param provider GameHandle Exact live NPC provider handle.
---@param mission GameId GameId<mission> definition to reserve and offer.
---@return CcbResult result `value` is a CcbNpcMissionOfferResult.
function CcbNpcMissionsApi.offer(provider, mission) end
---@param provider GameHandle Exact live NPC provider handle.
---@param owner GameHandle Exact avatar owner handle; no ambient avatar is selected.
---@param mission GameId GameId<mission> definition to reserve and assign.
---@return CcbResult result `value` is a CcbNpcMissionAssignmentResult.
function CcbNpcMissionsApi.add_assigned(provider, owner, mission) end
---@param provider GameHandle Exact live NPC provider handle.
---@param owner GameHandle Exact avatar owner handle; no ambient avatar is selected.
---@return CcbResult result `value` is a CcbNpcMissionActionResult.
function CcbNpcMissionsApi.assign_selected(provider, owner) end
---@param provider GameHandle Exact live NPC provider handle.
---@param owner GameHandle Exact avatar owner handle; no ambient avatar is selected.
---@param force? boolean Explicit incomplete-goal success override.
---@return CcbResult result `value` is a CcbNpcMissionActionResult.
function CcbNpcMissionsApi.succeed_selected(provider, owner, force) end
---@param provider GameHandle Exact live NPC provider handle.
---@param owner GameHandle Exact avatar owner handle; no ambient avatar is selected.
---@return CcbResult result `value` is a CcbNpcMissionActionResult.
function CcbNpcMissionsApi.fail_selected(provider, owner) end
---@param provider GameHandle Exact live NPC provider handle.
---@param owner GameHandle Exact avatar owner handle; no ambient avatar is selected.
---@return CcbResult result `value` is a CcbNpcMissionActionResult.
function CcbNpcMissionsApi.clear_selected(provider, owner) end
---@param provider GameHandle Exact live NPC provider handle.
---@param owner GameHandle Exact avatar owner handle; no ambient avatar is selected.
---@return CcbResult result `value` is a CcbNpcMissionActionResult; `error.code` is `no_generic_reward`, `already_claimed`, `not_successful`, or `reward_overflow` when claim preflight rejects.
function CcbNpcMissionsApi.claim_selected_reward(provider, owner) end

---@class CcbNpcMedicalApi
local CcbNpcMedicalApi = {}
---@param provider GameHandle Exact NPC provider handle.
---@param patient GameHandle Exact avatar handle; required, no avatar fallback.
---@param level? 'basic'|'advanced'
---@param include_allies? boolean
---@return CcbResult
function CcbNpcMedicalApi.provide_aid(provider, patient, level, include_allies) end
---@param provider GameHandle Exact NPC provider handle.
---@param operation 'install'|'remove'
---@param patient GameHandle Exact Character handle; required, with no implicit avatar fallback.
---@return CcbResult
function CcbNpcMedicalApi.open_bionic_service(provider, operation, patient) end
---@param provider GameHandle Exact NPC provider handle.
---@param patient GameHandle Exact avatar handle; required, no fallback.
---@return CcbResult
function CcbNpcMedicalApi.repair_bionic_limbs(provider, patient) end

---@class CcbNpcGroomingApi
local CcbNpcGroomingApi = {}
---@param provider GameHandle Exact NPC provider handle.
---@param client GameHandle Exact avatar handle; required, no fallback.
---@param area 'hair'|'beard'
---@return CcbResult
function CcbNpcGroomingApi.open_style(provider, client, area) end
---@param provider GameHandle Exact NPC provider handle.
---@param client GameHandle Exact avatar handle; required, no fallback.
---@param service 'haircut'|'shave'
---@return CcbResult
function CcbNpcGroomingApi.provide(provider, client, service) end

---@class CcbNpcTrainingApi
local CcbNpcTrainingApi = {}
---@param teacher GameHandle Exact Character/NPC teacher handle.
---@param student GameHandle Exact Character student handle.
---@return CcbResult
function CcbNpcTrainingApi.offerings(teacher, student) end
---@param teacher GameHandle Exact Character/NPC teacher handle.
---@param students GameHandle[] Exact student handles.
---@param subject GameId GameId<skill|proficiency|martial_art|spell>
---@return CcbResult
function CcbNpcTrainingApi.start(teacher, students, subject) end
---@param provider GameHandle Exact NPC provider handle.
---@param student GameHandle Exact avatar handle for player training.
---@param mode 'player'
---@return CcbResult
function CcbNpcTrainingApi.start_selected(provider, student, mode) end

---@class CcbNpcDialogueActionsApi
local CcbNpcDialogueActionsApi = {}
---@param handle GameHandle Exact NPC handle.
---@return CcbResult
function CcbNpcDialogueActionsApi.finish(handle) end
---@param handle GameHandle Exact NPC handle.
---@return CcbResult
function CcbNpcDialogueActionsApi.provoke_combat(handle) end

---@alias CcbNpcDialogueStatus 'not_started'|'rejected'|'completed'

---@class CcbNpcDialogueResult
---@field status CcbNpcDialogueStatus Native synchronous start/completion outcome.
---@field started boolean True only when the native dialogue UI started.
---@field completed boolean True only after a started dialogue synchronously ended.

---@class CcbNpcsApi
local CcbNpcsApi = {}
---@param options? CcbNpcQueryOptions
---@return CcbResult result `value` is a bounded NPC-class page.
function CcbNpcsApi.classes(options) end
---@param id GameId GameId<npc_class>
---@return CcbResult
function CcbNpcsApi.class(id) end
---@param options? CcbNpcQueryOptions
---@return CcbResult result `value` is a bounded list of exact NPC snapshots.
function CcbNpcsApi.list(options) end
---@param handle GameHandle Exact live NPC handle.
---@return CcbResult result `value` is a detached CcbNpcSnapshot.
function CcbNpcsApi.get(handle) end
---@param unique_id string Explicit stable unique NPC id; no nearby/first lookup.
---@return CcbResult result `value` is a detached CcbNpcSnapshot.
function CcbNpcsApi.find_unique(unique_id) end
---@param global? boolean
---@return integer
function CcbNpcsApi.count_allies(global) end
---@param origin GameHandle Exact observer/Character/Creature handle.
---@param role string
---@param radius? integer
---@return CcbResult
function CcbNpcsApi.has_role_nearby(origin, role, radius) end
---@param origin GameHandle Exact observer/Character/Creature handle.
---@param class GameId GameId<npc_class>
---@param radius? integer
---@return CcbResult
function CcbNpcsApi.has_follower_nearby(origin, class, radius) end
---@param handle GameHandle Exact NPC handle.
---@param name string
---@return CcbResult
function CcbNpcsApi.rename(handle, name) end
---@param handle GameHandle Exact NPC handle.
---@param attitude string
---@return CcbResult
function CcbNpcsApi.set_attitude(handle, attitude) end
---@param handle GameHandle Exact NPC handle.
---@param deltas CcbNpcOpinion
---@return CcbResult
function CcbNpcsApi.modify_opinion(handle, deltas) end
---@param handle GameHandle Exact NPC handle.
---@param amount integer
---@return CcbResult
function CcbNpcsApi.add_debt(handle, amount) end
---@param handle GameHandle Exact NPC handle.
---@param amount integer
---@return CcbResult
function CcbNpcsApi.add_faction_rep(handle, amount) end
---@param handle GameHandle Exact NPC handle.
---@param class GameId GameId<npc_class>
---@return CcbResult
function CcbNpcsApi.set_class(handle, class) end
---@param handle GameHandle Exact NPC handle.
---@param faction GameId GameId<faction>
---@return CcbResult
function CcbNpcsApi.set_faction(handle, faction) end
---@param handle GameHandle Exact NPC handle.
---@param topic string Explicit topic id.
---@return CcbResult
function CcbNpcsApi.set_first_topic(handle, topic) end
---@param handle GameHandle Exact NPC handle.
---@param avatar GameHandle Exact avatar owner handle; required, no global-player fallback.
---@param enabled boolean
---@return CcbResult
function CcbNpcsApi.set_radio_representative(handle, avatar, enabled) end
---@return table
function CcbNpcsApi.ai_rule_catalog() end
---@param handle GameHandle Exact NPC handle.
---@param family string
---@param rule string
---@return CcbResult
function CcbNpcsApi.set_ai_policy(handle, family, rule) end
---@param handle GameHandle Exact NPC handle.
---@param rule string
---@param enabled? boolean
---@return CcbResult
function CcbNpcsApi.set_ally_rule(handle, rule, enabled) end
---@param handle GameHandle Exact NPC handle.
---@param rule string
---@param state 'inherit'|'allow'|'deny'
---@return CcbResult
function CcbNpcsApi.set_ally_override(handle, rule, state) end
---@param target GameHandle Exact target NPC handle.
---@param source GameHandle Exact source NPC handle.
---@return CcbResult
function CcbNpcsApi.copy_ai_rules(target, source) end
---@param handle GameHandle Exact NPC handle.
---@return CcbResult
function CcbNpcsApi.make_thankful(handle) end
---@param handle GameHandle Exact NPC handle.
---@param request string
---@return CcbResult
function CcbNpcsApi.record_refusal(handle, request) end
---@param handle GameHandle Exact NPC handle.
---@return CcbResult
function CcbNpcsApi.follow_temporarily(handle) end
function CcbNpcsApi.stop_temporary_following(handle) end
function CcbNpcsApi.make_neutral(handle) end
function CcbNpcsApi.start_fleeing(handle) end
function CcbNpcsApi.start_mugging(handle) end
---@param handle GameHandle Exact NPC handle.
---@param avatar GameHandle Exact avatar owner handle; required, no global-player fallback.
function CcbNpcsApi.join_player(handle, avatar) end
---@param handle GameHandle Exact NPC handle.
---@param avatar GameHandle Exact avatar owner handle; required, no global-player fallback.
function CcbNpcsApi.leave_player(handle, avatar) end
---@param handle GameHandle Exact NPC handle.
---@param enabled boolean
function CcbNpcsApi.set_guarding(handle, enabled) end
function CcbNpcsApi.become_hostile(handle) end
function CcbNpcsApi.warn_player_departure(handle) end
function CcbNpcsApi.clear_stolen_item_claim(handle) end
---@param handle GameHandle Exact NPC handle.
function CcbNpcsApi.destinations(handle) end
---@param handle GameHandle Exact NPC handle.
---@param goal TripointCoord
function CcbNpcsApi.plan_travel(handle, goal) end
function CcbNpcsApi.set_goal(handle, goal) end
function CcbNpcsApi.lead_to(handle, goal) end
function CcbNpcsApi.set_guard_position(handle, position) end
function CcbNpcsApi.companion_state(handle) end
function CcbNpcsApi.set_companion_role(handle, role) end
function CcbNpcsApi.open_companion_missions(handle, role) end
---@param recipient GameHandle Exact NPC recipient handle.
---@param giver GameHandle Exact Character giver handle; no avatar fallback.
---@param item GameHandle Exact item owned by giver.
---@param use_item? boolean
function CcbNpcsApi.offer_item(recipient, giver, item, use_item) end
---@param npc GameHandle Exact NPC interlocutor; no nearby/current fallback.
---@param speaker GameHandle Exact avatar speaker; no global-avatar fallback.
---@param topic string Required registered topic id; never inferred from either participant.
---@return CcbResult result `value` is a detached CcbNpcDialogueResult after synchronous UI teardown; it never carries a persistent or live dialogue session token.
function CcbNpcsApi.open_dialogue(npc, speaker, topic) end
function CcbNpcsApi.open_rules(handle) end
---@param avatar GameHandle Exact avatar handle; required.
function CcbNpcsApi.open_control_menu(avatar) end
---@param handle GameHandle Exact allied NPC handle.
---@param avatar GameHandle Exact avatar owner handle; required, no global-player fallback.
function CcbNpcsApi.take_control(handle, avatar) end
---@param handle GameHandle Exact NPC handle.
---@return CcbResult
function CcbNpcsApi.ai_rules(handle) end
---@field medical CcbNpcMedicalApi
---@field grooming CcbNpcGroomingApi
---@field training CcbNpcTrainingApi
---@field missions CcbNpcMissionsApi
---@field dialogue CcbNpcDialogueActionsApi

---@class TradeQuoteToken
---@field quote_id integer Opaque runtime-owned quote identity; never serialized or constructed by Lua.
---@field runtime_generation integer Runtime owner generation captured at issuance.
---@field world_generation integer World generation captured at issuance.
---@field seller_stable_id integer Exact seller Character/NPC stable identity.
---@field buyer_stable_id integer Exact buyer Character/NPC stable identity.
---@field seller_identity_generation integer Exact seller identity generation.
---@field buyer_identity_generation integer Exact buyer identity generation.
---@field holder_mutation_generation integer Global authoritative Item-holder mutation epoch; any Item mutation invalidates all quotes.
---@field pricing_generation integer Detached authoritative pricing-input generation.
---@field faction_generation integer Detached faction pricing-input generation.
---@field debt_generation integer Detached NPC debt-input generation.
---@field opinion_generation integer Detached NPC opinion-input generation.
---@field issued_turn integer Turn at which the quote was issued.
---@field expires_turn integer Exclusive expiry turn; the quote is stale at or after this turn.
---@field registered boolean True only while the token is in the active runtime registry.
---@field is_valid fun(self: TradeQuoteToken): boolean False after any runtime, world, participant, Item, holder, pricing, settlement, expiry, save, or shutdown invalidation.

---@alias CcbTradeQuoteSettlementStrategy 'cash'|'npc_debt'

---@class CcbTradeQuoteSettlement
---@field strategy CcbTradeQuoteSettlementStrategy Explicit quote settlement preflight strategy.
---@field currency 'cash' Explicit supported currency; quote rejects other currencies.

---@alias CcbTradeCommitSettlementStrategy 'npc_debt'

---@class CcbTradeNpcDebtSettlement
---@field strategy 'npc_debt' The only currently publishable commit settlement.
---@field currency 'cash' Explicit cash-denominated NPC debt account.

---Commit settlement is an intentionally one-member union.  A cash publish
---settlement is not exposed until its atomic currency path is source-complete.
---@alias CcbTradeSettlement CcbTradeNpcDebtSettlement

---@class CcbTradeQuoteHolder
---@field kind 'character' Exact Character holder kind; no map/container/vehicle or implicit selection.
---@field character GameHandle Exact Character/NPC holder handle.
---@field slot 'inventory'|'worn'|'wielded' Explicit Character slot.

---@class CcbTradeQuoteHolderSnapshot: CcbTradeQuoteHolder
---@field locator table<string, any> Detached canonical holder locator captured at quote time.
---@field mutation_generation integer Global holder epoch captured at quote time.

---@class CcbTradeQuoteLineInput
---@field direction 'seller_to_buyer'|'buyer_to_seller' Explicit transfer direction.
---@field item GameHandle Exact generation-safe Item handle.
---@field quantity integer Exact whole-item quantity or charge quantity; charge Items must use 1..current charges and non-charge Items must use 1.
---@field source_holder CcbTradeQuoteHolder Exact source holder matching direction.
---@field destination_holder CcbTradeQuoteHolder Exact destination holder matching direction.

---@class CcbTradeQuoteOptions
---@field settlement CcbTradeQuoteSettlement Explicit settlement options with `strategy` and `currency`; no implicit participant or player-cash default.
---@field expiry_turns? integer Positive bounded quote lifetime in turns.

---@class CcbTradeQuoteLineSnapshot
---@field direction 'seller_to_buyer'|'buyer_to_seller'
---@field item GameHandle Exact quoted Item handle.
---@field item_uid integer Exact Item UID captured at quote time.
---@field item_identity_generation integer Exact Item identity generation captured at quote time.
---@field quantity integer Exact requested quantity captured at quote time.
---@field charges_at_quote integer Exact complete charge count captured at quote time.
---@field source_holder CcbTradeQuoteHolderSnapshot Canonical source holder locator and generation snapshot.
---@field destination_holder CcbTradeQuoteHolderSnapshot Canonical destination holder locator and generation snapshot.
---@field source_holder_mutation_generation integer Global holder mutation epoch at quote time.
---@field destination_holder_mutation_generation integer Global holder mutation epoch at quote time.
---@field unit_price integer Authoritative detached per-unit price.
---@field total integer Authoritative detached line total.
---@field tax integer Detached line tax; currently zero when the native rule has no tax.
---@field accepted boolean True for a line in a successful detached quote.
---@field rejection_reason? string Present only when a line is rejected.

---@class CcbTradeQuoteSnapshot
---@field token TradeQuoteToken Runtime-owned nonpersistent QuoteToken.
---@field seller GameHandle Exact seller Character/NPC handle.
---@field buyer GameHandle Exact buyer Character/NPC handle.
---@field seller_stable_id integer
---@field buyer_stable_id integer
---@field seller_identity_generation integer
---@field buyer_identity_generation integer
---@field holder_mutation_generation integer Any Item mutation invalidates this quote and all other quotes.
---@field pricing_generation integer
---@field faction_generation integer
---@field debt_generation integer
---@field opinion_generation integer
---@field settlement_strategy CcbTradeQuoteSettlementStrategy Explicit selected settlement strategy.
---@field currency 'cash' Explicit supported currency; unsupported currencies are rejected.
---@field seller_to_buyer_total integer Total authoritative value moving from seller to buyer.
---@field buyer_to_seller_total integer Total authoritative value moving from buyer to seller.
---@field net integer Net settlement amount before the selected strategy is applied.
---@field tax integer Detached aggregate tax.
---@field settlement_amount integer Detached selected-strategy settlement amount.
---@field debt_before integer|nil Detached NPC debt before settlement.
---@field debt_after integer|nil Detached NPC debt after settlement.
---@field sold_before integer|nil Detached NPC sold/opinion value before settlement.
---@field sold_after integer|nil Detached NPC sold/opinion value after settlement.
---@field buyer_cash_before integer
---@field seller_cash_before integer
---@field free_exchange boolean Whether the authoritative NPC rules permit free exchange.
---@field issued_turn integer
---@field expires_turn integer
---@field available_settlement_modes string[] Modes explicitly accepted by the authoritative rules.
---@field lines CcbTradeQuoteLineSnapshot[] Detached line snapshots.
---@field rejection_reasons string[] Empty for a successful quote; rejected requests return CcbResult.error instead.

---@alias CcbTradeCommitStaleErrorCode
---| 'stale_quote'
---| 'stale_runtime'
---| 'stale_world'
---| 'expired_quote'
---| 'stale_holder'
---| 'stale_participant'
---| 'stale_identity'
---| 'stale_item'
---| 'wrong_holder'
---| 'wrong_subtype'
---| 'destroyed_creature'
---| 'dead_creature'
---| 'pricing_changed'
---| 'price_changed'
---| 'faction_changed'
---| 'debt_changed'
---| 'opinion_changed'

---@alias CcbTradeCommitRollbackErrorCode 'source_changed'|'rollback_failed'

---@alias CcbTradeCommitErrorCode
---| CcbTradeCommitStaleErrorCode
---| CcbTradeCommitRollbackErrorCode
---| 'invalid_quote'
---| 'consumed_quote'
---| 'unsupported_settlement'
---| 'unsupported_currency'
---| 'settlement_changed'
---| 'unsupported_participants'
---| 'unsupported_holder'
---| 'unsupported_item'
---| 'invalid_transaction'
---| 'invalid_quantity'
---| 'invalid_identity'
---| 'overlapping_holder'
---| 'destination_capacity'
---| 'destination_rejected'
---| 'credit_limit'
---| 'numeric_overflow'
---| 'settlement_publish_failed'

---@class CcbTradeCommitError: CcbPlatformResultError
---@field code CcbTradeCommitErrorCode Stable commit rejection, stale, or rollback code.

---@class CcbTradeCommitLineResult
---@field direction 'seller_to_buyer'|'buyer_to_seller'
---@field item_uid integer Source Item UID captured by the quote.
---@field transferred_item_uid integer Destination Item UID after full or partial extraction.
---@field quantity integer Exact quantity transferred.
---@field total integer Detached authoritative quoted line total.

---@class CcbTradeCommitValue
---@field committed true True only after every Item and settlement publication succeeds.
---@field consumed true The QuoteToken is permanently single-use after success.
---@field quote_id integer Committed quote identity.
---@field commit_generation integer Monotonic generation after consuming the token.
---@field settlement_strategy CcbTradeCommitSettlementStrategy
---@field currency 'cash'
---@field settlement_amount integer Authoritative net amount applied to the NPC debt account.
---@field debt_before integer NPC debt before publication.
---@field debt_after integer NPC debt after publication.
---@field sold_before integer NPC sold/opinion value before publication.
---@field sold_after integer NPC sold/opinion value after publication.
---@field buyer_cash_before integer Detached buyer cash snapshot.
---@field seller_cash_before integer Detached seller cash snapshot.
---@field buyer_cash_after integer Detached buyer cash after the selected settlement plan.
---@field seller_cash_after integer Detached seller cash after the selected settlement plan.
---@field lines CcbTradeCommitLineResult[] Detached per-line transfer results.

---@class CcbTradeCommitResult: CcbResult
---@field value? CcbTradeCommitValue Present only after atomic Item transfer and npc_debt publication.
---@field error? CcbTradeCommitError Present for invalid, consumed, stale, rejected, or rollback-failed commits.

---@class CcbTradeApi
local CcbTradeApi = {}

---Open the native barter window. Both handles are explicit; only the active avatar is supported as buyer. Runtime write phase only. Does not replace exact-Item quote/commit.
---@param seller GameHandle Exact NPC handle.
---@param buyer GameHandle Exact active avatar handle.
---@param cost integer Nonnegative service cost added to the barter balance.
---@param title string Deal title, at most 4096 bytes and no NUL.
---@return CcbResult result `value` is true when accepted, false when cancelled.
function CcbTradeApi.open(seller, buyer, cost, title) end

---Pay the NPC using their existing credit ledger or the native barter window. No implicit buyer. Runtime write phase only.
---@param seller GameHandle Exact NPC handle.
---@param buyer GameHandle Exact active avatar handle.
---@param cost integer Nonnegative service cost in cents.
---@return CcbResult result `value` is true when paid, false when cancelled.
function CcbTradeApi.pay(seller, buyer, cost) end

---Read-only native price for a made-to-order item prototype, not an inventory reservation. Includes the native NPC pricing rules. Call again immediately before payment; delivery remains explicit Lua inventory logic.
---@param seller GameHandle Exact NPC handle.
---@param buyer GameHandle Exact different Character handle.
---@param item_type GameId Valid GameId<item>.
---@param count integer Quantity, 1..1000000 (charges for charge-counted items).
---@return CcbResult result `value` is { item: GameId, item_name: string, count: integer, cost_cents: integer, count_by_charges: boolean }. Invalid/nonpositive/overflow prices fail closed.
function CcbTradeApi.order_price(seller, buyer, item_type, count) end

---@param seller GameHandle Exact seller Character/NPC handle; never inferred from avatar/current trader.
---@param buyer GameHandle Exact buyer Character/NPC handle; never inferred from avatar/current trader.
---@param lines CcbTradeQuoteLineInput[] Dense explicit direction, Item, quantity, source-holder, and destination-holder lines.
---@param options CcbTradeQuoteOptions Required explicit settlement strategy and currency.
---@return CcbResult result `value` is a detached CcbTradeQuoteSnapshot; quote performs no Item, currency, debt, or opinion mutation.
function CcbTradeApi.quote(seller, buyer, lines, options) end

---@param token TradeQuoteToken Runtime-owned nonpersistent quote token.
---@return CcbResult result `value` is the still-valid detached CcbTradeQuoteSnapshot; stale tokens fail closed.
function CcbTradeApi.get(token) end

---@param token TradeQuoteToken Runtime-owned nonpersistent quote token.
---@param settlement CcbTradeSettlement Explicit currently supported `npc_debt` settlement; no implicit avatar/current trader is used.
---@return CcbTradeCommitResult result `value` is published only after atomic two-way Item transfer and NPC debt settlement; `error.code` reports consumed/stale/rejection/rollback failures.
function CcbTradeApi.commit(token, settlement) end

---@class CcbPlatformInventoryApi: CcbInventoryApi
local CcbPlatformInventoryApi = {}

---Return the Character's singular physical wielded item without scanning a page.
---A force-unarmed martial-art style does not hide a physically wielded item;
---compose that policy separately through `martial_arts.current`.
---@param character GameHandle Character handle.
---@return CcbResult result `value` is a live item GameHandle or nil when no item is wielded.
function CcbPlatformInventoryApi.wielded(character) end

---Test whether the Character wears an item whose exact `itype_id` equals the
---requested item id.  Only `outfit::worn` membership is matched: the wielded
---item, json flags, categories, charges, and contained items are never
---considered, and an unknown or empty item id yields false instead of an error.
---@param character GameHandle Character handle.
---@param item GameId GameId<item>
---@return CcbResult result `value` is true only when a worn item has the exact requested type id.
function CcbPlatformInventoryApi.is_wearing(character, item) end

---@class CcbPlatformAchievementsApi: CcbAchievementsApi
local CcbPlatformAchievementsApi = {}

---Complete any currently tracked pending achievement, matching native gameplay awards.
---@param id GameId GameId<achievement>
---@return CcbResult result `value` is true only when this call changed the completion state.
function CcbPlatformAchievementsApi.complete(id) end

---@class CcbPlatformActivitySnapshot
---@field active boolean
---@field id? GameId GameId<activity>; nil when no activity is active.
---@field verb string Player-facing progressive verb, or an empty string when inactive.
---@field moves_total integer Native total move budget.
---@field moves_left integer Native remaining move budget.
---@field interruptible boolean
---@field interruptible_with_keyboard boolean
---@field auto_resume boolean
---@field rooted boolean
---@field resumable boolean
---@field progress number Clamped progress from zero through one when the move budget permits it.

---@class CcbPlatformActivityMutation
---@field changed boolean
---@field activity CcbPlatformActivitySnapshot Resulting current activity.

---@class CcbPlatformActivitiesApi
local CcbPlatformActivitiesApi = {}

---Read a detached snapshot of one Character's current native activity.
---@param character GameHandle Character handle.
---@return CcbResult result `value` is a CcbPlatformActivitySnapshot.
function CcbPlatformActivitiesApi.snapshot(character) end

---Assign a plain time-based activity through native Character assignment rules.
---Native actors/handlers, EOC policies, multi-activity workflows, automatic-needs
---activities, and speed/neither budgets require dedicated Lua-native services.
---@param character GameHandle Character handle.
---@param id GameId GameId<activity>
---@param duration TimeDuration Positive duration whose move budget fits the native integer range.
---@return CcbResult result `value` is a CcbPlatformActivityMutation.
function CcbPlatformActivitiesApi.assign_timed(character, id, duration) end

---Cancel the current activity through native cleanup, backlog, and resumption rules.
---@param character GameHandle Character handle.
---@return CcbResult result `value` is a CcbPlatformActivityMutation.
function CcbPlatformActivitiesApi.cancel(character) end

---@class CcbPlatformWoundSnapshot
---@field id GameId GameId<wound>
---@field base_pain integer Pain rolled when this wound instance was created.
---@field current_pain integer Current pain after native healing attenuation.
---@field healing_time TimeDuration Total native healing duration.
---@field healing_progress TimeDuration Accumulated native healing progress.
---@field healing_fraction number Native healing fraction from zero through one.

---@class CcbPlatformWoundMutation
---@field changed boolean Whether the exact body-part wound sequence changed.
---@field before CcbPlatformWoundSnapshot[] Detached native-order snapshot before mutation.
---@field after CcbPlatformWoundSnapshot[] Detached native-order snapshot after mutation.

---@class CcbPlatformWoundsApi
local CcbPlatformWoundsApi = {}

---Read one Character's wounds on an exact current-anatomy body part.
---No nearest-part or other body-part fallback is performed.
---Wrong GameId kinds or unknown ids raise invalid_argument; handle, target,
---and missing-part failures use the returned CcbResult error.
---@param character GameHandle Character handle.
---@param body_part GameId GameId<body_part>
---@return CcbResult result `value` is a dense native-order CcbPlatformWoundSnapshot array.
function CcbPlatformWoundsApi.snapshot(character, body_part) end

---Add or worsen one typed wound on an exact body part; runtime-callback write only.
---The Wound per-part limit is authoritative; reaching it returns `changed = false`.
---The explicit body part is authoritative: direct add bypasses the Wound's natural
---damage-selection body-part eligibility.  A changed add immediately resynchronizes
---the Character's perceived-pain derived state.
---Wrong GameId kinds or unknown ids raise invalid_argument before mutation.
---@param character GameHandle Character handle.
---@param body_part GameId GameId<body_part>
---@param wound GameId GameId<wound>
---@return CcbResult result `value` is a CcbPlatformWoundMutation with detached native-order before/after arrays.
function CcbPlatformWoundsApi.add(character, body_part, wound) end

---Remove every instance of one wound type from an exact body part; runtime-callback write only.
---A changed removal immediately resynchronizes the Character's perceived-pain derived state.
---Wrong GameId kinds or unknown ids raise invalid_argument before mutation.
---@param character GameHandle Character handle.
---@param body_part GameId GameId<body_part>
---@param wound GameId GameId<wound>
---@return CcbResult result `value` has detached native-order before/after arrays; absent instances produce `changed = false`.
function CcbPlatformWoundsApi.remove(character, body_part, wound) end

---@class CcbPlatformBionicsApi: CcbBionicsApi
local CcbPlatformBionicsApi = {}

---@class CcbPlatformBionicSummary
---@field installed_count integer Number of installed bionic instances; power-storage capacity may exist without an instance.
---@field power UnitValue Current bionic energy.
---@field maximum_power UnitValue Maximum bionic energy.
---@field has_capacity boolean Whether maximum bionic energy is greater than zero.

---Read composable installed-count and power-capacity facts without a paginated instance scan.
---@param character GameHandle Character handle.
---@return CcbResult result `value` is a CcbPlatformBionicSummary.
function CcbPlatformBionicsApi.summary(character) end

---Grant a bionic through native gameplay rules without an inspection-list limit.
---@param character GameHandle Character handle.
---@param id GameId GameId<bionic>
---@return CcbResult result `value.changed` reports whether the character gained instances.
function CcbPlatformBionicsApi.grant(character, id) end

---Remove the first matching bionic instance through native gameplay rules.
---@param character GameHandle Character handle.
---@param id GameId GameId<bionic>
---@return CcbResult result `value.changed` reports whether an instance was removed.
function CcbPlatformBionicsApi.remove_type(character, id) end

---@class CcbRecipeQueryOptions
---@field offset? integer Non-negative bounded page offset.
---@field limit? integer Positive bounded page size.
---@field batch? integer Positive native crafting batch.
---@field include_obsolete? boolean
---@field known? boolean
---@field craftable? boolean
---@field skill? GameId GameId<skill>
---@field result? GameId GameId<item>
---@field flag? string

---@class CcbRecipePage
---@field items table
---@field total integer
---@field offset integer
---@field limit integer
---@field returned integer
---@field has_more boolean
---@field batch integer

---@class CcbRequirementQueryOptions
---@field offset? integer Non-negative bounded page offset.
---@field limit? integer Positive bounded page size.
---@field batch? integer Positive native crafting batch.

---@class CcbRecipesApi
local CcbRecipesApi = {}

---@class CcbRequirementsApi
local CcbRequirementsApi = {}

---@class CcbPlatformRecipesApi: CcbRecipesApi
local CcbPlatformRecipesApi = {}

---All recipe availability queries require an exact Character handle; no avatar fallback.
---@param character GameHandle Exact live Character used for inventory/skill availability.
---@param options? CcbRecipeQueryOptions
---@return CcbResult result `value` is a CcbRecipePage.
function CcbPlatformRecipesApi.list(character, options) end
---@param character GameHandle Exact live Character used for inventory/skill availability.
---@param options? CcbRecipeQueryOptions
---@return CcbResult result `value` is a CcbRecipePage.
function CcbPlatformRecipesApi.all(character, options) end
---@param skill GameId GameId<skill>
---@param character GameHandle Exact live Character used for availability.
---@param options? CcbRecipeQueryOptions
---@return CcbResult result `value` is a CcbRecipePage.
function CcbPlatformRecipesApi.by_skill(skill, character, options) end
---@param flag string Bounded native recipe flag.
---@param character GameHandle Exact live Character used for availability.
---@param options? CcbRecipeQueryOptions
---@return CcbResult result `value` is a CcbRecipePage.
function CcbPlatformRecipesApi.by_flag(flag, character, options) end
---@param character GameHandle Exact live Character used for availability.
---@param id GameId GameId<recipe>
---@param batch? integer
---@return CcbResult result `value` is a detached recipe snapshot.
function CcbPlatformRecipesApi.get(character, id, batch) end
---@param id GameId GameId<recipe>
---@param flag string
---@return boolean
function CcbPlatformRecipesApi.has_flag(id, flag) end

---@param character GameHandle Exact live Character used for inventory/skill availability.
---@param options? CcbRequirementQueryOptions
---@return CcbResult result `value` is a bounded requirement page.
function CcbRequirementsApi.list(character, options) end
---@param character GameHandle Exact live Character used for inventory/skill availability.
---@param id string
---@param batch? integer
---@return CcbResult result `value` is a detached requirement snapshot or nil.
function CcbRequirementsApi.get(character, id, batch) end
---@param character GameHandle Exact live Character used for inventory/skill availability.
---@param id GameId GameId<recipe>
---@param batch? integer
---@return CcbResult result `value` is a detached requirement snapshot.
function CcbRequirementsApi.for_recipe(character, id, batch) end

---Query learned knowledge rather than temporary book/helper availability.
---@param character GameHandle Character handle.
---@param id GameId GameId<recipe>
---@return CcbResult result `value` is true only when the Character knows this recipe.
function CcbPlatformRecipesApi.knows(character, id) end

---Teach a recipe through native character rules, including `never_learn` policy.
---@param character GameHandle Character handle.
---@param id GameId GameId<recipe>
---@return CcbResult result `value.changed` reports whether learned state changed; `value.known` is the resulting state.
function CcbPlatformRecipesApi.learn(character, id) end

---Forget one learned recipe through native character rules.
---@param character GameHandle Character handle.
---@param id GameId GameId<recipe>
---@return CcbResult result `value.changed` reports whether learned state changed; `value.known` is the resulting state.
function CcbPlatformRecipesApi.forget(character, id) end

---@class CcbPlatformRecipeCategoryForget
---@field changed boolean Whether at least one learned recipe was forgotten.
---@field forgotten_count integer Number of learned recipes removed.
---@field known_before integer Learned-recipe count before removal.
---@field known_after integer Learned-recipe count after removal.
---@field category GameId GameId<crafting_category> used for selection.
---@field subcategory? string Optional native subcategory selector.

---Forget every learned recipe in one category, optionally narrowed to a subcategory.
---This does not enumerate or mutate recipes available only from books, helpers, or other temporary sources.
---Native CSC_ALL/FAVORITE/RECENT/HIDDEN selectors retain their engine selection rules.
---@param character GameHandle Character handle.
---@param category GameId GameId<crafting_category>
---@param subcategory? string Native subcategory id; omitted or empty selects the whole category.
---@return CcbResult result `value` is a CcbPlatformRecipeCategoryForget.
function CcbPlatformRecipesApi.forget_category(character, category, subcategory) end

---@class CcbPlatformMartialArtsApi: CcbMartialArtsApi
local CcbPlatformMartialArtsApi = {}

---Learn one martial-art style without coupling the mutation to presentation.
---@param character GameHandle Character handle.
---@param id GameId GameId<martial_art>
---@return CcbResult result `value.changed` reports whether known state changed; `value.known` is the resulting state.
function CcbPlatformMartialArtsApi.learn(character, id) end

---Forget one martial-art style through the character's native style collection.
---@param character GameHandle Character handle.
---@param id GameId GameId<martial_art>
---@return CcbResult result `value.changed` reports whether known state changed; `value.known` is the resulting state.
function CcbPlatformMartialArtsApi.forget(character, id) end

---@class CcbPlatformMoraleOptions
---@field duration? TimeDuration Non-negative; defaults to one hour.
---@field decay_start? TimeDuration Non-negative; defaults to thirty minutes.
---@field capped? boolean Defaults to false.

---@class CcbPlatformMoraleApi
local CcbPlatformMoraleApi = {}

---Add or combine one typed morale instance through native stacking rules.
---@param character GameHandle Character handle.
---@param id GameId GameId<morale>
---@param bonus integer
---@param max_bonus integer
---@param options? CcbPlatformMoraleOptions
---@return CcbResult result `value.before` and `value.after` are the matching net bonuses.
function CcbPlatformMoraleApi.add(character, id, bonus, max_bonus, options) end

---Remove all item-specific variants of one morale type.
---@param character GameHandle Character handle.
---@param id GameId GameId<morale>
---@return CcbResult result `value.before` and `value.after` are the matching net bonuses; `value.changed` reports whether they differ.
function CcbPlatformMoraleApi.remove(character, id) end

---@class CcbPlatformRandomApi: CcbRandomApi
local CcbPlatformRandomApi = {}

---@param minimum integer Inclusive lower bound in -1000000000..1000000000.
---@param maximum integer Inclusive upper bound in -1000000000..1000000000.
---@return integer
function CcbPlatformRandomApi.int(minimum, maximum) end

---@param numerator integer
---@param denominator integer Positive denominator up to 1000000000.
---@return boolean
function CcbPlatformRandomApi.chance(numerator, denominator) end

---@param denominator number Converted to a native integer; values at or below one always succeed.
---@return boolean
function CcbPlatformRandomApi.one_in(denominator) end

---@param numerator number
---@param denominator number Positive finite denominator with `0 <= numerator <= denominator`.
---@return boolean
function CcbPlatformRandomApi.probability(numerator, denominator) end

---@param minimum integer Inclusive lower bound.
---@param maximum integer Inclusive upper bound.
---@param count integer Number of results from 0 through 1024.
---@param with_replacement? boolean Defaults to false.
---@return integer[] values Dense sampled values; unique unless replacement was requested.
function CcbPlatformRandomApi.sample_integers(minimum, maximum, count, with_replacement) end

---@param check number
---@param difficulty number
---@param die_size? integer Defaults to 10.
---@return boolean success True when `random(1, die_size) + check > difficulty`.
function CcbPlatformRandomApi.contested(check, difficulty, die_size) end

---@class CcbPlatformStringPredicates
local CcbPlatformStringPredicates = {}

---@param values string[] At least two strings.
---@return boolean duplicate_found
function CcbPlatformStringPredicates.any_equal(values) end

---@param values string[] At least one string.
---@return boolean all_match
function CcbPlatformStringPredicates.all_equal(values) end

---@class CcbPlatformModQueries
local CcbPlatformModQueries = {}

---@param mod_id string
---@return boolean loaded Includes active Lua-first Platform Mods and the world's active Mod order.
function CcbPlatformModQueries.is_loaded(mod_id) end

---@class CcbPlatformEnvironmentQueries
local CcbPlatformEnvironmentQueries = {}

---@return string dimension_id Stable id of the currently active dimension.
function CcbPlatformEnvironmentQueries.dimension() end

---@return boolean is_night True while the sun is at or below civil dawn (i.e. it is not
--- the legacy EOC "is_day" state); ordinary Lua code may negate it directly.
function CcbPlatformEnvironmentQueries.is_night() end

---@param position TripointCoord Absolute map-square coordinate inside the active map.
---@return boolean
function CcbPlatformEnvironmentQueries.is_outside(position) end

---@param from TripointCoord Absolute map-square coordinate inside the active map.
---@param to TripointCoord Absolute map-square coordinate inside the active map.
---@param range integer Non-negative maximum range.
---@param with_fields? boolean Defaults to true.
---@return boolean visible
function CcbPlatformEnvironmentQueries.line_of_sight(from, to, range, with_fields) end

---@param position TripointCoord Absolute map-square coordinate inside the active map.
---@param flag string Bounded non-empty furniture flag id; unknown ids and out-of-bounds
--- positions return false.
---@return boolean
function CcbPlatformEnvironmentQueries.furniture_has_flag(position, flag) end

---@param position TripointCoord Absolute map-square coordinate; no inbounds gate
--- (mirrors the legacy map_terrain_id handler, so out-of-bounds resolves to the
--- null terrain id).
---@return string
function CcbPlatformEnvironmentQueries.terrain_id(position) end

---@param position TripointCoord Absolute map-square coordinate; no inbounds gate
--- (mirrors the legacy map_furniture_id handler, so out-of-bounds resolves to the
--- null furniture id).
---@return string
function CcbPlatformEnvironmentQueries.furniture_id(position) end

---@param position TripointCoord Absolute map-square coordinate.
---@param field_id string Bounded non-empty field type id.
---@return boolean
function CcbPlatformEnvironmentQueries.field_exists(position, field_id) end

---@param position TripointCoord Absolute map-square coordinate.
---@param flag string Bounded non-empty terrain flag id.
---@return boolean
function CcbPlatformEnvironmentQueries.terrain_has_flag(position, flag) end

---@param position TripointCoord Absolute map-square coordinate; out-of-bounds
--- returns false (mirroring the legacy map_is_outside handler).
---@return boolean True when the tile is indoors or under cover.
function CcbPlatformEnvironmentQueries.is_indoor_tile(position) end

---@param direction string One of N/NE/E/SE/S/SW/W/NW (cardinal direction).
---@return boolean Whether the avatar's safe-mode visibility marks that
--- direction dangerous (mirrors the legacy u_safe_mode_trigger handler).
function CcbPlatformEnvironmentQueries.safe_mode_dangerous(direction) end

---@class CcbPlatformGameplayApi
---@field strings CcbPlatformStringPredicates
---@field mods CcbPlatformModQueries
---@field math CcbPlatformMathApi
---@field environment CcbPlatformEnvironmentQueries
---@field options CcbPlatformGameplayOptionsApi
local CcbPlatformGameplayApi = {}

---@class CcbPlatformMathApi
local CcbPlatformMathApi = {}

---Evaluate a native gameplay expression against the supplied actor and
---detached callback context.  This is a domain expression service, not an EOC
---runner; it returns a finite number and follows native variable semantics.
---@param expression string Native math expression, at most 8192 bytes.
---@param actor? GameHandle Character/creature used for u_/npc_ variables.
---@param context? table<string, boolean|number|string|TripointCoord>
---@return CcbResult result `value` is the finite numeric result.
function CcbPlatformMathApi.evaluate(expression, actor, context) end

---Evaluate and apply a native assignment expression against an active callback.
---@param expression string Native math assignment/expression, at most 8192 bytes.
---@param actor? GameHandle Character/creature used for u_/npc_ variables.
---@param context? table<string, boolean|number|string|TripointCoord>
---@return CcbResult result `value` is the finite numeric result.
function CcbPlatformMathApi.apply(expression, actor, context) end

---@param text string
---@class CcbCharacterSnapshot
---@field name string
---@field x integer
---@field y integer
---@field z integer
---@field moves integer
---@field stamina integer
---@field stamina_max integer
---@field pain integer
---@field focus integer
---@field speed integer
---@field hunger integer
---@field thirst integer
---@field sleepiness integer

---@class CcbMovementModesSnapshot
---@field items table
---@field count integer
---@field current_id string
---@field desired_id string

---@class CcbBoundedItemList
---@field items table
---@field total integer
---@field returned integer
---@field limit integer
---@field truncated boolean

---@class CcbCreatureSnapshot
---@field kind 'avatar'|'npc'|'monster'|'creature'
---@field name string
---@field display_name string
---@field position TripointCoord
---@field visible? boolean Present only when a separate observer was supplied.
---@field distance? integer Present only when a separate observer was supplied.
---@field attitude? string Present only when a separate observer was supplied.
---@field dead boolean
---@field hp integer
---@field hp_max integer

---@class CcbCreaturesApi
local CcbCreaturesApi = {}

---@param handle GameHandle Exact live Creature handle.
---@return CcbResult result `value` is a detached CcbCreatureSnapshot; stale or dead handles fail closed.
function CcbCreaturesApi.snapshot(handle) end

---@param observer GameHandle Exact live Character observer handle.
---@param options? CcbCreatureNearbyOptions Query limits and filters; results contain generation-safe handles and detached values.
---@return CcbResult result
function CcbCreaturesApi.nearby(observer, options) end

---@param observer GameHandle Exact live avatar handle; NPC/monster/other Character handles fail closed.
---@param direction string One of N/NE/E/SE/S/SW/W/NW/L.
---@return CcbResult result
function CcbCreaturesApi.visible_monsters(observer, direction) end

---@class CcbTimeSnapshot
---@field turn integer
---@field year integer
---@field season_id string
---@field season_name string

---@class CcbWeatherSnapshot
---@field id string
---@field temperature_c number
---@field wind_speed number
---@field wind_direction number

function CcbPlatformServices.message(text) end

---@return integer
function CcbPlatformServices.turn() end

---@param character GameHandle Exact live Character handle; no implicit avatar is selected.
---@return CcbResult result `value` is a detached CcbCharacterSnapshot.
function CcbPlatformServices.character_snapshot(character) end

---@param character GameHandle Exact live Character handle.
---@return CcbResult result `value` is a detached CcbMovementModesSnapshot.
function CcbPlatformServices.movement_modes_snapshot(character) end

---@return CcbTimeSnapshot
function CcbPlatformServices.time_snapshot() end

---@return CcbWeatherSnapshot
function CcbPlatformServices.weather_snapshot() end

---@param limit? integer
---@param character GameHandle Exact live Character handle.
---@param limit? integer
---@return CcbResult result `value` is a detached CcbBoundedItemList.
function CcbPlatformServices.inventory_snapshot(character, limit) end

---@param character GameHandle Exact live Character handle.
---@param limit? integer
---@return CcbResult result `value` is a detached bounded effect list.
function CcbPlatformServices.effects_snapshot(character, limit) end

---@param character GameHandle Exact live Character handle.
---@param limit? integer
---@return CcbResult result `value` is a detached bounded skill list.
function CcbPlatformServices.skills_snapshot(character, limit) end

---@param character GameHandle Exact live Character handle.
---@param limit? integer
---@return CcbResult result `value` is a detached bounded equipment snapshot.
function CcbPlatformServices.equipment_snapshot(character, limit) end

---@param character GameHandle Exact live Character handle owning the searched inventory.
---@param item_handle GameHandle Exact item handle owned by `character`; no UID search is performed.
---@param offset? integer Non-negative bounded page offset.
---@param limit? integer Positive bounded page size.
---@return CcbResult result `value` is a detached bounded contents snapshot.
function CcbPlatformServices.item_contents_snapshot(character, item_handle, offset, limit) end

---@param character GameHandle Exact live Character handle.
---@param field_limit? integer
---@return CcbResult result `value` is a detached bounded tile snapshot.
function CcbPlatformServices.current_tile_snapshot(character, field_limit) end

---@param character GameHandle Exact live Character handle.
---@param limit? integer
---@return CcbResult result `value` is a detached bounded mutation list.
function CcbPlatformServices.mutations_snapshot(character, limit) end

---@param character GameHandle Exact live Character handle.
---@param limit? integer
---@return CcbResult result `value` is a detached bounded bionic list.
function CcbPlatformServices.bionics_snapshot(character, limit) end

---@param character GameHandle Exact live Character handle.
---@param limit? integer
---@return CcbResult result `value` is a detached bounded mission list.
function CcbPlatformServices.missions_snapshot(character, limit) end

---@param character GameHandle Exact live Character handle.
---@param limit? integer
---@return CcbResult result `value` is a detached bounded activity snapshot.
function CcbPlatformServices.activity_snapshot(character, limit) end

---@param character GameHandle Exact live Character handle used as the observer.
---@param radius? integer
---@param limit? integer
---@return CcbResult result `value` is a detached bounded creature list.
function CcbPlatformServices.nearby_creatures_snapshot(character, radius, limit) end

---@class CcbPlatformV1
---@field platform_version 1
---@field ModDefinition fun(options: ModDefinitionOptions): ModDefinition
---@field content CcbPlatformContent
---@field runtime CcbPlatformRuntime
---@field dialogue CcbPlatformDialogueApi
---@field state CcbPlatformState
---@field tasks CcbPlatformTasks
---@field presentation CcbPlatformPresentation
---@field services CcbPlatformServices
local ccb = {}

return ccb
