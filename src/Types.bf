using System;
using System.Interop;

#define FT_CONFIG_OPTION_INCREMENTAL

namespace Freetype
{
	typealias FT_Int16 = c_short;
	typealias FT_UInt16 = c_ushort;
	typealias FT_Int32 = int32;
	typealias FT_UInt32 = uint32;
	typealias FT_INT64 = c_longlong;
	typealias FT_UINT64 = c_longlong;

	typealias FT_Bool = c_uchar;
	typealias FT_Byte = c_uchar;
	typealias FT_Short = c_short;
	typealias FT_UShort = c_ushort;
	typealias FT_Int = c_int;
	typealias FT_UInt = c_uint;
	typealias FT_Long = c_long;
	typealias FT_ULong = c_ulong;

	typealias FT_F2Dot14 = c_short;
	typealias FT_F26Dot6 = c_long;

	typealias FT_Pos = c_long;
	typealias FT_Fixed = c_long;
	typealias FT_Pointer = void*;
	typealias FT_String = c_char;
	typealias FT_Char = c_char;

	function FT_Error FT_DebugHook_Func( void*  arg );

	[CRepr]
	struct FT_Memory
	{
		public void* user;
		public FT_Alloc_Func    alloc;
		public FT_Free_Func     free;
		public FT_Realloc_Func  realloc;

		public function void* FT_Alloc_Func(Self* memory, c_long size);
		public function void FT_Free_Func(Self* memory, void* block);
		public function void* FT_Realloc_Func(Self* memory, c_long cur_size, c_long new_size, void* block);
	}

	[CRepr]
	struct FT_Module
	{

	}

	// Is pointer by default
	[CRepr]
	struct FT_ListNode
	{
		public FT_ListNode*  prev;
		public FT_ListNode*  next;
		public void*        data;
	}

	[CRepr]
	struct FT_ListRec
	{
		public FT_ListNode*  head;
		public FT_ListNode*  tail;
	}

	[CRepr]
	struct FT_Renderer
	{

	}

	[CRepr]
	struct FT_Vector
	{
		public FT_Pos x;
		public FT_Pos y;
	}

	// Is pointer by default
	[CRepr]
	struct FT_Library
	{
		FT_Memory*          memory;           /* library's memory manager */

		FT_Int             version_major;
		FT_Int             version_minor;
		FT_Int             version_patch;

		FT_UInt            num_modules;
		FT_Module*[FT_MAX_MODULES]          modules;  /* module objects  */

		FT_ListRec*         renderers;        /* list of renderers        */
		FT_Renderer*        cur_renderer;     /* current outline renderer */
		FT_Module*          auto_hinter;

		FT_DebugHook_Func[4]  debug_hooks;

#if FT_CONFIG_OPTION_SUBPIXEL_RENDERING
		FT_LcdFiveTapFilter      lcd_weights;      /* filter weights, if any */
		FT_Bitmap_LcdFilterFunc  lcd_filter_func;  /* filtering callback     */
#else
		FT_Vector[3]                lcd_geometry;  /* RGB subpixel positions */
#endif

		FT_Int             refcount;
	}

	[CRepr]
	struct FT_Bitmap_Size
	{
		public FT_Short  height;
		public FT_Short  width;

		public FT_Pos    size;

		public FT_Pos    x_ppem;
		public FT_Pos    y_ppem;
	}

	// Is pointer by default
	[CRepr]
	struct FT_CharMap
	{
		public FT_Face*      face;
		public FT_Encoding  encoding;
		public FT_UShort    platform_id;
		public FT_UShort    encoding_id;
	}

	[CRepr]
	struct FT_BBox
	{
		public FT_Pos  xMin, yMin;
		public FT_Pos  xMax, yMax;
	}

	[CRepr]
	struct FT_ServiceCacheRec
	{
		public FT_Pointer  service_POSTSCRIPT_FONT_NAME;
		public FT_Pointer  service_MULTI_MASTERS;
		public FT_Pointer  service_METRICS_VARIATIONS;
		public FT_Pointer  service_GLYPH_DICT;
		public FT_Pointer  service_PFR_METRICS;
		public FT_Pointer  service_WINFNT;
	}	

	[CRepr]
	struct FT_Incremental_InterfaceRec
	{

	}

	// Is pointer by default
	[CRepr]
	struct FT_Face_Internal
	{
		public FT_Matrix  transform_matrix;
		public FT_Vector  transform_delta;
		public FT_Int     transform_flags;

		public FT_ServiceCacheRec  services;

#if FT_CONFIG_OPTION_INCREMENTAL
		FT_Incremental_InterfaceRec*  incremental_interface;
#endif

		public FT_Char              no_stem_darkening;
		public FT_Int32             random_seed;

#if FT_CONFIG_OPTION_SUBPIXEL_RENDERING
		FT_LcdFiveTapFilter      lcd_weights;      /* filter weights, if any */
		FT_Bitmap_LcdFilterFunc  lcd_filter_func;  /* filtering callback     */
#endif

		public FT_Int  refcount;

	}

	// Is pointer by default
	[CRepr]
	struct FT_Driver
	{
		/*FT_ModuleRec     root;
		FT_Driver_Class  clazz;
		FT_ListRec       faces_list;
		FT_GlyphLoader   glyph_loader;*/
	}

	[CRepr, Union]
	struct FT_StreamDesc
	{
		public c_long   value;
		public void*  pointer;
	}

	// Is pointer by default
	[CRepr]
	struct FT_Stream
	{
		public c_uchar*       _base;
		public c_ulong        size;
		public c_ulong       pos;

		public FT_StreamDesc        descriptor;
		public FT_StreamDesc        pathname;
		public FT_Stream_IoFunc     read;
		public FT_Stream_CloseFunc  close;

		public FT_Memory            memory;
		public c_uchar*       	cursor;
		public c_uchar*       	limit;

		public function c_ulong FT_Stream_IoFunc(FT_Stream* stream, c_ulong offset, c_uchar* buffer, c_ulong count);
		public function c_ulong FT_Stream_CloseFunc(FT_Stream* stream);
	}

	// Is pointer by default
	[CRepr]
	struct FT_Face
	{
		public FT_Long           num_faces;
		public FT_Long           face_index;

		public FT_Long           face_flags;
		public FT_Long           style_flags;

		public FT_Long           num_glyphs;

		public FT_String*        family_name;
		public FT_String*        style_name;

		public FT_Int            num_fixed_sizes;
		public FT_Bitmap_Size*   available_sizes;

		public FT_Int            num_charmaps;
		public FT_CharMap**       charmaps;

		public FT_Generic        generic;

		/*# The following member variables (down to `underline_thickness`) */
		/*# are only relevant to scalable outlines; cf. @FT_Bitmap_Size    */
		/*# for bitmap fonts.                                              */
		public FT_BBox           bbox;

		public FT_UShort         units_per_EM;
		public FT_Short          ascender;
		public FT_Short          descender;
		public FT_Short          height;

		public FT_Short          max_advance_width;
		public FT_Short          max_advance_height;

		public FT_Short          underline_position;
		public FT_Short          underline_thickness;

		public FT_GlyphSlot*      glyph;
		public FT_Size*           size;
		public FT_CharMap*        charmap;

		/*@private begin */

		public FT_Driver*         driver;
		public FT_Memory*         memory;
		public FT_Stream*         stream;

		public FT_ListRec        sizes_list;

		public FT_Generic        autohint;   /* face-specific auto-hinter data */
		public void*             extensions; /* unused                         */

		FT_Face_Internal*  _internal;
	}

	[CRepr]
	struct FT_Generic
	{
		public void*                 data;
		public FT_Generic_Finalizer  finalizer;

		public function void FT_Generic_Finalizer(void* object);
	}

	[CRepr]
	struct FT_Size_Metrics
	{
		public FT_UShort  x_ppem;      /* horizontal pixels per EM               */
		public FT_UShort  y_ppem;      /* vertical pixels per EM                 */

		public FT_Fixed   x_scale;     /* scaling values used to convert font    */
		public FT_Fixed   y_scale;     /* units to 26.6 fractional pixels        */

		public FT_Pos     ascender;    /* ascender in 26.6 frac. pixels          */
		public FT_Pos     descender;   /* descender in 26.6 frac. pixels         */
		public FT_Pos     height;      /* text height in 26.6 frac. pixels       */
		public FT_Pos     max_advance; /* max horizontal advance, in 26.6 pixels */

	}

	// Is pointer by default
	[CRepr]
	struct FT_Size_Internal
	{
		public void* module_data;
		public FT_Render_Mode   autohint_mode;
		public FT_Size_Metrics  autohint_metrics;
	}

	// Is pointer by default
	[CRepr]
	struct FT_Size
	{
		public FT_Face*           face;      /* parent face object              */
		public FT_Generic        generic;   /* generic pointer for client uses */
		public FT_Size_Metrics   metrics;   /* size metrics                    */
		public FT_Size_Internal*  _internal;
	}

	[CRepr]
	struct FT_Glyph_Metrics
	{
		public FT_Pos  width;
		public FT_Pos  height;

		public FT_Pos  horiBearingX;
		public FT_Pos  horiBearingY;
		public FT_Pos  horiAdvance;

		public FT_Pos  vertBearingX;
		public FT_Pos  vertBearingY;
		public FT_Pos  vertAdvance;
	}

	[CRepr]
	struct FT_Bitmap
	{
		public c_uint    rows;
		public c_uint    width;
		public c_int     pitch;
		public c_uchar*  buffer;
		public c_short   num_grays;
		public FT_Pixel_Mode   pixel_mode;
		public c_uchar   palette_mode;
		public void*           palette;
	}

	[CRepr]
	struct FT_Outline
	{
		public c_short       n_contours;      /* number of contours in glyph        */
		public c_short       n_points;        /* number of points in the glyph      */

		public FT_Vector*  points;          /* the outline's points               */
		public c_char*       tags;            /* the points flags                   */
		public c_short*      contours;        /* the contour end points             */

		public FT_Outline_Flags    flags;           /* outline masks                      */
	}

	[CRepr]
	struct FT_Matrix
	{
		public FT_Fixed  xx, xy;
		public FT_Fixed  yx, yy;
	}

	// Is pointer by default
	[CRepr]
	struct FT_SubGlyph
	{
		public FT_Int     index;
		public FT_UShort  flags;
		public FT_Int     arg1;
		public FT_Int     arg2;
		public FT_Matrix  transform;
	}

	// Is pointer by default
	[CRepr]
	struct FT_GlyphSlot
	{
		public FT_Library*        library;
		public FT_Face*           face;
		public FT_GlyphSlot*      next;
		public FT_UInt           glyph_index; /* new in 2.10; was reserved previously */
		public FT_Generic        generic;

		public FT_Glyph_Metrics  metrics;
		public FT_Fixed          linearHoriAdvance;
		public FT_Fixed          linearVertAdvance;
		public FT_Vector         advance;

		public FT_Glyph_Format   format;

		public FT_Bitmap         bitmap;
		public FT_Int            bitmap_left;
		public FT_Int            bitmap_top;

		public FT_Outline        outline;

		public FT_UInt           num_subglyphs;
		public FT_SubGlyph*       subglyphs;

		public void*             control_data;
		public c_long              control_len;

		public FT_Pos            lsb_delta;
		public FT_Pos            rsb_delta;

		public void*             other;

		public FT_Slot_Internal*  _internal;
	}

	[CRepr]
	struct FT_GlyphLoadRec
	{
		public FT_Outline   outline;       /* outline                   */
		public FT_Vector*   extra_points;  /* extra points table        */
		public FT_Vector*   extra_points2; /* second extra points table */
		public FT_UInt      num_subglyphs; /* number of subglyphs       */
		public FT_SubGlyph  subglyphs;     /* subglyphs                 */
	}	

	[CRepr]
	struct FT_GlyphLoader
	{
		public FT_Memory        memory;
		public FT_UInt          max_points;
		public FT_UInt          max_contours;
		public FT_UInt          max_subglyphs;
		public FT_Bool          use_extra;

		public FT_GlyphLoadRec  _base;
		public FT_GlyphLoadRec  current;

		public void*            other;            /* for possible future extension? */
	}

	[CRepr]
	struct FT_Slot_Internal
	{
		public FT_GlyphLoader*  loader;
		public FT_UInt         flags;
		public FT_Bool         glyph_transformed;
		public FT_Matrix       glyph_matrix;
		public FT_Vector       glyph_delta;
		public void*           glyph_hints;

		public FT_Int32        load_flags;
	}
}
