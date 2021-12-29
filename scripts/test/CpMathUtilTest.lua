lu = require("luaunit")
package.path = package.path .. ";../?.lua;../ai/?.lua"
require('mock-GiantsEngine')
require('mock-Courseplay')
require('CpObject')
require('CpUtil')
require('CpMathUtil')

local s = CpMathUtil.getSeries(1, 10, 1)
lu.assertItemsEquals(s, {1, 2, 3, 4, 5, 6, 7, 8, 9, 10})
s = CpMathUtil.getSeries(0, 10, 1)
lu.assertItemsEquals(s, {0, 1, 2, 3, 4, 5, 6, 7, 8, 9, 10})
s = CpMathUtil.getSeries(1, 10, 2)
lu.assertItemsEquals(s, {1, 3.25, 5.5, 7.75, 10})
s = CpMathUtil.getSeries(-10, 10, 2)
lu.assertItemsEquals(s, {-10, -8, -6, -4, -2, 0, 2, 4, 6, 8, 10})
s = CpMathUtil.getSeries(10, 1, 2)
lu.assertItemsEquals(s, {10, 7.75, 5.5, 3.25, 1})
s = CpMathUtil.getSeries(1, 10, 10)
lu.assertItemsEquals(s, {1, 10})
s = CpMathUtil.getSeries(1, 10, 100)
lu.assertItemsEquals(s, {1, 10})
s = CpMathUtil.getSeries(10, 1, 100)
lu.assertItemsEquals(s, {1, 10})

s = CpMathUtil.getSeries(0, 10.5, 1)
lu.assertItemsEquals(s, {0, 1.05, 2.1, 3.15, 4.2, 5.25, 6.3, 7.35, 8.4, 9.45, 10.5})