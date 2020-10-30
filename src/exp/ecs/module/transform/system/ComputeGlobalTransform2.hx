package exp.ecs.module.transform.system;

import exp.ecs.system.*;
import exp.ecs.module.transform.component.*;

private typedef Components = {
	final transform:Transform2;
	final parent:Transform2;
}

/**
 * Compute global values for Transform2
 */
@:nullSafety(Off)
class ComputeGlobalTransform2 extends SingleListSystem<Components> {
	public function new() {
		super(NodeList.spec(@:component(transform) Transform2 && @:component(parent) ~Parent(Transform2)));
	}

	override function update(dt:Float) {
		for (node in nodes)
			node.data.transform.computeGlobal(node.data.parent);
	}
}
