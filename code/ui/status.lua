function update_status()
end

function draw_status()
  local x0 = 4 -- leftmost
  local pw = 15
  local bw = 40
  local bh = 4
  local x1 = x0 + pw + 2 -- middle
  local x3 = 90 -- end

  local y0 = 4

  -- portrait
  rectfill(x0, y0, x0 + pw, y0 + pw, 7)
  rectfill(x0 + 1, y0 + 1, x0 + pw - 1, y0 + pw - 1, 8)
  sspr(x0 + 1, y0 + 1, pw - 2, pw - 2, x0 + 1, y0 + 1, pw - 1, pw - 1)

  -- name
  -- print("jEAN", x1 + 1, y0 + 16, 7)

  -- -- energy
  print("jEAN", x1 + 1, y0 + 3, 7)
  rect(x1, y0 + bh + 5, x1 + bw, y0 + bh * 2 + 5, 7)
  rectfill(x1 + 1, y0 + bh + 6, x1 + bw - 1, y0 + bh * 2 + 4, 8)

  -- energy bar
  local energy = p.energy
  local energy_bar_width = ceil(bw * (energy / 100))
  energy_bar_width = mid(0, energy_bar_width, bw - 2)
  rectfill(x1 + 1, y0 + bh + 6, x1 + 1 + energy_bar_width, y0 + bh * 2 + 4, 10)
end
