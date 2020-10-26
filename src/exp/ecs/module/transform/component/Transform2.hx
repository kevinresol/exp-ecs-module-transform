package exp.ecs.module.transform.component;

import hxmath.math.*;

// TODO: consider integrating pos/rot/scal in a single component

@:allow(exp.ecs)
class Transform2 implements Component {
	public var position:Vector2 = Vector2.zero;
	public var rotation:Float = 0;
	public var scale:Vector2 = new Vector2(1, 1);

	public var local(get, never):MatrixView3x3;
	public var global(get, never):MatrixView3x3;

	final _local:Matrix3x3 = Matrix3x3.identity;
	final _global:Matrix3x3 = Matrix3x3.identity;

	inline function computeLocal(tx:Float, ty:Float, r:Float, sx:Float, sy:Float) {
		final sin = Math.sin(r);
		final cos = Math.cos(r);

		_local.set(
			// @formatter:off
			cos * sx, -sin * sy, tx,
			sin * sx,  cos * sy, ty,
			0       , 0        , 1 
			// @formatter:on
		);
	}

	inline function computeGlobal(parent:Null<Transform2>) {
		if (parent == null)
			_local.copyTo(_global);
		else
			(parent._global * _local).copyTo(_global);
	}

	inline function get_local():MatrixView3x3
		return _local;

	inline function get_global():MatrixView3x3
		return _global;

	public inline function clone():Transform2 {
		return new Transform2(position.clone(), rotation, scale.clone());
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
