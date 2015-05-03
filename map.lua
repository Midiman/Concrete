Class		= require "lib.hump.class"
GameState	= require "lib.hump.gamestate"
bump		= require "lib.bump.bump"
sti			= require "lib.sti"

--
Entity		= require "entities.entity"
Block		= require "entities.block"
Player		= require "entities.player"
--

Map = Class {
	init = function(self, width, height)
		self.size = { w = width, h = height }
		self.camera = nil
		self.world = bump.newWorld()
		--
		self.entities = {}
		self.players = {}
		self:addEntities()
		self:addPlayers()
	end,
	--
	addEntities = function(self)
		for i=1,128 do
			local _x = 32 * (i-1) 
			local _y = 480
			
			self.entities[#self.entities+1] = Block(self.world,_x,_y,32,32)
		end
	end,
	addPlayers = function(self)
		for i=1,1 do
			local _x = 128 + math.random(0,960)
			local _y = 240-64
			self.players[#self.players+1] = Player(self.world,_x,_y)
		end
	end,
	getEntitiesInRect = function(self,x,y,w,h)
		local ents = {}
		for i, e in ipairs(self.entities) do
			local _x, _y = e:getPosition()
			if _x > x and _x <= (x+w)
			and _y > y and _y <= (y+h)
			then
				ents[#ents+1] = e
			end
		end
		return ents
	end,
	--
	update = function(self,dt)
		for i, p in ipairs(self.players) do
			p:update(dt)
		end
		for i, e in ipairs(self.entities) do
			e:update(dt)
		end
	end,
	draw = function(self)
		for i, p in ipairs(self.players) do
			p:draw()
		end
		for i, e in ipairs(self.entities) do
			e:draw()
		end
	end
}

return Map
