import UIKit

class MessageDecryptor: NSObject {
    
    func decryptMessage(_ message: String) -> String {
        var number = 1, numberStr = "", result = message, counter = 0, begin = 0, end = 0, copyMessage = message

        for char in message {
            if char.isNumber {
                numberStr.append(char)
            }
            var check = true, checkCounter = false
            if char == "[" {
                counter += 1
                number = Int(number)
                check = false
                checkCounter = true
            }
            if char == "]" {
                counter -= 1
            }
            if counter == 0 && checkCounter {
                let start = message.index(message.startIndex, offsetBy: begin)
                let endi = message.index(message.startIndex, offsetBy: end)
                result += decryptMessage(String(message[start..<endi]))
            }
            if check {
                begin += 1
            }
            end += 1
            
        }
        result = String(repeating: result, count: number)
        return result
    }
}
