import UIKit

class MessageDecryptor: NSObject {
    
    func decryptMessage(_ message: String) -> String {
        var number = 1, numberStr = "", result = "", counter = 0, begin = 0, end = 0
        var check = true, checkCounter = false, checkNumber = true
        for char in message {
            if char.isNumber && checkNumber {
                numberStr.append(char)
            }
            else if char == "[" {
                counter += 1
                number = Int(numberStr) ?? 0
                check = false
                checkCounter = true
                checkNumber = false
            }
            else if char == "]" {
                counter -= 1
                checkNumber = true
            }
            else if check {
                result.append(char)
            }
            if counter == 0 && checkCounter {
                let start = message.index(message.startIndex, offsetBy: begin+1)
                let endi = message.index(message.startIndex, offsetBy: end)
                let tmpResult = decryptMessage(String(message[start..<endi]))
                if numberStr != "" {
                    result += String(repeating: tmpResult, count: number)
                    numberStr = ""
                } else {
                    result += tmpResult
                }
                begin = end
                checkCounter = false
                check = true
                print(result)
            }
            if check {
                begin += 1
            }
            end += 1
        }
        
        return result
    }
}
