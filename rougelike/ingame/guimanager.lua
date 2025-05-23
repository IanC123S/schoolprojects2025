manager = {}

guioptions = {}
totaloptions = {"firerate", "speed", "bulletspeed", "bulletdmg"}

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
  if hei-87.5 < my and my < hei-12.5 then
    if wid/2-37.5 < mx and mx < wid/2+37.5 then
      spendingmoneys = spendingmoneys - 1
      increasestat(guioptions[2])
    end
    if wid/2-137.5 < mx and mx < wid/2-62.5 then
      spendingmoneys = spendingmoneys - 1
      increasestat(guioptions[1])
    end
    if wid/2+62.5 < mx and mx < wid/2+137.5 then
      spendingmoneys = spendingmoneys - 1
      increasestat(guioptions[3])
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
  if spendingmoneys > 0 then
    love.graphics.rectangle("line",wid/2-250, hei-100, 500,125)
  
    love.graphics.rectangle("line",wid/2-37.5, hei-87.5, 75, 75)
    love.graphics.rectangle("line",wid/2-137.5, hei-87.5, 75, 75)
    love.graphics.rectangle("line",wid/2+62.5, hei-87.5, 75, 75)
  
    local curfont = love.graphics:getFont()
    local o1 = love.graphics.newText(curfont, guioptions[1])
    local o1x, o1y = o1:getDimensions()
    local o2 = love.graphics.newText(curfont, guioptions[2])
    local o2x, o2y = o2:getDimensions()
    local o3 = love.graphics.newText(curfont, guioptions[3])
    local o3x, o3y = o3:getDimensions()
    
    love.graphics.draw(o1, wid/2-100-(o1x/2), hei-87.5)
    love.graphics.draw(o2, wid/2-(o2x/2), hei-87.5)
    love.graphics.draw(o3, wid/2+100-(o3x/2), hei-87.5)
  end
end

return manager