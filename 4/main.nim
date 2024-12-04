import std/enumerate
import std/strutils
import std/sequtils
from std/strformat import fmt
import std/options

proc readInput(p: string): seq[string] =
    let f = open(p)
    defer: f.close()

    var rows: seq[string]
    for line in f.lines():
        # let chars = line.split("")
        rows.add(line)

    return rows

proc plus(a: int, b: int): int =
    return a + b

proc minus(a: int, b: int): int =
    return a - b

proc noop(a: int, _: int): int =
    a

proc part1(p: string) =
    echo fmt"Part 1: Running {p}..."

    var total = 0

    # read input into a 2d grid
    let reports = readInput(p)

    # echo reports
    let dim = reports.len()

    # for each position in grid
    for i in 0..(dim-1):
        for j in 0..(dim-1):
            let c = reports[i][j]
            var found = 0

            # is it an "X"?
            if c != char('X'):
                continue

            # check the next 3 chars, in all 8 directions
            for (a, b) in [
                 (plus, plus),
                 (plus, noop),
                 (plus, minus),
                 (noop, plus),
                #  (noop, noop),
                 (noop, minus),
                 (minus, plus),
                 (minus, noop),
                 (minus, minus),
            ]:
                let bounds_check1 = a(i, 3)
                if bounds_check1 >= dim or bounds_check1 < 0:
                    continue

                let bounds_check2 = b(j, 3)
                if bounds_check2 >= dim or bounds_check2 < 0:
                    continue


                let c2 = reports[a(i, 1)][b(j, 1)]
                if c2 != char('M'):
                    continue

                let c3 = reports[a(i, 2)][b(j, 2)]
                if c3 != char('A'):
                    continue


                let c4 = reports[a(i, 3)][b(j, 3)]
                if c4 != char('S'):
                    continue

                found += 1
                echo fmt"Found i={i} j={j}"

            total += found

    echo fmt"total = {total}"

proc part2(p: string) =
    echo fmt"Part 2: Running {p}..."

    var total = 0

    # read input into a 2d grid
    let reports = readInput(p)
    let dim = reports.len()

    # for each position in grid
    for i in 0..(dim-1):
        for j in 0..(dim-1):
            let c = reports[i][j]

            # is it an "A"?
            if c != char('A'):
                continue

            # bounds check
            if i + 1 >= dim or i - 1 < 0 or j + 1 >= dim or j - 1 < 0:
                continue

            let top_l= reports[i-1][j+1]
            let bot_l= reports[i-1][j-1]
            let top_r= reports[i+1][j+1]
            let bot_r = reports[i+1][j-1]

            let diag1 = (top_l == char('M') and bot_r == char('S')) or (top_l == char('S') and bot_r == char('M'))
            let diag2 = (top_r == char('M') and bot_l == char('S')) or (top_r == char('S') and bot_l == char('M'))

            if diag1 and diag2:
                echo fmt"Found i={i} j={j}"
                total += 1

    echo fmt"total = {total}"


part1("example.txt")
# part1("input.txt")

part2("example.txt")
# part2("input.txt")
