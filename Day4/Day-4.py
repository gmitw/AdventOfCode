lines = [line.replace('\n',' ') for line in open('input.txt').read().split('\n\n')]
passports = [dict(tuple(x.split(':')) for x in line.split()) for line in lines]

def hgt_rule(s):
    if s[-2:] == 'cm':
        return 150 <= int(s.split('cm')[0]) <= 193
    elif s[-2:] == 'in':
        return 59 <= int(s.split('in')[0]) <= 76
    else:
        return False

ruleset = {
    'byr': lambda x: 1920 <= int(x) <= 2002,
    'iyr': lambda x: 2010 <= int(x) <= 2020,
    'eyr': lambda x: 2020 <= int(x) <= 2030,
    'hgt': lambda x: hgt_rule(x),
    'hcl': lambda x: len(x) == 7 and x[0] == '#' and all(c.isnumeric() or c in 'abcdef' for c in x[1:]),
    'ecl': lambda x: x in 'amb blu brn gry grn hzl oth'.split(),
    'pid': lambda x: len(x) == 9 and x.isnumeric()
}

def part1(d):
    return all(key in d for key in ruleset)

def part2(d):
    return all(key in d and ruleset[key](d[key]) for key in ruleset)

print(sum(part1(p) for p in passports))
print(sum(part2(p) for p in passports))