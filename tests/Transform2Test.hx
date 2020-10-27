package;

import exp.ecs.*;
import exp.ecs.module.transform.component.*;
import exp.ecs.module.transform.system.*;
import tink.state.Observable;

using Transform2Test.FloatTools;

@:asserts
@:access(exp.ecs)
class Transform2Test {
	public function new() {}

	function prepare(p1, r1, s1, p2, r2, s2) {
		final parent = new Entity(0);
		final child = new Entity(1);
		parent.add(Transform2, p1, r1, s1);
		child.add(Transform2, p2, r2, s2);
		child.parent = parent;

		// system
		final systems = @:privateAccess [
			{
				final system = new ComputeLocalTransform2(null);
				system.nodes = new NodeList([
					new Node(parent, {
						transform: parent.get(Transform2),
					}),
					new Node(child, {
						transform: child.get(Transform2),
					}),
				]);
				system;
			},
			{
				final system = new ComputeGlobalTransform2(null);
				system.nodes = new NodeList([
					new Node(parent, {
						transform: parent.get(Transform2),
						parent: null
					}),
					new Node(child, {
						transform: child.get(Transform2),
						parent: parent.get(Transform2)
					}),
				]);
				system;
			},
		];

		return {parent: parent, child: child, systems: systems}
	}

	public function rotate() {
		final objects = prepare({x: 0, y: 0}, Math.PI / 2, {x: 1, y: 1}, {x: 2, y: 1}, 0, {x: 1, y: 1});

		// run
		for (system in objects.systems)
			system.update(1 / 60);

		final transform = objects.child.get(Transform2);

		asserts.assert(transform.local.tx == 2); // tx
		asserts.assert(transform.local.ty == 1); // ty

		asserts.assert(transform.global.tx.eq(-1)); // tx
		asserts.assert(transform.global.ty.eq(2)); // ty
		asserts.assert(transform.global.m00 == Math.cos(Math.PI / 2));
		asserts.assert(transform.global.m01 == Math.sin(Math.PI / 2));
		asserts.assert(transform.global.m10 == -Math.sin(Math.PI / 2));
		asserts.assert(transform.global.m11 == Math.cos(Math.PI / 2));

		// trace((transform.matrix : Matrix2.MatrixView3x3).toString());
		// trace((transform.global : Matrix2.MatrixView3x3).toString());

		return asserts.done();
	}

	public function scale() {
		final objects = prepare({x: 0, y: 0}, 0, {x: 4, y: 3}, {x: 2, y: 1}, 0, {x: 1, y: 1});

		// run
		for (system in objects.systems)
			system.update(1 / 60);

		final transform = objects.child.get(Transform2);

		asserts.assert(transform.local.tx == 2); // tx
		asserts.assert(transform.local.ty == 1); // ty

		asserts.assert(transform.global.tx == 8); // tx
		asserts.assert(transform.global.ty == 3); // ty

		// trace((transform.matrix : Matrix2.MatrixView3x3).toString());
		// trace((transform.global : Matrix2.MatrixView3x3).toString());

		return asserts.done();
	}

	public function translate() {
		final objects = prepare({x: 4, y: 3}, 0, {x: 1, y: 1}, {x: 2, y: 1}, 0, {x: 1, y: 1});

		// run
		for (system in objects.systems)
			system.update(1 / 60);

		final transform = objects.child.get(Transform2);

		asserts.assert(transform.local.tx == 2); // tx
		asserts.assert(transform.local.ty == 1); // ty

		asserts.assert(transform.global.tx == 6); // tx
		asserts.assert(transform.global.ty == 4); // ty

		// trace((transform.matrix : Matrix2.MatrixView3x3).toString());
		// trace((transform.global : Matrix2.MatrixView3x3).toString());

		return asserts.done();
	}

	public function complex() {
		final objects = prepare({x: 4, y: 3}, Math.PI / 2, {x: 2, y: 2}, {x: 2, y: 1}, 0, {x: 1, y: 1});

		// run
		for (system in objects.systems)
			system.update(1 / 60);

		final transform = objects.child.get(Transform2);

		asserts.assert(transform.local.tx == 2); // tx
		asserts.assert(transform.local.ty == 1); // ty

		asserts.assert(transform.global.tx == 2); // tx
		asserts.assert(transform.global.ty == 7); // ty

		// trace((transform.matrix : Matrix2.MatrixView3x3).toString());
		// trace((transform.global : Matrix2.MatrixView3x3).toString());

		return asserts.done();
	}
}

class FloatTools {
	public static function eq(v1:Float, v2:Float) {
		return Math.abs(v1 - v2) < 0.000000001;
	}
}
