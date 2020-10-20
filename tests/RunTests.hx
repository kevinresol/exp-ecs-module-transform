package;

import tink.unit.*;
import tink.testrunner.*;

class RunTests {
	static function main() {
		Runner.run(TestBatch.make([
			// @formatter:off
			new Matrix2Test(),
			new Position2Test(),
			new Transform2Test(),
			// @formatter:on
		])).handle(Runner.exit);
	}
}
