batfile = open("input.txt","r").read().split("\n\n")

filters = ["byr","iyr","eyr","hgt","hcl","ecl","pid"]

filtered_list = []

for p in batfile:
    if all((f in p) for f in filters):
        filtered_list += [p]

"""
byr: 1920 => 2002
iyr: 2010 => 2020
eyr: 2020 => 2030
hgt: digit followed by 
"""