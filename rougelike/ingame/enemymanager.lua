manager = {}

-- new = x, y

function manager.create()
  if math.random(1,10) == 1 then
    table.insert(badguys,{
      ["x"] = math.random(0,wid),
      ["y"] = math.random(0,hei),
      ["health"] = math.floor(25*difficulty),
      ["maxhealth"] = math.floor(25*difficulty),
      ["size"] = 20,
      ["firerate"] = 1,
      ["firecooldown"] = 1,
      ["ai"] = "spin",
      ["rotation"] = 0,
      ["rotspeed"] = .025,
      ["image"] = love.graphics.newImage("images/turret.png"),
      ["score"] = 1000
    })
  else
    table.insert(badguys,{
      ["x"] = math.random(0,1)*wid-20,
      ["y"] = math.random(0,hei),
      ["health"] = math.floor(5*difficulty),
      ["maxhealth"] = math.floor(5*difficulty),
      ["size"] = 10,
      ["firerate"] = 3,
      ["firecooldown"] = 3,
      ["ai"] = "main",
      ["image"] = love.graphics.newImage("images/enemy.png"),
      ["score"] = 2000
    })
  end
end

function manager.createboss()
  if math.random(1,2) == 1 then
    badguys["boss"] = {
      ["x"] = wid/2,
      ["y"] = hei/2,
      ["health"] = math.floor(200*difficulty),
      ["maxhealth"] = math.floor(200*difficulty),
      ["size"] = 20,
      ["firerate"] = 1,
      ["firecooldown"] = 1,
      ["ai"] = "main",
      ["randomtrackingpercent"] = 20,
      ["image"] = love.graphics.newImage("images/enemyboss.png"),
      ["score"] = 10000
    }
  else
    badguys["boss"] = {
      ["x"] = wid/2,
      ["y"] = hei/2,
      ["health"] = math.floor(300*difficulty),
      ["maxhealth"] = math.floor(300*difficulty),
      ["size"] = 40,
      ["firerate"] = .1,
      ["firecooldown"] = .1,
      ["ai"] = "spin",
      ["rotation"] = 0,
      ["rotspeed"] = .5,
      ["randomtrackingpercent"] = 80,
      ["image"] = love.graphics.newImage("images/bigboy.png"),
      ["score"] = 10000
    }
  end
end

function manager.checkbullet(bx, by, bulletdmg)
  for i,v in pairs(badguys) do
    if v["x"]-v["size"] < bx and bx < v["x"]+v["size"] then
        if v["y"]-v["size"] < by and by < v["y"]+v["size"] then
          v["health"] = v["health"] - bulletdmg
          return "hit"
        end  
      end
  end
end

function manager.tick()
  if not alive then
    return nil
  end
  for i,v in pairs(badguys) do
    if v["ai"] == "main" then
      local xdif = playerpos["x"]-v["x"]
      local ydif = playerpos["y"]-v["y"]
      local rot = math.atan2(xdif, ydif)
      
      v["x"] = math.sin(rot)+v["x"]
      v["y"] = math.cos(rot)+v["y"]
      
      if v["firecooldown"] > 0 then
        v["firecooldown"]=v["firecooldown"]-.1
      else
        local pdx = playerpos["x"]-v["x"]
        local pdy = playerpos["y"]-v["y"]
        local rot = math.atan2(pdx, pdy)
        
        if v["randomtrackingpercent"] and math.random(1,v["randomtrackingpercent"]) == 1 then
          projectilemanager.create("enemy", v["x"], v["y"], -math.sin(rot)*3, -math.cos(rot)*3, bulletdamage, true)
        else
          projectilemanager.create("enemy", v["x"], v["y"], -math.sin(rot)*3, -math.cos(rot)*3, bulletdamage)
        end
        
        if i == "boss" then
          projectilemanager.create("enemy", v["x"], v["y"], math.sin(rot)*3, math.cos(rot)*3, bulletdamage)
          projectilemanager.create("enemy", v["x"], v["y"], math.sin(rot-90)*3, math.cos(rot-90)*3, bulletdamage)
          projectilemanager.create("enemy", v["x"], v["y"], math.sin(rot+90)*3, math.cos(rot+90)*3, bulletdamage)
        end
        
        v["firecooldown"]=v["firerate"]
      end
    elseif v["ai"] == "spin" then
      if v["firecooldown"] > 0 then
        v["firecooldown"]=v["firecooldown"]-.1
      else
        if v["randomtrackingpercent"] and math.random(1,v["randomtrackingpercent"]) == 1 then
          projectilemanager.create("enemy", v["x"], v["y"], -math.sin(v["rotation"])*3, -math.cos(v["rotation"])*3, bulletdamage, true)
        else
          projectilemanager.create("enemy", v["x"], v["y"], -math.sin(v["rotation"])*3, -math.cos(v["rotation"])*3, bulletdamage)
        end
        v["firecooldown"]=v["firerate"]
      end
      v["rotation"] = v["rotation"] + v["rotspeed"]
    end
    if v["health"] <= 0 then
      exp = exp + v["maxhealth"]
      score = score + v["score"]
      if i == "boss" then
        if playerhealth < 100 then
          playerhealth = 100
        end
      end
      badguys[i] = nil
    end
  end
end

function manager.draw()
  for i,v in pairs(badguys) do
    if i == "boss" then
      love.graphics.setColor(1,0,0)
      local width = (v["health"]/v["maxhealth"])*(wid/2)
      love.graphics.rectangle("fill", wid/2-width/2, 10, width, 20)
      love.graphics.setColor(1,1,1)
    else
      love.graphics.setColor(1,0,0)
      local health = v["health"]/v["maxhealth"]
      local healthwidth = health*v["size"]*2
      love.graphics.rectangle("fill", v["x"]-healthwidth/2, v["y"]-v["size"]-10, healthwidth, 5)
      love.graphics.setColor(1,1,1)
    end
    if v["image"] then
      love.graphics.draw(v["image"], v["x"]-v["size"], v["y"]-v["size"])
    else
      love.graphics.circle("fill", v["x"], v["y"], v["size"])
    end
  end
end

return manager