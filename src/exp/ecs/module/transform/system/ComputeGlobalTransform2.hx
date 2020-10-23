package exp.ecs.module.transform.system;

import exp.ecs.module.transform.component.*;

private typedef Components = {
	final transform:Transform2;
	final parent:Transform2;
}

/**
 * Compute global values for Transform2
 */
@:nullSafety(Off)
class ComputeGlobalTransform2 extends System {
	final list:NodeList<Components>;
	var nodes:Array<Node<Components>>;

	public function new(list) {
		this.list = list;
	}

	override function initialize() {
		return list.bind(v -> nodes = v, tink.state.Scheduler.direct);
	}

	override function update(dt:Float) {
		for (node in nodes)
			node.components.transform.computeGlobal(node.components.parent);
	}

	public static function getNodes(world:World) {
		// @formatter:off
		return NodeList.generate(world,
			@:field(transform) Transform2 &&
			@:field(parent) ~Parent(Transform2)
		);
		// @formatter:on
	}
}
