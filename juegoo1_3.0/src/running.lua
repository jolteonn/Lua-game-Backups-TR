
playerTeleported = false

local textou = 'txt'
local map1 = require "src/map1"
local battle = require "src/battle"

mapChange = require 'src/stateManager'


     require "src/player"
  
     world:addCollisionClass('player')
     player.collider:setCollisionClass('player')
     player.collider:setCollisionClass('solid')
     world:addCollisionClass("door")


     local inmap = 'inmap1'
     if game.state.map1 then
      inmap = 'inmap1'
      textt = 'in map 1'
     elseif game.state.map2 then
      inmap = 'inmap2'
      textt = 'in map 2'
     end

    --  player.collider:setCollisionClass(inmap)
     -----------------NPCS--------------------------
     -----classes---------------
     world:addCollisionClass("npc")
     world:addCollisionClass("enemy")
     world:addCollisionClass("bird")
     world:addCollisionClass("npc3")
     world:addCollisionClass("wall")

    -----npc colliders----------------     
    mp1 = {}
    mp1.npc1 = world:newRectangleCollider(400, 300, 35, 60)
    mp1.enemy = world:newRectangleCollider(900, 400, 35, 60)
    mp1.door1 = world:newRectangleCollider(900, 1900, 400, 50)
    mp1.npc3 = world:newRectangleCollider(500, 600, 36, 60)
    mp1.npc3:setType('static')
    mp1.pajaro = world:newRectangleCollider(200, 300, 36, 60)
    
   -----set tipo y classe------

   for key, collider in pairs(mp1) do
    collider:setType('static')
  end

  mp1.npc1:setCollisionClass('npc')
  mp1.enemy:setCollisionClass('enemy')
  mp1.pajaro:setCollisionClass('bird')
  mp1.door1:setCollisionClass('door')
    ------------------------------------------------
    

  local npcCreator = require "src/npc_creator"
  local boxx = love.graphics.newImage("dialogbox1.png")
  

------------DIALOGOS-------------------------------------------------
local alien_name = "alien"
local alien_d1 = "holaholaa no se q poner xd\n \n esta es la segunda linea ya se como hacer parrafos xd"
local alien_d2 = "holaesta es la pagina 2"
local alien_d3 = "holaesta es la pagina 33333333333"

local bird_name = "bird"

-----------------------------------------------------------------------

local primero = "texto 1"
local segundo = "texto 2"
local tercero = "texto 3"
local cuarto = "texto 4"


local dialog1 = dialog.new(boxx, primero, segundo, tercero)

local bird_d1 = "olaola aaaaaaaa"



function updateRunning(dt)




    playerupdate(dt)
  world:update(dt)
    cam:lookAt(player.x, player.y)
   player.anim:update(dt)  

if player.collider:enter("npc") then
  dialogEvent = true
  npcCollide = true
  dialog1:updateText("NPC", "this is not bird", alien_d3, alien_d1)
end

if player.collider:exit("npc") then
  dialogEvent = false
  onScreen = false
 end

 -------- cambios de mapa doors------ COLLIDER DESTROY
 if player.collider:enter("door") then  
  playerTeleported = true
   if playerTeleported then
     player.x = 250
     player.y = 250
     player.collider:setPosition(player.x, player.y)
   end  
  map:changeGameState("map2")    
  for key, collider in pairs(mp1) do
    collider:destroy()
end
  for key, collider in pairs(cl) do
    collider:destroy()
end
end

---- ADD MAP2 COLLIDERS
if player.collider:enter("door") then
  if map.state.map1 then
   wallState = 'solid'
    solidST = 'solid'   -- no tiene relevancia ?? npc3 funciona igual si es solid o ghost
     mp1.npc3:setCollisionClass(solidST)
  elseif map.state.map2 then
    wallState = 'ghost'
    solidST = 'ghost'
     mp1.npc3:setCollisionClass(solidST)

  end
end
-----

--CHEKIF---(DELETE LATER)
if solidST == 'solid' then 
  textou = 'solidod'
elseif solidST == 'ghost' then
  textou = 'ghosostos'
end



if player.collider:enter("enemy") then
  --DESTROY COLLIDERS MAPA ANTERIOR
  mp1.enemy:destroy()
  mp1.door1:destroy()

  map:changeGameState("battle")
  --map:changeGameState('map1')

end



if player.collider:enter("bird") then
  dialogEvent = true
  onScreen = true
  bird_ = true
  primero = "pajroo"
  segundo = bird_d1
  dialog1:updateText("Bird", "I am bird", "hello", "bye", "xd")
  end

if player.collider:exit("bird") then
  dialogEvent = false
  onScreen = false
  bird_ = false
  end

--eliminar
   if player.collider:enter("npc3") then
    solidST = 'ghost'
   end
   if player.collider:enter("wall") then
    wallState = 'ghost'
   end
  end



function drawRunning()

cam:attach()
if map.state.map1 then
  drawMap1()

elseif map.state.map2 then
  drawMap2()
 
end

if finish then 
  drawMap1()
end

dialog1:update()

world:draw()
  playerdraw()
cam:detach()
love.graphics.print(textou)

if onScreen then
  dialog1:show(50, 450)
end

end