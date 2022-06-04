Actor = Object:extend()

function Actor:new(imgPath, x, y, speed)
    self.image = love.graphics.newImage(imgPath)
    self.x = x
    self.y = y
    self.speed = speed
    self.width = self.image:getWidth()
    self.height = self.image:getHeight()
end
