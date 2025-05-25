function love.load()
  love.window.setTitle("Rougelike Project")
  love.window.setIcon(love.image.newImageData("images/player.png"))
  currentpageselected = require("title")
  currentpageselected.load()
  wid, hei = love.graphics.getWidth(), love.graphics.getHeight()
  
  transitionalpha = 1
  transitionalphamodifier = 0
  
  love.graphics.setFont(love.graphics.newFont("images/font.ttf", 25))
end

function love.update(...)
  currentpageselected.update(...)
  transitionalpha = (transitionalpha*.95 + transitionalphamodifier*.05)
end

function love.draw(...)
  currentpageselected.draw(...)
  
  love.graphics.setColor(0,0,0,transitionalpha)
  love.graphics.rectangle("fill",0,0,wid,hei)
  love.graphics.setColor(1,1,1,1)
end

function love.mousepressed(...)
  currentpageselected.mousepressed(...)
end