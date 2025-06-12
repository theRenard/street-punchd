function update_top_bars()
end

function draw_top_bars()
  local margin = 2
  local portrait_width = 16
  local bar_width = 32
  local bar_height = 4
  local screen_width = 128
  local bar_margin = 2
  map()

  -- Player (left)
  local player_x = margin
  local player_bar_x = player_x + portrait_width + bar_margin

  -- player portrait
  rectfill(player_x, margin, player_x + portrait_width, margin + portrait_width, 7)
  rectfill(player_x + 1, margin + 1, player_x + portrait_width - 1, margin + portrait_width - 1, 8)
  -- Draw player head only (15x15 region from the sprite, not scaled, mirrored)
  sspr(player_x + 1, margin + 1, 15, 15, player_x + 2, margin - 1, 15, 15)

  -- Calculate bar y position so the bottom aligns with the bottom of the portrait
  local bar_y = margin + portrait_width - bar_height

  -- player name (above the bar)
  print("jEAN", player_bar_x, bar_y - 6, 7)
  rect(player_bar_x, bar_y, player_bar_x + bar_width, bar_y + bar_height, 7)
  rectfill(player_bar_x + 1, bar_y + 1, player_bar_x + bar_width - 1, bar_y + bar_height - 1, 8)

  -- player energy
  local player_energy = player.energy
  local player_energy_bar_width = ceil(bar_width * (player_energy / 100))
  player_energy_bar_width = mid(0, player_energy_bar_width, bar_width - 2)
  rectfill(player_bar_x + 1, bar_y + 1, player_bar_x + 1 + player_energy_bar_width, bar_y + bar_height - 1, 10)

  -- Cyclist (right)
  local cyclist_x = screen_width - margin - portrait_width
  local cyclist_bar_x = cyclist_x - bar_margin - bar_width

  -- cyclist portrait
  rectfill(cyclist_x, margin, cyclist_x + portrait_width, margin + portrait_width, 7)
  rectfill(cyclist_x + 1, margin + 1, cyclist_x + portrait_width - 1, margin + portrait_width - 1, 12)
  -- Draw cyclist head only (15x15 region from the sprite, not scaled, mirrored)
  sspr(cyclist_sprite_frames[1] + 4, 40, 15, 15, cyclist_x + 1, margin + 1, 15, 15, true)

  -- cyclist name (right-aligned, above the bar)
  local cyclist_name = "hUGO"
  local cyclist_name_width = #cyclist_name * 4 -- 4px per char in Pico-8 font
  print(cyclist_name, cyclist_bar_x + bar_width - cyclist_name_width + 2, bar_y - 6, 7)
  rect(cyclist_bar_x, bar_y, cyclist_bar_x + bar_width, bar_y + bar_height, 7)
  rectfill(cyclist_bar_x + 1, bar_y + 1, cyclist_bar_x + bar_width - 1, bar_y + bar_height - 1, 8)

  -- cyclist energy
  local cyclist_energy = cyclist.energy or 100
  local cyclist_energy_bar_width = ceil(bar_width * (cyclist_energy / 100))
  cyclist_energy_bar_width = mid(0, cyclist_energy_bar_width, bar_width - 2)
  rectfill(cyclist_bar_x + 1, bar_y + 1, cyclist_bar_x + 1 + cyclist_energy_bar_width, bar_y + bar_height - 1, 10)
end
