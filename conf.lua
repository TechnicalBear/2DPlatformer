function love.conf(t)
	t.modules.joystick = true
	t.modules.audio = true
	t.modules.keyboard = true
	t.modules.event = true
	t.modules.image = true
	t.modules.graphics = true
	t.modules.timer = true
	t.modules.mouse = true
	t.modules.sound = true
	t.modules.thread = true
	t.modules.physics = true
	t.console = true
	t.title = "Platformer"
	t.author = "Bearz"
	t.window.fullscreen = false
	t.window.vsync = false
	t.window.height = 600
	t.window.width = 800
end