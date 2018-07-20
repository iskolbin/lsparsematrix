Lua Sparse Matrix
=================

Tiny lua sparse matrix library. Stores values in a flat table with metatable
set. Coordinates are assumed to be numbers in the interval from -2^26 to 2^26.

### `SparseMatrix.new`

Create new sparse matrix

### `SparseMatrix:set( x, y, [v] )`

Sets sparse matrix value at `x`, `y` to `v`(or `nil` if omitted)

### `SparseMatrix:get( x, y, [default] )`

Returns value at `x`, `y` or `default` if there is no value(or `nil` if omitted)

### `SparseMatrix:iter()`

Returns iterator triplet for general `for`, generates 4 values: `key, x, y, v`

### `SparseMatrix:next(prevk)`

Returns `key, x, y, v` after key `prevk` (if omitted returns first quartet),
used mainly internally for `iter` 
