Shader "ACG/PlasmaShader"
{
    Properties
    {
        _Color("Color", Color) = (1,1,1,1)
        _Speed("Speed", Range(0,100)) = 10
        _Scale1("Scale 1", Range(0.1,10)) = 2
        _Scale2("Scale 2", Range(0.1,10)) = 2
        _Scale3("Scale 3", Range(0.1,10)) = 2
        _Scale4("Scale 4", Range(0.1,10)) = 2

        
    }
     SubShader
    {
        CGPROGRAM
            #pragma surface surf Standard

            struct Input{
                float2 uv_MainTex;
                float3 worldPos;
            };
            float _Scale1;
            float _Scale2;
            float _Scale3;
            float _Scale4;
            float _Speed;
            float4 _Color;

            void surf(Input IN, inout SurfaceOutputStandard o){
                const float PI = 3.14159265;
                float t = _Time.x *_Speed;

                float c = sin(t + IN.worldPos.x * _Scale1);

                c+= sin(t + IN.worldPos.z *_Scale2);
                c+= sin(_Scale3 + (sin(t/2) * IN.worldPos.x)+ IN.worldPos.z *cos(t/3));
                
                float c1 = pow( IN.worldPos.x + 0.5 * cos(t/5),2);
                float c2 = pow( IN.worldPos.z + 0.5 * cos(t/3),2);
                c+= sin(sqrt(_Scale4 * (c1+c2)+1+t));

                o.Albedo.r =sin(c/4.0*PI);
                o.Albedo.g = sin(c/4.0*PI+2*PI/4);
                o.Albedo.b = sin(c/4.0*PI+2*PI/4);
                o.Albedo *= _Color;
            }
        ENDCG
    }
}