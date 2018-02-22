import MetalKit

enum ModelDataTypes{
    case TRIANGLE
    case STALL
}

enum CustomDataTypes{
    case TRIANGLE
}

enum FileDataTypes{
    case STALL
}

class ModelDataLibrary {

    private static var modelDataCollection: [ModelDataTypes: ModelData] = [:]
    
    public static func initialize(){
        setupAllModelData()
    }
    
    private static func setupAllModelData(){
        //Add the custom models here
        addCustomModel(.TRIANGLE)
        
        //Add the file models here
        addFileModel(.STALL)
    }
    
    public static func modelData(_ modelDataType: ModelDataTypes)->ModelData{
        return (modelDataCollection[modelDataType])!
    }
    
    private static func addCustomModel(_ customDataType: CustomDataTypes){
        var modelData = ModelData()
        var modelDataType: ModelDataTypes? = nil
        switch customDataType {
            case .TRIANGLE:
                let triangle = Triangle()
                modelData.vertices = triangle.vertices
                modelData.indices = triangle.indices
                modelDataType = .TRIANGLE
        }
        modelDataCollection.updateValue(modelData, forKey: modelDataType!)
    }
    
    private static func addFileModel(_ fileDataType: FileDataTypes){
        var modelData = ModelData()
        var modelDataType: ModelDataTypes? = nil
        switch fileDataType {
        case .STALL:
            modelData = ModelLoader.LoadModelFromWavefront(filename: "stall.obj")
            modelDataType = .STALL
        }
        modelDataCollection.updateValue(modelData, forKey: modelDataType!)
    }
}

