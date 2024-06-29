-- 禁用断言
_ASSERT = false

-- 测试断言(这里不会触发错误)
local value = assert(10 > 20)
print("Assertion passed")
