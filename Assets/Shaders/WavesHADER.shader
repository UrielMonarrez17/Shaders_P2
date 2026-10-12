Shader "ACG/WavesShader"
{
    Properties
    {
        _MainTex("Texture", 2D) = "white" {}
        _Freq("frequency", Range(0,5)) = 3
        _Speed("Speed", Range(0,100)) = 10
        _Amplitude("Amplitude", Range(0,1)) = 0.5
        
    }
    SubShader
    {
        CGPROGRAM
            #pragma surface surf Lambert vertex:vert

            struct Input{
                float2 uv_MainTex;
            };

        
            struct appdata{
                float4 vertex : POSITION;
                float3 normal : NORMAL;
                float4 texcoord : TEXCOORD0;
                float4 texcoord1 : TEXCOORD1;
                float4 texcoord2 : TEXCOORD2;
            };

            float _Freq;
            sampler2D _MainTex;
            float _Speed;
            float _Amplitude;

            void vert (inout appdata v){
                float t = _Time * _Speed;
                float waveHeight = sin(t + v.vertex.x * _Freq) * _Amplitude;
                v.vertex.y += waveHeight;
                v.normal = normalize(float3(v.normal.x + waveHeight, v.normal.y, v.normal.z));
            }

            void surf(Input In, inout SurfaceOutput o){
                o.Albedo = tex2D(_MainTex, In.uv_MainTex);
            }

        
        ENDCG
    }
}