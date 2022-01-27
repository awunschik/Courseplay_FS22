---@class VehicleSettingsEvent
VehicleSettingsEvent = {}

local VehicleSettingsEvent_mt = Class(VehicleSettingsEvent, Event)

InitEventClass(VehicleSettingsEvent, "VehicleSettingsEvent")

function VehicleSettingsEvent.emptyNew()
	return Event.new(VehicleSettingsEvent_mt)
end

--- Creates a new Event
function VehicleSettingsEvent.new(vehicle,setting)
	local self = VehicleSettingsEvent.emptyNew()
	self.vehicle = vehicle
	self.setting = setting
	return self
end

--- Reads the serialized data on the receiving end of the event.
function VehicleSettingsEvent:readStream(streamId, connection) -- wird aufgerufen wenn mich ein Event erreicht
	self.vehicle = NetworkUtil.readNodeObject(streamId)
	local name = streamReadString(streamId)
	local setting = self.vehicle:getCpSettings()[name]
	setting:readStream(streamId,connection)
	self:run(connection,setting);
end

--- Writes the serialized data from the sender.
function VehicleSettingsEvent:writeStream(streamId, connection)  -- Wird aufgrufen wenn ich ein event verschicke (merke: reihenfolge der Daten muss mit der bei readStream uebereinstimmen 
	NetworkUtil.writeNodeObject(streamId,self.vehicle)
	streamWriteString(streamId,self.setting:getName())
	self.setting:writeStream(streamId,connection)
end

--- Runs the event on the receiving end of the event.
function VehicleSettingsEvent:run(connection,setting) -- wir fuehren das empfangene event aus
	--- If the receiver was the client make sure every clients gets also updated.
	if not connection:getIsServer() then
		g_server:broadcastEvent(VehicleSettingsEvent.new(self.vehicle,setting), nil, connection, self.vehicle)
	end
end

function VehicleSettingsEvent.sendEvent(vehicle,setting)
	if g_server ~= nil then
		g_server:broadcastEvent(VehicleSettingsEvent.new(vehicle,setting), nil, nil, vehicle)
	else
		g_client:getServerConnection():sendEvent(VehicleSettingsEvent.new(vehicle,setting))
	end
end