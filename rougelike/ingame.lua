local game = {}

function game.load()
  difficulty = 1
  
  projectiles = {}
  badguys = {}
  
  backgroundmanager = require("ingame/backgroundmanager")
  projectilemanager = require("ingame/projectilemanager")
  playermanager = require("ingame/playermanager")
  enemymanager = require("ingame/enemymanager")
  guimanager = require("ingame/guimanager")
  
  alive = true
  
  playerpos = {["x"]=wid/2,["y"]=hei/2}
  playerhealth = 100
  
  exp = 0
  level = 0
  
  reqexp = 20
  spendingmoneys = 0
  
  speed = 3
  bulletspeed = 3
  bulletdamage = 5
  
  firerate = 3
  reloadingtime = 1
  
  enemytick = 100
  enemymanager.create()
  
  bosstick = 1000
end

function game.update()
  if not alive and transitionalpha > 1 then
    currentpageselected = require("title")
    currentpageselected.load()
  end
  
  if not badguys["boss"] then
    enemytick = enemytick - 1
    difficulty = difficulty + 0.001
    bosstick = bosstick+1
    if bosstick == 10000 then
      bosstick = 0
      enemymanager.createboss()
    end
  end
  projectilemanager.tick()
  playermanager.tick()
  enemymanager.tick()
  
  if enemytick < 0 then
    enemytick = 100
    enemymanager.create()
  end
  if exp >= reqexp then
    spendingmoneys = spendingmoneys + 1
    exp = 0
    level = level + 1
    reqexp = reqexp*1.5
    playerhealth = playerhealth + 20
  end
  
  reloadingtime = reloadingtime-(firerate*.1)
  if alive then
    if reloadingtime <= 0 and love.mouse.isDown(1) then
      local mx, my = love.mouse.getPosition()
      
      reloadingtime = 10
      
      local pdx = playerpos["x"]-mx
      local pdy = playerpos["y"]-my
      local rot = math.atan2(pdx, pdy)
    
      projectilemanager.create("plr", playerpos["x"], playerpos["y"], math.sin(rot)*bulletspeed, math.cos(rot)*bulletspeed, bulletdamage)
    end 
  end
end

function game.draw()
  backgroundmanager.draw()
  projectilemanager.draw()
  playermanager.draw()
  enemymanager.draw()
  guimanager.draw()
end

function game.mousepressed(...)
    guimanager.mousepressed(...)
end

return game