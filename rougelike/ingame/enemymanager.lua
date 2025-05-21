manager = {}

function manager.create()
  table.insert(badguys, {50,50,100,10,3,3})
end

function manager.checkbullet(bx, by)
  for i,v in pairs(badguys) do
    if v[1]-10 < bx and bx < v[1]+10 then
        if v[2]-10 < by and by < v[2]+10 then
          badguys[i][3] = badguys[i][3] - 5
          return true
        end  
      end
  end
  return false
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
  end
end

function manager.draw()
  for i,v in pairs(badguys) do
    love.graphics.circle("fill", badguys[i][1], badguys[i][2], badguys[i][4])
  end
end

return manager