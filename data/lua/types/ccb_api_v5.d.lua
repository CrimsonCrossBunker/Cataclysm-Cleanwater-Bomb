---@meta

-- LuaLS declarations for the CCB Lua Mod API v5.
-- This file is editor metadata. Do not require or copy it into runtime code.

---@alias CcbScalar boolean|integer|number|string
---@alias CcbScalarMap table<string, CcbScalar>
---@alias CcbPageSlot
---| '"main.extensions"'
---| '"ingame.extensions"'
---| '"settings.mods"'
---| '"debug.tools"'
---@alias CcbTone '"normal"'|'"muted"'|'"good"'|'"warning"'|'"bad"'|'"info"'
---@alias CcbSizeToken '"compact"'|'"normal"'|'"wide"'|'"fill"'
---@alias CcbRegistryKind
---| '"bionic"'
---| '"furniture"'
---| '"item"'
---| '"monster"'
---| '"mutation"'
---| '"recipe"'
---| '"skill"'
---| '"terrain"'

---@alias CcbCapability
---| '"events"'
---| '"game.actions"'
---| '"game.actions.dangerous"'
---| '"game.callbacks"'
---| '"game.hooks"'
---| '"game.read"'
---| '"game.write"'
---| '"modules.import"'
---| '"registry.read"'
---| '"scheduler"'
---| '"services.consume"'
---| '"services.provide"'
---| '"state.character"'
---| '"state.page"'
---| '"state.world"'
---| '"ui.pages"'
---@alias CcbCoordinateOrigin '"rel"'|'"relative"'|'"abs"'|'"absolute"'|'"sm"'|'"submap"'|'"omt"'|'"overmap_terrain"'|'"om"'|'"overmap"'|'"bub"'|'"bubble"'|'"reality_bubble"'
---@alias CcbCoordinateScale
---| '"ms"'|'"map_square"'
---| '"sm"'|'"submap"'
---| '"omt"'|'"overmap_terrain"'
---| '"seg"'|'"segment"'
---| '"om"'|'"overmap"'
---@alias CcbHookMode '"observe"'|'"intercept"'
---@alias CcbCallbackKind
---| '"iuse"'
---| '"iwieldable"'
---| '"iwearable"'
---| '"iequippable"'
---| '"istate"'
---| '"imelee"'
---| '"iranged"'
---| '"bionic"'
---| '"mutation"'
---| '"trap"'
---| '"monster"'
---@alias CcbLuaValue nil|boolean|integer|number|string|GameId|GameEnum|UnitValue|TimeDuration|TimePoint|PointCoord|TripointCoord|CcbLuaValue[]|table<string, CcbLuaValue>

---Immutable typed JSON-definition id.
---@class GameId
---@field kind string
---@field value string
local GameId = {}

---@return boolean
function GameId:is_null() end

---@return boolean
function GameId:is_valid() end

---Immutable physical unit value.
---@class UnitValue
---@field kind string
---@field canonical_unit string
local UnitValue = {}

---@return boolean
function UnitValue:is_integral() end

---@param unit string
---@return number
function UnitValue:value(unit) end

---@param other UnitValue
---@return UnitValue
function UnitValue:add(other) end

---@param other UnitValue
---@return UnitValue
function UnitValue:subtract(other) end

---@param factor number
---@return UnitValue
function UnitValue:scale(factor) end

---@param other UnitValue
---@return -1|0|1
function UnitValue:compare(other) end

---Immutable duration with exact turn storage.
---@class TimeDuration
---@field turns integer
local TimeDuration = {}

---@param unit string
---@return number
function TimeDuration:value(unit) end

---@return string
function TimeDuration:display() end

---@param other TimeDuration
---@return -1|0|1
function TimeDuration:compare(other) end

---@param factor integer
---@return TimeDuration
function TimeDuration:scale(factor) end

---@param divisor integer
---@return TimeDuration
function TimeDuration:divide(divisor) end

---Immutable calendar point.
---@class TimePoint
---@field turn integer
local TimePoint = {}

---@return integer
function TimePoint:second_of_minute() end

---@return integer
function TimePoint:minute_of_hour() end

---@return integer
function TimePoint:hour_of_day() end

---@return boolean
function TimePoint:is_day() end

---@return boolean
function TimePoint:is_night() end

---@return boolean
function TimePoint:is_dawn() end

---@return boolean
function TimePoint:is_dusk() end

---@return TimePoint
function TimePoint:sunrise() end

---@return TimePoint
function TimePoint:sunset() end

---@return string
function TimePoint:moon_phase() end

---@return string
function TimePoint:season() end

---@return string
function TimePoint:display() end

---@param other TimePoint
---@return -1|0|1
function TimePoint:compare(other) end

---Immutable two-dimensional coordinate tagged with origin and scale.
---@class PointCoord
---@field x integer
---@field y integer
---@field origin CcbCoordinateOrigin
---@field scale CcbCoordinateScale
---@field type string
local PointCoord = {}

---@param other PointCoord
---@return PointCoord
function PointCoord:add(other) end

---@param other PointCoord
---@return PointCoord
function PointCoord:subtract(other) end

---@param factor integer
---@return PointCoord
function PointCoord:scale_by(factor) end

---@param scale CcbCoordinateScale
---@return PointCoord
function PointCoord:to(scale) end

---@param scale CcbCoordinateScale
---@return PointCoord
function PointCoord:project_to(scale) end

---@param scale CcbCoordinateScale
---@return PointCoord coarse, PointCoord remainder
function PointCoord:project_remain(scale) end

---@param remainder PointCoord
---@return PointCoord
function PointCoord:project_combine(remainder) end

---@param other PointCoord
---@return integer
function PointCoord:manhattan_distance(other) end

---@param other PointCoord
---@return integer
function PointCoord:square_distance(other) end

---@param other PointCoord
---@return number
function PointCoord:euclidean_distance(other) end

---@param other PointCoord
---@return -1|0|1
function PointCoord:compare(other) end

---Immutable three-dimensional coordinate tagged with origin and scale.
---@class TripointCoord
---@field x integer
---@field y integer
---@field z integer
---@field origin CcbCoordinateOrigin
---@field scale CcbCoordinateScale
---@field type string
local TripointCoord = {}

---@return PointCoord
function TripointCoord:xy() end

---@param other TripointCoord
---@return TripointCoord
function TripointCoord:add(other) end

---@param other PointCoord
---@return TripointCoord
function TripointCoord:add_xy(other) end

---@param other TripointCoord
---@return TripointCoord
function TripointCoord:subtract(other) end

---@param other PointCoord
---@return TripointCoord
function TripointCoord:subtract_xy(other) end

---@param factor integer
---@return TripointCoord
function TripointCoord:scale_by(factor) end

---@param scale CcbCoordinateScale
---@return TripointCoord
function TripointCoord:to(scale) end

---@param scale CcbCoordinateScale
---@return TripointCoord
function TripointCoord:project_to(scale) end

---@param scale CcbCoordinateScale
---@return TripointCoord coarse, PointCoord remainder
function TripointCoord:project_remain(scale) end

---@param remainder PointCoord
---@return TripointCoord
function TripointCoord:project_combine(remainder) end

---@param other TripointCoord
---@return integer
function TripointCoord:manhattan_distance(other) end

---@param other TripointCoord
---@return integer
function TripointCoord:square_distance(other) end

---@param other TripointCoord
---@return number
function TripointCoord:euclidean_distance(other) end

---@param other TripointCoord
---@return -1|0|1
function TripointCoord:compare(other) end

---Immutable typed enumeration member.
---@class GameEnum
---@field kind string
---@field name string
---@field ordinal integer
local GameEnum = {}

---@class CcbHandleLocator
---@field scope string
---@field stable_id integer
---@field x integer
---@field y integer
---@field z integer
---@field path integer[]

---@class CcbError
---@field code string
---@field message string

---@class CcbResult
---@field ok boolean
---@field value? any
---@field error? CcbError

---Generation-bound opaque reference to a live native game object.
---@class GameHandle
---@field kind '"creature"'|'"item"'|'"vehicle"'
---@field locator CcbHandleLocator
local GameHandle = {}

---@return boolean
function GameHandle:is_valid() end

---@return CcbResult
function GameHandle:status() end

---@class CcbTypesApi
local CcbTypesApi = {}

---@param kind string
---@param value string
---@return GameId
function CcbTypesApi.id(kind, value) end

---@return string[]
function CcbTypesApi.id_kinds() end

---@class CcbUnitsApi
local CcbUnitsApi = {}

---@param kind string
---@param value number
---@param unit string
---@return UnitValue
function CcbUnitsApi.new(kind, value, unit) end

---@return string[]
function CcbUnitsApi.kinds() end

---@param kind string
---@return string[]
function CcbUnitsApi.units(kind) end

---@class CcbTimeApi
---@field turn_zero TimePoint
---@field before_time_starts TimePoint
local CcbTimeApi = {}

---@param value integer
---@param unit string
---@return TimeDuration
function CcbTimeApi.duration(value, unit) end

---@param turn integer
---@return TimePoint
function CcbTimeApi.point(turn) end

---@return TimePoint
function CcbTimeApi.now() end

---@class CcbCoordsApi
---@field max_range_points integer
---@field point_rel_ms fun(x: integer, y: integer): PointCoord
---@field point_rel_sm fun(x: integer, y: integer): PointCoord
---@field point_rel_omt fun(x: integer, y: integer): PointCoord
---@field point_rel_seg fun(x: integer, y: integer): PointCoord
---@field point_rel_om fun(x: integer, y: integer): PointCoord
---@field point_abs_ms fun(x: integer, y: integer): PointCoord
---@field point_abs_sm fun(x: integer, y: integer): PointCoord
---@field point_abs_omt fun(x: integer, y: integer): PointCoord
---@field point_abs_seg fun(x: integer, y: integer): PointCoord
---@field point_abs_om fun(x: integer, y: integer): PointCoord
---@field point_sm_ms fun(x: integer, y: integer): PointCoord
---@field point_omt_ms fun(x: integer, y: integer): PointCoord
---@field point_omt_sm fun(x: integer, y: integer): PointCoord
---@field point_om_ms fun(x: integer, y: integer): PointCoord
---@field point_om_sm fun(x: integer, y: integer): PointCoord
---@field point_om_omt fun(x: integer, y: integer): PointCoord
---@field point_bub_ms fun(x: integer, y: integer): PointCoord
---@field point_bub_sm fun(x: integer, y: integer): PointCoord
---@field tripoint_rel_ms fun(x: integer, y: integer, z: integer): TripointCoord
---@field tripoint_rel_sm fun(x: integer, y: integer, z: integer): TripointCoord
---@field tripoint_rel_omt fun(x: integer, y: integer, z: integer): TripointCoord
---@field tripoint_rel_seg fun(x: integer, y: integer, z: integer): TripointCoord
---@field tripoint_rel_om fun(x: integer, y: integer, z: integer): TripointCoord
---@field tripoint_abs_ms fun(x: integer, y: integer, z: integer): TripointCoord
---@field tripoint_abs_sm fun(x: integer, y: integer, z: integer): TripointCoord
---@field tripoint_abs_omt fun(x: integer, y: integer, z: integer): TripointCoord
---@field tripoint_abs_seg fun(x: integer, y: integer, z: integer): TripointCoord
---@field tripoint_abs_om fun(x: integer, y: integer, z: integer): TripointCoord
---@field tripoint_sm_ms fun(x: integer, y: integer, z: integer): TripointCoord
---@field tripoint_omt_ms fun(x: integer, y: integer, z: integer): TripointCoord
---@field tripoint_omt_sm fun(x: integer, y: integer, z: integer): TripointCoord
---@field tripoint_om_ms fun(x: integer, y: integer, z: integer): TripointCoord
---@field tripoint_om_sm fun(x: integer, y: integer, z: integer): TripointCoord
---@field tripoint_om_omt fun(x: integer, y: integer, z: integer): TripointCoord
---@field tripoint_bub_ms fun(x: integer, y: integer, z: integer): TripointCoord
---@field tripoint_bub_sm fun(x: integer, y: integer, z: integer): TripointCoord
local CcbCoordsApi = {}

---@param origin CcbCoordinateOrigin
---@param scale CcbCoordinateScale
---@param x integer
---@param y integer
---@return PointCoord
function CcbCoordsApi.point(origin, scale, x, y) end

---@param origin CcbCoordinateOrigin
---@param scale CcbCoordinateScale
---@param x integer
---@param y integer
---@param z integer
---@return TripointCoord
function CcbCoordsApi.tripoint(origin, scale, x, y, z) end

---@return string[]
function CcbCoordsApi.kinds() end

---@generic T: PointCoord|TripointCoord
---@param value T
---@param scale CcbCoordinateScale
---@return T
function CcbCoordsApi.project_to(value, scale) end

---@param value PointCoord|TripointCoord
---@param scale CcbCoordinateScale
---@return PointCoord|TripointCoord, PointCoord
function CcbCoordsApi.project_remain(value, scale) end

---@generic T: PointCoord|TripointCoord
---@param coarse T
---@param remainder PointCoord
---@return T
function CcbCoordsApi.project_combine(coarse, remainder) end

---@generic T: PointCoord|TripointCoord
---@param from T
---@param to T
---@param max_points integer
---@return T[]
function CcbCoordsApi.line(from, to, max_points) end

---@param from PointCoord
---@param to PointCoord
---@param max_points integer
---@return PointCoord[]
function CcbCoordsApi.rectangle(from, to, max_points) end

---@param from TripointCoord
---@param to TripointCoord
---@param max_points integer
---@return TripointCoord[]
function CcbCoordsApi.box(from, to, max_points) end

---@class CcbEnumDescription
---@field kind string
---@field status '"covered"'|'"not_applicable"'
---@field available boolean
---@field replacement string
---@field reason string
---@field count integer

---@class CcbEnumPage
---@field kind string
---@field offset integer
---@field limit integer
---@field total integer
---@field returned integer
---@field has_more boolean
---@field values GameEnum[]

---@class CcbEnumsApi
local CcbEnumsApi = {}

---@param kind string
---@param name string
---@return GameEnum
function CcbEnumsApi.value(kind, name) end

---@return string[]
function CcbEnumsApi.kinds() end

---@param kind string
---@return CcbEnumDescription
function CcbEnumsApi.describe(kind) end

---@param kind string
---@param offset? integer
---@param limit? integer
---@return CcbEnumPage
function CcbEnumsApi.values(kind, offset, limit) end

---@param kind string
---@param name string
---@return boolean
function CcbEnumsApi.has(kind, name) end

---@class CcbSerdeApi
---@field format '"ccb_lua_value"'
---@field version integer
---@field max_bytes integer
---@field max_depth integer
---@field max_nodes integer
---@field max_table_entries integer
local CcbSerdeApi = {}

---@param value CcbLuaValue
---@return string
function CcbSerdeApi.encode(value) end

---@param document string
---@return CcbLuaValue
function CcbSerdeApi.decode(document) end

---@return string[]
function CcbSerdeApi.types() end

---@class CcbHandlesApi
local CcbHandlesApi = {}

---@return GameHandle
function CcbHandlesApi.avatar() end

---@class CcbPageDescriptor
---@field title? string
---@field category? string
---@field order? integer
---@field slots? CcbPageSlot[]

---@class ScriptUiEnvironment
---@field profile string
---@field input '"touch"'|'"mouse_keyboard"'|'"terminal"'
---@field density '"touch"'|'"comfortable"'|'"compact"'
---@field breakpoint '"narrow"'|'"regular"'|'"wide"'
---@field minimum_target number
---@field touch boolean
---@field hover boolean
---@field swipe_scroll boolean
---@field native_text_input boolean
---@field keyboard_navigation boolean
---@field pointer_activation boolean
---@field tap_activation boolean
---@field long_press_dangerous boolean

---@alias CcbUiEnvironment ScriptUiEnvironment

---@class CcbRadialOption
---@field id string
---@field label string
---@field enabled? boolean
---@field selected? boolean

---@class CcbActionSlotOption
---@field id string
---@field label string
---@field enabled? boolean

---Ephemeral drawing facade. Valid only during the current page draw callback;
---do not retain it in globals, closures, events, services, or scheduled work.
---@class ScriptUiContext
local ScriptUiContext = {}

---@return '"imgui"'
function ScriptUiContext:backend() end

---@return '"sdl2"'|'"sdl3"'|'"imtui"'
function ScriptUiContext:platform() end

---@param capability string
---@return boolean
function ScriptUiContext:supports(capability) end

---@return boolean
function ScriptUiContext:is_immediate_mode() end

---@return boolean
function ScriptUiContext:uses_native_widgets() end

---@return CcbUiEnvironment
function ScriptUiContext:environment() end

---@param value string
function ScriptUiContext:text(value) end

---@param value string
function ScriptUiContext:heading(value) end

---@param value string
function ScriptUiContext:bullet_text(value) end

---@param value string
function ScriptUiContext:disabled_text(value) end

---@param value string
---@param red number
---@param green number
---@param blue number
---@param alpha number
function ScriptUiContext:text_colored(value, red, green, blue, alpha) end

---@param value string
---@param tone CcbTone
function ScriptUiContext:text_tone(value, tone) end

function ScriptUiContext:separator() end
function ScriptUiContext:same_line() end
function ScriptUiContext:new_line() end
function ScriptUiContext:spacing() end

---@param width number
function ScriptUiContext:set_next_item_width(width) end

---@param size CcbSizeToken
function ScriptUiContext:item_width(size) end

---@param fraction number
---@param overlay? string
function ScriptUiContext:progress_bar(fraction, overlay) end

---@param label string
---@return boolean activated
function ScriptUiContext:button(label) end

---@param id string
---@param label string
---@return boolean activated
function ScriptUiContext:button_id(id, label) end

---@param label string
---@return boolean activated
function ScriptUiContext:small_button(label) end

---@param id string
---@param label string
---@return boolean activated
function ScriptUiContext:small_button_id(id, label) end

---@param label string
---@param value boolean
---@return boolean value
function ScriptUiContext:checkbox(label, value) end

---@param id string
---@param label string
---@param value boolean
---@return boolean value
function ScriptUiContext:checkbox_id(id, label, value) end

---@param label string
---@param active boolean
---@return boolean activated
function ScriptUiContext:radio_button(label, active) end

---@param id string
---@param label string
---@param active boolean
---@return boolean activated
function ScriptUiContext:radio_button_id(id, label, active) end

---@param label string
---@param selected boolean
---@return boolean activated
function ScriptUiContext:selectable(label, selected) end

---@param id string
---@param label string
---@param selected boolean
---@return boolean activated
function ScriptUiContext:selectable_id(id, label, selected) end

---@param label string
---@param value integer
---@param minimum integer
---@param maximum integer
---@return integer value
function ScriptUiContext:slider_int(label, value, minimum, maximum) end

---@param id string
---@param label string
---@param value integer
---@param minimum integer
---@param maximum integer
---@return integer value
function ScriptUiContext:slider_int_id(id, label, value, minimum, maximum) end

---@param label string
---@param value number
---@param minimum number
---@param maximum number
---@return number value
function ScriptUiContext:slider_float(label, value, minimum, maximum) end

---@param id string
---@param label string
---@param value number
---@param minimum number
---@param maximum number
---@return number value
function ScriptUiContext:slider_float_id(id, label, value, minimum, maximum) end

---@param label string
---@param value integer
---@return integer value
function ScriptUiContext:input_int(label, value) end

---@param id string
---@param label string
---@param value integer
---@return integer value
function ScriptUiContext:input_int_id(id, label, value) end

---@param label string
---@param value number
---@return number value
function ScriptUiContext:input_float(label, value) end

---@param id string
---@param label string
---@param value number
---@return number value
function ScriptUiContext:input_float_id(id, label, value) end

---@param label string
---@param value string
---@return string value
function ScriptUiContext:input_text(label, value) end

---@param id string
---@param label string
---@param value string
---@return string value
function ScriptUiContext:input_text_id(id, label, value) end

---@param id string
---@param center_label string
---@param options CcbRadialOption[]
---@return string selected_id Empty when no new selection was made.
function ScriptUiContext:radial_select_id(id, center_label, options) end

---@param id string
---@param selected_action string
---@param context_revision integer
---@param options CcbActionSlotOption[]
---@return string selected_action
function ScriptUiContext:action_slot_id(id, selected_action, context_revision, options) end

---@param id string
---@param height number
---@param draw fun()
function ScriptUiContext:child(id, height, draw) end

---@param id string
---@param height CcbSizeToken
---@param draw fun()
function ScriptUiContext:scroll(id, height, draw) end

---@param id string
---@param columns integer
---@param draw fun()
function ScriptUiContext:table(id, columns, draw) end

---@param id string
---@param narrow_columns integer
---@param regular_columns integer
---@param wide_columns integer
---@param draw fun()
function ScriptUiContext:grid(id, narrow_columns, regular_columns, wide_columns, draw) end

function ScriptUiContext:table_next_row() end

---@return boolean visible
function ScriptUiContext:table_next_column() end

---@param id string
---@param draw fun()
function ScriptUiContext:tabs(id, draw) end

---@param id string
---@param label string
---@param draw fun()
---@return boolean active
function ScriptUiContext:tab(id, label, draw) end

---@param id string
---@param label string
---@param default_open boolean
---@param draw fun()
---@return boolean open
function ScriptUiContext:tree(id, label, default_open, draw) end

---@param id string
---@param title string
---@param open boolean
---@param draw fun()
---@return boolean open
function ScriptUiContext:modal(id, title, open, draw) end

---@param text string
function ScriptUiContext:tooltip(text) end

---@param item_count integer
---@param row_height number
---@param draw_range fun(first: integer, last_exclusive: integer)
function ScriptUiContext:virtual_list(item_count, row_height, draw_range) end

---@param item_count integer
---@param row_height CcbSizeToken
---@param draw_range fun(first: integer, last_exclusive: integer)
function ScriptUiContext:virtual_list_rows(item_count, row_height, draw_range) end

---@class CcbUiApi
local CcbUiApi = {}

---@param id string
---@param descriptor CcbPageDescriptor
---@param draw fun(ctx: ScriptUiContext, params: CcbScalarMap) ctx is valid only for this invocation
---@overload fun(id: string, title: string, draw: fun(ctx: ScriptUiContext, params: CcbScalarMap))
function CcbUiApi.page(id, descriptor, draw) end

---@param page_id string
---@param params? CcbScalarMap
function CcbUiApi.open(page_id, params) end

function CcbUiApi.back() end

function CcbUiApi.close() end

---@class CcbEventOptions
---@field priority? integer
---@field once? boolean

---@class CcbEvent
---@field type string
---@field turn integer
---@field data CcbScalarMap
---@field data_types table<string, string>

---@alias CcbEventCallback fun(event: CcbEvent): boolean?

---@class CcbEventsApi
local CcbEventsApi = {}

---@param name string Game event id, lifecycle event id, or source-local custom event id.
---@param callback CcbEventCallback
---@return integer subscription_id
---@overload fun(name: string, options: CcbEventOptions, callback: CcbEventCallback): integer
function CcbEventsApi.on(name, callback) end

---@param provider_id string
---@param name string
---@param callback CcbEventCallback
---@return integer subscription_id
---@overload fun(provider_id: string, name: string, options: CcbEventOptions, callback: CcbEventCallback): integer
function CcbEventsApi.on_from(provider_id, name, callback) end

---@param subscription_id integer
---@return boolean removed
function CcbEventsApi.off(subscription_id) end

---@param name string
---@param data? CcbScalarMap
---@return boolean continued
function CcbEventsApi.emit(name, data) end

---@class CcbSchedulerApi
local CcbSchedulerApi = {}

---@param delay_turns integer
---@param callback fun(task_id: integer, now_turn: integer, due_turn: integer): boolean?
---@return integer task_id
function CcbSchedulerApi.after(delay_turns, callback) end

---@param interval_turns integer
---@param callback fun(task_id: integer, now_turn: integer, due_turn: integer): boolean?
---@return integer task_id
function CcbSchedulerApi.every(interval_turns, callback) end

---@param task_id integer
---@return boolean canceled
function CcbSchedulerApi.cancel(task_id) end

---@return integer turn
function CcbSchedulerApi.now() end

---@class CcbServiceDescriptor
---@field version? integer
---@field methods table<string, fun(arguments: CcbScalarMap): CcbScalarMap?>

---@class CcbServiceInfo
---@field provider string
---@field name string
---@field version integer
---@field methods string[]

---@class CcbServicesApi
local CcbServicesApi = {}

---@param name string
---@param descriptor CcbServiceDescriptor
function CcbServicesApi.provide(name, descriptor) end

---@param provider_id string
---@param service_name string
---@param method_name string
---@param arguments? CcbScalarMap
---@return CcbScalarMap
function CcbServicesApi.call(provider_id, service_name, method_name, arguments) end

---@param provider_id string
---@param service_name string
---@param minimum_version? integer
---@return boolean
function CcbServicesApi.available(provider_id, service_name, minimum_version) end

---@return CcbServiceInfo[]
function CcbServicesApi.list() end

---@class CcbModulesApi
local CcbModulesApi = {}

---@param provider_id string
---@param module_name string
---@return any exports
function CcbModulesApi.import(provider_id, module_name) end

---@return string source_id
function CcbModulesApi.source_id() end

---@class CcbRegistryListOptions
---@field offset? integer
---@field limit? integer
---@field query? string
---@field details? boolean

---@class CcbRegistryEntry
---@field id string
---@field name string

---@class CcbRegistryDefinition: CcbRegistryEntry
---@field kind CcbRegistryKind
---@field description? string

---@class CcbRegistryPage
---@field kind CcbRegistryKind
---@field revision integer
---@field offset integer
---@field limit integer
---@field total integer
---@field returned integer
---@field has_more boolean
---@field entries (CcbRegistryEntry|CcbRegistryDefinition)[]

---@class CcbRegistryApi
local CcbRegistryApi = {}

---@return CcbRegistryKind[]
function CcbRegistryApi.kinds() end

---@param kind CcbRegistryKind
---@param id string
---@return CcbRegistryDefinition?
function CcbRegistryApi.get(kind, id) end

---@param kind CcbRegistryKind
---@param options? CcbRegistryListOptions
---@return CcbRegistryPage
function CcbRegistryApi.list(kind, options) end

---@return integer
function CcbRegistryApi.revision() end

---@class CcbI18nApi
local CcbI18nApi = {}

---@param message string
---@return string
function CcbI18nApi.gettext(message) end

---@param context string
---@param message string
---@return string
function CcbI18nApi.pgettext(context, message) end

---@param singular string
---@param plural string
---@param count integer
---@return string
function CcbI18nApi.ngettext(singular, plural, count) end

---@param context string
---@param singular string
---@param plural string
---@param count integer
---@return string
function CcbI18nApi.npgettext(context, singular, plural, count) end

---@return integer
function CcbI18nApi.language_revision() end

---@class CcbStateStore
local CcbStateStore = {}

---@generic T: CcbScalar
---@param key string
---@param default T
---@return T
function CcbStateStore.get(key, default) end

---@param key string
---@param value CcbScalar|nil
function CcbStateStore.set(key, value) end

---@class CcbStateApi
---@field character CcbStateStore
---@field world CcbStateStore
---@field page CcbStateStore

---@class CcbPlayerSnapshot
---@field name string
---@field moves integer
---@field stamina integer
---@field stamina_max integer
---@field pain integer
---@field focus integer
---@field speed integer
---@field hunger integer
---@field thirst integer
---@field sleepiness integer
---@field morale integer
---@field stored_kcal integer
---@field healthy_kcal integer
---@field kcal_percent number
---@field radiation integer
---@field bionic_power_kj number
---@field bionic_power_max_kj number
---@field movement_mode_id string
---@field movement_mode_name string
---@field desired_movement_mode_id string
---@field desired_movement_mode_name string
---@field movement_mode_pending boolean
---@field x integer
---@field y integer
---@field z integer

---@class CcbMovementMode
---@field id string
---@field name string
---@field available boolean
---@field current boolean
---@field desired boolean
---@field switch_moves integer
---@field switch_seconds number

---@class CcbMovementModesSnapshot
---@field items CcbMovementMode[]
---@field count integer
---@field current_id string
---@field desired_id string

---@class CcbTimeSnapshot
---@field turn integer
---@field year integer
---@field season_id string
---@field season_name string
---@field day integer
---@field hour integer
---@field minute integer
---@field display string

---@class CcbWeatherSnapshot
---@field id string
---@field name string
---@field temperature_c number
---@field temperature_display string
---@field dangerous boolean
---@field raining boolean
---@field sight_penalty number
---@field wind_speed number
---@field wind_direction string

---@class CcbItemSnapshot
---@field uid integer
---@field id string
---@field name string
---@field category_id string
---@field category_name string
---@field charges integer
---@field count_by_charges boolean
---@field weight_grams number
---@field volume_ml number
---@field contents_count integer
---@field worn boolean
---@field wielded boolean

---@class CcbBoundedItemList
---@field items CcbItemSnapshot[]
---@field total integer
---@field returned integer
---@field limit integer
---@field truncated boolean

---@class CcbEffectSnapshot
---@field id string
---@field name string
---@field description string
---@field body_part_id string
---@field duration_turns integer
---@field intensity integer
---@field permanent boolean

---@class CcbSkillSnapshot
---@field id string
---@field name string
---@field description string
---@field level integer
---@field exercise_percent integer
---@field knowledge_level integer
---@field knowledge_percent integer
---@field rusty boolean
---@field training boolean
---@field combat boolean

---@class CcbMutationSnapshot
---@field id string
---@field name string
---@field description string
---@field active boolean
---@field activatable boolean
---@field base_trait boolean
---@field purifiable boolean
---@field threshold boolean
---@field points integer

---@class CcbBionicSnapshot
---@field uid integer
---@field id string
---@field name string
---@field description string
---@field powered boolean
---@field activatable boolean
---@field included boolean
---@field incapacitated_turns integer
---@field charge_timer_turns integer
---@field activation_cost_kj number
---@field deactivation_cost_kj number

---@class CcbMissionSnapshot
---@field uid integer
---@field id string
---@field name string
---@field description string
---@field status '"active"'|'"completed"'|'"failed"'
---@field selected boolean
---@field has_deadline boolean
---@field deadline_turn integer
---@field has_target boolean
---@field target_x? integer
---@field target_y? integer
---@field target_z? integer

---@class CcbActivityEntry
---@field id string
---@field active boolean
---@field verb string
---@field moves_total integer
---@field moves_left integer
---@field interruptible boolean
---@field interruptible_with_keyboard boolean
---@field auto_resume boolean
---@field progress_message string
---@field progress number

---@class CcbCreatureSnapshot
---@field name string
---@field kind '"monster"'|'"npc"'|'"creature"'
---@field attitude string
---@field distance integer
---@field x integer
---@field y integer
---@field z integer
---@field hp integer
---@field hp_max integer

---@class CcbActionDescriptor
---@field id string
---@field label string
---@field group string
---@field repeatable boolean
---@field dangerous boolean

---@class CcbInputContextSnapshot
---@field category string
---@field hud_scene_id string
---@field hud_scene_title string
---@field revision integer
---@field actions CcbActionDescriptor[]
---@field available table<string, boolean>

---@class CcbQueuedAction
---@field id integer
---@field type string
---@field status '"queued"'
---@field queued_turn integer
---@field action? string
---@field context_revision? integer
---@field dangerous? boolean
---@field source? string

---@class CcbActionResult
---@field id integer
---@field type string
---@field status '"succeeded"'|'"failed"'|'"canceled"'|'"denied"'
---@field error string
---@field queued_turn integer
---@field completed_turn integer
---@field action_taken boolean

---@class CcbActionsStatus
---@field pending_count integer
---@field result_count integer
---@field result_limit integer
---@field pending CcbQueuedAction[]
---@field results CcbActionResult[]

---@class CcbGameActionsApi
local CcbGameActionsApi = {}

---@param action_type string
---@param options? table
---@return integer request_id
function CcbGameActionsApi.enqueue(action_type, options) end

---@param action_id string
---@param context_revision integer
---@return integer request_id
function CcbGameActionsApi.enqueue_context(action_id, context_revision) end

---@param request_id integer
---@return boolean canceled
function CcbGameActionsApi.cancel(request_id) end

---@param result_limit? integer
---@return CcbActionsStatus
function CcbGameActionsApi.status(result_limit) end

---@return CcbInputContextSnapshot
function CcbGameActionsApi.context_snapshot() end

---@class CcbActionMenuDescriptor
---@field id string
---@field name? string
---@field category? string
---@field hotkey? string

---@class CcbActionMenuEntry
---@field registration_id integer
---@field id string
---@field name string
---@field category string
---@field source string
---@field enabled boolean

---@class CcbActionMenuLimits
---@field entries integer
---@field entries_per_source integer
---@field name_bytes integer
---@field callback_instructions integer

---@class CcbActionMenuApi
local CcbActionMenuApi = {}

---@param descriptor CcbActionMenuDescriptor
---@param callback fun()
---@return integer registration_id
function CcbActionMenuApi.register(descriptor, callback) end

---@param registration_id integer
---@return boolean removed
function CcbActionMenuApi.off(registration_id) end

---@return CcbActionMenuEntry[]
function CcbActionMenuApi.list() end

---@return CcbActionMenuLimits
function CcbActionMenuApi.limits() end

---@class CcbSidebarLine
---@field text string
---@field color? string

---@alias CcbSidebarOutput string|string[]|CcbSidebarLine[]

---@class CcbSidebarWidgetDescriptor
---@field id string
---@field name? string
---@field height? integer Use -2 for dynamic height, otherwise 1..64.
---@field order? integer
---@field default_toggle? boolean
---@field redraw_every_frame? boolean
---@field panel_visible? boolean|fun(): boolean
---@field draw fun(): CcbSidebarOutput
---@field render? fun()

---@class CcbSidebarWidgetInfo
---@field registration_id integer
---@field key string
---@field id string
---@field name string
---@field source string
---@field height integer
---@field order? integer
---@field default_toggle boolean
---@field redraw_every_frame boolean
---@field enabled boolean

---@class CcbSidebarLimits
---@field widgets integer
---@field widgets_per_source integer
---@field height integer
---@field lines integer
---@field line_bytes integer
---@field output_bytes integer
---@field callback_instructions integer

---@class CcbSidebarApi
local CcbSidebarApi = {}

---@param descriptor CcbSidebarWidgetDescriptor
---@return integer registration_id
function CcbSidebarApi.register_widget(descriptor) end

---@param descriptor CcbSidebarWidgetDescriptor
---@return integer registration_id
function CcbSidebarApi.register(descriptor) end

---@param registration_id integer
---@return boolean removed
function CcbSidebarApi.off(registration_id) end

---@return integer removed
function CcbSidebarApi.clear_widgets() end

---@return CcbSidebarWidgetInfo[]
function CcbSidebarApi.list() end

---@return CcbSidebarLimits
function CcbSidebarApi.limits() end

---@return string
function CcbSidebarApi.get_layout_id() end

---@class CcbHookOptions
---@field priority? integer
---@field once? boolean

---@class CcbHookSpec
---@field name string
---@field mode CcbHookMode
---@field cancellable boolean
---@field requires_write boolean
---@field payload_fields string[]
---@field result_fields string[]

---@class CcbHookLimits
---@field hooks integer
---@field handlers integer
---@field registered integer
---@field priority_min integer
---@field priority_max integer
---@field dispatch_depth integer
---@field instruction_budget integer

---@class CcbHookPayload
---@field hook string
---@field turn integer
---@field [string] CcbLuaValue|GameHandle|ScriptMapgenContext|MissionToken

---@alias CcbHookCallback fun(payload: CcbHookPayload): table?

---@class CcbHooksApi
local CcbHooksApi = {}

---@param name string
---@param callback CcbHookCallback
---@return integer subscription_id
---@overload fun(name: string, options: CcbHookOptions, callback: CcbHookCallback): integer
function CcbHooksApi.on(name, callback) end

---@param subscription_id integer
---@return boolean removed
function CcbHooksApi.off(subscription_id) end

---@param name string
---@return CcbHookSpec
function CcbHooksApi.describe(name) end

---@return CcbHookSpec[]
function CcbHooksApi.list() end

---@return CcbHookLimits
function CcbHooksApi.limits() end

---@class CcbCallbackDescriptor
---@field priority? integer
---@field once? boolean
---@field can_use? fun(payload: table): boolean|table
---@field on_use? fun(payload: table): boolean|table
---@field can_unwield? fun(payload: table): boolean|table
---@field can_wield? fun(payload: table): boolean|table
---@field on_unwield? fun(payload: table)
---@field on_wield? fun(payload: table)
---@field can_takeoff? fun(payload: table): boolean|table
---@field can_wear? fun(payload: table): boolean|table
---@field on_takeoff? fun(payload: table)
---@field on_wear? fun(payload: table)
---@field on_break? fun(payload: table)
---@field on_durability_change? fun(payload: table)
---@field on_repair? fun(payload: table)
---@field on_drop? fun(payload: table): boolean|table
---@field on_pickup? fun(payload: table)
---@field on_tick? fun(payload: table)
---@field on_block? fun(payload: table)
---@field on_hit? fun(payload: table)
---@field on_melee_attack? fun(payload: table): boolean|table
---@field on_miss? fun(payload: table)
---@field can_fire? fun(payload: table): boolean|table
---@field can_reload? fun(payload: table): boolean|table
---@field on_fire? fun(payload: table): boolean|table
---@field on_reload? fun(payload: table)
---@field on_activate? fun(payload: table)
---@field on_deactivate? fun(payload: table)
---@field on_installed? fun(payload: table)
---@field on_removed? fun(payload: table)
---@field on_gain? fun(payload: table)
---@field on_loss? fun(payload: table)
---@field can_trigger? fun(payload: table): boolean|table
---@field on_trigger? fun(payload: table)
---@field on_trigger_aftermath? fun(payload: table)
---@field get_examine_menu_entries? fun(payload: table): string[]|table
---@field on_examine_menu_entry? fun(payload: table)
---@field on_tame? fun(payload: table)

---@class CcbCallbackMethodSpec
---@field name string
---@field decision boolean
---@field requires_write boolean

---@class CcbCallbackKindSpec
---@field kind CcbCallbackKind
---@field target_id_kind string
---@field methods CcbCallbackMethodSpec[]

---@class CcbCallbackLimits
---@field kinds integer
---@field registrations integer
---@field registrations_per_target integer
---@field registered integer
---@field priority_min integer
---@field priority_max integer
---@field dispatch_depth integer
---@field instruction_budget integer

---@class CcbCallbacksApi
local CcbCallbacksApi = {}

---@param kind CcbCallbackKind
---@param target GameId
---@param descriptor CcbCallbackDescriptor
---@return integer registration_id
function CcbCallbacksApi.register(kind, target, descriptor) end

---@param registration_id integer
---@return boolean removed
function CcbCallbacksApi.off(registration_id) end

---@param kind CcbCallbackKind
---@return CcbCallbackKindSpec
function CcbCallbacksApi.describe(kind) end

---@return CcbCallbackKindSpec[]
function CcbCallbacksApi.list() end

---@return CcbCallbackLimits
function CcbCallbacksApi.limits() end

---Callback-scoped 24x24 deterministic mapgen facade.
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
---@return GameId?
function ScriptMapgenContext:furniture_at(x, y) end

---@param x integer
---@param y integer
---@return GameId?
function ScriptMapgenContext:trap_at(x, y) end

---@param x integer
---@param y integer
---@param id GameId
---@return boolean
function ScriptMapgenContext:set_terrain(x, y, id) end

---@param x integer
---@param y integer
---@param id GameId?
---@return boolean
function ScriptMapgenContext:set_furniture(x, y, id) end

---@param x integer
---@param y integer
---@param id GameId?
---@return boolean
function ScriptMapgenContext:set_trap(x, y, id) end

function ScriptMapgenContext:fill_groundcover() end

---@param id string
---@param x integer
---@param y integer
function ScriptMapgenContext:nest(id, x, y) end

---@param id string
function ScriptMapgenContext:generate(id) end

---@class CcbMapgenHookOptions: CcbHookOptions
---@field terrain_ids? string[]
---@field z_min? integer
---@field z_max? integer

---@class CcbMapgenLimits
---@field map_width integer
---@field map_height integer
---@field operations integer
---@field nested_generators integer
---@field full_generators integer
---@field handlers integer
---@field registered integer
---@field priority_min integer
---@field priority_max integer
---@field z_min integer
---@field z_max integer
---@field terrain_ids integer

---@class CcbMapgenApi
local CcbMapgenApi = {}

---@param callback fun(context: ScriptMapgenContext)
---@return integer subscription_id
---@overload fun(options: CcbMapgenHookOptions, callback: fun(context: ScriptMapgenContext)): integer
function CcbMapgenApi.on_postprocess(callback) end

---@param subscription_id integer
---@return boolean removed
function CcbMapgenApi.off(subscription_id) end

---@return CcbMapgenLimits
function CcbMapgenApi.limits() end

---@class CcbBindingDomain
---@field id string
---@field namespace string
---@field capability CcbCapability|string
---@field minimum_api_version integer
---@field status '"planned"'|'"partial"'|'"covered"'|'"not_applicable"'

---@class CcbDefinitionsDescription
---@field kind string
---@field typed boolean
---@field enumerable boolean
---@field detail_level '"snapshot"'|'"identity"'
---@field fields string[]
---@field revision integer
---@field count? integer

---@class CcbTypedDefinitionEntry
---@field id GameId
---@field value string
---@field name string

---@class CcbTypedDefinitionPage
---@field kind string
---@field revision integer
---@field offset integer
---@field limit integer
---@field total integer
---@field returned integer
---@field has_more boolean
---@field entries table[]

---@class CcbDefinitionsApi
local CcbDefinitionsApi = {}

---@return string[]
function CcbDefinitionsApi.kinds() end

---@param kind string
---@return CcbDefinitionsDescription
function CcbDefinitionsApi.describe(kind) end

---@param id GameId
---@return boolean
function CcbDefinitionsApi.exists(id) end

---@param id GameId
---@return table?
function CcbDefinitionsApi.get(id) end

---@param kind string
---@param options? CcbRegistryListOptions
---@return CcbTypedDefinitionPage
function CcbDefinitionsApi.list(kind, options) end

---@return integer
function CcbDefinitionsApi.revision() end

---@class CcbDiagnosticEntry
---@field sequence integer
---@field severity '"error"'
---@field generation integer
---@field world_generation integer
---@field source string
---@field context string
---@field message string

---@class CcbDiagnosticsHealth
---@field ok boolean
---@field last_error string
---@field memory_pressure number
---@field diagnostic_records integer
---@field latest_diagnostic_sequence integer

---@class CcbDiagnosticsRuntime
---@field generation integer
---@field world_generation integer
---@field source_count integer
---@field current_source string
---@field accepting_actions boolean

---@class CcbDiagnosticsMemory
---@field used integer
---@field limit integer
---@field remaining integer

---@class CcbDiagnosticsCallbacks
---@field count integer
---@field total_us integer
---@field max_us integer
---@field average_us number
---@field slow_count integer
---@field slow_threshold_us integer
---@field last_slow string
---@field event_dispatch_depth integer
---@field mapgen_dispatch_depth integer
---@field service_call_depth integer

---@class CcbDiagnosticsSource
---@field id string
---@field version string
---@field api_version integer
---@field capabilities CcbCapability[]
---@field dependencies string[]
---@field pages integer
---@field action_menu_entries integer
---@field sidebar_widgets integer
---@field event_handlers integer
---@field mapgen_handlers integer
---@field scheduled_tasks integer
---@field services integer
---@field modules integer
---@field current boolean

---@class CcbDiagnosticsSnapshot
---@field schema_version 1
---@field health CcbDiagnosticsHealth
---@field runtime CcbDiagnosticsRuntime
---@field memory CcbDiagnosticsMemory
---@field callbacks CcbDiagnosticsCallbacks
---@field resources table<string, integer>
---@field limits table<string, integer>
---@field sources CcbDiagnosticsSource[]

---@class CcbDiagnosticsApi
local CcbDiagnosticsApi = {}

---@return CcbDiagnosticsSnapshot
function CcbDiagnosticsApi.snapshot() end

---@param limit? integer
---@return CcbDiagnosticEntry[]
function CcbDiagnosticsApi.recent(limit) end

---@class CcbMessageEntry
---@field time string
---@field text string

---@class CcbMessagePage
---@field items CcbMessageEntry[]
---@field total integer
---@field returned integer
---@field limit integer
---@field truncated boolean

---@class CcbMessagesApi
local CcbMessagesApi = {}

---@param limit? integer
---@return CcbMessagePage
function CcbMessagesApi.recent(limit) end

---@param message string
---@param type? string
function CcbMessagesApi.add(message, type) end

---@class CcbConstantsSnapshot
---@field body_temperature table
---@field lighting table

---@class CcbConstantsApi
local CcbConstantsApi = {}

---@return CcbConstantsSnapshot
function CcbConstantsApi.snapshot() end

---@class CcbRandomApi
local CcbRandomApi = {}

---@param minimum integer
---@param maximum integer
---@return integer
function CcbRandomApi.int(minimum, maximum) end

---@param numerator integer
---@param denominator integer
---@return boolean
function CcbRandomApi.chance(numerator, denominator) end

---@class CcbVariantSoundOptions
---@field angle_degrees? number
---@field pitch_min? number
---@field pitch_max? number

---@class CcbAmbientSoundOptions
---@field channel? string
---@field fade_in_ms? integer
---@field pitch? number
---@field loops? integer

---@class CcbSoundApi
local CcbSoundApi = {}

---@param id string
---@param variant string
---@param volume integer
---@param options? CcbVariantSoundOptions
function CcbSoundApi.play(id, variant, volume, options) end

---@param id string
---@param variant string
---@param volume integer
---@param options? CcbAmbientSoundOptions
function CcbSoundApi.play_ambient(id, variant, volume, options) end

---@return string[]
function CcbSoundApi.channels() end

---@class CcbTargetArea
---@field first TripointCoord
---@field second TripointCoord

---@class CcbTargetingApi
local CcbTargetingApi = {}

---@param message string
---@param allow_vertical? boolean
---@return TripointCoord?
function CcbTargetingApi.choose_adjacent(message, allow_vertical) end

---@param message string
---@param allow_vertical? boolean
---@return TripointCoord?
function CcbTargetingApi.choose_direction(message, allow_vertical) end

---@return TripointCoord?
function CcbTargetingApi.look_around() end

---@param message string
---@param start? TripointCoord
---@param allow_vertical? boolean
---@return CcbTargetArea?
function CcbTargetingApi.choose_area(message, start, allow_vertical) end

---@param message string
---@param failure_message string
---@param action string
---@param allow_vertical? boolean
---@param allow_autoselect? boolean
---@return TripointCoord?
function CcbTargetingApi.choose_adjacent_for_action(message, failure_message, action, allow_vertical, allow_autoselect) end

---@param message string
---@param failure_message string
---@param candidates TripointCoord[]
---@param allow_vertical? boolean
---@param allow_autoselect? boolean
---@return TripointCoord?
function CcbTargetingApi.choose_adjacent_where(message, failure_message, candidates, allow_vertical, allow_autoselect) end

---@class CcbHallucinationOptions
---@field monster? GameId
---@field lifespan? TimeDuration

---@class CcbSpawnsApi
local CcbSpawnsApi = {}

---@param monster GameId
---@param position TripointCoord
---@param radius? integer
---@return CcbResult
function CcbSpawnsApi.monster(monster, position, radius) end

---@param position TripointCoord
---@param options? CcbHallucinationOptions
---@return CcbResult
function CcbSpawnsApi.hallucination(position, options) end

---@class CcbFollowersApi
local CcbFollowersApi = {}

---@return table
function CcbFollowersApi.list() end

---@param character GameHandle
---@return CcbResult
function CcbFollowersApi.add(character) end

---@param character GameHandle
---@return CcbResult
function CcbFollowersApi.remove(character) end

---@class CcbRelocationApi
local CcbRelocationApi = {}

---@param position TripointCoord
---@return CcbResult
function CcbRelocationApi.local_at(position) end

---@param position TripointCoord
---@return CcbResult
function CcbRelocationApi.overmap_at(position) end

---@class CcbNearbyOptions
---@field radius? integer
---@field limit? integer
---@field visible_only? boolean
---@field include_avatar? boolean
---@field include_hallucinations? boolean

---@class CcbCharactersAdjustments
---@field moves? integer
---@field stamina? integer
---@field pain? integer
---@field focus? integer
---@field hunger? integer
---@field thirst? integer
---@field sleepiness? integer
---@field radiation? integer
---@field painkiller? integer
---@field stored_kcal? integer

---@class CcbCreaturesApi
local CcbCreaturesApi = {}

---@return GameHandle
function CcbCreaturesApi.avatar() end

---@param handle GameHandle
---@return CcbResult
function CcbCreaturesApi.snapshot(handle) end

---@param options? CcbNearbyOptions
---@return table
function CcbCreaturesApi.nearby(options) end

---@param position TripointCoord
---@return CcbResult
function CcbCreaturesApi.at(position) end

---@class CcbCharactersApi
local CcbCharactersApi = {}

---@return GameHandle
function CcbCharactersApi.avatar() end

---@param handle GameHandle
---@param body_part_limit? integer
---@return CcbResult
function CcbCharactersApi.snapshot(handle, body_part_limit) end

---@param id integer
---@return CcbResult
function CcbCharactersApi.by_id(id) end

---@param options? CcbNearbyOptions
---@return table
function CcbCharactersApi.nearby(options) end

---@param handle GameHandle
---@param adjustments CcbCharactersAdjustments
---@return CcbResult
function CcbCharactersApi.adjust(handle, adjustments) end

---@param handle GameHandle
---@param body_part GameId
---@param amount integer
---@return CcbResult
function CcbCharactersApi.heal(handle, body_part, amount) end

---@param handle GameHandle
---@param mode GameId
---@return CcbResult
function CcbCharactersApi.set_movement_mode(handle, mode) end

---@class CcbEffectAddOptions
---@field body_part? GameId
---@field intensity? integer
---@field force? boolean
---@field permanent? boolean

---@class CcbEffectUpdateOptions
---@field body_part? GameId
---@field duration? TimeDuration
---@field intensity? integer
---@field permanent? boolean

---@class CcbEffectsApi
local CcbEffectsApi = {}

---@param handle GameHandle
---@param limit? integer
---@return CcbResult
function CcbEffectsApi.list(handle, limit) end

---@param handle GameHandle
---@param id GameId
---@param body_part? GameId
---@return CcbResult
function CcbEffectsApi.has(handle, id, body_part) end

---@param handle GameHandle
---@param id GameId
---@param body_part? GameId
---@return CcbResult
function CcbEffectsApi.get(handle, id, body_part) end

---@param handle GameHandle
---@param id GameId
---@param duration TimeDuration
---@param options? CcbEffectAddOptions
---@return CcbResult
function CcbEffectsApi.add(handle, id, duration, options) end

---@param handle GameHandle
---@param id GameId
---@param body_part? GameId
---@return CcbResult
function CcbEffectsApi.remove(handle, id, body_part) end

---@param handle GameHandle
---@param id GameId
---@param options CcbEffectUpdateOptions
---@return CcbResult
function CcbEffectsApi.update(handle, id, options) end

---@class CcbPageOptions
---@field offset? integer
---@field limit? integer

---@class CcbBionicConfigureOptions
---@field auto_shutdown? boolean
---@field show_sprite? boolean
---@field safe_fuel_threshold? number

---@class CcbBionicsApi
local CcbBionicsApi = {}

---@param options? CcbPageOptions
---@return table
function CcbBionicsApi.definitions(options) end

---@param id GameId
---@return table?
function CcbBionicsApi.definition(id) end

---@param character GameHandle
---@param limit? integer
---@return CcbResult
function CcbBionicsApi.list(character, limit) end

---@param character GameHandle
---@param uid integer
---@return CcbResult
function CcbBionicsApi.get(character, uid) end

---@param character GameHandle
---@param id GameId
---@return CcbResult
function CcbBionicsApi.has(character, id) end

---@param character GameHandle
---@param id GameId
---@return CcbResult
function CcbBionicsApi.install(character, id) end

---@param character GameHandle
---@param uid integer
---@return CcbResult
function CcbBionicsApi.remove(character, uid) end

---@param character GameHandle
---@param power UnitValue
---@return CcbResult
function CcbBionicsApi.set_power(character, power) end

---@param character GameHandle
---@param uid integer
---@return CcbResult
function CcbBionicsApi.activate(character, uid) end

---@param character GameHandle
---@param uid integer
---@return CcbResult
function CcbBionicsApi.deactivate(character, uid) end

---@param character GameHandle
---@param uid integer
---@param options CcbBionicConfigureOptions
---@return CcbResult
function CcbBionicsApi.configure(character, uid, options) end

---@class CcbItemPocketOptions: CcbPageOptions

---@class CcbItemContentsOptions: CcbPageOptions
---@field max_depth? integer
---@field recursive? boolean

---@class CcbItemUpdates
---@field charges? integer
---@field damage? integer
---@field favorite? boolean

---@class CcbItemsApi
local CcbItemsApi = {}

---@param handle GameHandle
---@param relation_limit? integer
---@return CcbResult
function CcbItemsApi.snapshot(handle, relation_limit) end

---@param handle GameHandle
---@param options? CcbItemPocketOptions
---@return CcbResult
function CcbItemsApi.pockets(handle, options) end

---@param handle GameHandle
---@param options? CcbItemContentsOptions
---@return CcbResult
function CcbItemsApi.contents(handle, options) end

---@param handle GameHandle
---@param updates CcbItemUpdates
---@return CcbResult
function CcbItemsApi.update(handle, updates) end

---@param handle GameHandle
---@param key string
---@return CcbResult
function CcbItemsApi.get_var(handle, key) end

---@param handle GameHandle
---@param key string
---@param value CcbScalar
---@return CcbResult
function CcbItemsApi.set_var(handle, key, value) end

---@param handle GameHandle
---@param key string
---@return CcbResult
function CcbItemsApi.erase_var(handle, key) end

---@param handle GameHandle
---@param flag GameId
---@return CcbResult
function CcbItemsApi.has_flag(handle, flag) end

---@param handle GameHandle
---@param flag GameId
---@param enabled boolean
---@return CcbResult
function CcbItemsApi.set_flag(handle, flag, enabled) end

---@param handle GameHandle
---@param technique GameId
---@return CcbResult
function CcbItemsApi.has_technique(handle, technique) end

---@param handle GameHandle
---@param technique GameId
---@param enabled boolean
---@return CcbResult
function CcbItemsApi.set_technique(handle, technique, enabled) end

---@class CcbInventoryOptions: CcbPageOptions
---@field max_depth? integer
---@field recursive? boolean
---@field include_wielded? boolean
---@field include_worn? boolean
---@field include_carried? boolean

---@class CcbGiveItemOptions
---@field allow_wield? boolean

---@class CcbInventoryApi
local CcbInventoryApi = {}

---@param character GameHandle
---@param options? CcbInventoryOptions
---@return CcbResult
function CcbInventoryApi.list(character, options) end

---@param character GameHandle
---@param uid integer
---@return CcbResult
function CcbInventoryApi.find(character, uid) end

---@param character GameHandle
---@param type GameId
---@param quantity integer
---@return CcbResult
function CcbInventoryApi.resources(character, type, quantity) end

---@param character GameHandle
---@param type GameId
---@param quantity integer
---@param options? CcbGiveItemOptions
---@return CcbResult
function CcbInventoryApi.give(character, type, quantity, options) end

---@param character GameHandle
---@param item GameHandle
---@param quantity? integer
---@return CcbResult
function CcbInventoryApi.remove(character, item, quantity) end

---@param character GameHandle
---@param item GameHandle
---@return CcbResult
function CcbInventoryApi.wield(character, item) end

---@param character GameHandle
---@param item GameHandle
---@return CcbResult
function CcbInventoryApi.wear(character, item) end

---@param character GameHandle
---@return CcbResult
function CcbInventoryApi.stash_wielded(character) end

---@class CcbMutationListOptions: CcbPageOptions
---@field include_hidden? boolean
---@field include_enchantment? boolean

---@class CcbMutationsApi
local CcbMutationsApi = {}

---@param options? CcbPageOptions
---@return table
function CcbMutationsApi.definitions(options) end

---@param id GameId
---@return table?
function CcbMutationsApi.definition(id) end

---@param character GameHandle
---@param options? CcbMutationListOptions
---@return CcbResult
function CcbMutationsApi.list(character, options) end

---@param character GameHandle
---@param id GameId
---@return CcbResult
function CcbMutationsApi.has(character, id) end

---@param character GameHandle
---@param id GameId
---@return CcbResult
function CcbMutationsApi.get(character, id) end

---@param character GameHandle
---@param id GameId
---@param variant? string
---@return CcbResult
function CcbMutationsApi.grant(character, id, variant) end

---@param character GameHandle
---@param id GameId
---@return CcbResult
function CcbMutationsApi.remove(character, id) end

---@param character GameHandle
---@param id GameId
---@param active boolean
---@return CcbResult
function CcbMutationsApi.set_active(character, id, active) end

---@param character GameHandle
---@param id GameId
---@param variant string
---@return CcbResult
function CcbMutationsApi.set_variant(character, id, variant) end

---@class CcbLearnSpellOptions
---@field force? boolean
---@field level? integer
---@field experience? integer

---@class CcbSpellsApi
local CcbSpellsApi = {}

---@param options? CcbPageOptions
---@return table
function CcbSpellsApi.definitions(options) end

---@param id GameId
---@return table?
function CcbSpellsApi.definition(id) end

---@param character GameHandle
---@param options? CcbPageOptions
---@return CcbResult
function CcbSpellsApi.list(character, options) end

---@param character GameHandle
---@param id GameId
---@return CcbResult
function CcbSpellsApi.knows(character, id) end

---@param character GameHandle
---@param id GameId
---@return CcbResult
function CcbSpellsApi.get(character, id) end

---@param character GameHandle
---@param id GameId
---@return CcbResult
function CcbSpellsApi.can_learn(character, id) end

---@param character GameHandle
---@param id GameId
---@param options? CcbLearnSpellOptions
---@return CcbResult
function CcbSpellsApi.learn(character, id, options) end

---@param character GameHandle
---@param id GameId
---@return CcbResult
function CcbSpellsApi.forget(character, id) end

---@param character GameHandle
---@param id GameId
---@param amount integer
---@return CcbResult
function CcbSpellsApi.set_experience(character, id, amount) end

---@param character GameHandle
---@param id GameId
---@param amount integer
---@return CcbResult
function CcbSpellsApi.gain_experience(character, id, amount) end

---@param character GameHandle
---@param id GameId
---@param level integer
---@return CcbResult
function CcbSpellsApi.set_level(character, id, level) end

---@param character GameHandle
---@param id GameId
---@param levels integer
---@return CcbResult
function CcbSpellsApi.gain_levels(character, id, levels) end

---@param character GameHandle
---@return CcbResult
function CcbSpellsApi.mana(character) end

---@param character GameHandle
---@param amount integer
---@return CcbResult
function CcbSpellsApi.set_mana(character, amount) end

---@param character GameHandle
---@param amount integer
---@return CcbResult
function CcbSpellsApi.modify_mana(character, amount) end

---@param character GameHandle
---@param enabled boolean
---@return CcbResult
function CcbSpellsApi.set_casting_ignore(character, enabled) end

---@param character GameHandle
---@param id GameId
---@param favorite boolean
---@return CcbResult
function CcbSpellsApi.set_favorite(character, id, favorite) end

---@param character GameHandle
---@param id GameId
---@param target TripointCoord
---@return CcbResult
function CcbSpellsApi.queue_cast(character, id, target) end

---Generation-bound mission identity.
---@class MissionToken
---@field uid integer
---@field runtime_generation integer
---@field world_generation integer
local MissionToken = {}

---@return boolean
function MissionToken:is_valid() end

---@class CcbMissionListOptions: CcbPageOptions
---@field scope? "all"|"avatar"
---@field status? "all"|"reserved"|"active"|"success"|"failure"

---@class CcbMissionsApi
local CcbMissionsApi = {}

---@param options? CcbPageOptions
---@return table
function CcbMissionsApi.definitions(options) end

---@param id GameId
---@return table?
function CcbMissionsApi.definition(id) end

---@param options? CcbMissionListOptions
---@return table
function CcbMissionsApi.list(options) end

---@param token MissionToken
---@return CcbResult
function CcbMissionsApi.get(token) end

---@return CcbResult
function CcbMissionsApi.current() end

---@param origin GameEnum
---@param position TripointCoord
---@return table?
function CcbMissionsApi.random_definition(origin, position) end

---@param token MissionToken
---@param npc_id? integer
---@return CcbResult
function CcbMissionsApi.is_complete(token, npc_id) end

---@param id GameId
---@param npc_id? integer
---@return CcbResult
function CcbMissionsApi.reserve(id, npc_id) end

---@param origin GameEnum
---@param position TripointCoord
---@param npc_id? integer
---@return CcbResult
function CcbMissionsApi.reserve_random(origin, position, npc_id) end

---@param token MissionToken
---@return CcbResult
function CcbMissionsApi.assign(token) end

---@param token MissionToken
---@return CcbResult
function CcbMissionsApi.select(token) end

---@param token MissionToken
---@param step integer
---@return CcbResult
function CcbMissionsApi.step_complete(token, step) end

---@param token MissionToken
---@return CcbResult
function CcbMissionsApi.fail(token) end

---@param token MissionToken
---@param force? boolean
---@return CcbResult
function CcbMissionsApi.complete(token, force) end

---@param token MissionToken
---@return CcbResult
function CcbMissionsApi.cancel(token) end

---@param token MissionToken
---@return CcbResult
function CcbMissionsApi.abandon(token) end

---@class CcbRecipeListOptions: CcbPageOptions
---@field batch? integer
---@field include_obsolete? boolean
---@field known? boolean
---@field craftable? boolean
---@field skill? GameId
---@field result? GameId
---@field flag? string

---@class CcbRecipesApi
local CcbRecipesApi = {}

---@return table
function CcbRecipesApi.limits() end

---@param options? CcbRecipeListOptions
---@return table
function CcbRecipesApi.list(options) end

---@param options? CcbRecipeListOptions
---@return table
function CcbRecipesApi.all(options) end

---@param skill GameId
---@param options? CcbRecipeListOptions
---@return table
function CcbRecipesApi.by_skill(skill, options) end

---@param flag string
---@param options? CcbRecipeListOptions
---@return table
function CcbRecipesApi.by_flag(flag, options) end

---@param id GameId
---@param batch? integer
---@return table?
function CcbRecipesApi.get(id, batch) end

---@param id GameId
---@param flag string
---@return boolean
function CcbRecipesApi.has_flag(id, flag) end

---@class CcbRequirementListOptions: CcbPageOptions
---@field batch? integer

---@class CcbRequirementsApi
local CcbRequirementsApi = {}

---@return table
function CcbRequirementsApi.limits() end

---@param options? CcbRequirementListOptions
---@return table
function CcbRequirementsApi.list(options) end

---@param id string
---@param batch? integer
---@return table?
function CcbRequirementsApi.get(id, batch) end

---@param recipe GameId
---@param batch? integer
---@return table
function CcbRequirementsApi.for_recipe(recipe, batch) end

---@class CcbCraftOptions
---@field batch? integer
---@field long? boolean

---@class CcbCraftingApi
local CcbCraftingApi = {}

---@param recipe GameId
---@param options? CcbCraftOptions
---@return integer request_id
function CcbCraftingApi.queue_start(recipe, options) end

---@class CcbWorldTileOptions
---@field item_limit? integer
---@field field_limit? integer

---@class CcbWorldRegionOptions: CcbWorldTileOptions
---@field radius? integer
---@field radius_z? integer
---@field offset? integer
---@field limit? integer

---@class CcbWorldVehicleOptions: CcbPageOptions

---@class CcbWorldApi
local CcbWorldApi = {}

---@param position TripointCoord
---@return TripointCoord
function CcbWorldApi.to_absolute(position) end

---@param position TripointCoord
---@return TripointCoord
function CcbWorldApi.to_bubble(position) end

---@return table
function CcbWorldApi.bounds() end

---@param position TripointCoord
---@param options? CcbWorldTileOptions
---@return CcbResult
function CcbWorldApi.tile(position, options) end

---@param center TripointCoord
---@param options? CcbWorldRegionOptions
---@return CcbResult
function CcbWorldApi.region(center, options) end

---@param options? CcbWorldVehicleOptions
---@return CcbResult
function CcbWorldApi.vehicles(options) end

---@param position TripointCoord
---@param terrain GameId
---@return CcbResult
function CcbWorldApi.set_terrain(position, terrain) end

---@param position TripointCoord
---@param furniture GameId?
---@return CcbResult
function CcbWorldApi.set_furniture(position, furniture) end

---@param position TripointCoord
---@param trap GameId?
---@return CcbResult
function CcbWorldApi.set_trap(position, trap) end

---@param position TripointCoord
---@param field GameId
---@param intensity integer
---@param age TimeDuration
---@return CcbResult
function CcbWorldApi.put_field(position, field, intensity, age) end

---@param position TripointCoord
---@param field GameId
---@return CcbResult
function CcbWorldApi.remove_field(position, field) end

---@param position TripointCoord
---@param item GameId
---@param quantity integer
---@return CcbResult
function CcbWorldApi.spawn_item(position, item, quantity) end

---@param position TripointCoord
---@param item GameHandle
---@return CcbResult
function CcbWorldApi.remove_item(position, item) end

---@class CcbOvermapSelectorTable
---@field terrain GameId|string
---@field match? GameEnum

---@alias CcbOvermapSelector GameId|string|CcbOvermapSelectorTable

---@class CcbOvermapSearchOptions: CcbPageOptions
---@field types? CcbOvermapSelector[]
---@field exclude_types? CcbOvermapSelector[]
---@field minimum_radius? integer
---@field radius? integer
---@field radius_z? integer
---@field seen? boolean
---@field explored? boolean

---@class CcbOvermapApi
local CcbOvermapApi = {}

---@return table
function CcbOvermapApi.limits() end

---@param position TripointCoord
---@return table?
function CcbOvermapApi.tile(position) end

---@param origin TripointCoord
---@param options? CcbOvermapSearchOptions
---@return table
function CcbOvermapApi.search(origin, options) end

---@param origin TripointCoord
---@param options? CcbOvermapSearchOptions
---@return table?
function CcbOvermapApi.closest(origin, options) end

---@param origin TripointCoord
---@param options? CcbOvermapSearchOptions
---@return table?
function CcbOvermapApi.random(origin, options) end

---@param position TripointCoord
---@param selector CcbOvermapSelector
---@param match? GameEnum
---@return boolean
function CcbOvermapApi.matches(position, selector, match) end

---@param position TripointCoord
---@param terrain GameId
---@return CcbResult
function CcbOvermapApi.set_terrain(position, terrain) end

---@param position TripointCoord
---@param vision GameEnum
---@return CcbResult
function CcbOvermapApi.set_seen(position, vision) end

---@param position TripointCoord
---@param explored boolean
---@return CcbResult
function CcbOvermapApi.set_explored(position, explored) end

---@param position TripointCoord
---@param note? string
---@return CcbResult
function CcbOvermapApi.set_note(position, note) end

---@param position TripointCoord
---@param radius integer
---@param dangerous boolean
---@return CcbResult
function CcbOvermapApi.set_note_danger(position, radius, dangerous) end

---@param center TripointCoord
---@param radius integer
---@return CcbResult
function CcbOvermapApi.reveal(center, radius) end

---Generation-bound token for an individual overmap horde entity.
---@class HordeEntityToken
---@field position TripointCoord
---@field monster GameId
---@field runtime_generation integer
---@field world_generation integer
local HordeEntityToken = {}

---@return boolean
function HordeEntityToken:is_valid() end

---Generation-bound token for a legacy aggregate monster group.
---@class LegacyHordeToken
---@field position TripointCoord
---@field group GameId
---@field runtime_generation integer
---@field world_generation integer
local LegacyHordeToken = {}

---@return boolean
function LegacyHordeToken:is_valid() end

---@alias CcbHordeFlavor "active"|"idle"|"dormant"|"immobile"

---@class CcbHordeEntityQueryOptions: CcbPageOptions
---@field radius? integer
---@field radius_z? integer
---@field flavors? CcbHordeFlavor[]
---@field monster? GameId

---@class CcbLegacyHordeQueryOptions: CcbPageOptions
---@field radius? integer
---@field radius_z? integer
---@field horde_only? boolean

---@class CcbLegacyHordeSettings
---@field population? integer
---@field interest? integer
---@field dying? boolean
---@field horde? boolean
---@field behavior? "none"|"city"|"roam"|"nemesis"
---@field target? TripointCoord
---@field nemesis_target? TripointCoord

---@class CcbLegacyHordeSpawnOptions: CcbLegacyHordeSettings
---@field group GameId
---@field position TripointCoord

---@class CcbHordesApi
local CcbHordesApi = {}

---@return table
function CcbHordesApi.limits() end

---@param options? CcbPageOptions
---@return table
function CcbHordesApi.definitions(options) end

---@param id GameId
---@param options? CcbPageOptions
---@return table?
function CcbHordesApi.definition(id, options) end

---@param id GameId
---@param recursive? boolean
---@param options? CcbPageOptions
---@return table
function CcbHordesApi.monsters(id, recursive, options) end

---@param group GameId
---@param monster GameId
---@return boolean
function CcbHordesApi.contains(group, monster) end

---@param center TripointCoord
---@param options? CcbHordeEntityQueryOptions
---@return table
function CcbHordesApi.entities(center, options) end

---@param token HordeEntityToken
---@return CcbResult
function CcbHordesApi.entity(token) end

---@param center TripointCoord
---@param options? CcbLegacyHordeQueryOptions
---@return table
function CcbHordesApi.legacy_groups(center, options) end

---@param token LegacyHordeToken
---@return CcbResult
function CcbHordesApi.legacy_group(token) end

---@param position TripointCoord
---@return table
function CcbHordesApi.summary(position) end

---@param position TripointCoord
---@param monster GameId
---@return CcbResult
function CcbHordesApi.spawn_entity(position, monster) end

---@param token HordeEntityToken
---@param destination TripointCoord
---@param intensity integer
---@return CcbResult
function CcbHordesApi.alert_entity(token, destination, intensity) end

---@param token HordeEntityToken
---@return CcbResult
function CcbHordesApi.remove_entity(token) end

---@param options CcbLegacyHordeSpawnOptions
---@return CcbResult
function CcbHordesApi.spawn_legacy_group(options) end

---@param token LegacyHordeToken
---@param options CcbLegacyHordeSettings
---@return CcbResult
function CcbHordesApi.update_legacy_group(token, options) end

---@param token LegacyHordeToken
---@return CcbResult
function CcbHordesApi.remove_legacy_group(token) end

---@param position TripointCoord
---@param power integer
---@return CcbResult
function CcbHordesApi.signal(position, power) end

---@return CcbResult
function CcbHordesApi.advance() end

---@class CcbRuntimeStatus
---@field loaded boolean
---@field generation integer
---@field world_generation integer
---@field pages integer
---@field action_menu_entries integer
---@field sidebar_widgets integer
---@field event_handlers integer
---@field mapgen_handlers integer
---@field sources integer
---@field memory_used integer
---@field memory_limit integer
---@field callback_count integer
---@field callback_time_total_us integer
---@field callback_time_max_us integer
---@field slow_callback_count integer
---@field last_slow_callback string
---@field last_error string

---@class CcbGameApi
---@field api_version 5
---@field actions CcbGameActionsApi
---@field action_menu CcbActionMenuApi
---@field sidebar CcbSidebarApi
---@field types CcbTypesApi
---@field units CcbUnitsApi
---@field time CcbTimeApi
---@field coords CcbCoordsApi
---@field enums CcbEnumsApi
---@field serde CcbSerdeApi
---@field handles CcbHandlesApi
---@field definitions CcbDefinitionsApi
---@field diagnostics CcbDiagnosticsApi
---@field hooks CcbHooksApi
---@field callbacks CcbCallbacksApi
---@field mapgen CcbMapgenApi
---@field creatures CcbCreaturesApi
---@field characters CcbCharactersApi
---@field effects CcbEffectsApi
---@field bionics CcbBionicsApi
---@field items CcbItemsApi
---@field inventory CcbInventoryApi
---@field mutations CcbMutationsApi
---@field spells CcbSpellsApi
---@field missions CcbMissionsApi
---@field recipes CcbRecipesApi
---@field requirements CcbRequirementsApi
---@field crafting CcbCraftingApi
---@field world CcbWorldApi
---@field overmap CcbOvermapApi
---@field hordes CcbHordesApi
---@field messages CcbMessagesApi
---@field constants CcbConstantsApi
---@field random CcbRandomApi
---@field sound CcbSoundApi
---@field targeting CcbTargetingApi
---@field spawns CcbSpawnsApi
---@field followers CcbFollowersApi
---@field relocation CcbRelocationApi
local CcbGameApi = {}

---@param message string
function CcbGameApi.add_msg(message) end

---@return string
function CcbGameApi.player_name() end

---@return CcbPlayerSnapshot
function CcbGameApi.player_snapshot() end

---@return CcbPlayerSnapshot
function CcbGameApi.player_stats() end

---@return CcbMovementModesSnapshot
function CcbGameApi.movement_modes_snapshot() end

---@return CcbTimeSnapshot
function CcbGameApi.time_snapshot() end

---@return CcbWeatherSnapshot
function CcbGameApi.weather_snapshot() end

---@param limit? integer
---@return CcbBoundedItemList
function CcbGameApi.inventory_snapshot(limit) end

---@param limit? integer
---@return table
function CcbGameApi.effects_snapshot(limit) end

---@param limit? integer
---@return table
function CcbGameApi.skills_snapshot(limit) end

---@param limit? integer
---@return table
function CcbGameApi.equipment_snapshot(limit) end

---@param uid integer
---@param limit? integer
---@return table
function CcbGameApi.item_contents_snapshot(uid, limit) end

---@param field_limit? integer
---@return table
function CcbGameApi.current_tile_snapshot(field_limit) end

---@param limit? integer
---@return table
function CcbGameApi.mutations_snapshot(limit) end

---@param limit? integer
---@return table
function CcbGameApi.bionics_snapshot(limit) end

---@param limit? integer
---@return table
function CcbGameApi.missions_snapshot(limit) end

---@param backlog_limit? integer
---@return table
function CcbGameApi.activity_snapshot(backlog_limit) end

---@param radius? integer
---@param limit? integer
---@return table
function CcbGameApi.nearby_creatures_snapshot(radius, limit) end

---@return CcbRuntimeStatus
function CcbGameApi.runtime_status() end

---@return CcbBindingDomain[]
function CcbGameApi.api_catalog() end

---@param domain string
---@return boolean
function CcbGameApi.api_supports(domain) end

---@generic T: CcbScalar
---@param key string
---@param default T
---@return T
function CcbGameApi.state_get(key, default) end

---@param key string
---@param value CcbScalar|nil
function CcbGameApi.state_set(key, value) end

---@type CcbUiApi
ui = {}

---@type CcbEventsApi
events = {}

---@type CcbSchedulerApi
scheduler = {}

---@type CcbServicesApi
services = {}

---@type CcbModulesApi
modules = {}

---@type CcbRegistryApi
registry = {}

---@type CcbI18nApi
i18n = {}

---@type CcbStateApi
state = {}

---@type CcbGameApi
game = {}

---@type CcbSidebarApi
sidebar = {}

---@type string
ccb_source_id = ""
