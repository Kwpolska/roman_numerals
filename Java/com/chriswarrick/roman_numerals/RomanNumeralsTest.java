/*
 * Test Suite for Roman Numeral Converter
 * Copyright © MMXVI-MMXVII, Chris Warrick.
 * All rights reserved.
 * License: 3-clause BSD, see main file for details.
 */

package com.chriswarrick.roman_numerals;

import static org.junit.Assert.*;
import org.junit.Test;
import java.io.FileReader;
import java.util.Scanner;

public class RomanNumeralsTest {

    @Test
    public void testToRoman() throws Exception {
        assertEquals("I", RomanNumerals.toRoman(1));
        assertEquals("II", RomanNumerals.toRoman(2));
        assertEquals("III", RomanNumerals.toRoman(3));
        assertEquals("IV", RomanNumerals.toRoman(4));
        assertEquals("V", RomanNumerals.toRoman(5));
        assertEquals("VI", RomanNumerals.toRoman(6));
        assertEquals("MCCXXXIV", RomanNumerals.toRoman(1234));
        assertEquals("MCMLVIII", RomanNumerals.toRoman(1958));
        assertEquals("MMCCXXII", RomanNumerals.toRoman(2222));
        assertEquals("MMMCMXCIX", RomanNumerals.toRoman(3999));
    }

    @Test
    public void testToRomanInvalid() throws Exception {
        try {
            RomanNumerals.toRoman(0);
            fail("0 does not throw exception");
        } catch (Exception e) {
            assertEquals("Integer must be between 1 and 3999", e.getMessage());
        }

        try {
            RomanNumerals.toRoman(-1);
            fail("-1 does not throw exception");
        } catch (Exception e) {
            assertEquals("Integer must be between 1 and 3999", e.getMessage());
        }

        try {
            RomanNumerals.toRoman(4000);
            fail("4000 does not throw exception");
        } catch (Exception e) {
            assertEquals("Integer must be between 1 and 3999", e.getMessage());
        }
    }

    @Test
    public void testToRomanFromFile() throws Exception {
        FileReader fr = new FileReader("../test_data.txt");
        Scanner s = new Scanner(fr);
        int integer;
        String roman;
        while (s.hasNext()) {
            integer = s.nextInt();
            roman = s.next();
            assertEquals(roman, RomanNumerals.toRoman(integer));
        }
        fr.close();
        s.close();
    }

    @Test
    public void testFromRomanFromFile() throws Exception {
        FileReader fr = new FileReader("../test_data.txt");
        Scanner s = new Scanner(fr);
        int integer;
        String roman;
        while (s.hasNext()) {
            integer = s.nextInt();
            roman = s.next();
            assertEquals(integer, RomanNumerals.fromRoman(roman));
        }
        fr.close();
        s.close();
    }
}
