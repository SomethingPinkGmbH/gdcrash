# Last-resort crash handler for Godot

This library adds a last-resort handler that presents the user with a useful error message in case of an unrecoverable
error.

## Usage

```gdscript
extends Node

func _ready():
    Crash.now(self, "Something bad happened.")
```
