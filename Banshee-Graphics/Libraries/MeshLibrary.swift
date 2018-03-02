import MetalKit

enum MeshDataTypes{
    
    //Custom Types
    case TRIANGLE
    case QUAD
    
    //Wavefront file types
    case FRUIT_STAND
    case ARMADILLO
    
    //Apple Desinged Types
    case PLANE_APPLE
    case CONE_APPLE
    case SPHERE_APPLE
    case ICOSAHEDRON_APPLE
    case CAPSULE_APPLE
    case CYLINDER_APPLE
    case HEMISPHERE_APPLE
    case CUBE_APPLE
}

class MeshLibrary {

    private static var meshes: [MeshDataTypes: MeshData] = [:]
    
    public static func initialize(){
        setupAllMeshData()
    }
    
    private static func setupAllMeshData(){
        //Custom Meshes
        addCustomMesh(baseMeshData: Triangle())
        addCustomMesh(baseMeshData: Quad())
        
        //Wavefront OBJ Meshes
        addWavefrontMesh(modelName: "stall", meshDataType: .FRUIT_STAND)
        addWavefrontMesh(modelName: "armadillo", meshDataType: .ARMADILLO)
        
        //Apple Meshes
        addAppleDesignedMesh(appleDesignedMeshType: .PLANE, meshDataType: .PLANE_APPLE)
        addAppleDesignedMesh(appleDesignedMeshType: .CONE, meshDataType: .CONE_APPLE)
        addAppleDesignedMesh(appleDesignedMeshType: .SPHERE, meshDataType: .SPHERE_APPLE)
        addAppleDesignedMesh(appleDesignedMeshType: .ICOSAHEDRON, meshDataType: .ICOSAHEDRON_APPLE)
        addAppleDesignedMesh(appleDesignedMeshType: .CAPSULE, meshDataType: .CAPSULE_APPLE)
        addAppleDesignedMesh(appleDesignedMeshType: .CYLINDER, meshDataType: .CYLINDER_APPLE)
        addAppleDesignedMesh(appleDesignedMeshType: .CUBE, meshDataType: .CUBE_APPLE)
    }
    
    public static func mesh(_ meshDataType: MeshDataTypes)->MeshData{
        return (meshes[meshDataType])!
    }
    
    private static func addCustomMesh(baseMeshData: BaseMeshData){
        meshes.updateValue(MeshLoader.LoadCustomMeshData(baseMeshData: baseMeshData), forKey: baseMeshData.meshDataType)
    }
    
    private static func addWavefrontMesh(modelName: String, meshDataType: MeshDataTypes){
        meshes.updateValue(MeshLoader.LoadMeshDataFromWavefront(modelName: modelName), forKey: meshDataType)
    }
    
    private static func addAppleDesignedMesh(appleDesignedMeshType: AppleDesignedMeshTypes, meshDataType: MeshDataTypes){
        meshes.updateValue(MeshLoader.LoadAppleDesignedMeshData(appleDesignedMeshType: appleDesignedMeshType), forKey: meshDataType)
    }
}

