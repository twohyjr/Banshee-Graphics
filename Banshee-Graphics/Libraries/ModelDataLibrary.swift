import MetalKit

enum ModelDataTypes{
    case TRIANGLE
    case STALL
    case QUAD
}

enum CustomDataTypes{
    case TRIANGLE
    case QUAD
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
        addCustomModel(.QUAD)
        
        //Add the file models here
        addFileModel(.STALL)
    }
    
    public static func modelData(_ modelDataType: ModelDataTypes)->ModelData{
        return (modelDataCollection[modelDataType])!
    }
    
    private static func addCustomModel(_ customDataType: CustomDataTypes){
        var baseData: BaseModelData!
        switch customDataType {
        case .TRIANGLE:
            baseData = Triangle()
        case .QUAD:
            baseData = Quad()
        }
        var modelData = ModelData()
        modelData.vertices = baseData.vertices
        modelData.indices = baseData.indices
        modelDataCollection.updateValue(modelData, forKey: baseData.modelDataType)
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

