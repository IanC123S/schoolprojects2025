function love.load()
  width, height = love.graphics.getWidth(), love.graphics.getHeight()
  x = 100
  y = height/2
  yvel = 0
  
  love.window.setTitle("Flappy Birb")
  
  active = false
  pipecooldown = 150
  points = 0
  
  gameover = false
  
  love.graphics.setNewFont("font.ttf", 40)
  font = love.graphics.getFont()
  text = love.graphics.newText(font, "Points: "..tostring(points))
  
  birdimg = love.graphics.newImage("images/Bird_00.png")
  pipeimgtop = love.graphics.newImage("images/PipeTop.png")
  pipeimgbottom = love.graphics.newImage("images/PipeBottom.png")
  background = love.graphics.newImage("images/Background.png")
  
  gameoverimage = love.graphics.newImage("images/GameOver.png")
  playbuttonimage = love.graphics.newImage("images/PlayButton.png")
  
  love.window.setIcon(love.image.newImageData("images/Bird_00.png"))
  
  anim = 0
  function jump()
    yvel = 7
    anim = 3
  end
  function reset()
    active = false
    pipes = {{["x"] = width+25, ["y"] = height/2}}
    yvel = 0
    pipecooldown = 150
    points = 0
    x = 100
    y = height/2
    upd = true
    text = love.graphics.newText(font, "Points: "..tostring(points))
    
    bgoffset = 0
    bg = {}
    for i = -1,math.ceil(width)/360+2,1 do
      table.insert(bg, i*360)
    end
  end
  pipes = {
    {["x"] = width+25, ["y"] = height/2}
  }
  
  bgoffset = 0
  bg = {}
  for i = -1,math.ceil(width)/360+2,1 do
      table.insert(bg, i*360)
  end
end

function love.update()
  upd = false
  bgoffset = bgoffset - .5
  if bgoffset < -360 then
    bgoffset = 0
  end
  
  if anim > 0 then
    anim = anim-.1
    if anim < 0 then
      anim = 0
    end
  end
  birdimg = love.graphics.newImage("images/Bird_0"..math.floor(anim)..".png")
  
  if active then
    gameover = true
    yvel = yvel-.3
    y = y-yvel
    
    if y < 0 or y > height then
      reset()
    end
    for i,v in pairs(pipes) do
      if not upd then
        pipes[i].x = pipes[i].x-2
        
        if v["x"]-25 < x and x < v["x"]+25 then
          if v["y"]-75 < y and y < v["y"]+75 then
            if v["x"] == x or v["x"]+1 == x then
              points = points + 1
              text = love.graphics.newText(font, "Points: "..tostring(points))
            end
          else
            reset()
          end
        end
      end
    end
    pipecooldown = pipecooldown-1
    if pipecooldown == 0 then
      pipecooldown = 150
      table.insert(pipes, {["x"] = width+25, ["y"] = height/2+math.random(1,100)})
    end
  end
end

function love.draw()
  for i,v in pairs(bg) do
      love.graphics.draw(background, v+bgoffset, 0, 0, 2.5, 2.5)
  end
  
  love.graphics.draw(birdimg, x-25, y-25, -yvel/25)
  for i,v in pairs(pipes) do
    love.graphics.draw(pipeimgtop, v["x"]-25, v["y"]+75) 
    love.graphics.draw(pipeimgbottom, v["x"]-25, v["y"]-575)
  end
  
  love.graphics.draw(text,10,10,0,1,1)
  
  if gameover and not active then
    love.graphics.draw(gameoverimage, width/2-192, 20)
  end
  if not active then
    love.graphics.draw(playbuttonimage, width/2-72, height/2)
  end
end

function love.keypressed(key)
  if key == "space" then
    active = true
    jump()
  end
end

function love.mousepressed(xp,yp,button)
  if button == 1 then
    active = true
    jump()
  end
end
