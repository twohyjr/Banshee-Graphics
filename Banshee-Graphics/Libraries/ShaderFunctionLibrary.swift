import MetalKit

enum ShaderFunctionTypes: String{
    //Vertex Shader Types
    case Basic_Vertex = "basic_vertex_shader"
    case Textured_Vertex = "textured_vertex_shader"
    case Instanced_Vertex = "instanced_vertex_shader"
    
    //Fragment Shader Types
    case Basic_Fragment = "basic_fragment_shader"
    case Textured_Fragment = "textured_fragment_shader"
}

class ShaderFunctionLibrary {
    
    private static var shaderFunctions:[ShaderFunctionTypes:ShaderFunction] = [:]

    public static func initialize(){
        setUpAllShaders()
    }
    
    private static func setUpAllShaders(){
        setUpVertexShaders()
        setUpFragmentShaders()
    }
    
    private static func setUpVertexShaders(){
        addShader(shaderType: .Basic_Vertex)
        addShader(shaderType: .Textured_Vertex)
        addShader(shaderType: .Instanced_Vertex)
    }
    
    private static func setUpFragmentShaders(){
        addShader(shaderType: .Basic_Fragment)
        addShader(shaderType: .Textured_Fragment)
    }
    
    private static func addShader(shaderType: ShaderFunctionTypes){
        shaderFunctions.updateValue(ShaderFunction(shaderType), forKey: shaderType)
    }
    
    public static func shaderFunction(_ shaderType: ShaderFunctionTypes)->MTLFunction{
        return (shaderFunctions[shaderType]?.function)!
    }
}

class ShaderFunction{
    var name: String!
    var function: MTLFunction!
    
    init(_ type: ShaderFunctionTypes){
        name = type.rawValue
        function = Engine.library.makeFunction(name: name)!
    }
}


