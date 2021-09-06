using System;
using System.Interop;

using internal Freetype;

namespace Freetype
{
	enum FT_Error : c_int
	{
		OK = 0x00,
		CannotOpenResource = 0x01,
		UnknownFileFormat = 0x02,
		InvalidFileFormat = 0x03,
		InvalidVersion = 0x04,
		LowerModuleVersion = 0x05,
		InvalidArgument = 0x06,
		UnimplementedFeature = 0x07,
		InvalidTable = 0x08,
		InvalidOffset = 0x09,
		ArrayTooLarge = 0x0A,
		MissingModule = 0x0B,
		MissingProperty = 0x0C,

		/* glyph/character errors */
		InvalidGlyphIndex = 0x10,
		InvalidCharacterCode = 0x11,
		InvalidGlyphFormat = 0x12,
		CannotRenderGlyph = 0x13,
		InvalidOutline = 0x14,
		InvalidComposite = 0x15,
		TooManyHints = 0x16,
		InvalidPixelSize = 0x17,

		/* handle errors */
		InvalidHandle = 0x20,
		InvalidLibraryHandle = 0x21,
		InvalidDriverHandle = 0x22,
		InvalidFaceHandle = 0x23,
		InvalidSizeHandle = 0x24,
		InvalidSlotHandle = 0x25,
		InvalidCharMapHandle = 0x26,
		InvalidCacheHandle = 0x27,
		InvalidStreamHandle = 0x28,

		/* driver errors */
		TooManyDrivers = 0x30,
		TooManyExtensions = 0x31,

		/* memory errors */
		OutOfMemory = 0x40,
		UnlistedObject = 0x41,

		/* stream errors */
		CannotOpenStream = 0x51,
		InvalidStreamSeek = 0x52,
		InvalidStreamSkip = 0x53,
		InvalidStreamRead = 0x54,
		InvalidStreamOperation = 0x55,
		InvalidFrameOperation = 0x56,
		NestedFrameAccess = 0x57,
		InvalidFrameRead = 0x58,

		/* raster errors */
		RasterUninitialized = 0x60,
		RasterCorrupted = 0x61,
		RasterOverflow = 0x62,
		RasterNegativeHeight = 0x63,

		/* cache errors */
		TooManyCaches = 0x70,

		/* TrueType and SFNT errors */
		InvalidOpcode = 0x80,
		TooFewArguments = 0x81,
		StackOverflow = 0x82,
		CodeOverflow = 0x83,
		BadArgument = 0x84,
		DivideByZero = 0x85,
		InvalidReference = 0x86,
		DebugOpCode = 0x87,
		ENDFInExecStream = 0x88,
		NestedDEFS = 0x89,
		InvalidCodeRange = 0x8A,
		ExecutionTooLong = 0x8B,
		TooManyFunctionDefs = 0x8C,
		TooManyInstructionDefs = 0x8D,
		TableMissing = 0x8E,
		HorizHeaderMissing = 0x8F,
		LocationsMissing = 0x90,
		NameTableMissing = 0x91,
		CMapTableMissing = 0x92,
		HmtxTableMissing = 0x93,
		PostTableMissing = 0x94,
		InvalidHorizMetrics = 0x95,
		InvalidCharMapFormat = 0x96,
		InvalidPPem = 0x97,
		InvalidVertMetrics = 0x98,
		CouldNotFindContext = 0x99,
		InvalidPostTableFormat = 0x9A,
		InvalidPostTable = 0x9B,
		DEFInGlyfBytecode = 0x9C,
		MissingBitmap = 0x9D,

		/* CFF, CID, and Type 1 errors */
		SyntaxError = 0xA0,
		StackUnderflow = 0xA1,
		Ignore = 0xA2,
		NoUnicodeGlyphName = 0xA3,
		GlyphTooBig = 0xA4,

		/* BDF errors */
		MissingStartfontField = 0xB0,
		MissingFontField = 0xB1,
		MissingSizeField = 0xB2,
		MissingFontboundingboxField = 0xB3,
		MissingCharsField = 0xB4,
		MissingStartcharField = 0xB5,
		MissingEncodingField = 0xB6,
		MissingBbxField = 0xB7,
		BbxTooBig = 0xB8,
		CorruptedFontHeader = 0xB9,
		CorruptedFontGlyphs = 0xBA,
	}

	enum FT_Render_Mode : c_int
	{
		Normal = 0,
		Light,
		Mono,
		LCD,
		LCD_V,
		SDF
	}

	enum FT_Kerning_Mode : c_int
	{
		Default = 0,
		Unfitted,
		Unscaled
	}

	enum FT_Load_Flags: c_int
	{
		Default = 0,
		NoScale = (1 << 0),
		NoHinting = (1 << 1),
		Render = (1 << 2),
		NoBitmap = (1 << 3),
		VerticalLayout = (1 << 4),
		ForceAutohint = (1 << 5),
		CropBitmap = (1 << 6),
		Pedantic = (1 << 7),
		IgnoreGlobalAdvanceWidth = (1 << 9),
		NoRecurse = (1 << 10),
		IgnoreTransform = (1 << 11),
		Monochrome = (1 << 12),
		LinearDesign = (1 << 13),
		NoAutohint = (1 << 15),

		/* Bits 16-19 are used by `FT_LOAD_TARGET_` */
		Color = (1 << 20),
		ComputeMetrics = (1 << 21),
		BitmapMetricsOnly = (1 << 22),

		/* used internally only by certain font drivers */
		AdvanceOnly = (1 << 8),
		SBitsOnly  = (1 << 14),
	}

	static
	{
		private static int32 FT_IMAGE_TAG(char8 _x1, char8 _x2, char8 _x3, char8 _x4)
		{
			return (((int32)_x1 << 24) | ((int32)_x2 << 16) | ((int32)_x3 << 8) | (int32)_x4);
		}

		private static int32 FT_ENC_TAG(char8 a, char8 b, char8 c, char8 d)
		{
			return (((int32)a << 24) | ((int32)b << 16) | ((int32)c << 8) | (int32)d);
		}

		internal const c_int FT_GLYPH_FORMAT_COMPOSITE = FT_IMAGE_TAG('c', 'o', 'm', 'p');
		internal const c_int FT_GLYPH_FORMAT_BITMAP = FT_IMAGE_TAG('b', 'i', 't', 's');
		internal const c_int FT_GLYPH_FORMAT_OUTLINE = FT_IMAGE_TAG('o', 'u', 't', 'l');
		internal const c_int FT_GLYPH_FORMAT_PLOTTER = FT_IMAGE_TAG('p', 'l', 'o', 't');


		internal const c_int FT_ENCODING_MS_SYMBOL = FT_ENC_TAG('s', 'y', 'm', 'b');
		internal const c_int FT_ENCODING_UNICODE = FT_ENC_TAG('u', 'n', 'i', 'c');

		internal const c_int FT_ENCODING_SJIS = FT_ENC_TAG('s', 'j', 'i', 's');
		internal const c_int FT_ENCODING_PRC = FT_ENC_TAG('g', 'b', ' ', ' ');
		internal const c_int FT_ENCODING_BIG5 = FT_ENC_TAG('b', 'i', 'g', '5');
		internal const c_int FT_ENCODING_WANSUNG = FT_ENC_TAG('w', 'a', 'n', 's');
		internal const c_int FT_ENCODING_JOHAB = FT_ENC_TAG('j', 'o', 'h', 'a');

		internal const c_int FT_ENCODING_ADOBE_STANDARD = FT_ENC_TAG('A', 'D', 'O', 'B');
		internal const c_int FT_ENCODING_ADOBE_EXPERT = FT_ENC_TAG('A', 'D', 'B', 'E');
		internal const c_int FT_ENCODING_ADOBE_CUSTOM = FT_ENC_TAG('A', 'D', 'B', 'C');
		internal const c_int FT_ENCODING_ADOBE_LATIN_1 = FT_ENC_TAG('l', 'a', 't', '1');

		internal const c_int FT_ENCODING_OLD_LATIN_2 = FT_ENC_TAG('l', 'a', 't', '2');
		internal const c_int FT_ENCODING_APPLE_ROMAN = FT_ENC_TAG('a', 'r', 'm', 'n');

	}

	enum FT_Glyph_Format : c_int
	{
		None = 0,
		Composite = FT_GLYPH_FORMAT_COMPOSITE,
		Bitmap = FT_GLYPH_FORMAT_BITMAP,
		Outline = FT_GLYPH_FORMAT_OUTLINE,
		Plotter = FT_GLYPH_FORMAT_PLOTTER,
	}

	enum FT_Pixel_Mode : c_uchar
	{
		None = 0,
		Mono,
		Gray,
		Gray2,
		Gray4,
		LCD,
		LCD_V,
		BGRA
	}

	enum FT_Outline_Flags : c_int
	{
		None = 0,
		Owner = 0x1,
		EvenOddFill = 0x2,
		ReverseFill = 0x4,
		IgnoreDropouts = 0x8,
		SmartDropouts = 0x10,
		IncludeStubs = 0x20,
		Overlap = 0x40,

		HighPrecision = 0x100,
		SinglePass = 0x200
	}

	enum FT_Encoding : c_int
	{
		None = 0,
		MsSymbol = FT_ENCODING_MS_SYMBOL,
		Unicode = FT_ENCODING_UNICODE,
		SJIS = FT_ENCODING_SJIS,
		PRC = FT_ENCODING_PRC,
		Bigs = FT_ENCODING_BIG5,
		Wansung = FT_ENCODING_WANSUNG,
		Johab = FT_ENCODING_JOHAB,
		AdobeStandard = FT_ENCODING_ADOBE_STANDARD,
		AdobeExpert = FT_ENCODING_ADOBE_EXPERT,
		AdobeCustom = FT_ENCODING_ADOBE_CUSTOM,
		AdobeLatin1 = FT_ENCODING_ADOBE_LATIN_1,
		OldLatin2 = FT_ENCODING_OLD_LATIN_2,
		AppleRoman = FT_ENCODING_APPLE_ROMAN,
	}
}
