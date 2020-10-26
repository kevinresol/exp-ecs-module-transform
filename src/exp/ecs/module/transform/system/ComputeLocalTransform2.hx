package exp.ecs.module.transform.system;

import exp.ecs.system.*;
import exp.ecs.module.transform.component.*;

private typedef Components = {
	final transform:Transform2;
}

/**
 * Set Transform2 with values defined in Position2/Rotation2/Scale2
 */
@:nullSafety(Off)
class ComputeLocalTransform2 extends SingleListSystem<Components> {
	override function update(dt:Float) {
		for (node in nodes) {
			final transform = node.components.transform;
			final position = transform.position;
			final rotation = transform.rotation;
			final scale = transform.scale;
			node.components.transform.computeLocal(position.x, position.y, rotation, scale.x, scale.y);
		}
	}

	public static function getNodes(world:World) {
		return NodeList.generate(world, @:component(transform) Transform2);
	}
}
