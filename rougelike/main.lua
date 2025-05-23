function love.load()
  difficulty = 1
  
  projectiles = {}
  badguys = {}
  
  projectilemanager = require("ingame/projectilemanager")
  playermanager = require("ingame/playermanager")
  enemymanager = require("ingame/enemymanager")
  guimanager = require("ingame/guimanager")
  
  wid, hei = love.graphics.getWidth(), love.graphics.getHeight()
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
end

function love.update()
  difficulty = difficulty + 0.001
  projectilemanager.tick()
  playermanager.tick()
  enemymanager.tick()
  
  enemytick = enemytick - 1
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
  if reloadingtime <= 0 and love.mouse.isDown(1) then
    local mx, my = love.mouse.getPosition()
    
    reloadingtime = 10
    
    local pdx = playerpos["x"]-mx
    local pdy = playerpos["y"]-my
    local rot = math.atan2(pdx, pdy)
  
    projectilemanager.create("plr", playerpos["x"], playerpos["y"], math.sin(rot)*bulletspeed, math.cos(rot)*bulletspeed, bulletdamage)
  end
end

function love.draw()
  guimanager.draw()
  playermanager.draw()
  projectilemanager.draw()
  enemymanager.draw()
  love.graphics.print("HP: "..playerhealth, 20, 20)
  love.graphics.print("ET: "..enemytick, 20, 40)
  love.graphics.print("DF: "..difficulty, 20, 60)
  love.graphics.print("EXP: "..exp, 20, 100)
  love.graphics.print("LVL: "..level, 20, 120)
end

function love.mousepressed(...)
  if spendingmoneys > 0 then
    guimanager.mousepressed(...)
  end
end