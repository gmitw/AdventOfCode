input_file = open("input.txt", "r").read().splitlines()

def splitList(list, half):
    middle_index = len(list)//2
    if half == "F":
        list = list[:middle_index]
    if half == "B":
        list = list[middle_index:]
    if half == "L":
        list = list[:middle_index]
    if half == "R":
        list = list[middle_index:]
    return list

def getRow(i):
    val = i[:7]
    nums = list(range(128))
    a = splitList(nums, val[0])
    b = splitList(a, val[1])
    c = splitList(b, val[2])
    d = splitList(c, val[3])
    e = splitList(d, val[4])
    f = splitList(e, val[5])
    g = splitList(f, val[6])
    return g

def getColumn(i):
    val = i[7:]
    nums = list(range(8))
    a = splitList(nums, val[0])
    b = splitList(a, val[1])
    c = splitList(b, val[2])
    return c

def main():
    answer = []
    for p in input_file:
        r = getRow(p)
        col = getColumn(p)
        # print("Row: " + str(r[0]) + " Column: " + str(col[0]))
        seatID = int(r[0]) * 8 + int(col[0]) 
        answer += [seatID]
    print(sorted(answer, reverse=True)[0])
    


if __name__ == "__main__":
    main()

  
    


