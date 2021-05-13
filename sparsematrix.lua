--[[

 sparsematrix - v0.1.0 - public domain Lua sparse matrix library
 no warranty implied; use at your own risk

 author: Ilya Kolbin (iskolbin@gmail.com)
 url: github.com/iskolbin/lsparsematrix

 See documentation in README file.

 COMPATIBILITY

 Lua 5.1+, LuaJIT

 LICENSE

 See end of file for license information.

--]]

local setmetatable, next, floor = _G.setmetatable, _G.next, math.floor

local SparseMatrix = {}

SparseMatrix.__index = SparseMatrix

function SparseMatrix.make(xyvs)
	local m, mset = {}, SparseMatrix.set
	if xyvs then
		for i = 1, #xyvs, 3 do
			mset(m, xyvs[i], xyvs[i+1], xyvs[i+2])
		end
	end
	return m
end

function SparseMatrix.new(xyvs)
	return setmetatable(SparseMatrix.make(xyvs), SparseMatrix)
end

if math.maxinteger and math.maxinteger >= 9223372036854775807 then

function SparseMatrix:set(x, y, v)
	if y < 0 then
		y = 4294967296 + y
	end
	self[x*4294967296 + y] = v
	return self
end

function SparseMatrix:get(x, y, default)
	if y < 0 then
		y = 4294967296 + y
	end
	return self[x*4294967296 + y] or default
end

load([[return function(SparseMatrix)
function SparseMatrix:next(prevk)
	local k, v = next(self, prevk)
	if not k then
		return
	end
	local x = k//4294967296
	local y = k - x*4294967296
	if y > 2147483648 then
		y = y - 4294967296
	end
	return k, x, y, v
end
end]])()(SparseMatrix)

else

function SparseMatrix:set(x, y, v)
	if y < 0 then
		y = 67108864 + y
	end
	self[x*67108864 + y] = v
	return self
end

function SparseMatrix:get(x, y, default)
	if y < 0 then
		y = 67108864 + y
	end
	return self[x*67108864 + y] or default
end

function SparseMatrix:next(prevk)
	local k, v = next(self, prevk)
	if not k then
		return
	end
	local x = floor(k/67108864)
	local y = k - x*67108864
	if y > 33554432 then
		y = y - 67108864
	end
	return k, x, y, v
end

end

function SparseMatrix:iter()
	return SparseMatrix.next, self
end

return SparseMatrix

--[[
------------------------------------------------------------------------------
This software is available under 2 licenses -- choose whichever you prefer.
------------------------------------------------------------------------------
ALTERNATIVE A - MIT License
Copyright (c) 2018 Ilya Kolbin
Permission is hereby granted, free of charge, to any person obtaining a copy of
this software and associated documentation files (the "Software"), to deal in
the Software without restriction, including without limitation the rights to
use, copy, modify, merge, publish, distribute, sublicense, and/or sell copies
of the Software, and to permit persons to whom the Software is furnished to do
so, subject to the following conditions:
The above copyright notice and this permission notice shall be included in all
copies or substantial portions of the Software.
THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE
SOFTWARE.
------------------------------------------------------------------------------
ALTERNATIVE B - Public Domain (www.unlicense.org)
This is free and unencumbered software released into the public domain.
Anyone is free to copy, modify, publish, use, compile, sell, or distribute this
software, either in source code form or as a compiled binary, for any purpose,
commercial or non-commercial, and by any means.
In jurisdictions that recognize copyright laws, the author or authors of this
software dedicate any and all copyright interest in the software to the public
domain. We make this dedication for the benefit of the public at large and to
the detriment of our heirs and successors. We intend this dedication to be an
overt act of relinquishment in perpetuity of all present and future rights to
this software under copyright law.
THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
AUTHORS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER LIABILITY, WHETHER IN AN
ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM, OUT OF OR IN CONNECTION
WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE SOFTWARE.
------------------------------------------------------------------------------
--]]
