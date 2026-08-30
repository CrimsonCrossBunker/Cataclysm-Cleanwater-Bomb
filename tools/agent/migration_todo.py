"""Shared taxonomy and records for Lua-first migration TODOs.

This module intentionally has no repository or generator dependencies.  The
migrator and the ledger tooling use the same closed category vocabulary while
keeping the generated ledger itself separate from migration output.
"""

from __future__ import annotations

from dataclasses import dataclass
from typing import Final, Literal


TodoCategory = Literal[
    "auto_fix",
    "manual_rewrite",
    "platform_gap",
    "semantic_choice",
]

TODO_CATEGORIES: Final[tuple[TodoCategory, ...]] = (
    "auto_fix",
    "manual_rewrite",
    "platform_gap",
    "semantic_choice",
)

TODO_CLASSIFICATIONS: Final[dict[TodoCategory, dict[str, object]]] = {
    "auto_fix": {
        "platform_core_input": False,
        "definition": (
            "The required Platform API already exists, but the migrator does "
            "not yet emit the correct Lua for this concrete shape."
        ),
    },
    "manual_rewrite": {
        "platform_core_input": False,
        "definition": (
            "The behavior should be rewritten with ordinary Lua control flow "
            "and existing domain services."
        ),
    },
    "platform_gap": {
        "platform_core_input": True,
        "definition": (
            "A reusable typed Platform service, registrar, or lifecycle "
            "boundary required by this shape does not exist."
        ),
    },
    "semantic_choice": {
        "platform_core_input": False,
        "definition": (
            "More than one intentional behavior is possible and a content "
            "author must choose the desired Lua design."
        ),
    },
}


def validate_todo_category(category: object) -> TodoCategory:
    """Validate an explicit category; omitted categories are never inferred."""
    if category not in TODO_CATEGORIES:
        raise ValueError(f"unknown migration TODO classification: {category}")
    return category  # type: ignore[return-value]


@dataclass(frozen=True)
class MigrationTodo:
    """One actionable migration record with an explicit source location."""

    category: TodoCategory
    location: str
    message: str

    def __post_init__(self) -> None:
        validate_todo_category(self.category)
        if not isinstance(self.location, str) or not self.location:
            raise ValueError(
                "migration TODO location must be a non-empty string"
            )
        if not isinstance(self.message, str) or not self.message:
            raise ValueError(
                "migration TODO message must be a non-empty string"
            )

    @classmethod
    def from_rendered(
        cls, category: TodoCategory, rendered: str
    ) -> "MigrationTodo":
        """Build a record from legacy ``location: message`` text."""
        if not isinstance(rendered, str):
            raise TypeError("migration TODO text must be a string")
        location, separator, message = rendered.partition(": ")
        if not separator:
            raise ValueError(
                "migration TODO text must contain a source location and "
                "message"
            )
        return cls(category, location, message)

    @property
    def platform_core_input(self) -> bool:
        """Whether this record is an input to Platform core backlog work."""
        return self.category == "platform_gap"

    @property
    def text(self) -> str:
        """Legacy human-readable form for report/test compatibility."""
        return f"{self.location}: {self.message}"

    def __str__(self) -> str:
        return self.text

    def __contains__(self, value: str) -> bool:
        return value in self.text

    def startswith(self, prefix: str | tuple[str, ...]) -> bool:
        return self.text.startswith(prefix)

    def endswith(self, suffix: str | tuple[str, ...]) -> bool:
        return self.text.endswith(suffix)


@dataclass(frozen=True)
class MigrationBoundary:
    """A non-actionable source/safety boundary kept out of TODO work."""

    location: str
    message: str

    def __post_init__(self) -> None:
        if not isinstance(self.location, str) or not self.location:
            raise ValueError(
                "migration boundary location must be a non-empty string"
            )
        if not isinstance(self.message, str) or not self.message:
            raise ValueError(
                "migration boundary message must be a non-empty string"
            )

    @property
    def text(self) -> str:
        return f"{self.location}: {self.message}"

    def __str__(self) -> str:
        return self.text

    def __contains__(self, value: str) -> bool:
        return value in self.text
