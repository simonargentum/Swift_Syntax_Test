import UIKit

enum Voice: String, CaseIterable {
    case low, medium, high
}

protocol RunningCreature {
    var runningSpeed: Int {get}
    var amountOfLegs: Int {get}
    var isRunning: Bool {get set}
    
    func run()
    func stop()
}

protocol SpeakingCreature {
    var voice: Voice {get}
    var isMuted: Bool {get set}
    
    func mute()
    func talk()
}

class Human {
    struct Name {
        private(set) var name: String
        private(set) var surname: String
        private(set) var patronymic: String
    }
    
    var person: Name
    
    private var _age: Int = 0 {
        didSet {
            happyBirthdayAction(self.age)
        }
    }
    
    var age: Int {
        get {
            self._age
        }
        set {
            if newValue >= 0 && newValue != self.age {
                self._age = newValue
            }
        }
    }
    
    var isAdult: Bool {
        if age >= 18 {
            return true
        } else {
            return false
        }
    }
    
    let happyBirthdayAction = { (age: Int) -> Void in
        print("С днем рождения! Тебе \(age) лет")
    }
    
    init(person: Name, age: Int) {
        self.person = person
        self.age = age
    }
}

class Animal {
    private(set) var isHerbivorous: Bool
    private var name: String
    
    class var numberOfInstances: Int { 22 }
    
    init(name: String, isHerbivorous: Bool) {
        self.name = name
        self.isHerbivorous = isHerbivorous
    }
    
    class func printInfo() {
        print("Нас осталось \(numberOfInstances) особей")
    }
}

class Tiger: Animal, RunningCreature {
    var runningSpeed: Int = 22
    
    var amountOfLegs: Int = 4
    
    var isRunning: Bool = true
    
    func run() {
        if !self.isRunning {
            self.isRunning
            print("побежали!")
        }
    }
    
    func stop() {
        if self.isRunning {
            !self.isRunning
            print("тормозим!")
        }
    }
    
    override class func printInfo() {
        print("Я редкий тигр! На соталось \(numberOfInstances)")
    }
    
    func eatTheAnimal(animal: Animal) {
        if !(animal is Tiger) {
            print("я съел \(animal)")
        } else if let animal = animal as? RunningCreature, animal.runningSpeed < self.runningSpeed {
            print("я съел \(animal)")
        }
    }
}

class Parrot: Animal, SpeakingCreature {
    var voice: Voice = .high
    
    var isMuted: Bool = true
    
    override class var numberOfInstances: Int { 77 }
    
    func mute() {
        if !isMuted {
            isMuted
        }
        print("помолчи")
    }
    
    func talk() {
        if isMuted {
            !isMuted
        }
        print("базарь, Кеша")
    }
}

final class Zoo {
    final var maxNumberOfAnimals: Int = Int.random(in: 1...22)
    final var name: String
    private(set) var animals: [Animal] = []
    private(set) var visitors: [Human] = []

    var totalNumberOfVisitors: Int = 0 {
        willSet {
            print("Как здорово, что вы к нам пришли!")
        }
    }
    
    init(maxNumberOfAnimals: Int, name: String) {
        self.maxNumberOfAnimals = maxNumberOfAnimals
        self.name = name
    }
    
    init(name: String) {
        self.name = name
    }
    
    func addingTheAnimal(animal: Animal) {
        if animals.count <= self.maxNumberOfAnimals {
            self.animals.append(animal)
        } else {
            print("В зоопарке нет места!")
        }
        zooInfo()
    }
    
    func addingTheVisitor(visitor: Human) {
        self.visitors.append(visitor)
        self.totalNumberOfVisitors += 1
        zooInfo()
    }
    
    func addingTheVisitors(visitors: [Human]) {
        self.visitors.append(contentsOf: visitors)
        self.totalNumberOfVisitors += visitors.count
        zooInfo()
    }
    
    func deletingAdultVisitors() {
        for (index, visitor) in visitors.enumerated() {
            if visitor.age >= 18 {
                visitors.remove(at: index)
            }
        }
        zooInfo()
    }
    
    func deletingTigers() {
        for (index, animal) in animals.enumerated() {
            if animal is Tiger {
                animals.remove(at: index)
            }
        }
        zooInfo()
    }
    
    private func zooInfo() {
        print("животных в зоопраке \(animals.count), посетителей за все время \(visitors.count)")
    }
    
    func feedingLion() {
        print("сегодня лев съест \(animals.randomElement())")
    }
}

let monkey = Animal(name: "Обезьяна", isHerbivorous: true)
let tiger = Tiger(name: "Тигр", isHerbivorous: false)
let rabbit = Animal(name: "Кролик", isHerbivorous: true)
let lion = Animal(name: "Лев", isHerbivorous: false)
let zoo = Zoo(name: "Зоопарк №1")
zoo.addingTheAnimal(animal: monkey)
zoo.addingTheAnimal(animal: tiger)
zoo.addingTheAnimal(animal: rabbit)
zoo.addingTheAnimal(animal: lion)
let firstVisitor = Human(person: Human.Name.init(name: "Семён", surname: "Серебрянский", patronymic: "Станиславович"), age: 30)
let secondVisitor = Human(person: Human.Name.init(name: "Александр", surname: "Серебрянский", patronymic: "Станиславович"), age: 34)
let thirdVisitor = Human(person: Human.Name.init(name: "Елисей", surname: "Серебрянский", patronymic: "Семенович"), age: 1)
let visitors: [Human] = [firstVisitor, secondVisitor, thirdVisitor]
zoo.addingTheVisitors(visitors: visitors)
tiger.eatTheAnimal(animal: rabbit)
zoo.deletingAdultVisitors()
zoo.deletingTigers()
for animal in zoo.animals {
    if let animal = animal as? SpeakingCreature {
        animal.talk()
    } else if let animal = animal as? RunningCreature {
        animal.runningSpeed
    } else {
        animal.isHerbivorous
    }
}

