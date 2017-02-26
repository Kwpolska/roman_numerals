package roman_numerals

import (
    "bufio"
    "os"
    "strconv"
    "strings"
    "testing"
)

func assertEqualFR(argument string, expected int, t *testing.T) {
    actual := FromRoman(argument)
    if actual != expected {
        t.Error("Expected ", expected, ", got ", actual)
    }
}

func assertEqualTR(argument int, expected string, t *testing.T) {
    actual, e := ToRoman(argument)
    if actual != expected {
        t.Error("Expected ", expected, ", got ", actual)
    }
    if e != nil {
        t.Error("Unexpected error in FromRoman: ", e)
    }
}

func TestToRoman(t *testing.T) {
    assertEqualTR(1, "I", t)
    assertEqualTR(1, "I", t)
    assertEqualTR(2, "II", t)
    assertEqualTR(3, "III", t)
    assertEqualTR(4, "IV", t)
    assertEqualTR(5, "V", t)
    assertEqualTR(6, "VI", t)
    assertEqualTR(1234, "MCCXXXIV", t)
    assertEqualTR(1958, "MCMLVIII", t)
    assertEqualTR(2222, "MMCCXXII", t)
    assertEqualTR(3999, "MMMCMXCIX", t)
}

func TestToRomanInvalid(t *testing.T) {
    _, e1 := ToRoman(-1)
    _, e0 := ToRoman(0)
    _, e4000 := ToRoman(4000)

    if e1 == nil {
        t.Error("-1 did not return range error")
    }
    if e0 == nil {
        t.Error("0 did not return range error")
    }
    if e4000 == nil {
        t.Error("4000 did not return range error")
    }
}

func TestFromRoman(t *testing.T) {
    assertEqualFR("I", 1, t)
    assertEqualFR("Ii", 2, t)
    assertEqualFR("iii", 3, t)
    assertEqualFR("  iv  ", 4, t)
    assertEqualFR("V", 5, t)
    assertEqualFR("ViIi", 8, t)
}

func TestFile(t *testing.T) {
    file, err := os.Open("../test_data.txt")
    if err != nil {
        t.Error("Test data not found")
    }
    defer file.Close()

    scanner := bufio.NewScanner(file)
    for scanner.Scan() {
        line := scanner.Text()
        if line == "" {
            break
        }
        slice := strings.Split(line, " ")
        integer_s := slice[0]
        roman := slice[1]
        integer, err := strconv.Atoi(integer_s)
        if err != nil {
            t.Error("Unable to convert to int: ", integer_s)
        }

        assertEqualTR(integer, roman, t)
        assertEqualFR(roman, integer, t)
    }
}
