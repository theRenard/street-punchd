-- particle system
particles = {}

-- particle manager
function init_particles()
  particles = {}
end

function add_particle(p)
  add(particles, p)
end

function update_particles()
  for p in all(particles) do
    update_particle(p)
    if p.dead then
      del(particles, p)
    end
  end
end

function draw_particles()
  for p in all(particles) do
    draw_particle(p)
  end
end

-- particle functions
function make_particle(x, y, sx, sy, type)
  local p = {
    x = x or 0,
    y = y or 0,
    sx = sx or 0,
    sy = sy or 0,
    ax = 0,
    ay = 0,
    frame = 0,
    max_frames = 30,
    rad = 1,
    max_rad = 1,
    clr = 7,
    dead = false,
    gravity = 0,
    friction = 1,
    fade = true,
    type = type or "basic"
  }

  -- set properties based on type
  if type == "dust" then
    p.max_frames = 45
    p.rad = randfloat(1, 3)
    p.max_rad = p.rad
    p.clr = 6
    p.gravity = 0.02
    p.friction = 0.98
    p.sx = randfloat(-0.5, 0.5)
    p.sy = randfloat(-1, -0.2)
  elseif type == "spark" then
    p.max_frames = 20
    p.rad = 1
    p.max_rad = 1
    p.clr = ({7, 8, 9, 10})[randint(1, 4)]
    p.gravity = 0.05
    p.friction = 0.95
    p.sx = randfloat(-2, 2)
    p.sy = randfloat(-3, -1)
  elseif type == "explosion" then
    p.max_frames = 30
    p.rad = randfloat(2, 5)
    p.max_rad = p.rad
    p.clr = ({8, 9, 10, 7})[randint(1, 4)]
    p.gravity = 0.1
    p.friction = 0.92
    local angle = randfloat(0, 1)
    local speed = randfloat(1, 4)
    p.sx = cos(angle) * speed
    p.sy = sin(angle) * speed
  elseif type == "smoke" then
    p.max_frames = 60
    p.rad = randfloat(2, 4)
    p.max_rad = p.rad
    p.clr = 13
    p.gravity = -0.02
    p.friction = 0.99
    p.sx = randfloat(-0.3, 0.3)
    p.sy = randfloat(-0.8, -0.2)
  end

  return p
end

function update_particle(p)
  -- apply physics
  p.sx += p.ax
  p.sy += p.ay
  p.sy += p.gravity

  -- apply friction
  p.sx *= p.friction
  p.sy *= p.friction

  -- move
  p.x += p.sx
  p.y += p.sy

  -- age
  p.frame += 1
  if p.frame >= p.max_frames then
    p.dead = true
  end

  -- bounds check
  if p.x < -8 or p.x > 136 or p.y < -8 or p.y > 136 then
    p.dead = true
  end
end

function draw_particle(p)
  if p.dead then return end

  local life_ratio = 1 - (p.frame / p.max_frames)
  local current_rad = p.rad
  local current_clr = p.clr

  if p.fade then
    current_rad = life_ratio * p.max_rad
    -- fade by changing to darker colors
    if life_ratio < 0.3 then
      current_clr = 0
    elseif life_ratio < 0.6 then
      current_clr = 5
    end
  end

  if current_rad > 0.5 then
    circfill(p.x, p.y, current_rad, current_clr)
  else
    pset(p.x, p.y, current_clr)
  end
end

-- convenience functions for creating particles
function create_dust(x, y, count)
  count = count or 1
  for i = 1, count do
    local p = make_particle(
      x + randfloat(-2, 2),
      y + randfloat(-2, 2),
      0, 0, "dust"
    )
    add_particle(p)
  end
end

function create_sparks(x, y, count)
  count = count or 3
  for i = 1, count do
    local p = make_particle(
      x + randfloat(-1, 1),
      y + randfloat(-1, 1),
      0, 0, "spark"
    )
    add_particle(p)
  end
end

function create_explosion(x, y, count, force)
  count = count or 8
  force = force or 1
  for i = 1, count do
    local p = make_particle(x, y, 0, 0, "explosion")
    -- scale by force
    p.rad *= force
    p.max_rad = p.rad
    p.sx *= force
    p.sy *= force
    add_particle(p)
  end
end

function create_smoke(x, y, count)
  count = count or 2
  for i = 1, count do
    local p = make_particle(
      x + randfloat(-1, 1),
      y + randfloat(-1, 1),
      0, 0, "smoke"
    )
    add_particle(p)
  end
end