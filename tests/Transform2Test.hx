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

	function prepare(m1, m2) {
		final parent = new Entity(0);
		final child = new Entity(1);
		parent.add(new Transform2(m1));
		child.add(new Transform2(m2));
		child.parent = parent;

		// system
		final system = new ComputeGlobalTransform2(new NodeList(Observable.const([
			new Node(parent, {
				transform: parent.get(Transform2),
				parent: null
			}),
			new Node(child, {
				transform: child.get(Transform2),
				parent: parent.get(Transform2)
			}),
		])));

		return {parent: parent, child: child, system: system}
	}

	public function rotate() {
		final objects = prepare(Matrix2.rotate(Math.PI / 2), Matrix2.translate(2, 1));

		// run
		objects.system.update(1 / 60);

		final transform = objects.child.get(Transform2);

		asserts.assert(transform.matrix.m20 == 2); // tx
		asserts.assert(transform.matrix.m21 == 1); // ty

		asserts.assert(transform.global.m20.eq(-1)); // tx
		asserts.assert(transform.global.m21.eq(2)); // ty
		asserts.assert(transform.global.m00 == Math.cos(Math.PI / 2));
		asserts.assert(transform.global.m01 == Math.sin(Math.PI / 2));
		asserts.assert(transform.global.m10 == -Math.sin(Math.PI / 2));
		asserts.assert(transform.global.m11 == Math.cos(Math.PI / 2));

		// trace((transform.matrix : Matrix2.MatrixView3x3).toString());
		// trace((transform.global : Matrix2.MatrixView3x3).toString());

		return asserts.done();
	}

	public function scale() {
		final objects = prepare(Matrix2.scale(4, 3), Matrix2.translate(2, 1));

		// run
		objects.system.update(1 / 60);

		final transform = objects.child.get(Transform2);

		asserts.assert(transform.matrix.m20 == 2); // tx
		asserts.assert(transform.matrix.m21 == 1); // ty

		asserts.assert(transform.global.m20 == 8); // tx
		asserts.assert(transform.global.m21 == 3); // ty

		// trace((transform.matrix : Matrix2.MatrixView3x3).toString());
		// trace((transform.global : Matrix2.MatrixView3x3).toString());

		return asserts.done();
	}

	public function translate() {
		final objects = prepare(Matrix2.translate(4, 3), Matrix2.translate(2, 1));

		// run
		objects.system.update(1 / 60);

		final transform = objects.child.get(Transform2);

		asserts.assert(transform.matrix.m20 == 2); // tx
		asserts.assert(transform.matrix.m21 == 1); // ty

		asserts.assert(transform.global.m20 == 6); // tx
		asserts.assert(transform.global.m21 == 4); // ty

		// trace((transform.matrix : Matrix2.MatrixView3x3).toString());
		// trace((transform.global : Matrix2.MatrixView3x3).toString());

		return asserts.done();
	}

	public function complex() {
		final objects = prepare(Matrix2.make(4, 3, Math.PI / 2, 2, 2), Matrix2.translate(2, 1));

		// run
		objects.system.update(1 / 60);

		final transform = objects.child.get(Transform2);

		asserts.assert(transform.matrix.m20 == 2); // tx
		asserts.assert(transform.matrix.m21 == 1); // ty

		asserts.assert(transform.global.m20 == 2); // tx
		asserts.assert(transform.global.m21 == 7); // ty

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
