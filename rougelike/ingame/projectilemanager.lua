manager = {}

function manager.create(ptype, x, y, xspeed, yspeed)
  table.insert(projectiles, {ptype, x, y, xspeed, yspeed})
end

function manager.tick()
  for i,projectile in pairs(projectiles) do
    projectiles[i][2] = projectile[2]-projectile[4]
    projectiles[i][3] = projectile[3]-projectile[5]
    
    if projectile[1] == "enemy" then
      if playerpos.x-5 < projectile[2] and projectile[2] < playerpos.x+5 then
        if playerpos.y-5 < projectile[3] and projectile[3] < playerpos.y+5 then
          playerhealth = playerhealth - 5
          projectiles[i] = nil
        end  
      end
    elseif projectile[1] == "plr" then
      local hit = enemymanager.checkbullet(projectile[2], projectile[3])
      if hit then
        projectile[i] = nil
      end
    end
  end
end

function manager.draw()
  for i,projectile in pairs(projectiles) do
    love.graphics.circle("line", projectile[2], projectile[3], 5)
  end
end

return manager