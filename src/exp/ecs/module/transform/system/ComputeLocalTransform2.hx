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
	public function new() {
		super(NodeList.spec(@:component(transform) Transform2));
	}

	override function update(dt:Float) {
		for (node in nodes) {
			final transform = node.data.transform;
			final position = transform.position;
			final rotation = transform.rotation;
			final scale = transform.scale;
			node.data.transform.computeLocal(position.x, position.y, rotation, scale.x, scale.y);
		}
	}
}
