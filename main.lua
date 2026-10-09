--game where Beachball fall from top player clicks.
--before hit the bottom.
--game ends when Beachball hits bottom.
--get 100 points to win.

-- use ( love . ) to load.

function love.load()
  Beachball = love.graphics.newImage("BeachBallSmall.png")
  Drinksmall = love.graphics.newImage("DrinkSmall.png")
  BackgroundImage = love.graphics.newImage("Background_Drop.png")

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


    --BeachBalls Clicked Counter
  BeachBallsClicked = 0


    -- Speed variables       
  NormalSpeed = 140
  SlowSpeed = 100
  CurrentSpeed = NormalSpeed -- Start at normal speed

  -- Slowdown timer variables
  SlowTimer = 0
  SlowDuration = 10.0

  -- Respawn Timer variables
  DrinkActive = true
  DrinkRespawnTimer = 0

  -- Spawn the Drink at a random position on the screen
  spawnDrink()
end


function spawnDrink()
  SpawnX = math.random(0, love.graphics.getWidth() - Drinksmall:getWidth())
  SpawnY = math.random(0, love.graphics.getHeight() - Drinksmall:getHeight())
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
        
        --move the X position each time the ball is clicked
        startx[i] = math.random(0, love.graphics.getWidth() - Beachball:getWidth())

        --reset its y value (go back to the top)
        starty[i] = math.random(Beachball:getHeight(), Beachball:getHeight() * 2) * -1
        BallsClicked = BallsClicked + 1
      end

    end

        -- Check if the player clicked the random Drink item
    if DrinkActive == true then
      if x >= SpawnX and x <= SpawnX + Drinksmall:getWidth() and y >= SpawnY and y <= SpawnY + Drinksmall:getHeight() then
      -- Trigger slowdown effect!
      CurrentSpeed = SlowSpeed
      SlowTimer = SlowDuration
       -- Deactivate the drink so it disappears.
      DrinkActive = false
       -- Set Countdown of 15 seconds until the next one spawns.
      DrinkRespawnTimer = 15.0

      end

    end

  end

end

-------------------------------------------------
--UPDATE
-------------------------------------------------
function love.update(dt)

    -- Handle the slowdown timer countdown
  if SlowTimer > 0 then
    SlowTimer = SlowTimer - dt
    if SlowTimer <= 0 then
      CurrentSpeed = NormalSpeed -- Reset speed when time runs out
    end
  end

  if DrinkActive == false then
    DrinkRespawnTimer = DrinkRespawnTimer - dt
    if DrinkRespawnTimer <= 0 then
        --spawn drink after the timer ends.
      spawnDrink()
      DrinkActive = true
    end

  end

  for i, v in ipairs(starty) do
    --if beach ball hits the bottom of the screen, lua quits (we lose)
    if starty[i] + Beachball:getHeight() >= love.graphics.getHeight() then
      --print("over the edge")
      love.event.quit()
    end
    --beach balls move down 
    starty[i] = starty[i] + CurrentSpeed * dt
  end

  

end

-------------------------------------------------
--DRAW
-------------------------------------------------
function love.draw()
  
  love.graphics.draw(BackgroundImage, 0, 0)
  --draw each beach ball at their respective x and y
  for i, v in ipairs(startx) do
    love.graphics.draw(Beachball, startx[i], starty[i])
  end
   if DrinkActive == true then
    love.graphics.draw(Drinksmall, SpawnX, SpawnY)
  end

  love.graphics.print("SCORE: " .. BeachBallsClicked, 20, 20, 0, 2, 2)

    if BeachBallsClicked == 100 then
        love.event.quit()
    end


end


