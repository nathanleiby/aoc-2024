# from std/strutils import (split,map)
import std/strutils

# from std/sequtils import map, zip
import std/sequtils

from std/strformat import fmt
from std/algorithm import sort

proc part1(p: string) =
    echo fmt"Part 1: Running {p}..."
    # read file
    let f = open(p)
    defer: f.close()

    # let left_list = newSeq(1)
    var left_list: seq[int]
    var right_list: seq[int]
    # let right_list = newSeq(1)
    # var vec: seq[seq[float32]]
    for line in f.lines():
        # split on space
        let values= line.split("   ").map(parseInt)

        let left = values[0]
        let right = values[1]

        # add data into two lists
            # left item into list 1
            # right item into list 2
        # echo fmt"{left} {right}"
        left_list.add(left)
        right_list.add(right)


    # sort the listsA
    sort(left_list)
    sort(right_list)

    # go through the pairs and compute distances: abs(a-b)
    let zipped = zip(left_list, right_list)

    var total = 0
    # sum the distances
    for pair in zipped:
        total += abs(pair[0]-pair[1])

    echo fmt"total = {total}"


proc part2(p: string) =
    echo fmt"Part 2: Running {p}..."
    # read file
    let f = open(p)
    defer: f.close()

    # let left_list = newSeq(1)
    var left_list: seq[int]
    var right_list: seq[int]
    # let right_list = newSeq(1)
    # var vec: seq[seq[float32]]
    for line in f.lines():
        # split on space
        let values= line.split("   ").map(parseInt)

        let left = values[0]
        let right = values[1]

        # add data into two lists
            # left item into list 1
            # right item into list 2
        # echo fmt"{left} {right}"
        left_list.add(left)
        right_list.add(right)


    # sort the listsA
    sort(left_list)
    sort(right_list)

    var total = 0
    for l in left_list:
        var count = 0
        for r in right_list:
            if l == r:
                count += 1

        total += (count * l)

    echo fmt"total = {total}"


part1("example.txt")
part1("input.txt")

part2("example.txt")
part2("input.txt")
