require("libs.Utils")
local BsleepTick = nil

-- Setting
-- Auto Midas
local funcmidas = true

function BTick( tick )
	if not client.connected or client.loading or client.console then
			return
	end
	
	if BsleepTick and BsleepTick > tick then
		return
	end
	
	local me = entityList:GetMyHero()
	if not me then
		return
	end
	local midas = me:FindItem("item_hand_of_midas")
	
	local creeps = entityList:FindEntities({classId=CDOTA_BaseNPC_Creep_Neutral,controllable=false,alive=true,illusion=false})

	if funcmidas and midas and me.alive == true and midas.state == -1 and me.unitState ~= 33554432 and me.unitState ~= 256 and me.unitState ~= 33554688 then
		for _,v in ipairs(creeps) do
			if GetDistance2D(me,v) < 700 and v:CanDie() and v.maxHealth >= 950 and v.ancient == false and v.level >= 5 then
				me:SafeCastItem("item_hand_of_midas",v)
			end
		end
	end

	BsleepTick = tick + 500
	return
end
script:RegisterEvent(EVENT_TICK,BTick)
