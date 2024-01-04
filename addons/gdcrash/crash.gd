class_name Crash extends Node

enum ExitMechanism {
	QUIT,
	SIGNAL
}

enum NotificationMechanism {
	ALERT,
	SIGNAL
}

var exit_mechanism: ExitMechanism = ExitMechanism.QUIT
var notification_mechanism: NotificationMechanism = NotificationMechanism.ALERT
signal on_crash

func crash(error_message: String):
	_notify(error_message)
	_exit()

func _notify(error_message: String):
	if notification_mechanism == NotificationMechanism.SIGNAL:
		on_crash.emit(error_message)
	else:
		var log_path = ProjectSettings.globalize_path(ProjectSettings.get_setting("debug/file_logging/log_path"))
		OS.alert(
			"Well, that's embarassing. The game just crashed.\n\nHere's what we know: %s\n\nThere may also be some additional clues in the log file located at %s."%[
				error_message,
				log_path
			],
			"Game crash"
		)

func _exit():
	if exit_mechanism == ExitMechanism.QUIT:
		get_tree().quit(1)
	else:
		get_tree().root.propagate_notification(NOTIFICATION_WM_CLOSE_REQUEST)

const AUTOLOAD_NAME = "CrashHandlerService"

static func get_service(requester: Node) -> Crash:
	return requester.get_tree().get_root().get_node(AUTOLOAD_NAME)

static func now(requester: Node, error_message: String):
	Crash.get_service(requester).crash(error_message)
