import MetalKit

class MeshLoader {
    
    //--------------------------------------------------------------------------------------------
    //------ Custom Model ---------------------------------------------------------------------------
    //--------------------------------------------------------------------------------------------
    public static func LoadCustomMeshData(baseMeshData: BaseMeshData)->MeshData{
        return getMeshData(baseMeshData: baseMeshData)
    }
    
    //--------------------------------------------------------------------------------------------
    //------ Apple Designed Models ------------------------------------------------------------------
    //--------------------------------------------------------------------------------------------
    public static func LoadAppleDesignedMeshData(appleDesignedMeshType: AppleDesignedMeshTypes)->MeshData{
        var meshData = MeshData()
        
        let bufferAllocator = MTKMeshBufferAllocator(device: Engine.device)
        var mdlMesh: MDLMesh!
        switch appleDesignedMeshType {
        case .PLANE:
            mdlMesh = MDLMesh(planeWithExtent: vector_float3(1, 1, 1),
                                                   segments: vector_uint2(100, 100),
                                                   geometryType: .triangleStrips,
                                                   allocator: bufferAllocator)
        }
        //        //----PLANE-----
        //        let mdlMesh: MDLMesh = MDLMesh(planeWithExtent: vector_float3(1, 1, 1),
        //                                       segments: vector_uint2(100, 100),
        //                                       geometryType: .triangleStrips,
        //                                       allocator: bufferAllocator)
        //
        //        //----CONE-----
        //        let mdlMesh: MDLMesh = MDLMesh(coneWithExtent: vector_float3(1,1,1),
        //                                       segments: vector_uint2(100,100),
        //                                       inwardNormals: false,
        //                                       cap: false,
        //                                       geometryType: .triangles,
        //                                       allocator: bufferAllocator)
        //
        //        //----SPHERE-----
        //        let mdlMesh: MDLMesh = MDLMesh(sphereWithExtent: vector_float3(1,1,1),
        //                                       segments: vector_uint2(100,100),
        //                                       inwardNormals: false,
        //                                       geometryType: .triangles,
        //                                       allocator: bufferAllocator)
        //
        //        //----ICOSAHEDRON-----
        //        let mdlMesh: MDLMesh = MDLMesh(icosahedronWithExtent: vector_float3(1,1,1),
        //                                       inwardNormals: false,
        //                                       geometryType: .triangles,
        //                                       allocator: bufferAllocator)
        //        //----CAPSULE-----
        //       let mdlMesh: MDLMesh = MDLMesh(capsuleWithExtent: vector_float3(1,1,1),
        //                                      cylinderSegments: vector_uint2(100,100),
        //                                      hemisphereSegments: 100,
        //                                      inwardNormals: false,
        //                                      geometryType: .triangles,
        //                                      allocator: bufferAllocator)
        //        //----CYLINDER-----
        //        let mdlMesh: MDLMesh = MDLMesh(cylinderWithExtent: vector_float3(1,1,1),
        //                                       segments: vector_uint2(100,100),
        //                                       inwardNormals: false,
        //                                       topCap: false,
        //                                       bottomCap: false,
        //                                       geometryType: .triangles,
        //                                       allocator: bufferAllocator)
        //        //----HEMISPHERE-----
        //        let mdlMesh: MDLMesh = MDLMesh(hemisphereWithExtent: vector_float3(1,1,1),
        //                                       segments: vector_uint2(100,100),
        //                                       inwardNormals: false,
        //                                       cap: true,
        //                                       geometryType: .triangles,
        //                                       allocator: bufferAllocator)
        //      //----CUBE-----
        //      let mdlMesh: MDLMesh = MDLMesh(boxWithExtent: vector_float3(1,1,1),
        //                                       segments: vector_uint3(100,100,100),
        //                                       inwardNormals: false,
        //                                       geometryType: .triangles,
        //                                       allocator: bufferAllocator)

        mdlMesh.vertexDescriptor = MeshVertexDescriptorLibrary.vertexDescriptor(.BASIC)
        meshData = getMeshData(mdlMesh: mdlMesh)
        
        return meshData
    }
    
    
    //--------------------------------------------------------------------------------------------
    //------ Wavefront Model (OBJ File) -------------------------------------------------------------
    //--------------------------------------------------------------------------------------------
    public static func LoadMeshDataFromWavefront(modelName: String)->MeshData{
        let bufferAllocator = MTKMeshBufferAllocator(device: Engine.device)
        guard let assetURL = Bundle.main.url(forResource: modelName, withExtension: "obj") else {
            fatalError("Asset \(modelName) does not exist.")
        }
        let asset = MDLAsset(url: assetURL,
                             vertexDescriptor: MeshVertexDescriptorLibrary.vertexDescriptor(.BASIC),
                             bufferAllocator: bufferAllocator)

        return getMeshData(mdlAsset: asset)
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


