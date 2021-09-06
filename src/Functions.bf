using System;

namespace Freetype
{
	public static
	{
		[CLink]
		public static extern FT_Error FT_Init_FreeType(FT_Library** library);

		[CLink]
		public static extern FT_Error FT_New_Face(FT_Library* library, char8* pathname, FT_Long face_index, FT_Face** aface);

		[CLink]
		public static extern FT_Error FT_New_Memory_Face(FT_Library* library, FT_Byte* file_base, FT_Long file_size, FT_Long face_index, FT_Face** aface);

		[CLink]
		public static extern FT_Error FT_New_Size(FT_Face* face, FT_Size** size);

		[CLink]
		public static extern FT_Error FT_Activate_Size(FT_Size* size);

		[CLink]
		public static extern FT_Error FT_Set_Char_Size(FT_Face* face, FT_F26Dot6 char_width, FT_F26Dot6 char_height, FT_UInt horz_resolution, FT_UInt vert_resolution);

		[CLink]
		public static extern FT_UInt FT_Get_Char_Index(FT_Face* face, FT_ULong charcode);

		[CLink]
		public static extern FT_Error FT_Load_Glyph(FT_Face* face, FT_UInt glyph_index, FT_Load_Flags load_flags);

		[CLink]
		public static extern FT_Error FT_Render_Glyph(FT_GlyphSlot* glyph, FT_Render_Mode render_mode);

		[CLink]
		public static extern FT_Error FT_Get_Kerning(FT_Face* face, FT_UInt left_glyph, FT_UInt right_glyph, FT_Kerning_Mode kern_mode, FT_Vector* akerning);

		[CLink]
		public static extern FT_Error FT_Done_Size(FT_Size* size);

		[CLink]
		public static extern FT_Error FT_Done_Face(FT_Face* face);

		[CLink]
		public static extern FT_Error FT_Done_FreeType(FT_Library* face);
	}

}