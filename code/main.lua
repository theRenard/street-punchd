-- enable extended map
-- poke(0x5f56, 0x80)

debug = 0

function _init()
	cls()

	init_buildings()
	init_street()
	init_home()
	init_player()
	init_cyclists()
	reset_score()
end

function _update60()
	update_buildings()
	update_street()
	update_home()
	update_player()
	update_cyclists()
	update_top_bars()
	update_score()
end

function _draw()
	cls(1)

	draw_background()
	draw_buildings()
	draw_street()
	draw_home()
	draw_objects()
	draw_player()
	draw_cyclists()
	draw_top_bars()
	draw_score()
end