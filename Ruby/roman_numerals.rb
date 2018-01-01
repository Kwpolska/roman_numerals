# Roman Numeral Converter
# Copyright © MMXVI-MMXVIII, Chris Warrick.
# All rights reserved.
#
# Redistribution and use in source and binary forms, with or without
# modification, are permitted provided that the following conditions are
# met:
#
# 1. Redistributions of source code must retain the above copyright
#    notice, this list of conditions, and the following disclaimer.
#
# 2. Redistributions in binary form must reproduce the above copyright
#    notice, this list of conditions, and the following disclaimer in the
#    documentation and/or other materials provided with the distribution.
#
# 3. Neither the name of the author of this software nor the names of
#    contributors to this software may be used to endorse or promote
#    products derived from this software without specific prior written
#    consent.
#
# THIS SOFTWARE IS PROVIDED BY THE COPYRIGHT HOLDERS AND CONTRIBUTORS
# "AS IS" AND ANY EXPRESS OR IMPLIED WARRANTIES, INCLUDING, BUT NOT
# LIMITED TO, THE IMPLIED WARRANTIES OF MERCHANTABILITY AND FITNESS FOR
# A PARTICULAR PURPOSE ARE DISCLAIMED.  IN NO EVENT SHALL THE COPYRIGHT
# OWNER OR CONTRIBUTORS BE LIABLE FOR ANY DIRECT, INDIRECT, INCIDENTAL,
# SPECIAL, EXEMPLARY, OR CONSEQUENTIAL DAMAGES (INCLUDING, BUT NOT
# LIMITED TO, PROCUREMENT OF SUBSTITUTE GOODS OR SERVICES; LOSS OF USE,
# DATA, OR PROFITS; OR BUSINESS INTERRUPTION) HOWEVER CAUSED AND ON ANY
# THEORY OF LIABILITY, WHETHER IN CONTRACT, STRICT LIABILITY, OR TORT
# (INCLUDING NEGLIGENCE OR OTHERWISE) ARISING IN ANY WAY OUT OF THE USE
# OF THIS SOFTWARE, EVEN IF ADVISED OF THE POSSIBILITY OF SUCH DAMAGE.

CHAR_VALUES = {
    "M" => 1000,
    "D" => 500,
    "C" => 100,
    "L" => 50,
    "X" => 10,
    "V" => 5,
    "I" => 1
}

CHAR_PRECEDENCE = {
    "C" => ["M", "D"],
    "X" => ["C", "L"],
    "I" => ["X", "V"]
}

# Convert a Roman numeral to an integer.
def from_roman(roman)
    roman = roman.strip.upcase
    roman_a = roman.chars
    integer = 0
    roman_a.zip(roman_a[1..-1]).each do |ch, nch|
        if CHAR_PRECEDENCE.has_key?(ch) and CHAR_PRECEDENCE[ch].include?(nch)
            integer -= CHAR_VALUES[ch]
        else
            integer += CHAR_VALUES[ch]
        end
    end
    integer
end

# Convert an ingeter to a Roman numeral.
def to_roman(integer)
    integer = integer.to_i
    if integer < 1 or integer > 3999
        raise RangeError, "Integer must be between 1 and 3999"
    end

    roman = ""
    integer, roman = prepare_group(integer, roman, 1000, "M", 900, "CM")
    integer, roman = prepare_group(integer, roman, 500, "D", 400, "CD")
    integer, roman = prepare_group(integer, roman, 100, "C", 90, "XC")
    integer, roman = prepare_group(integer, roman, 50, "L", 40, "XL")
    integer, roman = prepare_group(integer, roman, 10, "X", 9, "IX")
    integer, roman = prepare_group(integer, roman, 5, "V", 4, "IV")
    integer, roman = prepare_group(integer, roman, 1, "I", nil, nil)

    roman
end


# Prepare a Roman numeral group.
def prepare_group(integer, roman, group_value, group_letter, lower_value, lower_letter)
    count, integer = integer.divmod(group_value)
    roman += group_letter * count
    if lower_value and integer >= lower_value
        roman += lower_letter
        integer -= lower_value
    end
    return integer, roman
end
