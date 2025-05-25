manager = {}

guioptions = {}
totaloptions = {"firerate", "speed", "bulletspeed", "bulletdmg"}

local images = {love.graphics.newImage("images/icons/firerate.png"), love.graphics.newImage("images/icons/speed.png"), love.graphics.newImage("images/icons/bulletspeed.png"), love.graphics.newImage("images/icons/bulletdmg.png")}

local gameover = love.graphics.newImage("images/gameover.png")
local menu = love.graphics.newImage("images/menu.png")

local function increasestat(input)
  if input == "firerate" then
    firerate = firerate + 3
  end
  if input == "speed" then
    speed = speed + .5
  end
  if input == "bulletspeed" then
    bulletspeed = bulletspeed + 2
  end
  if input == "bulletdmg" then
    bulletdamage = bulletdamage + 2
  end
  manager.reset()
end


function manager.mousepressed(mx,my,button)
  if hei-87.5 < my and my < hei-12.5 and alive and spendingmoneys > 0 then
    if wid-85 < mx and mx < wid-10 then
      spendingmoneys = spendingmoneys - 1
      increasestat(guioptions[3])
      local source = love.audio.newSource("sfx/select.wav", "static")
      love.audio.play(source)
    end
    if wid-170 < mx and mx < wid-95 then
      spendingmoneys = spendingmoneys - 1
      increasestat(guioptions[2])
      local source = love.audio.newSource("sfx/select.wav", "static")
      love.audio.play(source)
    end
    if wid-255 < mx and mx < wid-180 then
      spendingmoneys = spendingmoneys - 1
      increasestat(guioptions[1])
      local source = love.audio.newSource("sfx/select.wav", "static")
      love.audio.play(source)
    end
  end
  if not alive then
    if wid/2-75 < mx and mx < wid/2+75 and hei/3+50 < my and my < hei/3+100 then
      transitionalpha = 0
      transitionalphamodifier = 1.2
      local source = love.audio.newSource("sfx/select.wav", "static")
      love.audio.play(source)
    end
  end
end

function manager.reset()
  guioptions = {}
  for i=1,3,1 do
    guioptions[i] = totaloptions[math.random(1,4)]
  end
end
manager.reset()

function manager.draw()
  if alive then
    if spendingmoneys > 0 then
      love.graphics.draw(love.graphics.newImage("images/icons/"..guioptions[1]..".png"), wid-255, hei-87.5)
      love.graphics.draw(love.graphics.newImage("images/icons/"..guioptions[2]..".png"), wid-170, hei-87.5)
      love.graphics.draw(love.graphics.newImage("images/icons/"..guioptions[3]..".png"), wid-85, hei-87.5)
    end
    love.graphics.setColor(0,255,0)
    love.graphics.rectangle("fill", 10, hei-35, playerhealth*2, 25)
    love.graphics.setColor(255,255,0)
    love.graphics.rectangle("fill", 10, hei-55, exp/reqexp*200, 15)
    love.graphics.setColor(255,255,255)
    
    love.graphics.print("Score: "..score, 10, 10)
  else
    love.graphics.setColor(0,0,0)
    local text = love.graphics.newText(love.graphics:getFont(),"Score: "..score)
    local tx, ty = text:getDimensions()
    
    love.graphics.draw(text, wid/2-tx/2, hei/3+25)
    love.graphics.setColor(1,1,1)
    love.graphics.draw(gameover, wid/2-114, hei/8)
    love.graphics.draw(menu, wid/2-75, hei/3+50)
  end
end

return manager