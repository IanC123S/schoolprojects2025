manager = {}

function manager.create()
  
end

function manager.tick()
  if love.keyboard.isDown("left") or love.keyboard.isDown("a") then
    playerpos.x = playerpos.x - speed
  end
  if love.keyboard.isDown("right") or love.keyboard.isDown("d") then
    playerpos.x = playerpos.x + speed
  end
  if love.keyboard.isDown("up") or love.keyboard.isDown("w") then
    playerpos.y = playerpos.y - speed
  end
  if love.keyboard.isDown("down") or love.keyboard.isDown("s") then
    playerpos.y = playerpos.y + speed
  end
end

function manager.draw()
  love.graphics.circle("fill", playerpos.x, playerpos.y, 10)
end

return manager