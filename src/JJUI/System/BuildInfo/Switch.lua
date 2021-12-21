local partsWithId = {}
local awaitRef = {}

local root = {
	ID = 0;
	Type = "ImageButton";
	Properties = {
		AnchorPoint = Vector2.new(0.5,0.5);
		Image = "rbxassetid://8206471480";
		Name = "Switch";
		Position = UDim2.new(0.5,0,0.34833329916,0);
		ImageColor3 = Color3.new(10/51,49/255,49/255);
		BackgroundTransparency = 1;
		Size = UDim2.new(0.30000001192093,0,0.090000003576279,0);
	};
	Children = {
		{
			ID = 1;
			Type = "UIAspectRatioConstraint";
			Properties = {
				AspectRatio = 2;
				DominantAxis = Enum.DominantAxis.Height;
				AspectType = Enum.AspectType.ScaleWithParentSize;
			};
			Children = {};
		};
		{
			ID = 2;
			Type = "ImageLabel";
			Properties = {
				AnchorPoint = Vector2.new(1,0.5);
				Image = "rbxassetid://8206467461";
				Name = "Circle";
				Position = UDim2.new(0.5,0,0.5,0);
				BackgroundTransparency = 1;
				Size = UDim2.new(1,0,0.89999997615814,0);
			};
			Children = {
				{
					ID = 3;
					Type = "UIAspectRatioConstraint";
					Properties = {
						DominantAxis = Enum.DominantAxis.Height;
						AspectType = Enum.AspectType.ScaleWithParentSize;
					};
					Children = {};
				};
			};
		};
	};
};

local function Scan(item, parent)
	local obj = Instance.new(item.Type)
	if (item.ID) then
		local awaiting = awaitRef[item.ID]
		if (awaiting) then
			awaiting[1][awaiting[2]] = obj
			awaitRef[item.ID] = nil
		else
			partsWithId[item.ID] = obj
		end
	end
	for p,v in pairs(item.Properties) do
		if (type(v) == "string") then
			local id = tonumber(v:match("^_R:(%w+)_$"))
			if (id) then
				if (partsWithId[id]) then
					v = partsWithId[id]
				else
					awaitRef[id] = {obj, p}
					v = nil
				end
			end
		end
		obj[p] = v
	end
	for _,c in pairs(item.Children) do
		Scan(c, obj)
	end
	obj.Parent = parent
	return obj
end

return function(p) return Scan(root, p) end