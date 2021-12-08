-- Create instances and give it properties using a function
return function(classname, props)
	local x = Instance.new(classname)
	for i,v in pairs(props) do
		if x[i] then
			x[i]=v
		end
	end
	return x
end