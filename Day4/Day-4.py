import re
import itertools

openfile = open("input.txt", "r")
batfile = openfile.read().split("\n\n")

filters = ["byr", "iyr", "eyr", "hgt", "hcl", "ecl", "pid"]

filtered_list = []

for p in batfile:
    if all((f in p) for f in filters):
        filtered_list += [p]

c = len(filtered_list)

for i in filtered_list:
    try:
        forms = re.split('[\n ]', i)
        for form in forms:
            d = form.split(":")
            
            if "iyr" in d[0] and 2010 <= int(d[1]) <= 2020:
                pass
            
    except:
        print("exception")

openfile.close()

"""
byr: 1920 => 2002
iyr: 2010 => 2020
eyr: 2020 => 2030
hgt: number followed by 'cm' or 'in'
hcl: a '#' followed by exactly sic characters 0-9 or a-f
ecl: exactly one of: amb, blu, brn, gry, grn, hzl, oth
pid: a nine-digit number, including leading zeroes
"""