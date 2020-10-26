package;

import tink.unit.*;
import tink.testrunner.*;

class RunTests {
	static function main() {
		Runner.run(TestBatch.make([
			// @formatter:off
			new Transform2Test(),
			// @formatter:on
		])).handle(Runner.exit);
	}
}
