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

package com.chriswarrick.roman_numerals;

import java.util.Map;
import java.util.HashMap;

public class RomanNumerals {
    private int integer;
    private StringBuilder roman;
    private static final Map<Character, Integer> CHAR_VALUES;
    private static final Map<Character, String> CHAR_PRECEDENCE;

    static {
        CHAR_VALUES = new HashMap<>();
        CHAR_VALUES.put('M', 1000);
        CHAR_VALUES.put('D', 500);
        CHAR_VALUES.put('C', 100);
        CHAR_VALUES.put('L', 50);
        CHAR_VALUES.put('X', 10);
        CHAR_VALUES.put('V', 5);
        CHAR_VALUES.put('I', 1);

        CHAR_PRECEDENCE = new HashMap<>();
        CHAR_PRECEDENCE.put('C', "MD");
        CHAR_PRECEDENCE.put('X', "CL");
        CHAR_PRECEDENCE.put('I', "XV");
    }


    RomanNumerals(int integer_) {
        integer = integer_;
        roman = new StringBuilder();
        roman.ensureCapacity(16);
    }

    private void prepareGroup(int groupValue, char groupLetter, int lowerValue, char lowerLetter) {
        int count = integer / groupValue;
        integer = integer % groupValue;
        for (int i = 0; i < count; i++) {
            roman.append(groupLetter);
        }

        if (lowerValue != 0 && integer >= lowerValue) {
            roman.append(lowerLetter);
            roman.append(groupLetter);
            integer -= lowerValue;
        }
    }

    public String toString() {
        return roman.toString();
    }

    public static int fromRoman(String roman_) {
        int integer = 0;
        String roman = roman_.trim().toUpperCase();
        int length = roman.length();
        int maxidx = length - 1;
        char ch;
        char nch;
        for (int i = 0; i < length; i++) {
            ch = roman.charAt(i);
            if (i == maxidx) {
                nch = '\0';
            } else {
                nch = roman.charAt(i + 1);
            }

            if (CHAR_PRECEDENCE.containsKey(ch) && CHAR_PRECEDENCE.get(ch).indexOf(nch) != -1) {
                integer -= CHAR_VALUES.get(ch);
            } else {
                integer += CHAR_VALUES.get(ch);
            }
        }
        return integer;
    }

    public static String toRoman(int integer) {
        RomanNumerals r = new RomanNumerals(integer);
        if (integer < 1 || integer > 3999) {
            throw new IllegalArgumentException("Integer must be between 1 and 3999");
        }
        r.prepareGroup(1000, 'M', 900, 'C');
        r.prepareGroup(500, 'D', 400, 'C');
        r.prepareGroup(100, 'C', 90, 'X');
        r.prepareGroup(50, 'L', 40, 'X');
        r.prepareGroup(10, 'X', 9, 'I');
        r.prepareGroup(5, 'V', 4, 'I');
        r.prepareGroup(1, 'I', 0, '\0');
        return r.toString();
    }
}
