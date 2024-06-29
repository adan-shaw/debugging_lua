--[[
	desc:获取时区
	auth:Carol Luo
]]


local os = os
local zone = os.date("%Z")

---获取时区
---@return string|UTC
local function localf()
	return zone
end

return localf


--[[
	GMT 格林威治標準時間 GMT
	UTC 全球座標時間 GMT
	ECT 歐洲中央時間 GMT+1:00
	EET 東歐時間 GMT+2:00
	ART (阿拉伯) 埃及標準時間 GMT+2:00
	EAT 東非時間 GMT+3:00
	MET 中東時間 GMT+3:30
	NET 近東時間 GMT+4:00
	PLT 巴基斯坦拉合爾時間 GMT+5:00
	IST 印度標準時間 GMT+5:30
	BST 孟加拉標準時間 GMT+6:00
	VST 越南標準時間 GMT+7:00
	CTT 中國標準時間 GMT+8:00
	JST 日本標準時間 GMT+9:00
	ACT 澳洲中央時間 GMT+9:30
	AET 東澳時間 GMT+10:00
	SST 索羅門標準時間 GMT+11:00
	NST 紐西蘭標準時間 GMT+12:00
	MIT 中途島時間 GMT-11:00
	HST 夏威夷標準時間 GMT-10:00
	AST 阿拉斯加標準時間 GMT-9:00
	PST 太平洋標準時間 GMT-8:00
	PNT 鳳凰城標準時間 GMT-7:00
	MST 山區標準時間 GMT-7:00
	CST 中央標準時間 GMT-6:00
	EST 東部標準時間 GMT-5:00
	IET 印地安那州東部標準時間 GMT-5:00
	PRT 波多黎各及美國維京島時間 GMT-4:00
	CNT 加拿大紐芬蘭時間 GMT-3:30
	AGT 阿根廷標準時間 GMT-3:00
	BET 巴西東部時間 GMT-3:00
	CAT 中非時間 GMT-1:00
]]
