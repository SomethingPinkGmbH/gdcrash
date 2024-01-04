@tool
class_name CrashEditorPlugin
extends EditorPlugin

func _enter_tree():
	add_autoload_singleton(Crash.AUTOLOAD_NAME, "res://addons/gdcrash/crash.gd")

func _exit_tree():
	remove_autoload_singleton(Crash.AUTOLOAD_NAME)
