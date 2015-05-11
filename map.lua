Class		= require "lib.hump.class"
GameState	= require "lib.hump.gamestate"
Camera		= require "lib.hump.camera"
bump		= require "lib.bump.bump"
sti			= require "lib.sti"

--
Entity		= require "entities.entity"
Block		= require "entities.block"
Enemy		= require "entities.enemy"
Player		= require "entities.player"
--

Map = Class {
	init = function(self, width, height)
		self.size = { w = width, h = height }
		self.camera = Camera(0,0)
		self.cameraBounds = { x = SCREEN_CENTER_X, y = SCREEN_CENTER_Y, w = width, h = height }
		self.world = bump.newWorld()
		--
		self.entities = {}
		self.players = {}
		self:addEntities()
		self:addPlayers()
		self:addEnemies()
		--
	end,
	--
	addEntity = function(self, e, x, y, w, h)
		table.insert( self.entities, e ) 
	end,
	removeEntity = function(self, e)
		for i, e in ipairs(self.entities) do
			if self.world:hasItem(self.entities[i]) then 
				table.remove(self.entities, i)
			end
		end
	end,
	addEntities = function(self)
		for i=1,128 do
			local _x = 32 * (i-1) 
			local _y = 480
			local e = Block(self.world,_x,_y,32,32)
			
			self:addEntity(e)
		end
	end,
	addPlayers = function(self)
		for i=1,1 do
			local _x = 128 + math.random(0,960)
			local _y = 240-64
			local e = Player(self.world,_x,_y)

			table.insert( self.players, e )
		end
	end,
	addEnemies = function(self)
		for i=1,2 do
			local _x = 800 + math.random(0,320)
			local _y = 432
			self.entities[#self.entities+1] = Enemy(self.world,_x,_y)
		end
	end,
	pruneDeadEntities = function(self)
		for i, e in ipairs(self.entities) do
			if e.isDestroyed then
				table.remove(self.entities, i)
			end
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
	moveCameraWithBounds = function(self, dt)
		local _x, _y = self.players[1]:getPosition()
		self.camera:lookAt(
			math.min(math.max(self.cameraBounds.x, _x), self.cameraBounds.w),
			math.min(math.max(self.cameraBounds.y, _y), self.cameraBounds.h))
	end,
	--
	update = function(self,dt)
		for i, p in ipairs(self.players) do
			p:update(dt)
		end
		for i, e in ipairs(self.entities) do
			e:update(dt)
		end

		self:pruneDeadEntities()
		self:moveCameraWithBounds(dt)
	end,
	draw = function(self)
		self.camera:attach()
		
		for i, p in ipairs(self.players) do
			p:draw()
		end
		for i, e in ipairs(self.entities) do
			e:draw()
		end

		self.camera:detach()
	end
}

return Map
