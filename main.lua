Gamestate = require "lib.hump.gamestate"

--

content = {}
content.fonts = {}

game = {}
game.time = 0
game.focused = nil

GRAVITY = 9.8 * 1.65

SCREEN_LEFT = nil
SCREEN_RIGHT = nil
SCREEN_TOP = nil
SCREEN_BOTTOM = nil
SCREEN_CENTER_X = nil
SCREEN_CENTER_Y = nil
SCREEN_WIDTH = nil
SCREEN_HEIGHT = nil

function love.load()
	-- Globals
	SCREEN_LEFT = 0
	SCREEN_RIGHT = love.graphics.getWidth()
	SCREEN_TOP = 0
	SCREEN_BOTTOM = love.graphics.getHeight()
	SCREEN_CENTER_X = SCREEN_RIGHT / 2
	SCREEN_CENTER_Y = SCREEN_BOTTOM / 2
	SCREEN_WIDTH = love.graphics.getWidth()
	SCREEN_HEIGHT = love.graphics.getHeight()
	--
	love.graphics.setBackgroundColor(0,0,0)
	--
	content.fonts["normal"]	= love.graphics.newFont("data/fonts/OpenSans-Semibold.ttf",24)
	content.fonts["small"]	= love.graphics.newFont("data/fonts/OpenSans-Semibold.ttf",16)
	love.graphics.setFont(content.fonts["normal"])
	--
	Gamestate.registerEvents()
	
	local initState = require("states/game2")
	Gamestate.switch(initState)
end

function love.mousepressed(x, y, button)
	--print( string.format("MousePressed %s at [%3i,%3i]", button, x, y) )
end

function love.mousereleased(x, y, button)
	--print( string.format("MouseReleased %s at [%3i,%3i]", button, x, y) )
end

function love.keypressed(key, unicode)
	--print( string.format("KeyPressed %s [%i]", key, unicode) )
end

function love.keyreleased(key)
	--print( string.format("KeyReleased %s", key) )

	-- Quit that mess
	if key == "escape" then 
		love.event.push("quit")
	end
end

function love.update(dt)
	game.time = game.time + dt
end

function love.draw()
	love.graphics.setFont( content.fonts["small"] )
	love.graphics.print( love.timer.getFPS(), SCREEN_LEFT, SCREEN_TOP )
end

function love.focus(f)
	game.focused = f
end

function love.quit()
	
end

