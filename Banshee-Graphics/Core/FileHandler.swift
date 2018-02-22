import Foundation

class FileHandler{
    
    public static func LoadFileString(fileName: String)->[String]{
        let url = Bundle.main.url(forResource: fileName, withExtension: nil)
        var readStringProject: String = ""
        do{ readStringProject = try String(contentsOf: url!)}catch{ }
        return readStringProject.components(separatedBy: .newlines)
    }
    
}
