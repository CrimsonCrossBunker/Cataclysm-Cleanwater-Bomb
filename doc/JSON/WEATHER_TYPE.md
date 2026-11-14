<!-- CCB-DOC-MOVED-START -->
> [!IMPORTANT] **Migration in progress / 迁移中**
>
> Stable document ID / 稳定文档 ID: `json.weather-types`
> 中文: https://crimsoncrossbunker.github.io/CCB-Docs/reference/json/weather-types/
> English: https://crimsoncrossbunker.github.io/CCB-Docs/en/reference/json/weather-types/
> Migration start date / 开始迁移日期: `2026-08-02`
> Source commit referenced by the last migration record / 上次迁移记录参考 commit: `0378ca2b84303cf614c617c9d9eaa50138cd21ff`
> CCB-Docs is still a work in progress; the links above are migration targets.
> CCB-Docs 仍在整理中；上方链接为迁移目标。
> Updates to this in-repository body are optional for now, and no comprehensive revision is currently planned. Developers may update it as needed. Some content has not been checked against the current CCB implementation; consult the relevant source code when using or updating it. Documentation may be updated alongside new or changed features. The retained body will serve as a reference for later documentation migration and reorganization, which may rewrite or omit the original text.
> 本仓库正文暂不列入必须更新项，暂不安排全面整理，是否更新由开发者按实际需要决定。部分内容尚未按当前 CCB 实现核实，使用和更新时应检查相关源码。新增或改动功能时，可同步更新相关文档。保留正文将作为后续文档迁移与整理的参考来源，后续整理不保证原文保留。
<!-- CCB-DOC-MOVED-END -->
# Weather Types

Each weather type is a type of weather that occurs, and what causes it. The only required entries are null and clear.

## `weather_type` properties

|      Identifier      |                                           Description                                            |
| -------------------- | ------------------------------------------------------------------------------------------------ |
| `name`               | UI name of weather type.                                                                         |
| `id`                 | Unique string for this weather type.                                                             |
| `color`              | UI color of weather type.                                                                        |
| `map_color`          | Map color of weather type.                                                                       |
| `sym`                | Map glyph of weather type.                                                                       |
| `ranged_penalty`     | Penalty to ranged attacks.                                                                       |
| `sight_penalty`      | Penalty to per-square visibility, applied in transparency map.                                   |
| `light_modifier`     | modification to ambient light.                                                                   |
| `temperature_modifier` | additive modifier to ambient temperature above ground.                                         |
| `sound_attn`         | Sound attenuation of a given weather type.                                                       |
| `dangerous`          | If true, our activity gets interrupted.                                                          |
| `precip`             | Amount of associated precipitation. Valid values are: none, very_light, light and heavy          |
| `rains`              | Whether said precipitation falls as rain.                                                        |
| `light_multiplier`   | Optional, multiplication to ambient light. Multiplication occurs before `light_modifier`.        |
| `tiles_animation`    | Optional, name of the tiles animation to use                                                     |
| `debug_cause_eoc`    | Optional, id of effect_on_condition to be run when the debug menu selects this weather.          |
| `debug_leave_eoc`    | Optional, id of effect_on_condition to be run when the debug menu is used to leave this weather. |
| `sound_category`     | Optional, what sound effect to play. Valid values are: silent, drizzle, rainy, thunder, flurries, snowstorm and snow. |
| `duration_min`       | Optional, the lower bound on the amount of time this weather can last. Defaults to 5 minutes.    |
| `duration_max`       | Optional, the upper bound on the amount of time this weather can last. Defaults to 5 minutes.    |
| `weather_animation`  | Optional, Information controlling weather animations.  Members: factor, color and glyph          |
| `sun_multiplier`     | Optional, multiplier to radiation from sun. Affects energy output of solar panels.               |
| `condition`          | A dialog condition to determine if this weather is happening.  See Dialogue conditions section of [NPCs](NPCs.md) A context variable of `weather_location` contains the location of the current tile checking its weather.  This can be used to have weather be based on location. |
| `priority`           | An integer.  If the condition of multiple weather types are true the one with higher priority wins. |
| `required_weathers`  | A string array of possible weathers, it is at this point in the loop. i.e. rain can only happen if the conditions for clouds light drizzle or drizzle are present.  Required weathers need to have lower load orders to be. |
| `passive_effects`    | Passive effects, that will be applied on character when this weather occurs; for detailed syntax, see [field_effect](JSON_INFO.md#field_effect) |

#### `weather_type` example

```jsonc
[
  {
    "id": "lightning",
    "type": "weather_type",
    "name": "Lightning Storm",
    "color": "c_yellow",
    "map_color": "h_yellow",
    "sym": "%",
    "sun_sym": "⛈️",
    "ranged_penalty": 4,
    "sight_penalty": 1.25,
    "light_modifier": -45,
    "temperature_modifier": "-30 C",
    "sound_attn": 8,
    "dangerous": false,
    "precip": "heavy",
    "rains": true,
    "required_weathers": [ "thunder" ],
    "priority": 80,
    "condition": { "math": [ "weather('pressure') < 990" ] },
    "passive_effects": [
      {
        "effect_id": "smoke_eyes",
        "body_part": "eyes",
        "intensity": 1,
        "min_duration": "2 seconds",
        "max_duration": "2 seconds",
        "immunity_data": { "body_part_env_resistance": [ [ "sensor", 3 ] ] },
        "immune_inside_vehicle": true
      },
      {
        "effect_id": "smoke_lungs",
        "body_part": "mouth",
        "intensity": 1,
        "min_duration": "2 seconds",
        "max_duration": "2 seconds",
        "immunity_data": { "body_part_env_resistance": [ [ "mouth", 3 ] ], "flags": [ "INHALED_TOXIN_IMMUNE" ] },
        "immune_inside_vehicle": true
      }
    ]
  }
]
