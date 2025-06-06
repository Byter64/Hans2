#include "Veci2.h"

Halib::Veci2::Veci2(int x, int y)
{
	this->x = x;
	this->y = y;
}

int Halib::Veci2::Magnitude() const
{
	return 0;
}

int Halib::Veci2::DotProduct(const Veci2& right)
{
	return x * right.x + y * right.y;
}

int Halib::Veci2::CrossProduct(const Veci2& right)
{
	return x * right.y - right.x * y;
}

Halib::Veci2 Halib::Veci2::operator-() const
{
	return { -this->x, -this->y };
}

Halib::Veci2 Halib::Veci2::operator+(const Veci2& vec2) const
{
	return{ this->x + vec2.x, this->y + vec2.y };
}

Halib::Veci2 Halib::Veci2::operator-(const Veci2& vec2) const
{
	return { x - vec2.x, y - vec2.y };
}

Halib::Veci2 Halib::Veci2::operator*(int a) const
{
	return { this->x * a, this->y * a };
}

Halib::Veci2 Halib::Veci2::operator/(int a) const
{
	return { this->x / a, this->y / a };
}

bool Halib::Veci2::operator==(const Veci2& vec2) const
{
	return x == vec2.x && y == vec2.y;
}

Halib::Veci2& Halib::Veci2::operator+=(const Veci2& vec2)
{
	x += vec2.x;
	y += vec2.y;
	return *this;
}

Halib::Veci2& Halib::Veci2::operator-=(const Veci2& vec2)
{
	x -= vec2.x;
	y -= vec2.y;
	return *this;
}

Halib::Veci2& Halib::Veci2::operator*=(int a)
{
	x *= a;
	y *= a;
	return *this;
}

Halib::Veci2& Halib::Veci2::operator/=(int a)
{
	x /= a;
	y /= a;
	return *this;
}