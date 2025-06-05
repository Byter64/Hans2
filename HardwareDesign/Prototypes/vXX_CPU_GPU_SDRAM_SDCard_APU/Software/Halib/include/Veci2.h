#pragma once

namespace Halib
{
	struct Veci2
	{
		int x;
		int y;
		
		Veci2() = default;
		Veci2(int x, int y);

		int Magnitude() const;
		int DotProduct(const Veci2& right);
		int CrossProduct(const Veci2& right);


		Veci2 operator-() const;
		Veci2 operator+(const Veci2& vec2) const;
		Veci2 operator-(const Veci2& vec2) const;
		Veci2 operator*(int a) const;
		Veci2 operator/(int a) const;

		Veci2& operator+=(const Veci2& vec2);
		Veci2& operator-=(const Veci2& vec2);
		Veci2& operator*=(int a);
		Veci2& operator/=(int a);

		bool operator==(const Veci2& vec2) const;
	};
}