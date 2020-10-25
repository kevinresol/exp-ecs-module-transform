package exp.ecs.module.transform.component;

class Position2 implements Component {
	public var x:Float;
	public var y:Float;

	public inline function set(x, y) {
		this.x = x;
		this.y = y;
	}

	public inline function copyFrom(other:Position2) {
		set(other.x, other.y);
	}
}
