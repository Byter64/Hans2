#include "Hapi.h"
#include <map>

extern "C" 
{
	#include "raylib.h"
}

static ::RenderTexture2D screen;
static ::Camera2D camera;

static std::map<Hapi::Image, ::Texture2D> idToTexture;
static std::map<Hapi::Font, ::Font> idToFont;

static void DrawTextEx2(Font font, const char* text, Vector2 position, float fontSize, float spacing, Color tint, float maxWidth);
static uint16_t GetInput();

int Hapi::Init()
{
	static bool isFirstCall = true;
	if (isFirstCall)
	{
		::SetConfigFlags(FLAG_WINDOW_RESIZABLE);
		::InitWindow(800, 480, "Hapi Desktop Environment");

		screen = ::LoadRenderTexture(SCREEN_WIDTH, SCREEN_HEIGHT);
		camera.offset = { 0, 0 };
		camera.rotation = 0.0f;
		camera.target = { 0, 0 };
		camera.zoom = 1.0f;

		isFirstCall = false;
	}

    return 0;
}

int Hapi::Terminate()
{
	::UnloadRenderTexture(screen);

    ::CloseWindow();
	return 0;
}

bool Hapi::ShouldClose()
{
	return WindowShouldClose();
}

Hapi::Image Hapi::LoadImage(char* start, int width, int height)
{
	::Image image;
	image.data = start;
	image.width = width;
	image.height = height;
	image.mipmaps = 1;
	image.format = PIXELFORMAT_UNCOMPRESSED_R5G5B5A1;
	Texture2D texture = ::LoadTextureFromImage(image);

	int index = texture.id;
	idToTexture[texture.id] = texture;
	return (Hapi::Image)index;
}

void Hapi::UpdateImage(Image image, char* start, int width, int height)
{
	//I don't understand this fully, but the width and hight of the Texture2D in idToTexture
	//must stay the same or else the texture is stretched
	::UpdateTextureRec(idToTexture[image], ::Rectangle{0, 0, (float)width, (float)height}, start);
}

void Hapi::UnloadImage(Image image)
{
	::UnloadTexture(idToTexture[image]);
	idToTexture.erase(image);
}

Hapi::Font Hapi::LoadFont(char* start, int width, int height, Hapi::FontAtlas fontatlas)
{
	Hapi::Image image = Hapi::LoadImage(start, width, height);
	::Texture2D texture = idToTexture[image];

	const auto& atlas = fontatlas.atlas;
	::Font font;

	font.baseSize = (*atlas.begin()).second.height;
	font.glyphCount = atlas.size();
	font.glyphPadding = 0;
	font.texture = texture;
	font.recs = (::Rectangle*) malloc(sizeof(::Rectangle) * atlas.size());
	font.glyphs = (::GlyphInfo*) malloc(sizeof(::GlyphInfo) * atlas.size());

	int index = 0;
	for (const std::pair<char, Hapi::Rectangle>& symbol : atlas)
	{
		const Hapi::Rectangle& rectangle = symbol.second;
		::Rectangle& rect = font.recs[index];
		::GlyphInfo& glyph = font.glyphs[index];

		rect.x = rectangle.x;
		rect.y = rectangle.y;
		rect.width = rectangle.width;
		rect.height = rectangle.height;

		glyph.value = symbol.first;
		glyph.offsetX = 0;
		glyph.offsetY = 0;
		glyph.advanceX = 0;
		glyph.image = { 0 };

		index++;
	}


	index = texture.id;
	idToFont[index] = font;
	return (Hapi::Font)index;
}

void Hapi::UnloadFont(Hapi::Font font)
{
	::UnloadFont(idToFont[font]);
	idToTexture.erase(font);
	idToFont.erase(font);
}

void Hapi::StartDrawing()
{
	::BeginTextureMode(screen);
	::BeginMode2D(camera);
}

void Hapi::EndDrawing()
{
	::EndMode2D();
	::EndTextureMode();


	::BeginDrawing();
	::DrawTexturePro(screen.texture, { 0, 0, (float)screen.texture.width, (float)-screen.texture.height}, { 0, 0, (float)::GetScreenWidth(), (float)::GetScreenHeight()}, {0, 0}, 0, Color(255, 255, 255, true).ToRaylib());
	::EndDrawing();
}

void Hapi::DrawText(const char* text, Hapi::Font font, int posX, int posY, unsigned int maxWidth)
{
	::DrawTextEx2(idToFont[font], text, { (float)posX, (float)posY }, idToFont[font].baseSize, 1, ::WHITE, maxWidth);
}

void Hapi::Clear(Color color)
{
	::ClearBackground(color.ToRaylib());
}

void Hapi::Draw(Image image, int ssX, int ssY, int x, int y, int width, int height)
{
	DrawTextureRec(idToTexture[image], { (float)ssX, (float)ssY, (float)width, (float)height }, { (float)x, (float)y }, Color(255, 255, 255, true).ToRaylib());
}

void Hapi::SetTargetFPS(int fps)
{
	::SetTargetFPS(fps);
}

void Hapi::SetVSync(bool vSync)
{
	
}


Hapi::ControllerInput Hapi::GetControllerInput()
{
	return ControllerInput{ GetInput()};
}


//Copied from rtext.c and modified
// Draw text using Font
// NOTE: chars spacing is NOT proportional to fontSize
static void DrawTextEx2(Font font, const char* text, Vector2 position, float fontSize, float spacing, Color tint, float maxWidth)
{
	static int textLineSpacing = 2;                 // Text vertical line spacing in pixels (between lines)

	if (font.texture.id == 0) font = ::GetFontDefault();  // Security check in case of not valid font

	int size = ::TextLength(text);    // Total size in bytes of the text, scanned by codepoints in loop

	float textOffsetY = 0;          // Offset between lines (on linebreak '\n')
	float textOffsetX = 0.0f;       // Offset X to next character to draw

	float scaleFactor = fontSize / font.baseSize;         // Character quad scaling factor

	for (int i = 0; i < size;)
	{
		// Get next codepoint from byte string and glyph index in font
		int codepointByteCount = 0;
		int codepoint = ::GetCodepointNext(&text[i], &codepointByteCount);
		int index = ::GetGlyphIndex(font, codepoint);

		if (codepoint == '\n')
		{
			// NOTE: Line spacing is a global variable, use SetTextLineSpacing() to setup
			textOffsetY += (fontSize + textLineSpacing);
			textOffsetX = 0.0f;
		}
		else
		{
			if ((codepoint != ' ') && (codepoint != '\t'))
			{
				if (textOffsetX + ((float)font.glyphs[index].advanceX * scaleFactor + spacing) > maxWidth)
				{
					textOffsetX = 0;
					textOffsetY += (fontSize + textLineSpacing);
				}
				::DrawTextCodepoint(font, codepoint, { position.x + textOffsetX, position.y + textOffsetY }, fontSize, tint);
			}

			if (font.glyphs[index].advanceX == 0) textOffsetX += ((float)font.recs[index].width * scaleFactor + spacing);
			else textOffsetX += ((float)font.glyphs[index].advanceX * scaleFactor + spacing);
		}

		i += codepointByteCount;   // Move text bytes counter to next codepoint
	}
}


//D-Pad mapped to WASD
//ABXY mapped to IJKL
//LR mapped to UO
//Start Select mapped to Enter Space
static int typeToKey[] = {
	KEY_K,
	KEY_J,
	KEY_SPACE,
	KEY_ENTER,
	KEY_W,
	KEY_S,
	KEY_A,
	KEY_D,
	KEY_L,
	KEY_I,
	KEY_U,
	KEY_O
};

static uint16_t GetInput()
{
	uint16_t rawInput = 0;
	rawInput |= ::IsKeyDown(typeToKey[(int)Hapi::Button::B]) << 0;
	rawInput |= ::IsKeyDown(typeToKey[(int)Hapi::Button::Y]) << 1;
	rawInput |= ::IsKeyDown(typeToKey[(int)Hapi::Button::Select]) << 2;
	rawInput |= ::IsKeyDown(typeToKey[(int)Hapi::Button::Start]) << 3;
	rawInput |= ::IsKeyDown(typeToKey[(int)Hapi::Button::Up]) << 4;
	rawInput |= ::IsKeyDown(typeToKey[(int)Hapi::Button::Down]) << 5;
	rawInput |= ::IsKeyDown(typeToKey[(int)Hapi::Button::Left]) << 6;
	rawInput |= ::IsKeyDown(typeToKey[(int)Hapi::Button::Right]) << 7;
	rawInput |= ::IsKeyDown(typeToKey[(int)Hapi::Button::A]) << 8;
	rawInput |= ::IsKeyDown(typeToKey[(int)Hapi::Button::X]) << 9;
	rawInput |= ::IsKeyDown(typeToKey[(int)Hapi::Button::L]) << 10;
	rawInput |= ::IsKeyDown(typeToKey[(int)Hapi::Button::R]) << 11;

	return rawInput;
}