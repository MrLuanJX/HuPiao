/************************************************************************/
/* copyright                                                            */
/* version 1.1    ?޸?TPoint  TRect ??????????Ϊint                     */
/************************************************************************/
#ifndef __COMMON_DEF_H__
#define __COMMON_DEF_H__

//////////////////////////////////////////////////////////////////////////
/* ƽ̨???ص?һЩ???? */
/** ???÷?ʽԼ?? */
#if (defined WIN32 || defined WIN64)
//-----------windows-----------------------------
    #define STD_CDECL   __cdecl         //C????Լ??
    #define STD_STDCALL __stdcall       //pascall????Լ??
    #define STD_EXPORTS __declspec(dllexport)
    #define STD_WINAPI  __stdcall 
#else
//-----------linux-------------------------------
    #define STD_CDECL
    #define STD_STDCALL
    #define STD_EXPORTS __attribute__ ((visibility("default")))
#endif

/* ??????ʽ???? */
#ifndef STD_EXTERN_C
    #ifdef __cplusplus
        #define STD_EXTERN_C  extern "C"
    #else
        #define STD_EXTERN_C  extern
    #endif
#endif

/* ?ӿڶ???:???ñ?׼??C????Լ?? */
#ifndef STD_API
    #define STD_API(rettype) STD_EXTERN_C STD_EXPORTS rettype STD_CDECL
	/* ?ӿ?ʵ??:???ñ?׼??C????Լ?? */
	#define STD_IMPL STD_EXTERN_C STD_EXPORTS
#endif
/* C++?ӿڶ??? */
#ifndef CPP_API
	#define CPP_API(rettype) STD_EXPORTS rettype STD_CDECL
	#define CPP_IMPL STD_EXPORTS
#endif

//////////////////////////////////////////////////////////////////////////
//???ö?????
/* MIN, MAX, ABS */
#define ZMIN(a, b)	((a)>(b) ? (b) : (a))
#define ZMAX(a, b)	((a)<(b) ? (b) : (a))
#define ZABS(a)		((a) < 0 ? (-(a)) : a)
#define ZSIGN(x)    (((x) < 0) ? -1 : 1)

#define ZFALSE		(0)
#define ZTRUE		(1)
#define ZPI			(3.1415926535)
#define PROCNAME(name)  static const char procName[] = name
#define ROUND(a) ((int)((a) + ((a) >= 0 ? 0.5 : -0.5)))
#define FLOOR(a) ( ROUND(a) + ((a - ROUND(a)) < 0 ) )
#define CEIL(a)  ( ROUND(a) + ((ROUND(a) - a) < 0 ) )

//////////////////////////////////////////////////////////////////////////
//64λ??????????????long???ض????ˣ?????????Ҫ??ǰ
#if (defined WIN32 || defined WIN64)
typedef __int64			TInt64;
#else
typedef long long		TInt64;
#endif

//????long?ĳ?????32λ??64λ?????⣬ͳһ??int????????ʶ???ں?û??????
//#define long int
//////////////////////////////////////////////////////////////////////////
/**common data types, when we write code, we must use this data type to make our code partable
 *more easily, and make our code write more precise in data type.*/
typedef signed char	    TInt8;
typedef signed short	TInt16;
typedef signed int	    TInt32;
typedef signed int	    TInt;
typedef signed long     TLong;      //????x32??4byte??x64??8byte
typedef unsigned char	TUint8;
typedef unsigned short	TUint16;
typedef unsigned int	TUint32;
typedef unsigned int	TUint;      //DWORD
typedef unsigned char   TUchar;     //BYTE
typedef unsigned short  TUshort;    //WORD
typedef unsigned long   TUlong;     //????x32??4byte??x64??8byte
typedef float		    TReal32;
typedef double		    TReal64;
typedef int		        TBool;
typedef void		    TVoid;
typedef void*           THandle;    // handle=void*
typedef int				TStatus;
typedef int				TSTATUS;
typedef void*			THandle;

//////////////////////////////////////////////////////////////////////////
/* ?? */
typedef struct TPoint_
{
	int x;
	int y;
}TPoint;

/* ????(??????ϵ) */
typedef struct TRect_
{
	int nLft; 
	int nRgt;
	int nTop;
	int nBtm;
}TRect;

//////////////////////////////////////////////////////////////////////////
//????????????ֵ????Сֵ
#define TINT8_MIN  (-128) 
#define TINT16_MIN (-32768)
#define TINT32_MIN (-2147483647 - 1)
#define TINT64_MIN (-9223372036854775807LL - 1)

#define TINT8_MAX  127
#define TINT16_MAX 32767
#define TINT32_MAX 2147483647
#define TINT64_MAX 9223372036854775807LL

#define TUINT8_MAX  0xff /* 255U */
#define TUINT16_MAX 0xffff /* 65535U */
#define TUINT32_MAX 0xffffffff  /* 4294967295U */
#define TUINT64_MAX 0xffffffffffffffffULL /* 18446744073709551615ULL */

//////////////////////////////////////////////////////////////////////////
//???????? ???????? <0 ???????? ??????ȷ??32λ?Ĵ???????
/** ?ж????? */
#define ISFAILED(iStatus)	 ((iStatus) <  0 )
#define ISSUCCEEDED(iStatus) ((iStatus) >= 0 )

/** û?д??? */
#define STATUS_OK                   (0     )
/** ?ڴ治?? */
#define STATUS_NOMEMORY             (-80001)
/** ???????????? */
#define STATUS_INVALIDARG           (-80002)
/** ?޴˽ӿ? */
#define STATUS_NOINTERFACE          (-80003)
/** ??Чָ?? */
#define STATUS_INVALIDPTR           (-80004)
/* ?ļ????? */
#define STATUS_FILEERROR            (-80005)
/** ʶ???ֵ?û?г?ʼ?? */
#define STATUS_DICT_UNINIT			(-80006)
/** ʶ???ֵ????? */
#define STATUS_RECG_ERROR			(-80007)
/** ?ֵ???ʼ?????? */
#define STATUS_DICT_ERROR			(-80008)
/** ָ??Ϊ?? */
#define STATUS_NULLPTR				(-80009)
/** not supported image formate    */      
#define	STATUS_UNKNOWFMT			(-80010)
/** ͼ?????? */
#define STATUS_BADIMAGE				(-80011)
/** ???????????? ........................ */
/** ??λ???? */
#define STATUS_DETECTERR			(-80020)
/** ???????? */
#define STATUS_DECODEERR			(-80021)
/** ???????? */
#define STATUS_ENCODEERR			(-80022)
/** ????????*/
#define STATUS_OVERTIME				(-80023)
/**???????? */
#define STATUS_UNEXPECTED			(-88888)

//////////////////////////////////////////////////////////////////////////

#endif //__COMMON_DEF_H__
