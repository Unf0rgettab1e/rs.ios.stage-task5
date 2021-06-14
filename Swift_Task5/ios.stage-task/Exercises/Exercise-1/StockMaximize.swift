import Foundation

class StockMaximize {

    func countProfit(prices: [Int]) -> Int {
        var maxValues = [Int]()
        var maxProfit = 0, begin = 0
        if prices.count > 1 {
            for i in 1..<prices.count {
                if (i+1 < prices.count && prices[i] >= prices[i+1] && prices[i] > prices[i-1]) || (prices[i] > prices[i-1] && i+1 == prices.count) {
                    maxValues.append(i)
                }
            }
            let countMax = maxValues.count
            if countMax > 1 {
                maxValues = deleteUnnecessaryItem(maxValues, prices, 0)
            }
            
            for it in maxValues{
                for i in begin..<it{
                    if prices[it] - prices[i] > 0 {
                        maxProfit += (prices[it] - prices[i])
                    }
                }
                begin = it + 1
            }
        }
        return maxProfit
    }

    func deleteUnnecessaryItem(_ maxValues: [Int], _ prices: [Int], _ begin: Int) -> [Int] {
        var tempMax = 0, copyMaxValues = maxValues, at = 0, countMax = maxValues.count
        if begin < countMax {
            for j in begin..<countMax {
                if prices[copyMaxValues[j]] > tempMax {
                    tempMax = prices[copyMaxValues[j]]
                    at = j
                }
            }
            let beginNew = begin + 1
            if at != 0 {
                copyMaxValues.removeSubrange(begin..<at)
            }
            if at != countMax {
                copyMaxValues = deleteUnnecessaryItem(copyMaxValues, prices, beginNew)
            }
        }
        return copyMaxValues
    }

}
