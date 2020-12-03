def moveToboggan(right,down):
    file = open("input.txt", "r").read().splitlines()
    d = 0
    c = 0
    r = 0

    while d < len(file):
        if (file[d]*100000)[r] == '#':
            c+=1
        r += right
        d += down
    return c

def main():
    one = moveToboggan(1,1)
    two = moveToboggan(3,1)
    three = moveToboggan(5,1)
    four = moveToboggan(7,1)
    five = moveToboggan(1,2)

    answer = one * two * three * four * five
    print(answer)


if __name__ == "__main__":
    main()
