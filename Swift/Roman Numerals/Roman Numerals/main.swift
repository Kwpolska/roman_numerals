/*
 * Roman Numeral Converter
 * Copyright © MMXVI-MMXVIII, Chris Warrick.
 * All rights reserved.
 *
 * Redistribution and use in source and binary forms, with or without
 * modification, are permitted provided that the following conditions are
 * met:
 *
 * 1. Redistributions of source code must retain the above copyright
 *    notice, this list of conditions, and the following disclaimer.
 *
 * 2. Redistributions in binary form must reproduce the above copyright
 *    notice, this list of conditions, and the following disclaimer in the
 *    documentation and/or other materials provided with the distribution.
 *
 * 3. Neither the name of the author of this software nor the names of
 *    contributors to this software may be used to endorse or promote
 *    products derived from this software without specific prior written
 *    consent.
 *
 * THIS SOFTWARE IS PROVIDED BY THE COPYRIGHT HOLDERS AND CONTRIBUTORS
 * "AS IS" AND ANY EXPRESS OR IMPLIED WARRANTIES, INCLUDING, BUT NOT
 * LIMITED TO, THE IMPLIED WARRANTIES OF MERCHANTABILITY AND FITNESS FOR
 * A PARTICULAR PURPOSE ARE DISCLAIMED.  IN NO EVENT SHALL THE COPYRIGHT
 * OWNER OR CONTRIBUTORS BE LIABLE FOR ANY DIRECT, INDIRECT, INCIDENTAL,
 * SPECIAL, EXEMPLARY, OR CONSEQUENTIAL DAMAGES (INCLUDING, BUT NOT
 * LIMITED TO, PROCUREMENT OF SUBSTITUTE GOODS OR SERVICES; LOSS OF USE,
 * DATA, OR PROFITS; OR BUSINESS INTERRUPTION) HOWEVER CAUSED AND ON ANY
 * THEORY OF LIABILITY, WHETHER IN CONTRACT, STRICT LIABILITY, OR TORT
 * (INCLUDING NEGLIGENCE OR OTHERWISE) ARISING IN ANY WAY OUT OF THE USE
 * OF THIS SOFTWARE, EVEN IF ADVISED OF THE POSSIBILITY OF SUCH DAMAGE.
 */

import Foundation

/* Dear Reader:
 * Xcode is pretty crazy, and I couldn’t get their fancy test framework to work for CLI apps.
 * So I wrote something half-assed in 15 minutes.
 * Sorry.
 */
func _testEq(actual: String, expected: String, errors: inout Int) {
    if (actual != expected) {
        print("\n!", actual, expected)
        errors += 1
    }
}

func _testEq(actual: Int, expected: Int, errors: inout Int) {
    if (actual != expected) {
        print("\n!", actual, expected)
        errors += 1
    }
}

func _testRaises(integer: Int, errors: inout Int) {
    do {
        _ = try toRoman(integer: integer)
        errors += 1
    } catch is RangeError {
        // do nothing
    } catch {
        print("Unknown error occurred")
        errors += 1
    }
}

func _finalize(errors: inout Int, allErrors: inout Int) {
    if errors == 0 {
        print("OK")
    } else {
        print(errors, "errors")
    }
    
    allErrors += errors;
    errors = 0;
}

func _cliConvert(input: String) {
    do {
        if let integer = Int(input) {
            print(try toRoman(integer: integer))
        } else {
            print(fromRoman(roman: input))
        }
    } catch is RangeError {
        print("Input out of range")
    } catch {
        print("Unknown error occurred")
    }
}

var args = CommandLine.arguments.dropFirst()
var mode = ""
var testDataFile = ""

print("Mode (test, interactive): ", terminator: "")
mode = readLine()!

if mode == "test" {
    print("Testing Roman Numerals")
    if testDataFile.isEmpty {
        print("Full path to test_data.txt: ", terminator: "")
        testDataFile = readLine()!
    }
    var errors = 0;
    var allErrors = 0;
    
    print("Testing toRoman... ", terminator: "")
    _testEq(actual: try toRoman(integer: 1), expected: "I", errors: &errors)
    _testEq(actual: try toRoman(integer: 2), expected: "II", errors: &errors)
    _testEq(actual: try toRoman(integer: 3), expected: "III", errors: &errors)
    _testEq(actual: try toRoman(integer: 4), expected: "IV", errors: &errors)
    _testEq(actual: try toRoman(integer: 5), expected: "V", errors: &errors)
    _testEq(actual: try toRoman(integer: 6), expected: "VI", errors: &errors)
    _testEq(actual: try toRoman(integer: 1234), expected: "MCCXXXIV", errors: &errors)
    _testEq(actual: try toRoman(integer: 1958), expected: "MCMLVIII", errors: &errors)
    _testEq(actual: try toRoman(integer: 2222), expected: "MMCCXXII", errors: &errors)
    _testEq(actual: try toRoman(integer: 3999), expected: "MMMCMXCIX", errors: &errors)
    _finalize(errors: &errors, allErrors: &allErrors)
    
    print("Testing fromRoman... ", terminator: "")
    _testEq(actual: fromRoman(roman: "I"), expected: 1, errors: &errors)
    _testEq(actual: fromRoman(roman: "Ii"), expected: 2, errors: &errors)
    _testEq(actual: fromRoman(roman: "iii"), expected: 3, errors: &errors)
    _testEq(actual: fromRoman(roman: "   iv   "), expected: 4, errors: &errors)
    _testEq(actual: fromRoman(roman: "V"), expected: 5, errors: &errors)
    _testEq(actual: fromRoman(roman: "ViIi"), expected: 8, errors: &errors)
    _finalize(errors: &errors, allErrors: &allErrors)
    
    print("Testing error conditions... ", terminator: "")
    _testRaises(integer: 0, errors: &errors)
    _testRaises(integer: -1, errors: &errors)
    _testRaises(integer: 4000, errors: &errors)
    _finalize(errors: &errors, allErrors: &allErrors)

    print("Testing file support... ", terminator: "")
    let fileContent = try String(contentsOfFile: testDataFile, encoding: String.Encoding.utf8)
    for line in fileContent.components(separatedBy: "\n") {
        let components = line.components(separatedBy: " ")
        if components.count != 2 { break }
        let integer = Int(components[0])
        let roman = components[1].trimmingCharacters(in: CharacterSet.whitespaces)
        _testEq(actual: try toRoman(integer: integer!), expected: roman, errors: &errors)
        _testEq(actual: fromRoman(roman: roman), expected: integer!, errors: &errors)
    }
    _finalize(errors: &errors, allErrors: &allErrors)
    if (allErrors == 0) {
        print("PASS")
    } else {
        print("FAIL: ", allErrors, "ERRORS")
        exit(1)
    }
} else if mode == "interactive" {
    while true {
        print("Type something to convert or ^C to exit:", terminator: " ")
        let input = readLine()
        _cliConvert(input: input!)
    }
} else {
    print("Unknown mode")
    exit(2)
}
