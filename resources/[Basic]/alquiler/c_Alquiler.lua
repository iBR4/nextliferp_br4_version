local texto = createColSphere(1654.3449707031, -1900.1020507812, 13.552103996277, 2.3 )

local vehiculos = {
	{"Buccaneer", 200,"Buccaneer"},
	{"Perennial", 200,"Perennial"},
	{"Tahoma", 300,"Tahoma"},
	{"Damaged Glendale", 250,"Damaged Glendale"},
	{"Blista Compact", 150,"Blista Compact"},
	{"Faggio", 70,"Faggio"},
	{"Wayfarer", 150,"Wayfarer"},
}

function crearPanel()

	ventana = guiCreateWindow(0.31, 0.35, 0.39, 0.43, "Alquiler de vehículos", true)
	guiWindowSetMovable(ventana, false)
	guiWindowSetSizable(ventana, false)

	GridList = guiCreateGridList(0.02, 0.08, 0.96, 0.53, true, ventana)
	guiGridListAddColumn(GridList, "Vehículo", 0.5)
	guiGridListAddColumn(GridList, "Precio", 0.5)
	guiGridListAddColumn(GridList, "Vehículo", 0.5)
		for k, v in ipairs(vehiculos) do
			k = k - 1
			guiGridListAddRow(GridList)
			guiGridListSetItemText(GridList, k, 1, v[1], false, false)
			guiGridListSetItemText(GridList, k, 2, v[2], false, false)
			guiGridListSetItemText(GridList, k, 3, v[3], false, false)
		end
	ComboBox = guiCreateComboBox(0.06, 0.63, 0.24, 0.34, "Elige el tiempo", true, ventana)
	guiComboBoxAddItem(ComboBox, "5 minutos")
	guiComboBoxAddItem(ComboBox, "10 minutos")
	guiComboBoxAddItem(ComboBox, "15 minutos")
	guiComboBoxAddItem(ComboBox, "20 minutos")
	guiComboBoxAddItem(ComboBox, "25 minutos")
	guiComboBoxAddItem(ComboBox, "30 minutos")
	btnAlquilar = guiCreateButton(0.50, 0.68, 0.23, 0.11, "Alquilar vehículo", true, ventana)
	guiSetProperty(btnAlquilar, "NormalTextColour", "FF29FE00")
	btnCancel = guiCreateButton(0.75, 0.68, 0.23, 0.11, "Cancelar Alquiler", true, ventana)
	guiSetProperty(btnCancel, "NormalTextColour", "FFFD0000")
	btnCerrar = guiCreateButton(0.81, 0.86, 0.18, 0.11, "Cerrar", true, ventana)
	guiSetProperty(btnCerrar, "NormalTextColour", "FFFCD000")

end

function cerrarPanel()
	destroyElement(GridList)
	destroyElement(btnAlquilar)
	destroyElement(btnCerrar)
	destroyElement(btnCancel)
	destroyElement(ComboBox)
	destroyElement(ventana)
	showCursor(false)
	LabelResultado = nil
	resultado = nil
end

function comandoAlquiler()
	if isElementWithinColShape( localPlayer, texto) then
	crearPanel()
	showCursor( true )
	addEventHandler( "onClientGUIClick", btnCerrar, cerrarPanel, false)
	addEventHandler( "onClientGUIClick", ComboBox, function()
		local itemselected = guiGridListGetSelectedItem( GridList )
		if itemselected > -1 then
			local precio = guiGridListGetItemText( GridList, itemselected, 2 )
			local seleccionado = guiComboBoxGetSelected( ComboBox )
			if seleccionado then
				local selectedid = guiComboBoxGetItemText( ComboBox, seleccionado)
				if selectedid then
					resultado = nil
					if LabelResultado then
						if isElement(LabelResultado) then
							destroyElement(LabelResultado)
						end
						LabelResultado = nil
					end
					if selectedid == "5 minutos" then
						resultado = precio * 5
					elseif selectedid == "10 minutos" then
						resultado = precio * 10
					elseif selectedid == "15 minutos" then
						resultado = precio * 15
					elseif selectedid == "20 minutos" then
						resultado = precio * 20
					elseif selectedid == "25 minutos" then
						resultado = precio * 25
					elseif selectedid == "30 minutos" then
						resultado = precio * 30
					end
						LabelResultado = guiCreateLabel(0.06, 0.72, 0.39, 0.25, "El vehículo sería alquilado \npor un total de: "..resultado.."$", true, ventana)
					if LabelResultado then
						guiLabelSetVerticalAlign(LabelResultado, "center")
					end
				end
			end
		else
			outputChatBox("#FFFFFFTe recomendamos primero seleccionar un vehículo y luego el tiempo.", 0,0,0, true)
		end
	end, false)
	addEventHandler( "onClientGUIClick", GridList, function()
		if LabelResultado then
			if not destroyElement(LabelResultado) then
				LabelResultado = nil
			end
		end
		resultado = nil
	end, false)
	addEventHandler( "onClientGUIClick", btnAlquilar, function()
		if resultado and LabelResultado then
			local itemselected = guiGridListGetSelectedItem( GridList )
			if itemselected > -1 then
				local nombreveh = guiGridListGetItemText( GridList, itemselected, 3 )
				local seleccionado = guiComboBoxGetSelected( ComboBox )
				if seleccionado then
					local selectedid = guiComboBoxGetItemText( ComboBox, seleccionado)
					if selectedid then
						if selectedid == "5 minutos" then
							triggerServerEvent( "alquilarVehiculo", localPlayer, nombreveh, localPlayer, 5*60000, resultado)
							cerrarPanel()
						elseif selectedid == "10 minutos" then
							triggerServerEvent( "alquilarVehiculo", localPlayer, nombreveh, localPlayer, 10*60000, resultado)
							cerrarPanel()
						elseif selectedid == "15 minutos" then
							triggerServerEvent( "alquilarVehiculo", localPlayer, nombreveh, localPlayer, 15*60000, resultado)
							cerrarPanel()
						elseif selectedid == "20 minutos" then
							triggerServerEvent( "alquilarVehiculo", localPlayer, nombreveh, localPlayer, 20*60000, resultado)
							cerrarPanel()
						elseif selectedid == "25 minutos" then
							triggerServerEvent( "alquilarVehiculo", localPlayer, nombreveh, localPlayer, 25*60000, resultado)
							cerrarPanel()
						elseif selectedid == "30 minutos" then
							triggerServerEvent( "alquilarVehiculo", localPlayer, nombreveh, localPlayer, 30*60000, resultado)
							cerrarPanel()
						end
					end
				end
			end
		else
			outputChatBox("#FFFFFFTe recomendamos primero seleccionar un vehículo y luego el tiempo.", 0,0,0, true)
		end
	end, false)
	addEventHandler( "onClientGUIClick", btnCancel, function()
		triggerServerEvent( "desalquilarVehiculo", localPlayer, localPlayer)
		cerrarPanel()
	end, false)
	end
end
addCommandHandler("alquilarveh", comandoAlquiler)