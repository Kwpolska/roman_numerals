# -*- encoding: utf-8 -*-
# Test Suite for Roman Numeral Converter
# Copyright © MMXVI-MMXVII, Chris Warrick.
# All rights reserved.
# License: 3-clause BSD, see main file for details.

require "./roman_numerals"
require "test/unit"

class TestRomanNumerals < Test::Unit::TestCase
    def test_to_roman
        assert_equal("I", to_roman(1))
        assert_equal("II", to_roman(2))
        assert_equal("III", to_roman(3))
        assert_equal("IV", to_roman(4))
        assert_equal("V", to_roman(5))
        assert_equal("VI", to_roman(6))
        assert_equal("MCCXXXIV", to_roman(1234))
        assert_equal("MCMLVIII", to_roman(1958))
        assert_equal("MMCCXXII", to_roman(2222))
        assert_equal("MMMCMXCIX", to_roman(3999))
    end


    def test_to_roman_invalid
        assert_raise(RangeError) { to_roman(0) }
        assert_raise(RangeError) { to_roman(-1) }
        assert_raise(RangeError) { to_roman(4000) }
    end

    def test_to_roman_file
        file = IO.readlines("../test_data.txt")
        file.each do |line|
            integer, roman = line.strip.split(" ")
            integer = integer.to_i
            assert_equal(roman, to_roman(integer))
        end
    end


    def test_from_roman
        assert_equal(1, from_roman("I"))
        assert_equal(2, from_roman("Ii"))
        assert_equal(3, from_roman("iii"))
        assert_equal(4, from_roman("  iv  "))
        assert_equal(5, from_roman("V"))
        assert_equal(8, from_roman("ViIi"))
    end

    def test_from_roman_file
        file = IO.readlines("../test_data.txt")
        file.each do |line|
            integer, roman = line.strip.split(" ")
            integer = integer.to_i
            assert_equal(integer, from_roman(roman))
        end
    end
end
