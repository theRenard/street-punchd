-- enable extended map
-- poke(0x5f56, 0x80)

debug = 1

function _init()
	cls()

	init_buildings()
	init_street()
	init_home()
	init_player()
	init_cyclists()
end

function _update60()
	update_buildings()
	update_street()
	update_home()
	update_player()
	update_cyclists()
end

function _draw()
	cls(1)

	-- draw_background()
	-- draw_buildings()
	-- draw_street()
	-- draw_home()
	draw_player()
	draw_cyclists()
	draw_objects()
end