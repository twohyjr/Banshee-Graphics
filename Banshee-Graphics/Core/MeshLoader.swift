import MetalKit

class MeshLoader {
    
    public static func LoadMeshDataFromWavefront(modelName: String)->MeshData{
//--------------------------------------------------------------------------------------------
//------ Custom Model ---------------------------------------------------------------------------
//--------------------------------------------------------------------------------------------
        let baseData: BaseMeshData = Quad()
        return getMeshData(baseMeshData: baseData)
        
        
//--------------------------------------------------------------------------------------------
//------ Apple Designed Model -------------------------------------------------------------------
//--------------------------------------------------------------------------------------------
//        let bufferAllocator = MTKMeshBufferAllocator(device: Engine.device)
//        let mdlMesh: MDLMesh = MDLMesh(planeWithExtent: vector_float3(1, 1, 1),
//                                       segments: vector_uint2(100, 100),
//                                       geometryType: .triangleStrips,
//                                       allocator: bufferAllocator)
//        mdlMesh.vertexDescriptor = MeshVertexDescriptorLibrary.vertexDescriptor(.BASIC)
//        return getMeshData(mdlMesh: mdlMesh)
        
        
//--------------------------------------------------------------------------------------------
//------ Wavefront Model (OBJ File) -------------------------------------------------------------
//--------------------------------------------------------------------------------------------
//        let bufferAllocator = MTKMeshBufferAllocator(device: Engine.device)
//        guard let assetURL = Bundle.main.url(forResource: modelName, withExtension: "obj") else {
//            fatalError("Asset \(modelName) does not exist.")
//        }
//        let asset = MDLAsset(url: assetURL,
//                             vertexDescriptor: MeshVertexDescriptorLibrary.vertexDescriptor(.BASIC),
//                             bufferAllocator: bufferAllocator)
//
//        return getMeshData(mdlAsset: asset)

    }
    
    ///Input is a custom model
    private static func getMeshData(baseMeshData: BaseMeshData)->MeshData{
        let meshData = MeshData()
        meshData.vertexBuffer = baseMeshData.vertexBuffer
        if(baseMeshData.indexCount > 0){
            meshData.indexBuffer = baseMeshData.indexBuffer
        }
        meshData.vertexDescriptor = baseMeshData.vertexDescriptor
        meshData.primitiveType = baseMeshData.primitiveType
        meshData.indexCount = baseMeshData.indexCount
        meshData.indexType = baseMeshData.indexType
        meshData.vertexCount = baseMeshData.vertexCount
        return meshData
        
    }
    
    ///Input is a obj file model
    private static func getMeshData(mdlAsset: MDLAsset)->MeshData{
        let meshData = MeshData()
        do{
            let meshes = try MTKMesh.newMeshes(asset: mdlAsset, device: Engine.device).metalKitMeshes
            meshData.vertexBuffer = meshes[0].vertexBuffers[0].buffer
            meshData.indexBuffer = meshes[0].submeshes[0].indexBuffer.buffer
            meshData.vertexDescriptor = MTKMetalVertexDescriptorFromModelIO(mdlAsset.vertexDescriptor!)
            meshData.primitiveType = meshes[0].submeshes[0].primitiveType
            meshData.indexCount = meshes[0].submeshes[0].indexCount
            meshData.indexType = meshes[0].submeshes[0].indexType
            meshData.vertexCount = meshes[0].vertexCount
        }catch let error as NSError{
            print(error)
        }
        return meshData
    }
    
    ///Input is an apple designed mesh object
    private static func getMeshData(mdlMesh: MDLMesh)->MeshData{
        let meshData = MeshData()
        do {
            let mtkMesh = try MTKMesh(mesh: mdlMesh, device: Engine.device)
            let mtkVertexBuffer = mtkMesh.vertexBuffers[0]
            let submesh = mtkMesh.submeshes[0]
            let mtkIndexBuffer = submesh.indexBuffer
            
            meshData.vertexBuffer = mtkVertexBuffer.buffer
            meshData.vertexBuffer.label = "Mesh Vertices"
            meshData.vertexDescriptor = MTKMetalVertexDescriptorFromModelIO(mdlMesh.vertexDescriptor)
            meshData.primitiveType = submesh.primitiveType
            meshData.indexBuffer = mtkIndexBuffer.buffer
            meshData.indexBuffer.label = "Mesh Indices"
            meshData.indexCount = submesh.indexCount
            meshData.indexType = submesh.indexType
            meshData.vertexCount = mtkMesh.vertexCount
            
        } catch let error as NSError {
            print(error) // Unable to create MTK mesh from MDL mesh
        }
        return meshData
    }
}


