/obj/machinery/power/port_gen/pacman/solid_fuel
	name = "\improper S.O.F.I.E.-type portable generator"
	desc = "The second most common generator design in the galaxy, second only to the P.A.C.M.A.N. \
		The S.O.F.I.E. (Stationary Operating Fuel Ignition Engine) is similar to other generators in \
		burning sheets of plasma in order to produce power. \
		Unlike other generators however, this one isn't as portable, or as safe to operate, \
		but at least it makes a hell of a lot more power. Must be <b>bolted to the ground</b> \
		and <b>attached to a wire</b> before use. A massive warning label wants you to know that this generator \
		<b>outputs waste heat and gasses to the air around it</b>."
	icon = 'modular_doppler/colony_fabricator/icons/machines.dmi'
	icon_state = "fuel_generator_0"
	base_icon_state = "fuel_generator"
	circuit = null
	anchored = TRUE
	max_sheets = 25
	time_per_sheet = parent_type::time_per_sheet * (5 / 3) //66.6% better
	power_gen = parent_type::power_gen * 2.5
	drag_slowdown = 1.5
	sheet_path = /obj/item/stack/sheet/mineral/plasma

/obj/machinery/power/port_gen/pacman/solid_fuel/Initialize(mapload)
	. = ..()
	AddElement(/datum/element/manufacturer_examine, COMPANY_FRONTIER)

// We don't need to worry about the board, this machine doesn't have one!
/obj/machinery/power/port_gen/pacman/solid_fuel/on_construction(mob/user, from_flatpack)
	return

/obj/machinery/power/port_gen/pacman/solid_fuel/process()
	. = ..()
	if(active)
		var/turf/where_we_spawn_air = get_turf(src)
		where_we_spawn_air.atmos_spawn_air("co2=10;TEMP=480") // Standard UK diesel engine operating temp is about 220 celsius or ~473 K

// Item for creating the generator or carrying it around

/obj/item/flatpacked_machine/fuel_generator
	name = "flat-packed S.O.F.I.E.-type portable generator"
	desc = /obj/machinery/power/port_gen/pacman/solid_fuel::desc
	icon_state = "fuel_generator_packed"
	type_to_deploy = /obj/machinery/power/port_gen/pacman/solid_fuel
	custom_materials = list(
		/datum/material/iron = SHEET_MATERIAL_AMOUNT * 5,
		/datum/material/glass = SHEET_MATERIAL_AMOUNT,
		/datum/material/titanium = SHEET_MATERIAL_AMOUNT,
		/datum/material/gold = HALF_SHEET_MATERIAL_AMOUNT,
	)
