/*
 * Roman Numeral Converter
 * Copyright © MMXVI-MMXVII, Chris Warrick.
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

var CHAR_VALUES: [Character: Int] = [
    "M": 1000,
    "D": 500,
    "C": 100,
    "L": 50,
    "X": 10,
    "V": 5,
    "I": 1
]

var CHAR_PRECEDENCE: [Character: [Character]] = [
    "C": ["M", "D"],
    "X": ["C", "L"],
    "I": ["X", "V"]
]

class RomanTuple {
    var integer: Int
    var roman: String

    init(integer: Int, roman: String) {
        self.integer = integer
        self.roman = roman
    }

    func prepareGroup(groupValue: Int, groupLetter: String, lowerValue: Int?, lowerLetter: String?) {
        let count = self.integer / groupValue
        self.integer = self.integer % groupValue
        self.roman.append(String.init(repeating: groupLetter, count: count))
        if (lowerValue != nil) && (integer >= lowerValue!) {
            self.roman.append(lowerLetter!)
            self.integer -= lowerValue!
        }
    }
}

struct RangeError: Error {
    let input: Int
}

func fromRoman(roman: String) -> Int {
    let roman = roman.trimmingCharacters(in: CharacterSet.whitespaces).uppercased().characters
    var nRoman = roman.dropFirst()
    nRoman.append("\0")
    var integer = 0

    for (ch, nch) in zip(roman, nRoman) {
        let cp = CHAR_PRECEDENCE[ch]
        if cp != nil && cp!.contains(nch) {
            integer -= CHAR_VALUES[ch]!
        } else {
            integer += CHAR_VALUES[ch]!
        }
    }

    return integer
}

func toRoman(integer: Int) throws -> String {
    if integer < 1 || integer > 3999 {
        throw RangeError(input: integer)
    }

    let rt = RomanTuple(integer: integer, roman: "")
    rt.prepareGroup(groupValue: 1000, groupLetter: "M", lowerValue: 900, lowerLetter: "CM")
    rt.prepareGroup(groupValue: 500, groupLetter: "D", lowerValue: 400, lowerLetter: "CD")
    rt.prepareGroup(groupValue: 100, groupLetter: "C", lowerValue: 90, lowerLetter: "XC")
    rt.prepareGroup(groupValue: 50, groupLetter: "L", lowerValue: 40, lowerLetter: "XL")
    rt.prepareGroup(groupValue: 10, groupLetter: "X", lowerValue: 9, lowerLetter: "IX")
    rt.prepareGroup(groupValue: 5, groupLetter: "V", lowerValue: 4, lowerLetter: "IV")
    rt.prepareGroup(groupValue: 1, groupLetter: "I", lowerValue: nil, lowerLetter: nil)

    return rt.roman
}
