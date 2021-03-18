entity_modifier.resize_player = function(player, size)
	local player_name = player:get_player_name()
	size = size or 1
	--a too high number makes the game lag
	if size < 0 or size > 80 then
		minetest.chat_send_player(player_name, "Invalid size: " .. size)
		return
	end

	local default_properties =
		entity_modifier.player_original_disguise_properties[player_name] or
		player_api.registered_models[player:get_properties().mesh]

	local jump = 1

	-- max. values `{x=-10/10,y=-10,15,z=-5/5}`
	if size == 1 then
		player:set_eye_offset(
			{x=0, y=0, z=0},
			{x=0, y=0, z=0}
		)
	elseif size < 1 then
		player:set_eye_offset(
			{x=0, y=0, z=0},
			{x=0, y=0, z=math.floor(5.5 - size * 5)}
		)
	else
		player:set_eye_offset(
			{x=0, y=0, z=0},
			{x=0, y=size * 5, z=-size}
		)
		if size >= 4 then
			jump = 2
		end
	end
	player:set_physics_override({jump = jump})

	local new_properties = {}

	-- corner positions: (x,y,z), (x,y,z)
	if default_properties.collisionbox then
		for i, v in ipairs(default_properties.collisionbox) do
			default_properties.collisionbox[i] = v * size
		end
	end

	if default_properties.selectionbox then
		for i, v in ipairs(default_properties.selectionbox) do
			default_properties.selectionbox[i] = v * size
		end
	end
	if default_properties.eye_height then
		new_properties.eye_height = default_properties.eye_height * size
	end
	new_properties.visual_size = {x=size, y=size}

	player:set_properties(new_properties)
end

minetest.register_privilege("resize", {
	description = "Can resize players"
})

minetest.register_chatcommand("resize", {
	params = "resize <name> [<size>]",
	description = "resize a player size (0.0 to 80)",
	privs = { resize = true },
	func = function(name, params)
		local args = params:split(" ")
		local player_name = args[1]
		if not player_name then
			minetest.chat_send_player(name, "Invalid usage: " .. params)
			return
		end

		local player = minetest.get_player_by_name(player_name)
		if player then
			entity_modifier.resize_player(player, tonumber(args[2]))
		else
			minetest.chat_send_player(name, "Invalid player name: " .. player_name)
		end
	end
})

minetest.register_privilege("resizeme", {
	description = "Can resize itself"
})

minetest.register_chatcommand("resizeme", {
	params = "resizeme [<size>]",
	description = "resize your player size (0.0 to 80)",
	privs = { resizeme = true },
	func = function(player_name, size_string)
		entity_modifier.resize_player(
			minetest.get_player_by_name(player_name),
			tonumber(size_string)
		)
	end
})
