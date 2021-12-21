local partsWithId = {}
local awaitRef = {}

local root = {
	ID = 0;
	Type = "Frame";
	Properties = {
		AnchorPoint = Vector2.new(0.5,0);
		Name = "Notification";
		Position = UDim2.new(0.5,0,0,4);
		BackgroundTransparency = 1;
		Size = UDim2.new(0.44999998807907,0,0,100);
		BorderSizePixel = 0;
		BackgroundColor3 = Color3.new(248/255,248/255,248/255);
	};
	Children = {
		{
			ID = 1;
			Type = "ImageLabel";
			Properties = {
				ImageColor3 = Color3.new(0,0,0);
				ScaleType = Enum.ScaleType.Slice;
				ImageTransparency = 0.5;
				BackgroundTransparency = 1;
				AnchorPoint = Vector2.new(0.5,1);
				Image = "rbxassetid://8310945691";
				Name = "Container";
				Position = UDim2.new(0.5,0,1,0);
				SliceScale = 0.012000000104308;
				Size = UDim2.new(1,0,0,100);
				BackgroundColor3 = Color3.new(248/255,248/255,248/255);
				SliceCenter = Rect.new(Vector2.new(512,512),Vector2.new(512,512));
			};
			Children = {
				{
					ID = 2;
					Type = "UIScale";
					Properties = {};
					Children = {};
				};
				{
					ID = 3;
					Type = "Frame";
					Properties = {
						AnchorPoint = Vector2.new(0,1);
						Position = UDim2.new(0,0,1,0);
						Name = "Body";
						ClipsDescendants = true;
						BackgroundTransparency = 1;
						Size = UDim2.new(1,0,1,-32);
						BorderSizePixel = 0;
						BackgroundColor3 = Color3.new(1,1,1);
					};
					Children = {
						{
							ID = 4;
							Type = "Frame";
							Properties = {
								Name = "Container";
								BackgroundTransparency = 1;
								Size = UDim2.new(1,0,1,0);
								BorderSizePixel = 0;
								BackgroundColor3 = Color3.new(1,1,1);
							};
							Children = {
								{
									ID = 5;
									Type = "UIPadding";
									Properties = {
										PaddingBottom = UDim.new(0,12);
										PaddingTop = UDim.new(0,12);
										PaddingLeft = UDim.new(0,12);
										PaddingRight = UDim.new(0,12);
									};
									Children = {};
								};
								{
									ID = 6;
									Type = "TextLabel";
									Properties = {
										FontSize = Enum.FontSize.Size14;
										TextColor3 = Color3.new(1,1,1);
										TextSize = 14;
										Text = "message";
										BackgroundTransparency = 1;
										Size = UDim2.new(1,0,1,0);
										TextWrapped = true;
										Font = Enum.Font.Gotham;
										Name = "Content";
										TextXAlignment = Enum.TextXAlignment.Left;
										BackgroundColor3 = Color3.new(1,1,1);
										TextYAlignment = Enum.TextYAlignment.Top;
										BorderSizePixel = 0;
										TextWrap = true;
									};
									Children = {};
								};
							};
						};
						{
							ID = 7;
							Type = "Frame";
							Properties = {
								Name = "Accent";
								BackgroundTransparency = 0.69999998807907;
								Size = UDim2.new(1,0,0,1);
								BorderSizePixel = 0;
								BackgroundColor3 = Color3.new(1,1,1);
							};
							Children = {};
						};
					};
				};
				{
					ID = 8;
					Type = "ImageLabel";
					Properties = {
						ImageColor3 = Color3.new(0,0,0);
						ScaleType = Enum.ScaleType.Slice;
						ImageTransparency = 0.60000002384186;
						BackgroundColor3 = Color3.new(248/255,248/255,248/255);
						BackgroundTransparency = 1;
						Image = "rbxassetid://6276641225";
						Name = "Top";
						Size = UDim2.new(1,0,0,32);
						SliceScale = 0.021999999880791;
						ZIndex = 3;
						BorderSizePixel = 0;
						SliceCenter = Rect.new(Vector2.new(256,256),Vector2.new(256,256));
					};
					Children = {
						{
							ID = 9;
							Type = "TextLabel";
							Properties = {
								FontSize = Enum.FontSize.Size14;
								TextXAlignment = Enum.TextXAlignment.Left;
								TextColor3 = Color3.new(16/17,16/17,16/17);
								BackgroundTransparency = 1;
								Text = "Notification";
								Size = UDim2.new(1,-12,1,0);
								TextWrapped = true;
								AnchorPoint = Vector2.new(1,0);
								Font = Enum.Font.GothamSemibold;
								Name = "Title";
								Position = UDim2.new(1,0,0,0);
								TextSize = 14;
								BackgroundColor3 = Color3.new(1,1,1);
								BorderSizePixel = 0;
								TextWrap = true;
							};
							Children = {};
						};
						-- {
						-- 	ID = 10;
						-- 	Type = "ImageButton";
						-- 	Properties = {
						-- 		LayoutOrder = 3;
						-- 		ScaleType = Enum.ScaleType.Fit;
						-- 		Active = false;
						-- 		Selectable = false;
						-- 		BorderColor3 = Color3.new(9/85,14/85,53/255);
						-- 		ClipsDescendants = true;
						-- 		AnchorPoint = Vector2.new(1,0);
						-- 		Image = "rbxassetid://8310763592";
						-- 		BackgroundTransparency = 1;
						-- 		Position = UDim2.new(0.98500001430511,0,0,5);
						-- 		Size = UDim2.new(1,0,0.75,0);
						-- 		Name = "Exit";
						-- 		BorderSizePixel = 0;
						-- 		BackgroundColor3 = Color3.new(1,1,1);
						-- 	};
						-- 	Children = {
						-- 		{
						-- 			ID = 11;
						-- 			Type = "UIAspectRatioConstraint";
						-- 			Properties = {};
						-- 			Children = {};
						-- 		};
						-- 	};
						-- };
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