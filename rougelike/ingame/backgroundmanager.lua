manager = {}

local backgroundlights = {}
local lighttime = 10
local lightimage = love.graphics.newImage("images/particle.png")
local grassimage = love.graphics.newImage("images/grass.png")

function manager.draw()
  for x=0,(wid/24),1 do
    for y=0,(hei/24),1 do
      love.graphics.setColor(.2,x/wid*5+.7,y/hei*5+.7)
      love.graphics.rectangle("fill", x*24, y*24, 24, 24)
      love.graphics.draw(grassimage, x*24, y*24)
    end
  end
  love.graphics.setColor(1,1,1,.3)
  
  lighttime = lighttime - 1
  if lighttime < 0 then
    lighttime = 10
    table.insert(backgroundlights,{1000, 1, math.random(1, wid), math.random(1, hei)})
  end
  for i,v in pairs(backgroundlights) do
    if v[1] > 500 then
      v[2] = v[2] + 1
    else
      v[2] = v[2] - 1
    end
    v[1] = v[1] - 1
    
    if v[1] < 0 then
      backgroundlights[i] = nil
    end
    love.graphics.draw(lightimage, v[3]-v[2]/4, v[4]-v[2]/4, 0, v[2]/40, v[2]/40)
  end
  love.graphics.setColor(1,1,1,1)
end

return manager