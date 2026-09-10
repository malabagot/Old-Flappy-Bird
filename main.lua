function love.draw()
-- The skybox
    love.graphics.setColor(0.376, 0.765, 1)
    love.graphics.rectangle('fill',0,0,skyboxWidth,skyboxHeight)
-- Top Pipe 1
    love.graphics.setColor(.18,.7,.2)
    love.graphics.rectangle('fill',pipe1X,0,70,skyboxHeight-pipe1XBottom-100)
-- Top Pipe 2
    love.graphics.setColor(.18,.7,.2)
    love.graphics.rectangle('fill',pipe2X,0,70,skyboxHeight-pipe2XBottom-100)
-- Bottom Pipe 1
    love.graphics.setColor(.18,.7,.2)
    love.graphics.rectangle('fill',pipe1X,500,70,-pipe1XBottom)
-- Bottom Pipe 2
    love.graphics.setColor(.18,.7,.2)
    love.graphics.rectangle('fill',pipe2X,500,70,-pipe2XBottom)

    local scaleX = birdWidth / birdImage:getWidth()
    local scaleY = birdHeight / birdImage:getHeight()
    love.graphics.setColor(1,1,1)
    love.graphics.draw(birdImage, birdX, birdY, 0, scaleX*2.5, scaleY*2.7,9,8)

    love.graphics.setColor(1,1,1)
    love.graphics.draw(pipeImage,pipe1X, skyboxHeight-pipe1XBottom, 0,3.2,3.2,0.2)

    love.graphics.setColor(1,1,1)
    love.graphics.draw(pipeImage,pipe2X, skyboxHeight-pipe2XBottom, 0,3.2,3.2,0.2)

    love.graphics.setColor(1,1,1)
    love.graphics.draw(pipeImage,pipe2X + pipeWidth + 0.2, skyboxHeight-pipe2XBottom-pipeGap, 3.145,3.2,3.2,0.2)

    love.graphics.setColor(1,1,1)
    love.graphics.draw(pipeImage,pipe1X + pipeWidth + 0.2, skyboxHeight-pipe1XBottom-pipeGap, 3.145,3.2,3.2,0.2)


end

function love.load()
    birdY = 250
    birdX = 50
    birdWidth = 30
    birdHeight = 25
    birdYSpeed = 50
    pipeWidth = 70
    pipeSpeed = 0.8
    pipe1X = 500
    pipe2X = 750 + pipeWidth/2
    pipeGap = 100
    pipe1XBottom = love.math.random(130,300)
    pipe2XBottom = love.math.random(130,300)
    skyboxHeight = 500
    skyboxWidth = 500
    deathSound = love.audio.newSource("ping.wav","static")
    birdImage = love.graphics.newImage("BirdImage.png")
    pipeImage = love.graphics.newImage("PipeImage.png")
end


function love.update(dt)
    birdYSpeed = birdYSpeed + dt*500
    birdY = birdY + (birdYSpeed*dt)   
    pipe1X = pipe1X - pipeSpeed
    pipe2X = pipe2X - pipeSpeed
-- resets pipe 1 when of screen    
    if pipe1X <= -pipeWidth then
        pipe1X = 500 
        pipe1XBottom = love.math.random(100,400)
    end
-- resets pipe 2 when of screen
    if pipe2X <= -pipeWidth then
        pipe2X = 500
        pipe2XBottom = love.math.random(100,400)
    end
    
    if birdX < pipe1X + pipeWidth and birdX + birdWidth > pipe1X then
        local gapTop = skyboxHeight - pipe1XBottom - pipeGap
        local gapBottom = skyboxHeight - pipe1XBottom
        if birdY < gapTop or birdY + birdHeight > gapBottom then
            deathSound:play()
        end
    end
    if birdX < pipe2X + pipeWidth and birdX + birdWidth > pipe2X then
        local gapTop = skyboxHeight - pipe2XBottom - pipeGap
        local gapBottom = skyboxHeight - pipe2XBottom
        if birdY < gapTop or birdY + birdHeight > gapBottom then
            deathSound:play()
        end

    end
    
end

function love.keypressed(key)
-- stops bird jumping of screen
    if birdY > 0 then        
        birdYSpeed = -200
    end
end