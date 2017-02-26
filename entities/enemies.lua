local Bomber = require('entities.bomber')
local config = require('lib.config')
local Entity = require('lib.entity')
local List   = require('lib.list')

local final   = 1.25
local initial = 3.00
local attackTime = 8
local attackRate = (final - initial) / config.seconds

local Enemies = Entity:extend()

function Enemies:new(opts)
  self.bombers = List(Bomber)
  self.next    = initial
  self.planets = opts.planets
  self.target  = next(opts.planets)
  self.time    = initial
end

function Enemies:draw()
  self.bombers:draw()
end

function Enemies:launch()
  local x, y
  local w, h = love.graphics.getDimensions()

  if math.random(2) > 1 then
    x = math.random(0, 1) * w
    y = math.random() * h
  else
    x = math.random() * w
    y = math.random(0, 1) * h
  end

  local px, py = self.target:project(attackTime)
  local vx = (px - x) / attackTime
  local vy = (py - y) / attackTime

  self.bombers:insert({ x = x, y = y, vx = vx, vy = vy })

  self.time   = self.next
  self.target = next(self.planets, self.target) or next(self.planets)
end

function Enemies:update(dt)
  self.bombers:update(dt)

  if self.time <= 0 then
    self:launch()
  end

  self.next = self.next + dt * attackRate
  self.time = self.time - dt
end

return Enemies
