import UIKit


//: ## 1. Create custom types to represent an Airport Departures display
//: ![Airport Departures](matthew-smith-5934-unsplash.jpg)
//: Look at data from [Departures at JFK Airport in NYC](https://www.airport-jfk.com/departures.php) for reference.
//:
//: a. Use an `enum` type for the FlightStatus (En Route, Scheduled, Canceled, Delayed, etc.)
//:
//: b. Use a struct to represent an `Airport` (Destination or Arrival)
//:
//: c. Use a struct to represent a `Flight`.
//:
//: d. Use a `Date?` for the departure time since it may be canceled.
//:
//: e. Use a `String?` for the Terminal, since it may not be set yet (i.e.: waiting to arrive on time)
//:
//: f. Use a class to represent a `DepartureBoard` with a list of departure flights, and the current airport
enum FlightStatus: String {
    case enRoute = "en route"
    case scheduled
    case canceled
    case delayed
    case onTime = "on time"
    case landed
    case boarding
    
}

struct Airport {
    let name: String
    let iata: String
}

struct Flight {
    let destination: String
    let airline: String
    var departureTime: Date?
    var terminal: String?
    let code: String
    var status: FlightStatus
    
}

class DepartureBoard {
    let departuredFlight: [Flight]
    let airport: Airport
    
    init(departuredFlight: [Flight], airport: Airport){
        self.departuredFlight = departuredFlight
        self.airport = airport
    }
}


//: ## 2. Create 3 flights and add them to a departure board
//: a. For the departure time, use `Date()` for the current time
//:
//: b. Use the Array `append()` method to add `Flight`'s
//:
//: c. Make one of the flights `.canceled` with a `nil` departure time
//:
//: d. Make one of the flights have a `nil` terminal because it has not been decided yet.
//:
//: e. Stretch: Look at the API for [`DateComponents`](https://developer.apple.com/documentation/foundation/datecomponents?language=objc) for creating a specific time


let kalvin = Flight(destination: "Atlanta", airline: "American Airline", departureTime: Date(), terminal: "A3", code: "D48574", status: .onTime)
let you = Flight(destination: "Los Angeles", airline: "Delta", departureTime: nil, terminal: "C2", code: "Ex9458", status: .canceled)
let us = Flight(destination: "Fuzhou",airline: "Cathay Pacific", departureTime: DateComponents(calendar: .current, timeZone: .current, year: 2020, month: 7, day: 19, hour: 10, minute: 50, second: 4).date!, terminal: nil, code: "L58473", status: .delayed)
let them = Flight(destination: "New Wark", airline: "Spirit", departureTime: nil, terminal: "C2", code: "A739", status: .scheduled)

var flights: [Flight] = []
flights.append(kalvin)
flights.append(you)
flights.append(us)
flights.append(them)
print(flights)

let jfk = Airport(name: "John F. Kennedy International Airport", iata: "JFK")
let clt = Airport(name: "Charlotte Douglas International Airport", iata: "CLT")
let foc = Airport(name: "Fuzhou Changle International Airport", iata: "FOC")

let departure = DepartureBoard(departuredFlight: flights, airport: clt)
//departure.append()



//: ## 3. Create a free-standing function that can print the flight information from the `DepartureBoard`
//: a. Use the function signature: `printDepartures(departureBoard:)`
//:
//: b. Use a `for in` loop to iterate over each departure
//:
//: c. Make your `FlightStatus` enum conform to `String` so you can print the `rawValue` String values from the `enum`. See the [enum documentation](https://docs.swift.org/swift-book/LanguageGuide/Enumerations.html).
//:
//: d. Print out the current DepartureBoard you created using the function
func printDepartures(_ departureBoard: DepartureBoard) {
    for flights in departureBoard.departuredFlight{
        print(flights.status.rawValue) //raw value gets the string version of the status enum
    }
}
printDepartures(departure)


//: ## 4. Make a second function to print print an empty string if the `departureTime` is nil
//: a. Createa new `printDepartures2(departureBoard:)` or modify the previous function
//:
//: b. Use optional binding to unwrap any optional values, use string interpolation to turn a non-optional date into a String
//:
//: c. Call the new or udpated function. It should not print `Optional(2019-05-30 17:09:20 +0000)` for departureTime or for the Terminal.
//:
//: d. Stretch: Format the time string so it displays only the time using a [`DateFormatter`](https://developer.apple.com/documentation/foundation/dateformatter) look at the `dateStyle` (none), `timeStyle` (short) and the `string(from:)` method
//:
//: e. Your output should look like:
//:
//:     Destination: Los Angeles Airline: Delta Air Lines Flight: KL 6966 Departure Time:  Terminal: 4 Status: Canceled
//:     Destination: Rochester Airline: Jet Blue Airways Flight: B6 586 Departure Time: 1:26 PM Terminal:  Status: Scheduled
//:     Destination: Boston Airline: KLM Flight: KL 6966 Departure Time: 1:26 PM Terminal: 4 Status: Scheduled
let dateFormat = DateFormatter()
dateFormat.dateFormat = "HH:mm"
func printDepartures2(_ departureBoard: DepartureBoard){
//    let dateFormat = DateFormatter()
//    dateFormat.dateFormat
    for flights in departureBoard.departuredFlight {
        if let timeUnwrapped = flights.departureTime{
            print("Destination: \(flights.destination), Airline: \(flights.airline), Flight: \(flights.code), Departure time: \(dateFormat.string(from: timeUnwrapped)), Terminal: \(flights.terminal ?? ""), Status: \(flights.status.rawValue) ")
        } else {
            let timeUnwrapped = "TBD"
            print("Destination: \(flights.destination), Airline: \(flights.airline), Flight: \(flights.code), Departure time: \(timeUnwrapped), Terminal: \(flights.terminal ?? "TBD"), Status: \(flights.status.rawValue) ")
        }
//        if flights.status == .canceled{
//            print("We're sorry your flight to \(flights.destination) was canceled, here is a $500 voucher")
//            continue
//        } else if flights.status == .scheduled {
//            print("Your flight to \(flights.destination) is scheduled to depart at \(timeUnwrapped) from terminal: \(flights.terminal ?? "TBD")")
//        } else if (flights.status == .boarding) {
//            print("Your flight is boarding, please head to terminal: \(flights.terminal) immediately. The doors are closing soon.")
//        }
//        guard let terminalUnwrapped = flights.terminal else {
//            print(
//            break
//        }
    }
}
printDepartures2(departure)


//: ## 5. Add an instance method to your `DepatureBoard` class (above) that can send an alert message to all passengers about their upcoming flight. Loop through the flights and use a `switch` on the flight status variable.
//: a. If the flight is canceled print out: "We're sorry your flight to \(city) was canceled, here is a $500 voucher"
//:
//: b. If the flight is scheduled print out: "Your flight to \(city) is scheduled to depart at \(time) from terminal: \(terminal)"
//:
//: c. If their flight is boarding print out: "Your flight is boarding, please head to terminal: \(terminal) immediately. The doors are closing soon."
//:
//: d. If the `departureTime` or `terminal` are optional, use "TBD" instead of a blank String
//:
//: e. If you have any other cases to handle please print out appropriate messages
//:
//: d. Call the `alertPassengers()` function on your `DepartureBoard` object below
//:
//: f. Stretch: Display a custom message if the `terminal` is `nil`, tell the traveler to see the nearest information desk for more details.
//extension DepartureBoard {
//    func alertPassengers(){
//        for flights in self.departuredFlight {
//            var timeUnwrapped = ""
//            if flights.departureTime != nil{
//                timeUnwrapped = flights.departureTime.String(from: Date())
//            } else {
//                timeUnwrapped = "TBD"
//
//            }
//        }
//    }
//}
//print(departure.alertPassengers)


//: ## 6. Create a free-standing function to calculate your total airfair for checked bags and destination
//: Use the method signature, and return the airfare as a `Double`
//:
//:     func calculateAirfare(checkedBags: Int, distance: Int, travelers: Int) -> Double {
//:     }
//:
//: a. Each bag costs $25
//:
//: b. Each mile costs $0.10
//:
//: c. Multiply the ticket cost by the number of travelers
//:
//: d. Call the function with a variety of inputs (2 bags, 2000 miles, 3 travelers = $750)
//:
//: e. Make sure to cast the numbers to the appropriate types so you calculate the correct airfare
//:
//: f. Stretch: Use a [`NumberFormatter`](https://developer.apple.com/documentation/foundation/numberformatter) with the `currencyStyle` to format the amount in US dollars.



