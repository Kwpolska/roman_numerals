/*
 * Test Suite for Roman Numeral Converter
 * Copyright © MMXVI, Chris Warrick.
 * All rights reserved.
 * License: 3-clause BSD, see main file for details.
 */

test('edge cases, toRoman', () => {
    const roman_numerals = require('../roman_numerals');
    expect(roman_numerals.toRoman(1)).toBe('I');
    expect(roman_numerals.toRoman(2)).toBe('II');
    expect(roman_numerals.toRoman(3)).toBe('III');
    expect(roman_numerals.toRoman(4)).toBe('IV');
    expect(roman_numerals.toRoman(5)).toBe('V');
    expect(roman_numerals.toRoman(6)).toBe('VI');
    expect(roman_numerals.toRoman(1234)).toBe('MCCXXXIV');
    expect(roman_numerals.toRoman(1958)).toBe('MCMLVIII');
    expect(roman_numerals.toRoman(2222)).toBe('MMCCXXII');
    expect(roman_numerals.toRoman(3999)).toBe('MMMCMXCIX');
});

test('invalid numbers, toRoman', () => {
    const roman_numerals = require('../roman_numerals');
    expect(roman_numerals.toRoman(0)).toBe(-1);
    expect(roman_numerals.toRoman(-1)).toBe(-1);
    expect(roman_numerals.toRoman(4000)).toBe(-1);
});

test('all numbers, toRoman', () => {
    const roman_numerals = require('../roman_numerals');
    const fs = require('fs');
    file = fs.readFileSync('../test_data.txt', {'encoding': 'utf-8'});
    lines = file.split('\n');
    for (var i = 0; i < lines.length; i++) {
        t = lines[i].split(' ');
        integer = parseInt(t[0]);
        roman = t[1];
        if (roman !== undefined && integer !== undefined) {
            expect(roman_numerals.toRoman(integer)).toBe(roman);
        }
    }
});

test('edge cases, fromRoman', () => {
    const roman_numerals = require('../roman_numerals');
    expect(roman_numerals.fromRoman("I")).toBe(1);
    expect(roman_numerals.fromRoman("Ii")).toBe(2);
    expect(roman_numerals.fromRoman("iii")).toBe(3);
    expect(roman_numerals.fromRoman("  iv  ")).toBe(4);
    expect(roman_numerals.fromRoman("V")).toBe(5);
    expect(roman_numerals.fromRoman("ViIi")).toBe(8);
});

test('all numbers, fromRoman', () => {
    const roman_numerals = require('../roman_numerals');
    const fs = require('fs');
    file = fs.readFileSync('../test_data.txt', {'encoding': 'utf-8'});
    lines = file.split('\n');
    for (var i = 0; i < lines.length; i++) {
        t = lines[i].split(' ');
        var integer = parseInt(t[0]);
        var roman = t[1];
        if (roman !== undefined && integer !== undefined) {
            expect(roman_numerals.fromRoman(roman)).toBe(integer);
        }
    }
});
