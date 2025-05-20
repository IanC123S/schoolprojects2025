function love.load()
  difficulty = 1
  
  projectilemanager = require("ingame/projectilemanager")
  playermanager = require("ingame/playermanager")
  
  wid, hei = love.graphics.getWidth(), love.graphics.getHeight()
  playerpos = {["x"]=wid/2,["y"]=hei/2}
  playerhealth = 100
end

function love.update()
  difficulty = difficulty + 0.01
  projectilemanager.tick()
  playermanager.tick()
end

function love.draw()
  playermanager.draw()
end
