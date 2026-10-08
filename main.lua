--game where animals fall from top player clicks
--before hit the bottom
--game ends when animal hits bottom

-- use ( love . ) to load.

function love.load()
  Beachball = love.graphics.newImage("BeachBall.png")
  backgroundImage = love.graphics.newImage("Background_Drop.png")

  math.randomseed(os.time())
  math.random(); math.random(); math.random()
  startx = {math.random(0, love.graphics.getWidth() - Beachball:getWidth()), 
            math.random(0, love.graphics.getWidth() - Beachball:getWidth()),  
            math.random(0, love.graphics.getWidth() - Beachball:getWidth()),  
            math.random(0, love.graphics.getWidth() - Beachball:getWidth()), 
            math.random(0, love.graphics.getWidth() - Beachball:getWidth())}
  starty = {0 - math.random(Beachball:getHeight(), Beachball:getHeight() * 2),
            0 - math.random(Beachball:getHeight(), Beachball:getHeight() * 2),
            0 - math.random(Beachball:getHeight(), Beachball:getHeight() * 2),
            0 - math.random(Beachball:getHeight(), Beachball:getHeight() * 2),
            0 - math.random(Beachball:getHeight(), Beachball:getHeight() * 2)}
end

-------------------------------------------------
--MOUSE PRESS
--1 = left, 2 = right, 3 = middle wheel
-------------------------------------------------
function love.mousepressed(x, y, button, istouch)
  if button == 1 then
    --print("left mouse clicked")
    for i, v in ipairs(startx) do
      --if the mouse x and y is within the boundary of a beach ball
      if x >= startx[i] and x <= startx[i] + Beachball:getWidth() and y >= starty[i] and y <= starty[i] + Beachball:getHeight() then
        --print("in bounds")
        math.randomseed(os.time())
        math.random(); math.random(); math.random()
        --reset its y value (go back to the top)
        starty[i] = math.random(Beachball:getHeight(), Beachball:getHeight() * 2) * -1
      end
    end
  end
end

-------------------------------------------------
--UPDATE
-------------------------------------------------
function love.update(dt)
  for i, v in ipairs(starty) do
    --if beach ball hits the bottom of the screen, lua quits (we lose)
    if starty[i] + Beachball:getHeight() >= love.graphics.getHeight() then
      --print("over the edge")
      love.event.quit()
    end
    --beach balls move down 
    starty[i] = starty[i] + 80 * dt
  end
end

-------------------------------------------------
--DRAW
-------------------------------------------------
function love.draw()
  
  love.graphics.draw(backgroundImage, 0, 0)
  --draw each beach ball at their respective x and y
  for i, v in ipairs(startx) do
    love.graphics.draw(Beachball, startx[i], starty[i])
  end
end