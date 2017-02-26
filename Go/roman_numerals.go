package roman_numerals

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

import (
    "strings"
    "errors"
)

var CHAR_VALUES = map[byte]int{
    'M': 1000,
    'D': 500,
    'C': 100,
    'L': 50,
    'X': 10,
    'V': 5,
    'I': 1,
}

var CHAR_PRECEDENCE = map[byte][2]byte{
    'C': [2]byte{'M', 'D'},
    'X': [2]byte{'C', 'L'},
    'I': [2]byte{'X', 'V'},
}

func FromRoman(roman string) int {
    var ch, nch byte
    roman = strings.ToUpper(strings.TrimSpace(roman))
    integer := 0
    length := len(roman)
    maxidx := length - 1
    for i := 0; i < len(roman); i++ {
        ch = roman[i]
        if i == maxidx {
            nch = 0
        } else {
            nch = roman[i + 1]
        }

        if (nch != 0) && (CHAR_PRECEDENCE[ch][0] == nch || CHAR_PRECEDENCE[ch][1] == nch) {
            integer -= CHAR_VALUES[ch]
        } else {
            integer += CHAR_VALUES[ch]
        }
    }

    return integer
}

func ToRoman(integer int) (string, error) {
    if integer < 1 || integer > 3999 {
        //raise ValueError()
        return "", errors.New("Integer must be between 1 and 3999")
    }

    roman := ""
    integer, roman = prepareGroup(integer, roman, 1000, "M", 900, "CM")
    integer, roman = prepareGroup(integer, roman, 500, "D", 400, "CD")
    integer, roman = prepareGroup(integer, roman, 100, "C", 90, "XC")
    integer, roman = prepareGroup(integer, roman, 50, "L", 40, "XL")
    integer, roman = prepareGroup(integer, roman, 10, "X", 9, "IX")
    integer, roman = prepareGroup(integer, roman, 5, "V", 4, "IV")
    integer, roman = prepareGroup(integer, roman, 1, "I", 0, "")

    return roman, nil
}

func prepareGroup(integer int, roman string, group_value int, group_letter string, lower_value int, lower_letter string) (int, string) {
    count := integer / group_value
    integer = integer % group_value
    roman += strings.Repeat(group_letter, count)
    if lower_value > 0 && integer >= lower_value {
        roman += lower_letter
        integer -= lower_value
    }
    return integer, roman
}
