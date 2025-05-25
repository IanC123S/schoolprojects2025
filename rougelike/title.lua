title = {}

function title.load()
  backgroundmanager = require("ingame/backgroundmanager")
  titleimage = love.graphics.newImage("images/title.png")
  
  playimage = love.graphics.newImage("images/play.png")
  playx = 11
  
  transitionalpha = 1
  transitionalphamodifier = 0
  
  transitionactivated = false
end

function title.update()
  local mx, my = love.mouse.getPosition()
  if 11 < mx and mx < 161 and 154 < my and my < 204 and not transitionactivated then
    playx = (playx*.9)+(61*.1)
  else
    playx = (playx*.9)+(11*.1)
  end
  if transitionalpha > 1.05 and transitionactivated then
    transitionalphamodifier = 0
    currentpageselected = require("ingame")
    currentpageselected.load()
  end
end

function title.mousepressed(mx, my, button)
  if 11 < mx and mx < 161 and 154 < my and my < 204 and button == 1 and not transitionactivated then
    transitionalpha = 0
    transitionalphamodifier = 1.2
    transitionactivated = true
  end
end

function title.draw()
  backgroundmanager.draw()
  love.graphics.draw(titleimage,0,0)
  love.graphics.draw(playimage, playx, 154)
end

return title