--Author: spiregor
local AutoStick = {}

AutoStick.IsToggled = Menu.AddOption( {"Item Specific", "Auto Magic Stick/Magic Wand"}, "Enable","")
AutoStick.PercentHPOption = Menu.AddOption({ "Item Specific", "Auto Magic Stick/Magic Wand"},"Percent HP", "", 5, 95, 5)


function AutoStick.OnUpdate()
    if not Menu.IsEnabled(AutoStick.IsToggled) then return true end
	--Log.Write(Menu.GetValue(AutoStick.PercentHPOption))
	AutoStick.Combo()
end

function AutoStick.Combo()
	local myHero = Heroes.GetLocal()
	local myHP = Entity.GetMaxHealth(myHero)
    local myMP = NPC.GetMana(myHero)
	if not myHero then return end
	local MagicStick  = NPC.GetItem(myHero, "item_magic_stick", true)
	local MagicWand  = NPC.GetItem(myHero, "item_magic_wand", true)
	local Faeire_fire  = NPC.GetItem(myHero, "item_faerie_fire", true)
	local ValidHP = math.floor(Menu.GetValue(AutoStick.PercentHPOption)*myHP / 100)
	--Log.Write(ValidHP)
	if not NPC.HasState(myHero, Enum.ModifierState.MODIFIER_STATE_INVISIBLE) and (MagicStick) and not NPC.HasModifier(myHero, "modifier_ice_blast") and Entity.IsAlive(myHero) then
		if Item.GetCurrentCharges(MagicStick)>=1 and Entity.GetHealth(myHero) <= ValidHP  then
		  if Ability.IsCastable(MagicStick, 0) then Ability.CastNoTarget(MagicStick) return end
		end
	end

	if not NPC.HasState(myHero, Enum.ModifierState.MODIFIER_STATE_INVISIBLE) and (MagicWand) and not NPC.HasModifier(myHero, "modifier_ice_blast") and Entity.IsAlive(myHero) then	
		if Item.GetCurrentCharges(MagicWand)>=1 and Entity.GetHealth(myHero) <= ValidHP then
		  if Ability.IsCastable(MagicWand, 0) then Ability.CastNoTarget(MagicWand) return end
		end
	end
	
	if not NPC.HasState(myHero, Enum.ModifierState.MODIFIER_STATE_INVISIBLE) and (Faeire_fire) and not NPC.HasModifier(myHero, "modifier_ice_blast") and Entity.IsAlive(myHero) then
		if Entity.GetHealth(myHero) <= ValidHP  then
		  if Ability.IsCastable(Faeire_fire, 0) then Ability.CastNoTarget(Faeire_fire) return end
		end
	end
    --Log.Write("Charge Stick"..":"..Item.GetCurrentCharges(MagicStick))
	--Log.Write("Charge Stick"..":"..Item.GetCurrentCharges(MagicStick).."   ".."Charge Wand"..":"..Item.GetCurrentCharges(MagicWand))
end

return AutoStick