extension String {
    static var Empty: String{
        return "";
    }
    
    subscript (i: Int) -> Character {
        return self[index(startIndex, offsetBy: i)]
    }
    
    mutating func trim()->String{
        return self.trimmingCharacters(in: .whitespaces)
    }
}
