import std/enumerate
import std/strutils
import std/sequtils
from std/strformat import fmt
import std/options

proc readInput(p: string): seq[seq[int]] =
    let f = open(p)
    defer: f.close()

    var reports: seq[seq[int]]
    for line in f.lines():
        let values = line.split(" ").map(parseInt)
        reports.add(values)

    return reports

type Direction = enum
    Unknown, Increasing, Decreasing

proc isSafe(r: seq[int], tolerate: int): bool =
    var prevOpt = none(int)
    var sortDirection = Direction.Unknown
    for (idx, current) in enumerate(r):
        if idx == tolerate:
            continue

        if prevOpt.isNone:
            prevOpt = some(current)
            continue

        # Check: Any two adjacent levels differ by at least one and at most three.
        var prev = prevOpt.get()
        let diff =  abs(prev - current)
        if not (diff >= 1 and diff <= 3):
            return false

        prevOpt = some(current)

        # Check: The levels are either all increasing or all decreasing.
        # NOTE: Do we need to care about repeated values? I think if we saw those, it should be unsafe, since it's not ALL increasing or decreasing
        if prev == current:
            return false

        let sortDir = (if prev > current: Direction.Increasing else: Direction.Decreasing)
        if sortDirection == Direction.Unknown:
            # set initial direction
            sortDirection = sortDir
        else:
            if sortDir != sortDirection:
                return false
    return true

proc part1(p: string) =
    echo fmt"Part 1: Running {p}..."

    let reports = readInput(p)

    var total = 0
    for r in reports:
        if isSafe(r, -1):
            total += 1

    echo fmt"total = {total}"

proc part2(p: string) =
    echo fmt"Part 2: Running {p}..."

    let reports = readInput(p)

    var total = 0
    for r in reports:
        for tolerate_idx, x in enumerate(r):
            if isSafe(r, tolerate_idx):
                total += 1
                break

    echo fmt"total = {total}"


part1("example.txt")
part1("input.txt")

part2("example.txt")
part2("input.txt")
