local math = math
local pairs = pairs
local ipairs = ipairs
local setmetatable = setmetatable

---不重复随机-缓存版本
---@param  list any[]   			@随机数组
---@param  map  table<any,true>|nil	@排除数据
---@return fun(index:index|nil):index				@随机闭包
local function localf(list,map)
	--容量
	local capacity = #list
	--占用
	local takeup = 0
	--记录
	local cache = setmetatable({},
	{
		__index = function(t,index)
			return list[index]
		end
	})
	
	local function closure(index)
		---避免报错
		if takeup == capacity then
			---容错(随机一个结果)
			index = math.random(1,capacity)
			return cache[index]
		end
	
		---记录未占用数据
		takeup = takeup + 1
		index = index or math.random(takeup,capacity)
		local value = cache[index]
	
		---更新剩余的数据
		cache[index] = cache[takeup]
		---删除占用的数据
		cache[takeup] = nil
		return value
	end

	---设置排除项
	if map then
		for key, _ in pairs(map) do
			for index, value in ipairs(list) do
				if key == value and index > takeup then
					closure(index)
				end
			end
		end
	end

	return closure
end

return localf