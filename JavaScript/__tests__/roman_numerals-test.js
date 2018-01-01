/*
 * Test Suite for Roman Numeral Converter
 * Copyright © MMXVI-MMXVIII, Chris Warrick.
 * All rights reserved.
 * License: 3-clause BSD, see main file for details.
 */

test("edge cases, toRoman", () => {
    const romanNumerals = require("../roman_numerals");
    expect(romanNumerals.toRoman(1)).toBe("I");
    expect(romanNumerals.toRoman(2)).toBe("II");
    expect(romanNumerals.toRoman(3)).toBe("III");
    expect(romanNumerals.toRoman(4)).toBe("IV");
    expect(romanNumerals.toRoman(5)).toBe("V");
    expect(romanNumerals.toRoman(6)).toBe("VI");
    expect(romanNumerals.toRoman(1234)).toBe("MCCXXXIV");
    expect(romanNumerals.toRoman(1958)).toBe("MCMLVIII");
    expect(romanNumerals.toRoman(2222)).toBe("MMCCXXII");
    expect(romanNumerals.toRoman(3999)).toBe("MMMCMXCIX");
});

test("invalid numbers, toRoman", () => {
    const romanNumerals = require("../roman_numerals");
    expect(romanNumerals.toRoman(0)).toBe(-1);
    expect(romanNumerals.toRoman(-1)).toBe(-1);
    expect(romanNumerals.toRoman(4000)).toBe(-1);
});

test("all numbers, toRoman", () => {
    const romanNumerals = require("../roman_numerals");
    const fs = require("fs");
    var file = fs.readFileSync("../test_data.txt", {"encoding": "utf-8"});
    var lines = file.split("\n");
    for (var i = 0; i < lines.length; i++) {
        var t = lines[i].split(" ");
        var integer = parseInt(t[0]);
        var roman = t[1];
        if (typeof roman !== "undefined" && typeof integer !== "undefined") {
            expect(romanNumerals.toRoman(integer)).toBe(roman);
        }
    }
});

test("edge cases, fromRoman", () => {
    const romanNumerals = require("../roman_numerals");
    expect(romanNumerals.fromRoman("I")).toBe(1);
    expect(romanNumerals.fromRoman("Ii")).toBe(2);
    expect(romanNumerals.fromRoman("iii")).toBe(3);
    expect(romanNumerals.fromRoman("  iv  ")).toBe(4);
    expect(romanNumerals.fromRoman("V")).toBe(5);
    expect(romanNumerals.fromRoman("ViIi")).toBe(8);
});

test("all numbers, fromRoman", () => {
    const romanNumerals = require("../roman_numerals");
    const fs = require("fs");
    var file = fs.readFileSync("../test_data.txt", {"encoding": "utf-8"});
    var lines = file.split("\n");
    for (var i = 0; i < lines.length; i++) {
        var t = lines[i].split(" ");
        var integer = parseInt(t[0]);
        var roman = t[1];
        if (typeof roman !== "undefined" && typeof integer !== "undefined") {
            expect(romanNumerals.fromRoman(roman)).toBe(integer);
        }
    }
});
