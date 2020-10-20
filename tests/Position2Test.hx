package;

import exp.ecs.*;
import exp.ecs.module.transform.component.*;
import exp.ecs.module.transform.system.*;
import tink.state.Observable;

@:asserts
@:access(exp.ecs)
class Position2Test {
	public function new() {}

	function prepare(m1, m2) {
		final parent = new Entity(0);
		final child = new Entity(1);
		parent.add(new Position2(2, 1));
		parent.add(new Transform2(Matrix2.zero()));
		child.add(new Position2(4, 3));
		child.add(new Transform2(Matrix2.zero()));
		child.parent = parent;

		// system
		final systems = [
			new SetTransform2(new NodeList(Observable.const([
				new Node(parent, {
					position: parent.get(Position2),
					scale: null,
					rotation: null,
					transform: parent.get(Transform2),
				}),
				new Node(child, {
					position: child.get(Position2),
					scale: null,
					rotation: null,
					transform: child.get(Transform2),
				}),
			]))),
			new ComputeGlobalTransform2(new NodeList(Observable.const([
				new Node(parent, {
					transform: parent.get(Transform2),
					parent: null
				}),
				new Node(child, {
					transform: child.get(Transform2),
					parent: parent.get(Transform2)
				}),
			]))),
		];

		return {parent: parent, child: child, systems: systems}
	}

	public function update() {
		final objects = prepare(Matrix2.rotate(Math.PI / 2), Matrix2.translate(2, 1));

		// run
		for (system in objects.systems)
			system.update(1 / 60);

		final transform = objects.child.get(Transform2);

		asserts.assert(transform.matrix.m20 == 4); // tx
		asserts.assert(transform.matrix.m21 == 3); // ty

		asserts.assert(transform.global.m20 == 6); // tx
		asserts.assert(transform.global.m21 == 4); // ty

		return asserts.done();
	}
}
