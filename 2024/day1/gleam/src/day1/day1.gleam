import gleam/int
import gleam/io
import gleam/list
import gleam/result
import gleam/string
import simplifile

pub fn part1(input: String) -> Int {
  let pairs =
    input
    |> string.trim
    |> string.split("\n")
    |> list.map(fn(line) {
      case string.split(line, "   ") {
        [left, right] -> {
          let l = result.unwrap(int.parse(left), 0)
          let r = result.unwrap(int.parse(right), 0)
          #(l, r)
        }
        _ -> #(0, 0)
      }
    })

  let left =
    pairs
    |> list.map(fn(pair) { pair.0 })
    |> list.sort(int.compare)

  let right =
    pairs
    |> list.map(fn(pair) { pair.1 })
    |> list.sort(int.compare)

  list.zip(left, right)
  |> list.map(fn(pair) { int.absolute_value(pair.0 - pair.1) })
  |> list.fold(0, fn(acc, x) { acc + x })
}

pub fn part2(input: String) -> Int {
  let pairs =
    input
    |> string.trim
    |> string.split("\n")
    |> list.map(fn(line) {
      case string.split(line, "   ") {
        [left, right] -> {
          let l = result.unwrap(int.parse(left), 0)
          let r = result.unwrap(int.parse(right), 0)
          #(l, r)
        }
        _ -> #(0, 0)
      }
    })

  let left = list.map(pairs, fn(pair) { pair.0 })
  let right = list.map(pairs, fn(pair) { pair.1 })

  list.fold(left, 0, fn(acc, num) {
    let occurrences = list.filter(right, fn(r) { r == num }) |> list.length
    acc + num * occurrences
  })
}

pub fn solve() {
  let assert Ok(input) = simplifile.read(from: "src/day1/a.txt")
  io.print("--- Day 1: Historian Hysteria --- \n")
  io.println(int.to_string(part1(input)))
  io.println(int.to_string(part2(input)))
}
