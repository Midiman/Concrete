GameState	= require "lib.hump.gamestate"
bump		= require "lib.bump.bump"
sti			= require "lib.sti"

Map			= require "map"

local state = {}

function state:enter(state)
	love.graphics.setBackgroundColor(80,16,80)
	self.uptime = 0
	self.map = Map(1024,1024)
	self._ents = {}
end

function state:keyreleased(key, unicode)

end

function state:update(dt)
	self.uptime = self.uptime + dt
	self.dt = dt
	
	self.map:update(dt)
	self._ents = self.map:getEntitiesInRect( 400, 400, 400, 400 )
end

function state:draw()
	self.map:draw()
	--
	love.graphics.print(string.format("%02.2f",self.uptime), SCREEN_RIGHT - 64, SCREEN_TOP + 16)
	love.graphics.print(string.format("(%04i,%04i)", self.map.players[1].velocity.x, self.map.players[1].velocity.y ), SCREEN_RIGHT - 64, SCREEN_TOP + 32)
	love.graphics.print(string.format("%i",#self._ents), SCREEN_RIGHT - 64, SCREEN_TOP + 48)
end

return state
