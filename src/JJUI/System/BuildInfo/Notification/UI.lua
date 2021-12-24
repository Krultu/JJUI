local partsWithId = {}
local awaitRef = {}

local root = {
	ID = 0;
	Type = "ScreenGui";
	Properties = {
		Name = "NOTIFICATION_UI";
		ZIndexBehavior = Enum.ZIndexBehavior.Sibling;
	};
	Children = {
		{
			ID = 1;
			Type = "ScrollingFrame";
			Properties = {
				ClipsDescendants = false;
				Selectable = false;
				ScrollBarThickness = 0;
				Size = UDim2.new(1,0,1,0);
				BackgroundTransparency = 1;
				Name = "F";
				Position = UDim2.new(0,0,0,-36);
				ScrollingEnabled = false;
				BackgroundColor3 = Color3.new(1,1,1);
				BorderSizePixel = 0;
				CanvasSize = UDim2.new();
			};
			Children = {
				{
					ID = 2;
					Type = "UIListLayout";
					Properties = {
						SortOrder = Enum.SortOrder.LayoutOrder;
						HorizontalAlignment = Enum.HorizontalAlignment.Center;
						Padding = UDim.new(0,5);
					};
					Children = {};
				};
				{
					ID = 3;
					Type = "UIPadding";
					Properties = {
						PaddingTop = UDim.new(0,4);
					};
					Children = {};
				};
				{
					ID = 4;
					Type = "TextLabel";
					Properties = {
						Visible = false;
						TextWrapped = true;
						TextStrokeTransparency = 0.75;
						AnchorPoint = Vector2.new(1,0);
						BorderSizePixel = 0;
						Size = UDim2.new(1,0,0,20);
						TextColor3 = Color3.new(16/17,16/17,16/17);
						Text = "";
						BackgroundTransparency = 1;
						FontSize = Enum.FontSize.Size14;
						LayoutOrder = 1;
						Font = Enum.Font.Gotham;
						Name = "Indicator";
						Position = UDim2.new(1,0,0,0);
						TextSize = 14;
						TextYAlignment = Enum.TextYAlignment.Bottom;
						BackgroundColor3 = Color3.new(1,1,1);
						TextWrap = true;
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