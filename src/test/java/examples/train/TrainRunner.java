package examples.train;

import com.intuit.karate.junit5.Karate;

class TrainRunner {

    @Karate.Test
    Karate testUsers() {
        return Karate.run("classpath:examples/train").tags("~@ztrain").relativeTo(getClass());
    }

}
