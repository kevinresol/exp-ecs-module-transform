package;

import exp.ecs.module.transform.component.*;

@:asserts
@:access(exp.ecs)
class Matrix2Test {
	public function new() {}

	public function rotate() {
		asserts.assert(Matrix2.make(4, 3, Math.PI / 2, 2, 2) == Matrix2.translate(4, 3) * Matrix2.rotate(Math.PI / 2) * Matrix2.scale(2, 2));
		return asserts.done();
	}
}
