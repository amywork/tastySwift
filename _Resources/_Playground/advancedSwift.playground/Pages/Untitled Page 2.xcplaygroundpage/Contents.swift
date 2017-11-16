import Foundation

func matches(for regex: String, in text: String) -> [String] {
    guard let regex = try? NSRegularExpression(pattern: regex) else { return []}
    let results = regex.matches(in: text,range: NSRange(text.startIndex..., in: text))
    return results.flatMap { Range($0.range, in: text) }.map { String(text[$0]) }
}
let result = matches(for: "[0-9]+", in: "ab2v9bc13j5jf4jv21")
    .flatMap{ (number: String) -> Int? in
        return Int(number)
    }.filter { (value: Int) -> Bool in
        return value % 2 != 0
    }.map { $0 * $0 }.reduce(0, +)

print(result)

let string = "ab2v9bc13j5jf4jv21"
let numberArray = (try? NSRegularExpression(pattern: "[0-9]+").matches(in: string, range: NSRange(string.startIndex..., in: string)).flatMap { Range($0.range, in: string) }.map { String(string[$0]) }) ?? []

let r = numberArray.flatMap{ (number: String) -> Int? in
    return Int(number)
}.filter { (value: Int) -> Bool in
    return value % 2 != 0
}.map { $0 * $0 }.reduce(0, +)
print(r)

let matched = matches(for: "[0-9]+", in: string)
print(matched)
// ["4", "9"]
