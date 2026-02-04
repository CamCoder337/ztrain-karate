package examples.conduit;

import com.intuit.karate.junit5.Karate;

class ConduitRunner {

    @Karate.Test
    Karate testConduit() {
        return Karate.run("classpath:examples/conduit").relativeTo(getClass()).tags("@ ");
    }

}
