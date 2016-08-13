Shader "Hidden/Temporal"
{
    Properties
    {
        _MainTex ("Texture", 2D) = "white" {}
    }

    CGINCLUDE
    #include "UnityCG.cginc"

    struct Input
    {
        float4 position : POSITION;
        float2 uv : TEXCOORD0;
    };

    struct Varyings
    {
        float4 position : SV_POSITION;
        float2 uv : TEXCOORD0;
    };

    Varyings vertex(Input input)
    {
        Varyings output;
        output.position = mul(UNITY_MATRIX_MVP, input.position);
        output.uv = input.uv;

        return output;
    }

    sampler2D _MainTex;
    sampler2D _HistoryTex;

    sampler2D _CameraMotionVectorsTexture;

    float4 fragment(Varyings input) : SV_Target
    {
        float2 motion = tex2D(_CameraMotionVectorsTexture, input.uv).xy;

        float4 color = tex2D(_MainTex, input.uv);
        float4 history = tex2D(_HistoryTex, input.uv - motion);

        return lerp(color, history, .5);
    }
    ENDCG

    SubShader
    {
        Cull Off ZWrite Off ZTest Always

        Pass
        {
            CGPROGRAM
            #pragma vertex vertex
            #pragma fragment fragment
            ENDCG
        }
    }
}
