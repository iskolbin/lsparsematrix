local SparseMatrix = require("sparsematrix")

local function test()
local x = SparseMatrix.new{
	1, 2, 'x',
	3, 4, 'y',
	5, 3, 'z',
	-10, -5, 'w',
	-10000, 20000, 'j',
	500000, -800000, 'k',
}

x:set(-9000000, -900000, 'i')

assert(x:get(1,2) == 'x')
assert(x:get(3,4) == 'y')
assert(x:get(5,3) == 'z')
assert(x:get(-10,-5) == 'w')
assert(x:get(-10000,20000) == 'j')
assert(x:get(500000,-800000) == 'k')
assert(x:get(-9000000,-900000) == 'i')
assert(x:get(-9000001,-900000) == nil)
assert(x:get(0,-900000) == nil)
assert(x:get(0,0) == nil)

local t = {}
for _, _, _, v in x:iter() do
	t[#t+1] = v
end
assert(#t == 7)

x:set(1,2,'u')
assert(x:get(1,2) == 'u')

x:set(1,2,nil)
assert(x:get(1,2) == nil)
end

test()
