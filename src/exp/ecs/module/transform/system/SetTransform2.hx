package exp.ecs.module.transform.system;

import exp.ecs.module.transform.component.*;

private typedef Components = {
	final transform:Transform2;
	final position:Position2;
	final rotation:Rotation2;
	final scale:Scale2;
}

/**
 * Set Transform2 with values defined in Position2/Rotation2/Scale2
 */
@:nullSafety(Off)
class SetTransform2 extends System {
	var nodes:Array<Node<Components>>;

	public function new(nodes:NodeList<Components>) {
		nodes.bind(v -> this.nodes = v, tink.state.Scheduler.direct);
	}

	override function update(dt:Float) {
		for (node in nodes) {
			var tx = 0., ty = 0., r = 0., sx = 1., sy = 1.;
			switch node.components.position {
				case null:
				case position:
					tx = position.x;
					ty = position.y;
			}
			switch node.components.rotation {
				case null:
				case rotation:
					r = rotation.angle;
			}
			switch node.components.scale {
				case null:
				case scale:
					sx = scale.x;
					sy = scale.y;
			}
			node.components.transform.compute(tx, ty, r, sx, sy);
		}
	}

	public static function getNodes(world:World) {
		// @formatter:off
		return NodeList.generate(world,
			@:field(transform) Transform2 &&
			(
				@:field(position) ~Position2 ||
				@:field(rotation) ~Rotation2 ||
				@:field(scale) ~Scale2 
			)
		);
		// @formatter:on
	}
}
