extends GutTest

var close_request = false

func test_crash():
	get_tree().set_auto_accept_quit(false)

	var crash_service = Crash.get_service(self)
	crash_service.exit_mechanism = Crash.ExitMechanism.SIGNAL
	crash_service.notification_mechanism = Crash.NotificationMechanism.SIGNAL
	watch_signals(crash_service)
	Crash.now(self, "Something bad happened!")

	assert_eq(close_request, true)
	assert_signal_emitted(crash_service, "on_crash")

func _notification(what):
	if what == NOTIFICATION_WM_CLOSE_REQUEST:
		close_request = true
