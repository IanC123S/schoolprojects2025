manager = {}

playerimage = love.graphics.newImage("images/player.png")

function manager.tick()
  if alive then
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
    if 0 > playerpos.y then
      playerpos.y = 0
    end
    if 0 > playerpos.x then
      playerpos.x = 0
    end
    if wid < playerpos.x then
      playerpos.x = wid
    end
    if hei < playerpos.y then
      playerpos.y = hei
    end
  end
  if playerhealth < 0 and alive then
    alive = false
    local source = love.audio.newSource("sfx/death.wav", "static")
    love.audio.play(source)
  end
end

function manager.draw()
  if alive then
    love.graphics.draw(playerimage, playerpos.x-10, playerpos.y-10)
  end
end

return manager