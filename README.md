[![Build Status](https://travis-ci.org/iskolbin/lsparsematrix.svg?branch=master)](https://travis-ci.org/iskolbin/lsparsematrix)
[![license](https://img.shields.io/badge/license-public%20domain-blue.svg)]()
[![MIT Licence](https://badges.frapsoft.com/os/mit/mit.svg?v=103)](https://opensource.org/licenses/mit-license.php)

Lua Sparse Matrix
=================

Tiny lua sparse matrix library. Stores values in a flat table with metatable
set. Coordinates are assumed to be numbers in the interval from -2^25 to 2^25.
For Lua 5.3+ with 64-bit integers x, y can be in the interval from -2^31 to 2^31.

```lua
local SparseMatrix = require("sparsematrix")

-- Creation OOP-style (also works in pure procedural style)
local m = SparseMatrix.new({
	1, 5, 'x',
	5, -1, 'y',
})

-- Getting
assert(m:get(1,5) == 'x')
assert(m:get(5,-1) == 'y')
assert(m:get(0,0) == nil)

-- Inserting/deleting
m:set(-2, 3, 'z')
m:set(1, 5, nil)
assert(m:get(-2, 3) == 'z')
assert(m:get(1, 5) == nil)

-- Iteration
-- Should print
--   -2 3 z
--    5 -1 y
for _, x, y, v in m:iter() do
	print(x, y, v)
end 
```

### `SparseMatrix.make([xyvs])`

Create plain lua table and fill it as a sparse matrix with values from `xyvs` which is
flat table containing triples `x`, `y`, `v`.


### `SparseMatrix.new([xyvs])`

Create new sparse matrix and fill it with values from `xyvs`. Internally it's `make`
followed with `setmetatable`.


### `SparseMatrix:set(x, y, [v])`

Sets sparse matrix value at `x`, `y` to `v`(or `nil` if omitted).


### `SparseMatrix:get(x, y, [default])`

Returns value at `x`, `y` or `default` if there is no value(or `nil` if omitted).


### `SparseMatrix:iter()`

Returns iterator pair for general `for`, generates 4 values: `key, x, y, v`.


### `SparseMatrix:next(prevk)`

Returns `key, x, y, v` after key `prevk` (if omitted returns first quartet),
used mainly internally for `iter`.
