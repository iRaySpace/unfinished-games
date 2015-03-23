require "Tserial"

local GAME_WIDTH = 0
local GAME_HEIGHT = 0

function love.load()

	-- Getting the screen dimensions
	GAME_WIDTH, GAME_HEIGHT = love.graphics.getDimensions()

	-- Box
	box =  {}
	box.x = 100
	box.y = 0
	box.width = 35
	box.height = 35
	box.velocity = {}
	box.velocity.x = 0
	box.velocity.y = 0
	box.acceleration = {}
	box.acceleration.x = 0
	box.acceleration.y = 50

	-- Tubes
	tubeOne = {}
	tubeOne.x = 400
	tubeOne.y = 0
	tubeOne.width = 100
	tubeOne.height = 300
	tubeOne.collide = false

	tubeTwo = {}
	tubeTwo.x = 400
	tubeTwo.y = 450
	tubeTwo.width = 100
	tubeTwo.height = 300
	tubeTwo.collide = false

	tubeThree = {}
	tubeThree.x = 700
	tubeThree.y = -150
	tubeThree.width = 100
	tubeThree.height = 300
	tubeThree.collide = false

	tubeFour = {}
	tubeFour.x = 700
	tubeFour.y = 300
	tubeFour.width = 100
	tubeFour.height = 300
	tubeFour.collide = false
	
	tubeFive = {}
	tubeFive.x = 100
	tubeFive.y = -50
	tubeFive.width = 100
	tubeFive.height = 300
	tubeFive.collide = false

	tubeSix = {}
	tubeSix.x = 100
	tubeSix.y = 400
	tubeSix.width = 100
	tubeSix.height = 300
	tubeSix.collide = false


	-- making tubes table
	tubes = {}
	tubes.velocity = {}
	tubes.velocity.x = -200

	-- adding tube to tubes table
	table.insert(tubes, tubeOne)
	table.insert(tubes, tubeTwo)
	table.insert(tubes, tubeThree)
	table.insert(tubes, tubeFour)
	table.insert(tubes, tubeFive)
	table.insert(tubes, tubeSix)

	player = {}
	player.score = 0

end

function love.draw()

	-- Box
	love.graphics.rectangle("fill", box.x, box.y, box.width, box.height)


	-- prints collide if a specific tube has collide enabled
	for k, v in ipairs(tubes) do

		if(v.collide) then love.graphics.print("Collide.", 320, 320) end
		love.graphics.rectangle("fill", v.x, v.y, v.width, v.height)

	end

end

function love.update(dt)

	-- Add
	box.x = box.x + box.velocity.x * dt
	box.y = box.y + box.velocity.y * dt

	-- Reset
	box.velocity.x = 0
	box.velocity.y = box.velocity.y + box.acceleration.y

	for k, v in ipairs(tubes) do
		-- checks collision for the specific tube and object
		if(checkCollision(box.x, box.y, box.width, box.height, v.x, v.y, v.width, v.height)) 
		then v.collide = true
			 player.score = player.score + 1
		else v.collide = false
		end

		v.x = v.x + tubes.velocity.x * dt
		-- if tube is utmost at the left hand
		-- get it back to the right
		if(v.x + v.width < 0)
		then v.x = GAME_WIDTH
		end

	end

	-- limits the player
	if box.y < 0 then box.y = 0 end

end

-- function that checks for collision
function checkCollision(x1, y1, w1, h1, x2, y2, w2, h2)

	return x1 < x2 + w2 and
		   x2 < x1 + w1 and
		   y1 < y2 + h2 and
		   y2 < y1 + h1

end

-- this is called everytime love updates
function love.keypressed(key)

	if key == "up" and box.y - box.height > 0 then box.velocity.y = -600 end

	--[[
	if key == "down" then 

		local filename = "game.sav"

		love.filesystem.write(filename, Tserial.pack(player))

	end

	if key == "left" then

		loaded = Tserial.unpack(love.filesystem.read("game.sav"))

	end
	]]--

end