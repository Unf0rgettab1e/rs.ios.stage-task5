import Foundation

public typealias Supply = (weight: Int, value: Int)

public final class Knapsack {
    let maxWeight: Int
    let drinks: [Supply]
    let foods: [Supply]
    var maxKilometers: Int {
        findMaxKilometres()
    }
    
    init(_ maxWeight: Int, _ foods: [Supply], _ drinks: [Supply]) {
        self.maxWeight = maxWeight
        self.drinks = drinks
        self.foods = foods
    }
    
    func findMaxKilometres() -> Int {
        var distanceFoods = [[Int]]()
        distanceFoods.reserveCapacity(foods.count)
        for i in 0..<foods.count {
            var food = [Int]()
            food.reserveCapacity(maxWeight)
            for j in 1...maxWeight {
                if i == 0 && foods[i].weight <= j {
                    food.append(foods[i].value)
                    continue
                } else if i == 0 {
                    food.append(0)
                    continue
                }
                if foods[i].weight <= j {
                    food.append(max(distanceFoods[i-1][j-1], (foods[i].value + ((j - foods[i].weight-1 >= 0) ? distanceFoods[i-1][j-foods[i].weight-1] : 0))))
                } else {
                    food.append(distanceFoods[i-1][j-1])
                }
            }
            distanceFoods.append(food)
        }
        var distanceDrinks = [[Int]]()
        distanceDrinks.reserveCapacity(drinks.count)
        for i in 0..<drinks.count {
            var drink = [Int]()
            drink.reserveCapacity(maxWeight)
            for j in 1...maxWeight {
                if i == 0 && drinks[i].weight <= j {
                    drink.append(drinks[i].value)
                    continue
                } else if i == 0 {
                    drink.append(0)
                    continue
                }
                if drinks[i].weight <= j {
                    drink.append(max(distanceDrinks[i-1][j-1], (drinks[i].value + ((j - drinks[i].weight-1 >= 0) ? distanceDrinks[i-1][j-drinks[i].weight-1] : 0))))
                } else {
                    drink.append(distanceDrinks[i-1][j-1])
                }
            }
            distanceDrinks.append(drink)
        }
        var result = Int()
        for i in 1..<maxWeight {
            let foodSet = distanceFoods[foods.count-1][maxWeight-i-1], drinkSet = distanceDrinks[drinks.count-1][i-1]
            let tmpRes = (foodSet <= drinkSet ? foodSet : drinkSet)
            if foodSet != 0 && drinkSet != 0 && tmpRes >= result{
                result = tmpRes
            }
        }

        return result
    }
}
