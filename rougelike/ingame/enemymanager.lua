manager = {}

function manager.create()
  table.insert(badguys, {math.random(0,1)*wid-20,math.random(0,hei),math.floor(5*difficulty),10,3,3,math.floor(5*difficulty)})
end

function manager.checkbullet(bx, by)
  for i,v in pairs(badguys) do
    if v[1]-10 < bx and bx < v[1]+10 then
        if v[2]-10 < by and by < v[2]+10 then
          badguys[i][3] = badguys[i][3] - 5
          return "hit"
        end  
      end
  end
end

function manager.tick()
  for i,v in pairs(badguys) do
    local xdif = playerpos["x"]-v[1]
    local ydif = playerpos["y"]-v[2]
    local rot = math.atan2(xdif, ydif)
    
    badguys[i][1] = math.sin(rot)+badguys[i][1]
    badguys[i][2] = math.cos(rot)+badguys[i][2]
    
    if badguys[i][6] > 0 then
      badguys[i][6]=badguys[i][6]-.1
    else
      local pdx = playerpos["x"]-v[1]
      local pdy = playerpos["y"]-v[2]
      local rot = math.atan2(pdx, pdy)
  
      projectilemanager.create("enemy", v[1], v[2], -math.sin(rot)*3, -math.cos(rot)*3, bulletdamage)
      badguys[i][6]=badguys[i][5]
    end
    if v[3] <= 0 then
      exp = exp + v[7]
      badguys[i] = nil
    end
  end
end

function manager.draw()
  for i,v in pairs(badguys) do
    local hptext = love.graphics.newText(love.graphics:getFont(), "HP: "..v[3])
    local textw, texth = hptext:getDimensions()
    
    love.graphics.circle("fill", badguys[i][1], badguys[i][2], badguys[i][4])
    love.graphics.draw(hptext, v[1]-(textw/2), v[2]-25)
  end
end

return manager