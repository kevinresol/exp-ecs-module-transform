package exp.ecs.module.transform.component;

import hxmath.math.*;

class Matrix2 {
	public static inline function zero() {
		return Matrix3x3.zero;
	}
	
	public static inline function make(tx:Float, ty:Float, r:Float, sx:Float, sy:Float) {
		final sin = Math.sin(r);
		final cos = Math.cos(r);

		return new Matrix3x3(
			// @formatter:off
			cos * sx, -sin * sy, tx,
			sin * sx,  cos * sy, ty,
			0       , 0        , 1 
			// @formatter:on
		);
	}

	public static inline function translate(tx, ty) {
		return new Matrix3x3(
			// @formatter:off
			1, 0, tx,
			0, 1, ty,
			0, 0, 1
			// @formatter:on
		);
	}

	public static inline function scale(sx, sy) {
		return new Matrix3x3(
			// @formatter:off
			sx, 0 , 0,
			0 , sy, 0,
			0 , 0 , 1
			// @formatter:on
		);
	}

	public static inline function rotate(radians) {
		final sin = Math.sin(radians);
		final cos = Math.cos(radians);
		return new Matrix3x3(
		// @formatter:off
			cos, -sin, 0,
			sin, cos , 0,
			0  , 0   , 1 
		);
	}
}