import std/strutils
import std/sequtils
from std/strformat import fmt
from std/algorithm import sort

proc readInput(p: string): (seq[int], seq[int]) =
    let f = open(p)
    defer: f.close()

    var left_list: seq[int]
    var right_list: seq[int]
    for line in f.lines():
        let values= line.split("   ").map(parseInt)

        let left = values[0]
        let right = values[1]

        left_list.add(left)
        right_list.add(right)

    sort(left_list)
    sort(right_list)

    return (left_list, right_list)

proc part1(p: string) =
    echo fmt"Part 1: Running {p}..."
    let (left_list, right_list) = readInput(p)

    let zipped = zip(left_list, right_list)
    var total = 0
    for pair in zipped:
        total += abs(pair[0]-pair[1])

    echo fmt"total = {total}"


proc part2(p: string) =
    echo fmt"Part 2: Running {p}..."
    let (left_list, right_list) = readInput(p)

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
