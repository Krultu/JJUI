local partsWithId = {}
local awaitRef = {}

local root = {
	ID = 0;
	Type = "Frame";
	Properties = {
		AnchorPoint = Vector2.new(0.5,0.5);
		Name = "RadialProgress";
		Position = UDim2.new(0.5,0,0.81499999761581,0);
		BackgroundTransparency = 1;
		Size = UDim2.new(0.11299999803305,0,0.18400000035763,0);
		BackgroundColor3 = Color3.new(10/51,10/51,10/51);
	};
	Children = {
		{
			ID = 1;
			Type = "ImageLabel";
			Properties = {
				ImageColor3 = Color3.new(10/51,10/51,10/51);
				ScaleType = Enum.ScaleType.Fit;
				Name = "Left";
				ImageRectSize = Vector2.new(128,256);
				BackgroundTransparency = 1;
				ZIndex = 2;
				Image = "rbxassetid://8295839524";
				Size = UDim2.new(0.5,0,1,0);
			};
			Children = {
				{
					ID = 2;
					Type = "Frame";
					Properties = {
						AnchorPoint = Vector2.new(0.5,0.5);
						Position = UDim2.new(1,0,0.5,0);
						BackgroundTransparency = 1;
						Size = UDim2.new(2,0,1,0);
					};
					Children = {
						{
							ID = 3;
							Type = "ImageLabel";
							Properties = {
								ImageColor3 = Color3.new(11/51,31/51,1);
								Image = "rbxassetid://8295840780";
								BackgroundTransparency = 1;
								ImageRectSize = Vector2.new(128,256);
								ScaleType = Enum.ScaleType.Fit;
								Size = UDim2.new(0.5,0,1,0);
							};
							Children = {};
						};
					};
				};
			};
		};
		{
			ID = 4;
			Type = "ImageLabel";
			Properties = {
				ImageColor3 = Color3.new(10/51,10/51,10/51);
				ScaleType = Enum.ScaleType.Fit;
				ImageRectOffset = Vector2.new(128,0);
				BackgroundTransparency = 1;
				Position = UDim2.new(0.5,0,0,0);
				ImageRectSize = Vector2.new(128,256);
				Image = "rbxassetid://8295839524";
				Name = "Right";
				Size = UDim2.new(0.5,0,1,0);
			};
			Children = {
				{
					ID = 5;
					Type = "Frame";
					Properties = {
						AnchorPoint = Vector2.new(0.5,0.5);
						Position = UDim2.new(0,0,0.5,0);
						BackgroundTransparency = 1;
						Size = UDim2.new(2,0,1,0);
					};
					Children = {
						{
							ID = 6;
							Type = "ImageLabel";
							Properties = {
								ImageColor3 = Color3.new(11/51,31/51,1);
								Image = "rbxassetid://8295840780";
								BackgroundTransparency = 1;
								Position = UDim2.new(0.5,0,0,0);
								ImageRectSize = Vector2.new(128,256);
								ImageRectOffset = Vector2.new(128,0);
								ScaleType = Enum.ScaleType.Fit;
								Size = UDim2.new(0.5,0,1,0);
							};
							Children = {};
						};
					};
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