/*
 * Roman Numeral Converter
 * Copyright © MMXVI, Chris Warrick.
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

CHAR_VALUES = {
    "M": 1000,
    "D": 500,
    "C": 100,
    "L": 50,
    "X": 10,
    "V": 5,
    "I": 1
}

CHAR_PRECEDENCE = {
    "C": ["M", "D"],
    "X": ["C", "L"],
    "I": ["X", "V"]
}

function fromRoman(roman) {
    var integer = 0;
    roman = roman.trim().toUpperCase();
    var length = roman.length;
    var maxidx = length - 1;
    for (var i = 0; i < length; i++) {
        var ch = roman.charAt(i);
        var nch;
        if (i === maxidx) {
            nch = null;
        } else {
            nch = roman.charAt(i + 1);
        }
        // Is the next character higher in precedence (char is negative)?
        try {
            idx = CHAR_PRECEDENCE[ch].indexOf(nch);
        } catch (e) {
            idx = -1;
        }
        if (idx != -1) {
            integer -= CHAR_VALUES[ch];
        } else {
            integer += CHAR_VALUES[ch];
        }
    }
    return integer;
}

function toRoman(integer) {
    integer = Math.floor(integer);
    if (integer < 1 || integer > 3999) {
        return -1;
    }

    var r = {
        "integer": integer,
        "roman": ""
    };

    r = prepareGroup(r, 1000, 'M', 900, 'CM');
    r = prepareGroup(r, 500, 'D', 400, 'CD');
    r = prepareGroup(r, 100, 'C', 90, 'XC');
    r = prepareGroup(r, 50, 'L', 40, 'XL');
    r = prepareGroup(r, 10, 'X', 9, 'IX');
    r = prepareGroup(r, 5, 'V', 4, 'IV');
    r = prepareGroup(r, 1, 'I', null, null);

    return r.roman;
}

function prepareGroup(r, groupValue, groupLetter, lowerValue, lowerLetter) {
    count = Math.floor(r.integer / groupValue);
    r.integer = r.integer % groupValue;
    for (var i = 0; i < count; i++) {
        r.roman += groupLetter;
    }
    if (lowerValue !== null && r.integer >= lowerValue) {
        r.roman += lowerLetter;
        r.integer -= lowerValue;
    }
    return r;
}


exports = {'fromRoman': fromRoman, 'toRoman': toRoman};
module.exports = exports;
