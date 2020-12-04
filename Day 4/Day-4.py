batfile = open("input.txt","r").read().split("\n\n")

filters = ["byr","iyr","eyr","hgt","hcl","ecl","pid"]

c = 0

for p in batfile:
    if all((f in p) for f in filters):
        c += 1

print(c)