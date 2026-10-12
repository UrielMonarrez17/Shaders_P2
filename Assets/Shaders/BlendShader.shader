Shader "ACG/BlendShader"
{
    Properties
    {
        _MainTex ("Albedo (RGB)", 2D) = "white" {}
    }
    SubShader
    {
        Tags { "Queue"="Transparent" }
        //finalValue = (sourceFactor * sourceValue)
        Blend SrcAlpha OneMinusSrcAlpha
        //Blend One One 
        //Blend DstColor Zero
        Pass{
            SetTexture[_MainTex] {combine texture}
        }

    
    }
    FallBack "Diffuse"
}
