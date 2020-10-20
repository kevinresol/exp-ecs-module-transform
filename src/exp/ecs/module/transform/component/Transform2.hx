package exp.ecs.module.transform.component;

import hxmath.math.*;

@:allow(exp.ecs)
class Transform2 implements Component {
	public var matrix:Matrix3x3;
	public final global:MatrixView3x3;

	final _global:Matrix3x3;

	public function new(matrix) {
		this.matrix = matrix;
		global = _global = Matrix3x3.zero;
	}

	inline function compute(tx:Float, ty:Float, r:Float, sx:Float, sy:Float) {
		(inline Matrix2.make(tx, ty, r, sx, sy)).copyTo(matrix);
	}

	inline function computeGlobal(parent:Null<Transform2>) {
		if (parent == null)
			matrix.copyTo(_global);
		else
			(parent._global * matrix).copyTo(_global);
	}

	public inline function clone():Transform2 {
		return new Transform2(matrix.clone());
	}
}

@:forward(toString)
abstract MatrixView3x3(Matrix3x3) from Matrix3x3 {
	public var m00(get, never):Float;
	public var m10(get, never):Float;
	public var m20(get, never):Float;
	public var m01(get, never):Float;
	public var m11(get, never):Float;
	public var m21(get, never):Float;
	public var m02(get, never):Float;
	public var m12(get, never):Float;
	public var m22(get, never):Float;
	public var tx(get, never):Float;
	public var ty(get, never):Float;

	inline function get_m00()
		return this.m00;

	inline function get_m10()
		return this.m10;

	inline function get_m20()
		return this.m20;

	inline function get_m01()
		return this.m01;

	inline function get_m11()
		return this.m11;

	inline function get_m21()
		return this.m21;

	inline function get_m02()
		return this.m02;

	inline function get_m12()
		return this.m12;

	inline function get_m22()
		return this.m22;

	inline function get_tx()
		return this.m20;

	inline function get_ty()
		return this.m21;

	public function toString():String
		return '[[$m00, $m10, $m20], [$m01, $m11, $m21], [$m02, $m12, $m22]]';
}
