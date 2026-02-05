package examples.special;

import com.intuit.karate.junit5.Karate;

class SpecialRunner {

    @Karate.Test
    Karate testAll() {
        return Karate.run().relativeTo(getClass());
    }

}
