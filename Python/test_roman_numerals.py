# -*- encoding: utf-8 -*-
# Test Suite for Roman Numeral Converter
# Copyright © MMXVI-MMXVII, Chris Warrick.
# All rights reserved.
# License: 3-clause BSD, see main file for details.

"""Test suite for Roman Numeral Converter."""
import pytest
from roman_numerals import to_roman, from_roman


def test_to_roman():
    assert to_roman(1) == 'I'
    assert to_roman(2) == 'II'
    assert to_roman(3) == 'III'
    assert to_roman(4) == 'IV'
    assert to_roman(5) == 'V'
    assert to_roman(6) == 'VI'
    assert to_roman(1234) == 'MCCXXXIV'
    assert to_roman(1958) == 'MCMLVIII'
    assert to_roman(2222) == 'MMCCXXII'
    assert to_roman(3999) == 'MMMCMXCIX'


def test_to_roman_invalid():
    with pytest.raises(ValueError):
        to_roman(0)
    with pytest.raises(ValueError):
        to_roman(-1)
    with pytest.raises(ValueError):
        to_roman(4000)


def test_to_roman_file():
    with open('../test_data.txt') as fh:
        for line in fh:
            integer, roman = line.strip().split(' ')
            integer = int(integer)
            assert to_roman(integer) == roman


def test_from_roman():
    assert from_roman("I") == 1
    assert from_roman("Ii") == 2
    assert from_roman("iii") == 3
    assert from_roman("  iv  ") == 4
    assert from_roman("V") == 5
    assert from_roman("ViIi") == 8


def test_from_roman_file():
    with open('../test_data.txt') as fh:
        for line in fh:
            integer, roman = line.strip().split(' ')
            integer = int(integer)
            assert from_roman(roman) == integer


if __name__ == '__main__':
    print("Please run with py.test.")
