manager = {}

bulletimage = love.graphics.newImage("images/bullet.png")

function manager.create(ptype, x, y, xspeed, yspeed, bulletdmg, homing)
  table.insert(projectiles, {ptype, x, y, xspeed, yspeed, bulletdmg, homing, 10})
end

function manager.tick()
  for i,projectile in pairs(projectiles) do
    projectiles[i][2] = projectile[2]-projectile[4]
    projectiles[i][3] = projectile[3]-projectile[5]
    
    if projectile[7] then
      local pdx = playerpos["x"]-projectile[2]
      local pdy = playerpos["y"]-projectile[3]
      local rot = math.atan2(pdx, pdy)
      
      projectile[4] = -math.sin(rot)*3 
      projectile[5] = -math.cos(rot)*3
      
      projectile[8] = projectile[8]-.01
      if projectile[8] < 0 then
        projectiles[i] = nil
      end
    end
    if projectile[1] == "enemy" then
      if playerpos.x-5 < projectile[2] and projectile[2] < playerpos.x+5 then
        if playerpos.y-5 < projectile[3] and projectile[3] < playerpos.y+5 then
          playerhealth = playerhealth - projectile[6]
          local source = love.audio.newSource("sfx/hit.wav", "static")
          love.audio.play(source)
          projectiles[i] = nil
        end  
      end
    elseif projectile[1] == "plr" then
      local hit = enemymanager.checkbullet(projectile[2], projectile[3], projectile[6])
      if hit == "hit" then
        projectiles[i] = nil
        local source = love.audio.newSource("sfx/enemydamage.wav", "static")
        love.audio.play(source)
      end
    end
    if projectile[2] < 0 or wid < projectile[2] or projectile[3] < 0 or hei < projectile[3] then
      projectiles[i] = nil
    end
  end
end

function manager.draw()
  for i,projectile in pairs(projectiles) do
    love.graphics.draw(bulletimage, projectile[2]-5, projectile[3]-5)
  end
end

return manager