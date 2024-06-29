--[[
	desc:a*寻路算法
]]

---a*寻路算法
---@param   params  searchRouteInfo @搜索信息
---@return number[]|nil          @返回路径 {1~6:方向,...}
local function localf(params)
end

return localf


---@class searchRouteInfo        @寻路信息 每一圈 + 5个
---@field direction integer[][]  @方向位移
---@field diroffset integer[]    @偏移距离
---@field orioffset integer[]    @起步距离(偏移+朝向)
---@field gridworld integer[]    @格子地图
---@field targetpos integer      @目标位置 {x,y}
---@field originpos integer      @开始位置 {x,y}
