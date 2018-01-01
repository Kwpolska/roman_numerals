-- Test Suite for Roman Numeral Converter
-- Copyright © MMXVI-MMXVIII, Chris Warrick.
-- All rights reserved.
-- License: 3-clause BSD, see main file for details.

require('roman_numerals')
local lu = require('luaunit')

TestRomanNumerals = {} -- class
    function test_to_roman()
        lu.assertEquals(to_roman(1), "I")
        lu.assertEquals(to_roman(2), "II")
        lu.assertEquals(to_roman(3), "III")
        lu.assertEquals(to_roman(4), "IV")
        lu.assertEquals(to_roman(5), "V")
        lu.assertEquals(to_roman(6), "VI")
        lu.assertEquals(to_roman(1234), "MCCXXXIV")
        lu.assertEquals(to_roman(1958), "MCMLVIII")
        lu.assertEquals(to_roman(2222), "MMCCXXII")
        lu.assertEquals(to_roman(3999), "MMMCMXCIX")
    end

    function test_to_roman_invalid()
        lu.assertErrorMsgContains("Integer must be between 1 and 3999", to_roman, 0)
        lu.assertErrorMsgContains("Integer must be between 1 and 3999", to_roman, -1)
        lu.assertErrorMsgContains("Integer must be between 1 and 3999", to_roman, 4000)
    end

    function test_from_roman()
        lu.assertEquals(from_roman("I"), 1)
        lu.assertEquals(from_roman("Ii"), 2)
        lu.assertEquals(from_roman("iii"), 3)
        lu.assertEquals(from_roman("  iv  "), 4)
        lu.assertEquals(from_roman("V"), 5)
        lu.assertEquals(from_roman("ViIi"), 8)
    end

    function test_to_roman_file()
        local fh = assert(io.open('../test_data.txt'))

        while true do
            local line = fh:read("*line")
            if not line then break end
            local space = line:find(" ")
            integer = tonumber(line:sub(1, space))
            integer = tonumber(integer)
            roman = line:sub(space, -1)
            lu.assertEquals(to_roman(integer), roman)
        end
        fh:close()
    end

    function test_from_roman_file()
        local fh = assert(io.open('../test_data.txt'))

        while true do
            local line = fh:read("*line")
            if not line then break end
            local space = line:find(" ")
            integer = tonumber(line:sub(1, space))
            integer = tonumber(integer)
            roman = line:sub(space, -1)
            lu.assertEquals(from_roman(roman), integer)
        end
        fh:close()
    end
-- class TestRomanNumerals

local runner = lu.LuaUnit.new()
runner:setOutputType("tap")
os.exit( runner:runSuite() )
