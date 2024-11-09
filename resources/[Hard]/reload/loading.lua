WeaponID = {
	[31] = true,
	[36] = true,
	[38] = true,
}

--add an event handler for onPlayerWeaponSwitch
addEventHandler ( 'onPlayerWeaponSwitch', getRootElement ( ), function()
   reloadPedWeapon(source)
end)
