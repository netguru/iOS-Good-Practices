import Cocoa

let testVal: String? = "7"
let dummyString: String? = "nope"

let newVal = testVal.map { $0 + "0" }
let extraVal = testVal.map { Int($0) }
let nextVal = testVal.flatMap { Int($0) }
let broken = dummyString.flatMap { Int($0) }

print(newVal)
print(extraVal)
print(nextVal)
print(broken)

var finalDate: Date?
var timestampFromBackend: String? = "2021-04-07T11:44:00+0000"

if let timestampFromBackend = timestampFromBackend {
    finalDate = ISO8601DateFormatter().date(from: timestampFromBackend)
}

print(finalDate)

timestampFromBackend = "2022-04-07T11:44:00+0000"
finalDate = timestampFromBackend.flatMap { ISO8601DateFormatter().date(from: $0) }
print(finalDate)

timestampFromBackend = nil
finalDate = timestampFromBackend.flatMap { ISO8601DateFormatter().date(from: $0) }
print(finalDate)


// simulate backend responses
fileprivate struct RawResponse: Decodable {
    let timestamp: String?
}

struct Response: Decodable {
    let date: Date?
    
    init(from decoder: Decoder) throws {
        let raw = try RawResponse(from: decoder)
        
        date = raw.timestamp.flatMap { ISO8601DateFormatter().date(from: $0) }
    }
}

let json = """
{
  "timestamp": "2022-04-07T11:44:00+0000"
}
""".data(using: .utf8)!

let response = try JSONDecoder().decode(Response.self, from: json)
dump(response)

let badJson = """
{
  "timestamp": null
}
""".data(using: .utf8)!

let badResponse = try JSONDecoder().decode(Response.self, from: badJson)
dump(badResponse)
