#!/usr/bin/env python3
"""Summarize a fixed action sequence from accepted Tracy CPU-zone CSV exports.

Export each relevant zone family with tracy-csvexport -u -f FILTER TRACE.
This reports elapsed scope time, including preemption, rather than CPU usage.
Input acquisition includes animation, drawing, polling and waiting. Commands
may open interactive menus even after action execution starts. This analyzer
never interprets either scope as pure simulation or pure off-CPU waiting.
"""

import argparse
import csv
import json
import statistics
from dataclasses import dataclass
from pathlib import Path


@dataclass(frozen=True)
class Event:
    name: str
    start: int
    duration: int
    thread: str
    value: str = ""

    @property
    def end(self):
        return self.start + self.duration


def read_events(paths):
    required = {"name", "ns_since_start", "exec_time_ns", "thread", "value"}
    events = []
    seen = set()
    for path in paths:
        with Path(path).open(newline="", encoding="utf-8") as stream:
            reader = csv.DictReader(stream)
            if not required.issubset(reader.fieldnames or []):
                raise ValueError(f"{path}: missing Tracy CPU-zone columns")
            for line, row in enumerate(reader, 2):
                if None in row or any(row.get(key) is None for key in required):
                    raise ValueError(f"{path}:{line}: malformed CSV row")
                event = Event(row["name"], int(row["ns_since_start"]),
                              int(row["exec_time_ns"]), row["thread"], row["value"])
                if event.start < 0 or event.duration < 0 or not event.thread:
                    raise ValueError(f"{path}:{line}: invalid event interval or thread")
                if event in seen:
                    raise ValueError(f"{path}:{line}: duplicate event; overlapping export filters?")
                seen.add(event)
                events.append(event)
    return events


def merged(intervals):
    result = []
    for start, end in sorted(intervals):
        if end <= start:
            continue
        if result and start <= result[-1][1]:
            result[-1] = (result[-1][0], max(end, result[-1][1]))
        else:
            result.append((start, end))
    return result


def span(intervals):
    return sum(end - start for start, end in merged(intervals))


def intersection(left, right):
    a, b = merged(left), merged(right)
    result = []
    i = j = 0
    while i < len(a) and j < len(b):
        start, end = max(a[i][0], b[j][0]), min(a[i][1], b[j][1])
        if end > start:
            result.append((start, end))
        if a[i][1] < b[j][1]:
            i += 1
        else:
            j += 1
    return merged(result)


def completed_turns(events, actions):
    """Require one main-thread suffix and monster update after each action.

    This is opt-in for fixed pause sequences. Movement at unusual speeds and
    long activities do not have a one-action/one-turn contract.
    """
    thread = actions[0].thread
    suffixes = [e for e in events if e.name == "simulate_turn_suffix" and e.thread == thread]
    monsters = [e for e in events if e.name == "monmove" and e.thread == thread]
    turns = []
    for index, action in enumerate(actions):
        boundary = actions[index + 1].start if index + 1 < len(actions) else float("inf")
        following = [e for e in suffixes if action.end <= e.start < boundary]
        if len(following) != 1 or following[0].end > boundary:
            raise ValueError(f"action {index + 1}: expected exactly one completed turn suffix")
        suffix = following[0]
        updates = [e for e in monsters if suffix.start <= e.start < suffix.end]
        if len(updates) != 1 or updates[0].end > suffix.end:
            raise ValueError(f"action {index + 1}: expected exactly one completed monster update")
        turns.append(suffix)
    in_window = [e for e in monsters if actions[0].start <= e.start < turns[-1].end]
    if len(in_window) != len(turns):
        raise ValueError("unexpected monster update outside a selected turn suffix")
    return turns


def summarize(events, expected, action_labels, *, require_turn_per_action=False):
    if not isinstance(expected, list) or not expected or any(
            not isinstance(label, str) or not label for label in expected):
        raise ValueError("expected sequence must be a nonempty list of action labels")
    if not action_labels or any(not isinstance(label, str) or not label for label in action_labels):
        raise ValueError("action family must contain nonempty labels")
    labels = set(action_labels)
    if not set(expected).issubset(labels):
        raise ValueError("expected sequence contains a label outside the action family")
    actions = sorted((e for e in events if e.name == "game.action_execute"
                      and e.value in labels), key=lambda e: e.start)
    if [e.value for e in actions] != expected:
        raise ValueError("recorded action labels/count/order differ from the fixed sequence")
    threads = {e.thread for e in actions}
    if len(threads) != 1:
        raise ValueError("fixed sequence spans multiple Tracy threads")
    thread = actions[0].thread
    if any(a.end > b.start for a, b in zip(actions, actions[1:])):
        raise ValueError("selected action scopes overlap")
    turns = completed_turns(events, actions) if require_turn_per_action else []
    last_end = turns[-1].end if turns else actions[-1].end
    draws = [e for e in events if e.name == "tiles.draw" and e.thread == thread]
    tail = min((e for e in events if e.name in ("game.mid_step", "game.input_redraw")
                and e.thread == thread and e.start >= last_end
                and any(e.start <= draw.start and draw.end <= e.end for draw in draws)),
               key=lambda e: e.start, default=None)
    if tail is None:
        raise ValueError("no completed presentation follows the final action; incomplete capture")
    lo, hi = actions[0].start, tail.end
    ordered = sorted((e for e in events if e.name == "game.action_execute"
                      and e.thread == thread and lo <= e.start < hi),
                     key=lambda e: e.start)
    if ordered != actions:
        raise ValueError("unexpected action inside the fixed sequence window")
    main = [e for e in events if e.thread == thread and e.start < hi and e.end > lo]
    names = ("game.action_execute", "input.acquire", "game.mid_step",
             "simulate_turn_suffix", "tiles.draw", "tiles.layer_loop",
             "tiles.draw_cache_rebuild", "monmove", "game.input_redraw")
    intervals = {}
    summaries = {}
    for name in names:
        family = [e for e in main if e.name == name]
        intervals[name] = merged((max(lo, e.start), min(hi, e.end)) for e in family)
        complete = [e.duration for e in family if lo <= e.start and e.end <= hi]
        durations = sorted(complete)
        summaries[name] = {
            "overlapping_calls": len(family), "complete_calls": len(complete),
            "union_elapsed_ns": span(intervals[name]),
            "complete_call_ms": ({
                "mean": statistics.mean(durations) / 1e6,
                "median": statistics.median(durations) / 1e6,
                "p95": durations[(95 * (len(durations) - 1)) // 100] / 1e6,
                "max": max(durations) / 1e6,
            } if durations else None),
        }
    phases = names[:4]
    phase_intervals = [pair for name in phases for pair in intervals[name]]
    covered = span(phase_intervals)
    draw = intervals["tiles.draw"]
    draw_by_phase = {name: span(intersection(draw, intervals[name])) for name in phases}
    report = {
        "action_count": len(actions), "action_family": sorted(labels), "tracy_thread_id": thread,
        "window_ns": [lo, hi], "window_elapsed_ms": (hi - lo) / 1e6,
        "window_policy": ("first selected action start through first completed mid-step or input redraw containing a tile draw after "
                          + ("last completed simulation turn" if turns else "last action")),
        "presentation_tail": {"zone": tail.name, "start_ns": tail.start, "end_ns": tail.end},
        "zones": summaries, "phase_covered_elapsed_ns": covered,
        "phase_overlap_ns": sum(span(intervals[n]) for n in phases) - covered,
        "outside_named_phases_elapsed_ns": hi - lo - covered,
        "tiles_draw_inside_phase_ns": draw_by_phase,
        "tiles_draw_outside_named_phases_ns": span(draw) - span(intersection(draw, phase_intervals)),
        "limits": [
            "Elapsed scope time includes scheduler delays; this is not CPU utilization or FPS.",
            "Input acquisition includes input waiting, animations, redraws and multiplayer polling.",
            "Action execution can include menus; the fixed action sequence defines this report's scope.",
            "Nested draw/layer/cache/monster rows overlap parent phases; do not add their totals.",
            "Startup and idle tail are excluded; partial boundary scopes are clipped.",
            "Tracy thread identifiers are not operating-system thread identifiers.",
        ],
    }
    if turns:
        report["completed_turns"] = {
            "count": len(turns), "first_suffix_start_ns": turns[0].start,
            "last_suffix_end_ns": turns[-1].end,
            "policy": "one completed main-thread suffix containing one completed monmove after every selected action, before the next action",
            "limits": "Scope completion does not establish calendar advancement or save equivalence; verify the native saved state separately.",
        }
    return report


def main():
    parser = argparse.ArgumentParser(description=__doc__)
    parser.add_argument("--actions", required=True,
                        help="comma-separated complete action family, e.g. UP,DOWN")
    parser.add_argument("--sequence", type=Path, required=True,
                        help="JSON array of expected action labels in order")
    parser.add_argument("--require-turn-per-action", action="store_true",
                        help="fixed pause sequences only: require one completed simulation/monster turn per action and include its presentation tail")
    parser.add_argument("csv", nargs="+", type=Path, help="accepted unwrapped CPU-zone exports")
    args = parser.parse_args()
    try:
        report = summarize(read_events(args.csv), json.loads(args.sequence.read_text()),
                           args.actions.split(","), require_turn_per_action=args.require_turn_per_action)
    except (ValueError, OSError) as error:
        parser.error(str(error))
    print(json.dumps(report, indent=2, sort_keys=True))


if __name__ == "__main__":
    main()
